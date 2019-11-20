Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A0DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505702240D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvdEOkBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505702240D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXFqo-0000wU-BR
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 21:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXFpl-0000Ky-JN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXFpk-0003se-Je
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:35:09 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXFpk-0003sF-C6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:35:08 -0500
Received: by mail-ot1-x342.google.com with SMTP id u13so19897751ote.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 18:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=o+sycsXsPY8vMFAga525YzP3r3wCue6MmGUsEHay0FU=;
 b=nvdEOkBpxZC6rl0tL7f2swERsgm+puFy4PFl35ovxRZOwwdOdbOaldYny8jCSnuewz
 Zln+4wP+KhO5/cRdwqPIkturEAxF5g7Q+nLh2fysK+0TSXplyN0iPyiBgFDG1qJdrqVO
 3hlXOPsQosX490mLPvs1aLoSkC7kObqFOmuHqXLU6N7XnM6ccgeUXUW62hiNAvAffpvP
 EofV75YLun4AvrzTkxL9bXdpDhnjGmUF2ZRWYO1zCD9Vhmnc4RwA+w8gHPawdAiPzWvp
 rq/8MHJCxzKMKcObxzprWosGVDSWAepmD0IHYcIBHFu1N7Cr3sbA+f/F5da/60IOl7sx
 3mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=o+sycsXsPY8vMFAga525YzP3r3wCue6MmGUsEHay0FU=;
 b=jA+TWa4G5MFJbYnn0Az1TOjUoLf2YlET79HPZcqMU1wFwK7Kv57ciWVwqDnJ/ScKHb
 YuiS9aqZ/psbsm3fmH7EJuyWwf1Uyb3KDUq2mvGkADOjD9NxZbwEUw7G0YWKL9zUIVhe
 UEalYBAWlJhTLVvoFyGm9Yk+X7FxO4dDNAekrZYvs/xVWw3hs5Vpj3hee7QyZEASmq/Q
 vvf8HKLmeNAAhT8u6Y9qyBmA3ayiPY2XeeXL29FD/pBETRvRvcqbS9L59AwCBh4mkE19
 f3Umei7ourEX6s1srNx7K9P0DNHMYzy0P8bWe/NTkmRhagvHJRNed8DveD7atxBrwNeh
 82aQ==
X-Gm-Message-State: APjAAAXBXa0dVsFQpzgwNtLfJO6oLUBOuSuSPlkOR8zyKeJEwtg+Ytgi
 ZHo5ZicIg9DWlxDHtVqxBy9IQkrCnABQuNt9dZ4=
X-Google-Smtp-Source: APXvYqwIng9oSLx3RJk/luDEXkgjHFLqWbbWc7rq8+xWAXql13vb0l1B9ndwoC8+330DD6xvkyteRu6j1wiS271hwME=
X-Received: by 2002:a05:6830:44c:: with SMTP id
 d12mr116543otc.121.1574217307401; 
 Tue, 19 Nov 2019 18:35:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Tue, 19 Nov 2019 18:35:07
 -0800 (PST)
In-Reply-To: <20191119190405.GA23854@ls3530.fritz.box>
References: <20191119190405.GA23854@ls3530.fritz.box>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 20 Nov 2019 03:35:07 +0100
Message-ID: <CAL1e-=iFW3JhEu_OwVM3LFekgVav=P2CED=BGFM=tqDJW0RQEw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/strace: Improve output of various syscalls
To: Helge Deller <deller@gmx.de>
Content-Type: multipart/alternative; boundary="00000000000068341f0597be0786"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000068341f0597be0786
Content-Type: text/plain; charset="UTF-8"

>
>  #ifdef TARGET_NR_ioctl
> -{ TARGET_NR_ioctl, "ioctl" , NULL, NULL, NULL },
> +{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x,%#x,%#x,%#x)", NULL, NULL },
>  #endif


ioctl() has only three arguments.

Regards,

Aleksandar

--00000000000068341f0597be0786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0#ifdef TARGET_NR_ioctl<br>
-{ TARGET_NR_ioctl, &quot;ioctl&quot; , NULL, NULL, NULL },<br>
+{ TARGET_NR_ioctl, &quot;ioctl&quot; , &quot;%s(%d,%#x,%#x,%#x,%#x,%#x)&qu=
ot;, NULL, NULL },<br>
=C2=A0#endif</blockquote><div><br></div><div>ioctl() has only three argumen=
ts.</div><div><br></div><div>Regards,</div><div><br></div><div>Aleksandar</=
div><div><br></div><div><br></div>

--00000000000068341f0597be0786--

