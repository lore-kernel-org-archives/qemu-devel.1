Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEFEC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD9F2173B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icMTnXLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD9F2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5pQh-00067S-FV
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5pPn-0005Dt-C1
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i5pPm-00088B-7Z
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:54:59 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:37576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i5pPm-00087r-23
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:54:58 -0400
Received: by mail-oi1-x22d.google.com with SMTP id v7so1429982oib.4
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=GzR7buEz5fclXFO8voYBddQllNLue+b+6bPBdf0COec=;
 b=icMTnXLBE3k6SHX07SXtHHtesGHE3fSkulhylmj6/BrkBOrr17EfuhbjsfSQKxd2j5
 Bqxr8VFTHncrXkm5epXzKKvR3AGT6k8cCqDbIOlVmy5VjB1Y2NreWXogkLdG8vI1iPqu
 wI7dmAgL2e4N/h9zjADQKYVeMMGJH3w7X6Yt4/mQJXJ8FUNsFTUeMnANHREgReHxdlGR
 vuUAg6Kvpso+llBVytgTdLpMIEdT+0D5lF93w9XysI2fMVmymVu1VJDrqKl5bZJ6i0Sx
 YcXoLhHnt9KVR2s/U4JEs+n0wEfVBM4j03tcm+BNarpNVytxvVvwshdRVgBCE9FBIaSO
 iHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=GzR7buEz5fclXFO8voYBddQllNLue+b+6bPBdf0COec=;
 b=SsmEft/ouw4sJVatnuOuT2VGwa8uSdhqu+Xs/gM8ZkrIv0Z3sd2Wmb/JL4WyNOIyZB
 xkuSWwJMnAcJyqushMo0Q/5wo86DVubBxcJuXbCLPWUFqbURfd/MyLy3+SrGxYlBnmi9
 C8m+wKakKCYYgKqFRaFGolauyDKSQtQlQG5b3rPYYkht7V1J252q4AIhVqAkdceqCOs3
 UDVqHJFHZu9xzFuqhK5mNMCMqqmZrR9J4XbZ3Tce+ejHbf2eNKvt0bZYmcGEJ/d+Vv9c
 Ay3PLa2nKTZpjUaHj1xG3/UeVWXxeziA4LJzQJg2Y/McNbRpRO23JgZvZ+7ChoLo2TvA
 EyuQ==
X-Gm-Message-State: APjAAAWBuFgaAbX4EdXxgP41L8dx5w/W7kdsNqccopxmu5TS8UXZWMng
 E33/oZHNSjz9KyT+KYjKv/wZs986JqFaI4wnSPs=
X-Google-Smtp-Source: APXvYqx84FDiQUwYysp+oyyr2C3AgVrjmdyXRlyCCU3DwAQXmxSS/CUhGkQ+UmMh/qAfWopwOqyqCUfuZppNDozxMso=
X-Received: by 2002:aca:568f:: with SMTP id k137mr1985775oib.106.1567680896621; 
 Thu, 05 Sep 2019 03:54:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Thu, 5 Sep 2019 03:54:56 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Thu, 5 Sep 2019 03:54:56 -0700 (PDT)
In-Reply-To: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Sep 2019 12:54:56 +0200
Message-ID: <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
To: Libo Zhou <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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

04.09.2019. 05.23, "Libo Zhou" <zhlb29@foxmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Hi Aleksandar,
>
> I have spent some time looking at your MXU ASE patch. It's super helpful.
I need to do exactly the same thing as you did.
>
> Now I just need a way to observe the memory and register file contents to
debug my instruction set simulator. I played with the "-d" switch to log a
bunch of information, but it seems that none of the items is of my
interest. The "-d cpu_reset" option displays all zeros in the GPR log.
>

It looks you need a custom logging tailored to your needs, based on
intercepting the instructions you added.

Aleksandar

> Please take your time, as I fully understand you need to work on Qemu
while answering all my questions. Again, thank you very much for your help!
>
> Cheers,
> Libo
>
