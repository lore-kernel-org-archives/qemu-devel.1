Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A09C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BEE20936
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7GK7Fud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BEE20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFk7b-00046v-Su
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFk6s-0002pp-Lw
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:20:58 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFk6q-0006ha-HE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:20:58 -0400
Received: by mail-ed1-x544.google.com with SMTP id c8so391902edv.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1BkTCI+47VXu3QHk3YsYNWt55DttbUP6HZu1YPlc//4=;
 b=k7GK7Fudd23G0vSnvnnTk0OOMP1nbnqdSYIdmFQJz9UOVtVHEPltICRzdx+LLxupkd
 IoJ4BsNIMT85yA71Ei6zlrX1g2GUAQH41hFWoPb/TsZTBZz6tlYa3JjqtSL8/oJ+Pg/H
 fI3+CseREs1RSpQqhAq0Ifvp0EOTUIr2LyRoGjaLLr6k25y/HBmNDwJr0zGI7W2CrEbc
 0tJUXrqsbRspvRddc2OaQIJvfFmUilqr4xOCxcu0rEaO4RGeOfVX0/COJKNVrFsCjpFt
 NkoiCz35MfMTKHocYRAIoChtQyT0NI9WYHMC2hxX/S/nY0/PRNIi607c3VvO1Kj0kg7o
 K2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1BkTCI+47VXu3QHk3YsYNWt55DttbUP6HZu1YPlc//4=;
 b=aIMhshITAr87MUSOPXedv5NSezookEFQNcy4udAAy6meoETk60piaJP1/2uXhCjbgD
 QloTFCtr+C9arzrtCQUMBOk+e4T837C0WkYbVNKXEMfIV1EjZh7LiysBqOp3KAvrzbIe
 /w61SnOXLhcdhafdjo+/ZzEjjMQ1ppohSmhLrMMUZXJAhSI1MWFf8Cf3uoIyXrvMjfe7
 2hGsqzYd665UTaIwAYL/JaCm0LNwaJ/nSP4WLP4tnEefXQu8etxLyUsKb+kq1ogL6zQ5
 /Ed+YxI9WKltaifitR2V9/N2ySlHw+WAmZAgI5zYKj9J46mCwyzYCc1cGlpWSy7Ro4Xb
 EP7g==
X-Gm-Message-State: AOAM530o2ee4WK3o+A78sIfQJ2iMJmaV+AmwJcXB5viDhO+Y2ngGG2x9
 G0o+AFVcuQvLzADJ/3W/IGXTbgTWcoBRg2miL4KAEw==
X-Google-Smtp-Source: ABdhPJxKuWmI5rPFMmFJetHPQjS8iOzqmywKwgqn0gCS8Cw8FQeBnivlRINwccx8S0X7aX7U/o1MtNdj/04Tv6gGBh0=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr762625edw.251.1599596454640; 
 Tue, 08 Sep 2020 13:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200908200123.3402311-1-ehabkost@redhat.com>
In-Reply-To: <20200908200123.3402311-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 21:20:43 +0100
Message-ID: <CAFEAcA9WEjne5TfwggVWPuBprkRs-a2-iNc43Xa_jBamaf9t8A@mail.gmail.com>
Subject: Re: [PULL 00/34] QOM boilerplate cleanup (v2)
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 21:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit b95ba83fc56ebfc4b6869f21db0c757c0c1911=
04:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20200908=
' in=3D
> to staging (2020-09-08 16:18:48 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 86f08d9faa5c05bff56c84ead337063e50e7eb4d:
>
>   virtio-vga: Use typedef name for instance_size (2020-09-08 15:32:38 -04=
00)
>
> Changes included in v2:
> * memory: Remove kernel-doc comment marker (Eduardo Habkost)
>
> ----------------------------------------------------------------
> QOM boilerplate cleanup
>
> Documentation build fix:
> * memory: Remove kernel-doc comment marker (Eduardo Habkost)
>
> QOM cleanups:
> * Rename QOM macros for consistency between
>   TYPE_* and type checking constants (Eduardo Habkost)
>
> QOM new macros:
> * OBJECT_DECLARE_* and OBJECT_DEFINE_* macros (Daniel P. Berrang=3DC3=3DA=
9)
> * DECLARE_*_CHECKER macros (Eduardo Habkost)
>
> Automated QOM boilerplate changes:
> * Automated changes to use DECLARE_*_CHECKER (Eduardo Habkost
> * Automated changes to use OBJECT_DECLARE* (Eduardo Habkost)

Compile failure, Windows:

In file included from /home/petmay01/qemu-for-merges/include/exec/memory.h:=
28:0,
                 from /home/petmay01/qemu-for-merges/include/sysemu/dma.h:1=
3,
                 from ../../hw/nvram/fw_cfg.c:28:
/home/petmay01/qemu-for-merges/include/sysemu/accel.h:65:22: error:
'ACCEL' redeclared as different kind of symbol
                      ACCEL, TYPE_ACCEL)
                      ^
/home/petmay01/qemu-for-merges/include/qom/object.h:571:5: note: in
definition of macro 'DECLARE_INSTANCE_CHECKER'
     OBJ_NAME(const void *obj) \
     ^
/home/petmay01/qemu-for-merges/include/sysemu/accel.h:64:1: note: in
expansion of macro 'DECLARE_OBJ_CHECKERS'
 DECLARE_OBJ_CHECKERS(AccelState, AccelClass,
 ^
In file included from
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/windows.h:72:0,
                 from
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winsock2.h:23,
                 from
/home/petmay01/qemu-for-merges/include/sysemu/os-win32.h:29,
                 from /home/petmay01/qemu-for-merges/include/qemu/osdep.h:1=
19,
                 from ../../hw/nvram/fw_cfg.c:25:
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winuser.h:1757:5:
note: previous declaration of 'ACCEL' was here
   } ACCEL,*LPACCEL;
     ^
Compiling C object libcommon.fa.p/hw_misc_aspeed_scu.c.obj


Compile failure, Linux, NetBSD, FReeBSD:

In file included from ../../hw/riscv/sifive_u.c:51:0:
/home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_u.h:80:5:
error: =E2=80=98SIFIVE_U_PRCI=E2=80=99 redeclared as different kind of symb=
ol
     SIFIVE_U_PRCI,
     ^~~~~~~~~~~~~
In file included from
/home/petmay01/linaro/qemu-for-merges/include/exec/memory.h:28:0,
                 from
/home/petmay01/linaro/qemu-for-merges/include/hw/boards.h:6,
                 from ../../hw/riscv/sifive_u.c:39:
/home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_u_prci.h:63:4=
4:
note: previous definition of =E2=80=98SIFIVE_U_PRCI=E2=80=99 was here
 DECLARE_INSTANCE_CHECKER(SiFiveUPRCIState, SIFIVE_U_PRCI,
                                            ^
/home/petmay01/linaro/qemu-for-merges/include/qom/object.h:571:5:
note: in definition of macro =E2=80=98DECLARE_INSTANCE_CHECKER=E2=80=99
     OBJ_NAME(const void *obj) \
     ^~~~~~~~
In file included from ../../hw/riscv/sifive_u.c:51:0:
/home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_u.h:84:5:
error: =E2=80=98SIFIVE_U_OTP=E2=80=99 redeclared as different kind of symbo=
l
     SIFIVE_U_OTP,
     ^~~~~~~~~~~~
In file included from
/home/petmay01/linaro/qemu-for-merges/include/exec/memory.h:28:0,
                 from
/home/petmay01/linaro/qemu-for-merges/include/hw/boards.h:6,
                 from ../../hw/riscv/sifive_u.c:39:
/home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_u_otp.h:54:43=
:
note: previous definition of =E2=80=98SIFIVE_U_OTP=E2=80=99 was here
 DECLARE_INSTANCE_CHECKER(SiFiveUOTPState, SIFIVE_U_OTP,
                                           ^
/home/petmay01/linaro/qemu-for-merges/include/qom/object.h:571:5:
note: in definition of macro =E2=80=98DECLARE_INSTANCE_CHECKER=E2=80=99
     OBJ_NAME(const void *obj) \
     ^~~~~~~~


and the similar

Compiling C object libqemu-riscv32-softmmu.fa.p/hw_riscv_sifive_e.c.o
In file included from
/home/petmay01/linaro/qemu-for-merges/include/exec/memory.h:28:0,
                 from
/home/petmay01/linaro/qemu-for-merges/include/hw/boards.h:6,
                 from ../../hw/riscv/sifive_e.c:35:
/home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_e_prci.h:56:4=
4:
error: =E2=80=98SIFIVE_E_PRCI=E2=80=99 redeclared as different kind of symb=
ol
 DECLARE_INSTANCE_CHECKER(SiFiveEPRCIState, SIFIVE_E_PRCI,
                                            ^
/home/petmay01/linaro/qemu-for-merges/include/qom/object.h:571:5:
note: in definition of macro =E2=80=98DECLARE_INSTANCE_CHECKER=E2=80=99
     OBJ_NAME(const void *obj) \
     ^~~~~~~~
In file included from ../../hw/riscv/sifive_e.c:45:0:
/home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_e.h:65:5:
note: previous definition of =E2=80=98SIFIVE_E_PRCI=E2=80=99 was here
     SIFIVE_E_PRCI,
     ^~~~~~~~~~~~~
../../hw/riscv/sifive_e.c:63:6: error: array index in initializer not
of integer type
     [SIFIVE_E_PRCI] =3D     { 0x10008000,     0x8000 },
      ^~~~~~~~~~~~~
../../hw/riscv/sifive_e.c:63:6: note: (near initialization for
=E2=80=98sifive_e_memmap=E2=80=99)
../../hw/riscv/sifive_e.c: In function =E2=80=98sifive_e_soc_realize=E2=80=
=99:
../../hw/riscv/sifive_e.c:218:32: error: array subscript is not an integer
     sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
                                ^
Makefile.ninja:4285: recipe for target
'libqemu-riscv32-softmmu.fa.p/hw_riscv_sifive_e.c.o' failed


thanks
-- PMM

