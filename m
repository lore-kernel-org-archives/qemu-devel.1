Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,TRACKER_ID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7736C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467F220801
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 14:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0wdtwq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467F220801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io757-0003NG-DJ
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 09:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1io74N-0002eg-7k
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 09:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1io74M-0003Rx-6n
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 09:39:55 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1io74M-0003Rc-3E
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 09:39:54 -0500
Received: by mail-yb1-xb44.google.com with SMTP id y67so11311288yba.12
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:content-transfer-encoding:mime-version:subject:date:references
 :to:in-reply-to:message-id;
 bh=eKyfqDzWhpfm7QXDCSdlO2+Ap+fUv6gMHcwSqpgghRs=;
 b=h0wdtwq06I+0vh7jkCDz8Q7L3y2xvh6rwIYTCLSraUb3G9Sg6Qq+QQ1/BbC5k9TBm6
 otLDAoLVPmkMh5+cH2TgQ5FXqK6haoaQ3SFfsUH4g/WdZyBstcrcGK0lGiATWVgGl0W/
 BxabrCY9zbVzFvMwfjm9LItx75G2LeMg5Xf1+4dVGogsxo+r09mOoRWeKueHbpWlf50S
 hB6UEJZ0lFqirRoTab/MqhEWVLD/87kdOgg8w2NJgWm7ApHk9K5oq0rwFE7sshMprHI2
 gxnrTj2k7iXSrgcdwi23oaH3Sb6HpPmJgHZMtST6VFs6zGvxGjvB4JEPZOpeQU1y28Rb
 FDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:date:references:to:in-reply-to:message-id;
 bh=eKyfqDzWhpfm7QXDCSdlO2+Ap+fUv6gMHcwSqpgghRs=;
 b=WmJ7M9r195YHHxSektdJeXPU7qotLdzQSMnr+LW2k8jIgyaKSRLyOw7wZCQ6cB6Nxk
 tGm3UcU2hp47F4bEQfIGdGuAYZBbaWlbi6fSrPDJqcrCGHqekaTw5yd/TH+5gAdGue2s
 0jRlhUDJ0HlwTKBH/hDletphnvlrV7HKV8xDrQYVVj72AE5l3XwoXMvpyuC7dqj6OL/k
 DlubU8eopT9B4GsK4ZSD3yTXgK7LEUJvF+mxRcTD/bUt7M3cluql+ZdEFrjWZKZVCjqh
 0j2LYeOndpcY3vbmbkRBtrPJby6y+DkWeVtTubz8mOPMQaPRJExyZ61MxTRGVSPjNBGV
 cKDA==
X-Gm-Message-State: APjAAAWn7MINr5PkVYfGGDUN4il/rX4BR9nKXNEssWTxNcsifJ7lv0mu
 eeMjnowatOwKIZC+UW5b+y+U6+tW
X-Google-Smtp-Source: APXvYqyRjQPdTmdxJg3vnJaziJqgy80m/6PooZOaht5cCX+/rxaLDrA4y8lROEunHn/NdHPWWVTWCA==
X-Received: by 2002:a25:c514:: with SMTP id v20mr74089927ybe.293.1578235193204; 
 Sun, 05 Jan 2020 06:39:53 -0800 (PST)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
 [69.14.184.20])
 by smtp.gmail.com with ESMTPSA id t3sm25847250ywi.18.2020.01.05.06.39.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 05 Jan 2020 06:39:52 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] Implement the Screamer sound chip for the mac99
 machine type
Date: Sun, 5 Jan 2020 09:39:51 -0500
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
To: qemu Developers <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?utf-8?Q?Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
Message-Id: <F5A6AB85-8A07-411C-9E45-776D13BADCA8@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Jan 4, 2020, at 8:58 PM, Programmingkid <programmingkidx@gmail.com> =
wrote:
>=20
> I found the patch that breaks Screamer sound support for =
qemu-system-ppc. It is this:
>=20
> commit 2ceb8240fa4e4e30fb853565eb2bed3032d74f62
> Author: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
> Date:   Thu Sep 19 23:24:11 2019 +0200
>=20
>    coreaudio: port to the new audio backend api
>=20
>    Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n =
<DirtY.iCE.hu@gmail.com>
>    Message-id: =
586a1e66de5cbc6c5234f9ae556d24befb6afada.1568927990.git.DirtY.iCE.hu@gmail=
.com
>    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
>=20
> Reversing this patch should make the Screamer patch work with the =
current git version of QEMU.

@Peter Maydell

Does QEMU play audio correctly on your version of Mac OS X? I am using =
Mac OS 10.12 and the audio sound demonically loud and scary. I am =
currently at this git revision:

f0dcfddecee8b860e015bb07d67cfcbdfbfd51d

Merge: 40f09ee833 725fe5d10d
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Jan 3 17:18:08 2020 +0000

    Merge remote-tracking branch =
'remotes/stefanha/tags/block-pull-request' into staging

I have ran several tests with qemu-system-i386 using Windows guest with =
the ac97 and sb16 sound cards. It sounds just as bad for me on =
qemu-system-ppc.=20

Thank you.=

