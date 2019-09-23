Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E05CC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C409320578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EORVKrGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C409320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPhe-0003jW-32
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCPfl-0002J2-Ph
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCPfk-0002ER-OT
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:50:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCPfk-0002Do-KH
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569250239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=mdFeExCw32J/66tvTWmcQHCCx94/AeBgk4A+Q6gTNUs=;
 b=EORVKrGWhmFsmlfOXXgQoNkYjYXTCkZjcXDEolanndeqHWCJBuCI1YKYtQ9rmTds93h439
 2KncWjv9ZdRjkevOLvRvj4mCSutnF+l+WplvZ2foJv0+j4DYZ1or2oBydlACQ4TFw6B8Ic
 sXpCM2bVldO+ehzK2DE3LXfyT1VXtNM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-tsehaL97O7irFrnLsy6t0Q-1; Mon, 23 Sep 2019 10:50:38 -0400
Received: by mail-wm1-f72.google.com with SMTP id 190so6832450wme.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6FHtdn929Y1JFOp+pGJ+LlPRgHOmWcAbNQIFojgmtlo=;
 b=Oj3VCFS2os4QxywAN0K2/D1rT33pkeSQfJ2Zary2d6zkhSSmrtZxSIaemg5oWdFrN7
 VUhu8DyWmOXUp4PMeI72XPFjs45T9Qt0gHO+TiSkS97XyPUFPwMI9ck2c9uRXZXfIDyT
 AYAVciRjx10aTDSJPfvcm9FPBMFwNrA4RLkZLibpjnmHUzjQ9/6Imanu3D9KzoDOonbM
 P/1hM/Aj4SIl3r/aenXCEnJzVpPmVOgvsoAapQ0sa52uoeWk/Llf7/AW2OBmWpD7z0CQ
 +w6IdVu4y1YbWEjbp0NrT43L1T4IuKNVT3MZB/8XIeGNy09FwT9dU5eS8UGgjsenhii+
 K1NA==
X-Gm-Message-State: APjAAAUJwvQzKH289dyVbZmITZ9OhvMUgYwplrbqgPYm5+OvMB/tSf6+
 IBPosQE0RvcBHq/rtR8WVpWNOeFWgvXaTrj+kxC3MbOaWlVJgSGZ2Nth5Abty8qjOOTE/OZbff7
 Xupifw9NbLbAToNw=
X-Received: by 2002:a5d:4a52:: with SMTP id v18mr5027362wrs.368.1569250236917; 
 Mon, 23 Sep 2019 07:50:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzgNuhFe6Asz1ZpMgPsmcG5YBvtrCZJfwQXoWHqVKJmCNn/D8AhDLxoilrjF9Q4ohs/UtO2cg==
X-Received: by 2002:a5d:4a52:: with SMTP id v18mr5027351wrs.368.1569250236730; 
 Mon, 23 Sep 2019 07:50:36 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v2sm21512022wmf.18.2019.09.23.07.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 07:50:36 -0700 (PDT)
Subject: Re: illegal hardware instruction during MIPS-I ELF linux user
 emulation
To: Peter Maydell <peter.maydell@linaro.org>
References: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
 <c722d11e-e0ff-8a91-d8f3-ee0a31f1df33@redhat.com>
 <CAFEAcA-iiLihZp-W_kjO3bJXza-+Q-eofagv8N_DbhkbdCUwPA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <97a2103b-8cc7-8526-1d79-3e023d27756e@redhat.com>
Date: Mon, 23 Sep 2019 16:50:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-iiLihZp-W_kjO3bJXza-+Q-eofagv8N_DbhkbdCUwPA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: tsehaL97O7irFrnLsy6t0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Libo Zhou <zhlb29@foxmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 4:42 PM, Peter Maydell wrote:
> On Mon, 23 Sep 2019 at 15:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> So currently there is no MIPS-I only CPU.
>> Note that the code got written with MIPS32 in mind, and implementing
>> MIPS-I requires a considerable amount of change in the codebase.
>=20
> ...but MIPS-I binaries should run on MIPS-II and newer CPUs, shouldn't
> they?

Some MIPS-I instructions where removed for MIPS-II (as RFE) and they are
not implemented. Also some CP0 registers are different.

>> IMO it is likely the RFE (Return from Exception) instruction.
>=20
> It seems unlikely that a linux userspace binary would be trying to
> execute RFE...

Oh I thought it was system emulation, indeed it can't be RFE.

One GCC release targetting R3000 (Philips PR31700, Toshiba TX39) doesn't
emit NOP for branch's delay slot. I remember QEMU fails to run the
binaries it generates, but I don't remember how it fails.

Libo, can you provide more information about the cross-compiler you use
and the flags you use when calling it please?

Thanks,

Phil.


