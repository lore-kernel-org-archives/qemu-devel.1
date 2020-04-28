Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030D6C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0ADB2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDgtNtSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0ADB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVlH-0000Qa-Uu
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jTVhz-00056T-4B
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jTVhv-0005UN-6q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:15:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jTVhu-0005JE-M0
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:15:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id s10so26052345wrr.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZScDKbUs2jbRV+d6RhvWhFvBcJTS20Lsu3Irk1KHNfY=;
 b=BDgtNtScKLjf33pJPSPfRMPHCFcm4b2MCUk6qqOvQ9beKx/Jh3L1gmNJXVN1QNZG7Z
 b2bN2+1n2VrTMCB8lG8m/aIwvzITpUEJ7zL0ufcjLzUcoS1I2rs1OQ1F6sZBbSvbECGu
 gsjT450YZVwmIa4EG/C458U0IWM2zIZxKBqoi42i5qYS1RkcBEUuDwEDIlfZ4kFsK58I
 0jLmx1Gow0bqL1IMb1Ng2L0xq78KzV6eWTkZlZvKQyb/w2jGMyfDHFRhHXtf1/OvD2Z+
 Djnaw+SzpAYTtY1J+BwyNusVy0q2Smpsk5qlospofySC6JARWkP+Q5u3pGAUtYW5ynJV
 1aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZScDKbUs2jbRV+d6RhvWhFvBcJTS20Lsu3Irk1KHNfY=;
 b=fsND1tho+D2Gnflb4R8WP0xbrv9zxrdKN+KU08lS/1QM2AI8zrp4XEpYiZ2bcpflrW
 hEYdrRl1ZhFf8GtbD61CebKpl1zLougCj6D//s+nETDRxP0y34UZ72JjZxflot2vmvUU
 JiwMDyH9LTwuUtQ+FM+hFcf/5bdfxxhal2+WzFiOeE9aCTdCjo32LDcVJHI5n5hfMPfU
 amP30RDJhCnnaHxUJYteMBD3VxhsmaEop29NiI3PbOdSDOMqcWlAFTcjMKAyPGV9voZl
 f0RP3zu1mjVCglM72lcx9r6URffSDLUn/zIuyJFHq600qJUk+65v1ljecaCKPEK+7XPa
 R7XQ==
X-Gm-Message-State: AGi0PuYmFgazHPYAHTSy0RpNwftdwSGbxGReaX69LMBB1VltBxnd4e0H
 UOZDVmgtkT8TmoOSXVdz4NOhDz5NixO9dccY4cE=
X-Google-Smtp-Source: APiQypJQhM3/fhNu83d5U596udXsAIciCBcEoXlDxNIRe/89NYWJJLxyHx5oysyjN4LjtenU2hL01Sz3DRXlIqv6AhY=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr34007019wrw.402.1588101348775; 
 Tue, 28 Apr 2020 12:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 28 Apr 2020 21:15:35 +0200
Message-ID: <CAHiYmc4tFTJJ3YACSNuy8ME=PirhYUjfDGGAYdyPqcW_0ga5KQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 1/7] configure: Add KVM target support for MIPS64
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 27. =D0=B0=D0=BF=D1=80 2020. =D1=83 11:33 Huacai Chen <=
zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Preparing for Loongson-3 virtualization, add KVM target support for
> MIPS64 in configure script.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Huacai, hi.

I am really glad this series arrived, and salute your work.

But it looks no cover letter arrived, and here and there there are
some omission.

The english machine translation of all relevant docs would be good too.

Please send v2, a little bit more complete.

Sincerely,
Aleksandar

>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 23b5e93..7581e65 100755
> --- a/configure
> +++ b/configure
> @@ -198,7 +198,7 @@ supported_kvm_target() {
>          arm:arm | aarch64:aarch64 | \
>          i386:i386 | i386:x86_64 | i386:x32 | \
>          x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
> -        mips:mips | mipsel:mips | \
> +        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
>          ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | =
\
>          s390x:s390x)
>              return 0
> --
> 2.7.0
>

