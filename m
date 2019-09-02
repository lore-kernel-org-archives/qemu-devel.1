Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D60C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811E62173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKESzbm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811E62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4otP-0007Ys-DL
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i4osH-00072w-4r
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i4osF-0005N2-Sd
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:08:12 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:33422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i4osF-0005Mo-OH
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:08:11 -0400
Received: by mail-oi1-x22d.google.com with SMTP id l2so10791197oil.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=at6pWMFM8JLirAYDpV5NA1Ohmqhzlv3WNzPIqDL+6sc=;
 b=NKESzbm9rdQ8qfOL0YptYByQB9eNCUiw3BK//NMcuZZg1lYeuGezyCDjz/MPgJSM0h
 MaWtyKH5dKYTSa47UbR7M8ipJnhj9eQAbjJ8VjcrFxVWsT1UGHyc2D5pSNXe0gsA/PUt
 pQaWgJKV6+c3C+jbkLGfNpby3IElOFIKLIMEycsg7s9hvhnvIn9BDjaNqkGdtIjy+U2V
 F6Sq32EcjWQNEaG6UhdKj4Rd9h/BKncAztUBL9LnlOAYRisE1G0FZ+VKESSqbB9XXKnX
 Kb3fZGnpVWisxMNwZyCDeqjliZd6FS9TUBkNDsLOpOvIUGIiblrY0UmyxueZ05nTXEDU
 ebqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=at6pWMFM8JLirAYDpV5NA1Ohmqhzlv3WNzPIqDL+6sc=;
 b=N+Sa1v7e3ZFUAouZypHSxBAnvmkmCf8/j7RuVPE7LOi53bqDj7b+mpCUoQADQ3NAsq
 AzEDXkuQDM+hdI/43NfQ2ow6dr0wCmZC+h4Rk7MTCPz8NmoE2kfti3npOfciXwhn7M9d
 7Cyjo8M/XKj9jlNzQ9sc8R+1KOia/ZkGpfuMP/48Cn2M889do8t6eEZ6ObFpQVT/IPYD
 BlDFTQh3Pgjsj3bpRtDJfbjOOOBXEP+yqhTTBR7H/4A+3C5qsZ77+fhUiXvsFnI+mqHK
 W9SkA+WQjI2tSjZOPasN55DA7QYU0ANadt70Kuh6t9Ouko3brNdso+lN9CXupKwtQ51B
 HENA==
X-Gm-Message-State: APjAAAVVr9dU29uiXuSaDQiuRXkUMoqcRAlUUU12nG0dhNAMV4WMg7NL
 X4G2+9p9SXpxENpMGrbV4U1vT2qwPT17vaXRLCw=
X-Google-Smtp-Source: APXvYqy+2yMs1OoIA3NLzZyZowq/DlNolS/9aEhytuTO8l9Ygoixl9LqZo5IKP+TBqeFtCQNmSXs6Os1ziFEL1j09FQ=
X-Received: by 2002:aca:bac4:: with SMTP id k187mr19992704oif.62.1567440490091; 
 Mon, 02 Sep 2019 09:08:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Mon, 2 Sep 2019 09:08:09 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Mon, 2 Sep 2019 09:08:09 -0700 (PDT)
In-Reply-To: <tencent_61024D4F136E131E2B085A7DACEA1593D007@qq.com>
References: <tencent_61024D4F136E131E2B085A7DACEA1593D007@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 2 Sep 2019 18:08:09 +0200
Message-ID: <CAL1e-=jAnpxiQgXG3jY00d7shxv-evXUPg_YztficjQ=0U18Xg@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Uncaught target signal 11 (Segmentation Faullt)
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.09.2019. 06.17, "Libo Zhou" <zhlb29@foxmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> I am trying to run a simple MIPS program with QEMU user mode.
>
>
>
> Host: Ubuntu 18.04 LTS on x86_64
> QEMU config: ../configure --target-list=3Dmips-linux-user
>
> Cross Compiler: sudo apt install gcc-mips-linux-gnu
>
>
> My test.c is simple: int main(void) {int a =3D 1; int b =3D2; int c; c =
=3D a +
b; return 0;}
> After compiling it with "mips-linux-gnu-gcc test.c -o test", I ran it
with "./qemu-mips -L /usr/mips-linux-gnu test", then I got the following
error message:
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>
>
> Does anyone have a solution to this? Thank you in advance.
>

Hi, Libo.

Please try this:

cd /usr/mips-linux-gnu
sudo mkdir etc
sudo ldconfig -c etc/ld.do.cache -r .

... and start qemu as you described.

Sincerely,
Aleksandar

>
> Cheers,
> Libo
