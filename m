Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8D120707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lK3WEMby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8D120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFJC-0005fy-AE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFIJ-0004Jw-B6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:22:43 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFIH-0001XH-EN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:22:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so21631973wro.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mMTm9iAyhbqpde1hmRa1EpTMz1BhWC/0zFvk7m2R66w=;
 b=lK3WEMbyo3LKuABlKOCe+pRbII3JOvp0N3NA3yA0x49nFsOqoLCmpecm+hPbXR3+TJ
 td79JlSs4Mb2HQegfj2oEnwF9bzZk9kYbWztkuDg7S/96ZJuXNFtIM/WdEl1RjAPZ5Ei
 LoeHgwtVQolPeGJ9T1Kecxpl05Fr330ZFtlmdP7nyqI/uZURdc8lw0fQ95uS+NPR1G4N
 5vqLtPYo628+YcYvSo/nR3Rfolfe2QIHOrkHjg4+zjpfvF0qeXBHwfv0WvbFkJ/CmEjr
 xI27lorYrVa5/U98vn/zB5e8lTNQd1IRbCt/8sxRGkby5t6E+o0sMyaNSoPbxEVolGnO
 nPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mMTm9iAyhbqpde1hmRa1EpTMz1BhWC/0zFvk7m2R66w=;
 b=oFESewKdNLe8hypsvpu/20Tyd4cKTgEQya5EBsLoJLZitCcotBVTN1XM0e1abmh8w9
 eVwUWrQwFFsEX4TWHzdLIH33oq4NJxXenGO/0/bNAQfqQo4OkWB2U+EsLUcVhSUkQeG4
 2nWw3n7rxQxYB2slunYS9cVEW4ZFmY1PywjO7IPKHX7NTRS0IuF6nMPE/FZxzIo4bgoY
 A85ncVFUyTlelvUx94V6dfFGJGJIrypYVGTumobA9d630Iau7E4ycfIk0vK2PGpf3P3N
 DV8iUqyzqFtmLKgeyLeS86hDkifiGKCyF4P1UFuMJC7WE13J9NRGRUq/2A6qRrb2bJ6x
 KN4g==
X-Gm-Message-State: AOAM531d36mjF9AEtAyamI6bQW/O89g4sRdX2Q+9fqx9jmuMtB2+fwkZ
 2rHFBhF+zIAWAoUPzHjXesjeiw==
X-Google-Smtp-Source: ABdhPJxRtDRqrDF9m1C0L7Me5lfUcq/jzIxE6Rxato8uv+S2VLERe1tlOuyqooUUsBITnvgjV7yGSQ==
X-Received: by 2002:adf:eacc:: with SMTP id o12mr4278927wrn.139.1592328156940; 
 Tue, 16 Jun 2020 10:22:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm5159402wmy.0.2020.06.16.10.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:22:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED9D51FF7E;
 Tue, 16 Jun 2020 18:22:34 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-6-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 05/15] tests/tcg/tricore: Add build infrastructure
In-reply-to: <20200604085441.103087-6-kbastian@mail.uni-paderborn.de>
Date: Tue, 16 Jun 2020 18:22:34 +0100
Message-ID: <875zbrylgl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> this includes the Makefile and linker script to build all the tests.
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  tests/tcg/tricore/Makefile.softmmu-target | 17 +++++++
>  tests/tcg/tricore/link.ld                 | 60 +++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>  create mode 100644 tests/tcg/tricore/link.ld
>
> diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricor=
e/Makefile.softmmu-target
> new file mode 100644
> index 0000000000..4a2cd6f218
> --- /dev/null
> +++ b/tests/tcg/tricore/Makefile.softmmu-target
> @@ -0,0 +1,17 @@
> +HOST_CC =3D gcc

I guess you need HOST_CC to process the source file. You don't need to
define it though - it should be picked up by config-host.mak included by
the main tcg makefile.

> +
> +TESTS_PATH =3D $(SRC_PATH)/tests/tcg/tricore
> +
> +LDFLAGS =3D -T$(TESTS_PATH)/link.ld
> +ASFLAGS =3D
> +
> +QEMU_OPTS +=3D -M tricore_testboard -nographic -kernel
> +
> +%.pS: $(TESTS_PATH)/%.S
> +	$(HOST_CC) -E -o $@ $<
> +
> +%.o: %.pS
> +	$(AS) $(ASFLAGS) -o $@ $<
> +
> +%.tst: %.o
> +	$(LD) $(LDFLAGS) $< -o $@
> diff --git a/tests/tcg/tricore/link.ld b/tests/tcg/tricore/link.ld
> new file mode 100644
> index 0000000000..364bcdc00a
> --- /dev/null
> +++ b/tests/tcg/tricore/link.ld
> @@ -0,0 +1,60 @@
> +/* Default linker script, for normal executables */
> +OUTPUT_FORMAT("elf32-tricore")
> +OUTPUT_ARCH(tricore)
> +ENTRY(_start)
> +
> +/* the internal ram description */
> +MEMORY
> +{
> +  text_ram (rx!p): org =3D 0x80000000, len =3D 15K
> +  data_ram (w!xp): org =3D 0xd0000000, len =3D 130K
> +}
> +/*
> + * Define the sizes of the user and system stacks.
> + */
> +__USTACK_SIZE =3D DEFINED (__USTACK_SIZE) ? __USTACK_SIZE : 1K ;
> +/*
> + * Define the start address and the size of the context save area.
> + */
> +__CSA_BEGIN =3D  0xd0000000 ;
> +__CSA_SIZE =3D  8k ;
> +__CSA_END =3D __CSA_BEGIN + __CSA_SIZE ;
> +
> +SECTIONS
> +{
> +  .text  :
> +  {
> +    *(.text)
> +    . =3D ALIGN(8);
> +  } > text_ram
> +
> +  .rodata :
> +  {
> +    *(.rodata)
> +    *(.rodata1)
> +  } > data_ram
> +
> +  .data :
> +  {
> +    . =3D ALIGN(8) ;
> +    *(.data)
> +    *(.data.*)
> +    . =3D ALIGN(8) ;
> +    __USTACK =3D . + __USTACK_SIZE -768;
> +
> +  } > data_ram
> +  /*
> +   * Allocate space for BSS sections.
> +   */
> +  .bss  :
> +  {
> +    BSS_BASE =3D . ;
> +    *(.bss)
> +    *(COMMON)
> +    . =3D ALIGN(8) ;
> +  } > data_ram
> +  /* Make sure CSA, stack and heap addresses are properly aligned.  */
> +  _. =3D ASSERT ((__CSA_BEGIN & 0x3f) =3D=3D 0 , "illegal CSA start addr=
ess") ;
> +  _. =3D ASSERT ((__CSA_SIZE & 0x3f) =3D=3D 0 , "illegal CSA size") ;
> +
> +}

Now would also be a good time to update the MAINTAINERS entry for
tricore to include everything in tests/tcg/tricore ;-)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

