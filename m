Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAF4C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19036206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+rU9IAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19036206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRGz-0002qc-8m
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYRGI-0002LM-N0
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:31:42 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYRGH-0005sM-FV
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:31:42 -0400
Received: by mail-ot1-x341.google.com with SMTP id j4so9941423otr.11
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jc+/lr9ycH0TTde7ttnjfwsSpQWYGiC6vAyoWOFGZ1U=;
 b=x+rU9IARl+aD1/e7luSeUHaK3P7WjOBq+Bnk9KV5slbuO1sFX3C5tWa40zJu31jbed
 aMKrimvWEqdpaENTIm+yfynw0jP2gquMnGUe8ng7SOWGlSQ+w7FcXoLfiCLZWdZ6S76y
 8KTt2F8WBFM+4emPUnglr5d0JX3MxYu3HdOX1uaEWakOs290UJryWaLeb5seZ8HRzVOB
 gz6NQIE+GYA1A2K8Jetajh5PTGsjwOSD9E3t30FUcfaobAESwF2Xilr5wr1JdrQ4NSCU
 zerC87in9OENJVTMjrY0/2Ftlwswpwq3niK95PiMV82KFrAGLRJxqKC+lR5LV9ZfGlob
 qzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jc+/lr9ycH0TTde7ttnjfwsSpQWYGiC6vAyoWOFGZ1U=;
 b=JUeEw7OYtOIiv2dSBEwP2Bvgrgp+OzR2OH6ti+XzM9ezXtcRUn6KBv3xX74QD7YrP+
 H3syfAomY/2EXTr7nTUPbRN+MffAF/7BMcz0KCavrwUZG1QWlhPExkh+hPU+Ku9vt5K4
 1ZGOdd/r4XJhqWlg9C7H4sDflW86onxI8Wfv39xu1EdusZX7Jt26bKJ2XIPkF1bO4oUj
 Pm0i04vdYDrHutZU4+mbboriu00XI571V+Ar5r1MkH2FjpV8ZwHDjVhlMeMoyS4o7z6h
 4SLvoR0S2vNfc99hZUTDQ0aR+R38YdlrAtpGF3oGlMa3cYz9wpO4K4pCCG+x94yBfdKz
 d56Q==
X-Gm-Message-State: AGi0PubUl1cDkbXLwWk3zWUqJYH9Ys7+RUdwPYi6PFm0XoLzR7lvf4xm
 QrTb0ez/8vx5d3u9qyLr6MN9peaMt6BPFLq6MSdjnQ==
X-Google-Smtp-Source: APiQypLgnvLWjXetAi+H5hjekb+QLkK/pyr95RKdxnLIOyt1okGmaSvqKFpWkjFLWDpGOHFB1hkAvKuX/ig7fA7hlaw=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr15177954otc.221.1589275899478; 
 Tue, 12 May 2020 02:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A0D32CA7B0D4D56FF2B2182DAA3EB6BC6508@qq.com>
In-Reply-To: <tencent_A0D32CA7B0D4D56FF2B2182DAA3EB6BC6508@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 10:31:28 +0100
Message-ID: <CAFEAcA_qdnCfZa1aAH7U0D0yTwdJd=maKPWGnz12Fpq3TVw=qA@mail.gmail.com>
Subject: Re: how to extend to load COFF executable image file
To: xiaolei <1482995675@qq.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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

On Tue, 12 May 2020 at 08:41, xiaolei <1482995675@qq.com> wrote:
>
> Hi all,
>   I attempt to add DSP architecture support for some TI processor, based on QEMU 4.2.

Don't try to add new code to QEMU based on an old version.
You should always work with the head-of-git. Otherwise you'll
be dealing with stuff that's gradually drifting out of date
and you'll end up with pain when you need to rebase.

>   When I work on the executable file loading , I try to load COFF executable  file. Following the ELF file processing scheme, I thought I could write a function similar to :
>        rom_add_elf_program(label, mapped_file, data, file_size, mem_size, addr, as);
>   But I got lost when I track down the usage to the global variable  :static QTAILQ_HEAD(, Rom) roms;
>   I did not get where this 'roms'  is used for program loading, and how the loaded program get to run eventually.  Can someone give me some hints?

You've gone down too far into the internals of the implementation there.
The way that QEMU's image loading code works is that all the data
that must be loaded is put into a set of "ROM blobs", which we
keep in a linked list. When the system is reset then the function
rom_reset() runs through the list and copies the data in each
blob into the right location in the guest memory. The simplest
way to create a blob is to use rom_add_blob(); but you could
also use rom_add_elf_program() if you wanted. That function is
a bit misnamed: it's not ELF specific and it doesn't handle
an entire program; it just has a couple of extra properties over
rom_add_blob:
 * it lets the caller provide data which only partly fills
   the blob, with the remainder to be zeroes
 * it can work with a GMappedFile so you don't need to copy
   the data out of the mapped file to pass to it

>   Also, the COFF file format differs from the ELF, there is no program header. I wonder if I could reuse the 'rom' structure like loading a ELF. Or there is a better way to do it.

Yes, you want to reuse the Rom struct, which isn't ELF specific
(we also use it for loading raw files and uImages). You would
need to write code which could read and parse a COFF file and
identify what parts of the input file needed to go where in
memory (and what parts of memory would need to be zeroed). Then
for each of those parts of memory you create a rom blob
(via rom_add_blob() or rom_add_elf_program()). That is, you
want the equivalent of the function "static int glue(load_elf, SZ)"
in include/hw/elf_ops.h. (That function is a bit odd because
we use the C preprocessor to create a 32 bit and a 64 bit
version of the function so we can load 32-bit ELF and 64-bit
ELF files. COFF may not need that complication.)

Consider also taking the simpler approach of just using
binutils objcopy to convert the COFF file into an ELF
and then passing that ELF file to QEMU. In particular
if you're also trying to implement an entire new architecture
you might as well skip the pain of writing a COFF file
loader for the moment.

thanks
-- PMM

