Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB9DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EF0206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7iMmhmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EF0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ9bj-0004p5-AC
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZ9ad-0003mu-CH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:51:39 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:41907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZ9ab-00064M-QZ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:51:38 -0400
Received: by mail-oi1-x22d.google.com with SMTP id 19so23907431oiy.8
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rYT/VCdSarMI+aJTrFiH7Pju/Kl2UMI0NV/J6/Si8vc=;
 b=e7iMmhmcVFzufhXeRHAEeQvCdQDmYCnfM0DIN1F6+CY+wVF+xKOv4eth1X6y7iNgBJ
 eGxQ4cKj7iP3O7DpW5T4g1XJSNR3Ju9844zBj+6EI0W2v7Fk/UBzURdBnjuX58h81uUs
 mMCYuOGVWIla+VhfU1JCFE4QhgjXYfDPfB9rlODPnPIQ/+hcSf/9tCJXP4uZobfpcTk4
 dk4u0x6feTroo81J57Gb7gpG6Jz0nKqnpQ1xQcQjdw5pWB7R9lNZzQq9sKOCeWi4NFz1
 Q95J8VAzsKE79KuJLkRbiIastP1kAd0KxvZnr4UwYoxJV/S1asG8PNu6q//NtkaRLL+f
 zMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rYT/VCdSarMI+aJTrFiH7Pju/Kl2UMI0NV/J6/Si8vc=;
 b=hcDn9HICjSBvan86MW7sfzVch5XxNSqVJYtwL32445/AbmXYPrfkAHKXTr1GHqfY4j
 7KVTmaSg6GxY9MGXcBn8R1fjG84jrqEbrRY3LsxHUf224FMLsn+PC/4Z+RDSe1TWtaLY
 2gg940D3kVaSlmJ6nrebC9KGjAc0EAlnPnL/8irktMX0KgrFBa6VJO+HvBlVS3ov+7Pv
 ovRTMTULmePcpbvYedQ51oQyKQFiixnPt8g5aArJ2ksk7jbRox31IcPPUAwo0h6NbQbQ
 gejrd5EPCybbYLY86juvn2tSUDv8PPKLpFMQJ9G3lA13Vu10qc+ldKmPRAogB337BSNI
 sEPw==
X-Gm-Message-State: AGi0Pua8NoMmCDSvquvHetCSEl21f3bgPornVaKOlp5kRMY9Jg64kB3W
 yKfZHTQWPrT+hljN2knympmzh+MtPw2VjU1BfQkbuQ==
X-Google-Smtp-Source: APiQypLAJbYGip2k0D/aY2vWj/YZCrFsf4S08PC8JYTG0o2mPQAhlP6LndEgRk3ilp9h14nYsCtzEyBirXNiUG2lgRY=
X-Received: by 2002:a54:400c:: with SMTP id x12mr28810939oie.146.1589446296240; 
 Thu, 14 May 2020 01:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_129CC651BFBFE9CB46B508FB74F1364C170A@qq.com>
In-Reply-To: <tencent_129CC651BFBFE9CB46B508FB74F1364C170A@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 09:51:25 +0100
Message-ID: <CAFEAcA-K3hCmESBHSPzyiFL1529Sj-ZKbqg=2UmCzx4d_ejomA@mail.gmail.com>
Subject: Re: how to extend to load COFF executable image file
To: casmac <1482995675@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On Thu, 14 May 2020 at 09:44, casmac <1482995675@qq.com> wrote:
>
> Hello,
>    Thanks for the detailed explaination and insightful advise!!
>    I firstly give a try to use objcopy from GNU binutils, but it seems th=
e COFF file I am work on (which is generated by TI's CCS IDE) cannot be rec=
ognized. The COFF format used by TI sllightly differs from GNU's definition=
. So I guess I have to parse and load the COFF file myself.

Ha. Over a decade ago I had to deal with TI's weirdo COFF file
variant. I took the approach of getting binutils to handle it
at least sufficiently to do COFF-to-ELF conversion:
http://www.chiark.greenend.org.uk/~pmaydell/misc/binutils.notes.txt
http://www.chiark.greenend.org.uk/~pmaydell/misc/binutils.patch.txt
though I imagine that getting that to work with a modern binutils
might be a bit of a pain.

>    As far as I understand how a COFF executable file is organized, there =
are generally 3 section 'chuncks'  to load. A section chunck may contain mu=
tilple sections. For example, a program may contain 3 section chucks:
> Section chucks:                               target address on DSP proce=
ssor
> Chunk 1 =3D txt + bss                                  0x1000
> Chunck 2=3D cio+const+data+stack             0x800000
> Chunck3 =3D vector                                    0x809fc1
>     Now, I am trying to make use of "ROM blobs" and rom_add_blob() call. =
I am confused about how to map the sections to blobs, one ROM for one secti=
on(for example .txt) , or one ROM for a section chunk?

You want one ROM blob for each contiguous lump of guest memory
for which you have data to provide. Guest memory which is
all-zeroes you can either do by passing a block of zeroes
to rom_add_blob(), or for the special case where the zeroes
directly follow a lump of other data, you can use
rom_add_elf_program() to avoid having to allocate the zeroes.

> Meanwhile, how to use the fileds from the  Rom struct:

You don't need to look at the rom struct fields. Just
call either rom_add_blob() or rom_add_elf_program() and
those functions will handle the rom struct for you.

thanks
-- PMM

