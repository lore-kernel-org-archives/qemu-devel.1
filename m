Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91EDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7612087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T09zr3yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7612087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG02D-0007GA-CO
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG00m-00061e-Mk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:19:44 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:37049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG00k-00040c-LM
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:19:44 -0400
Received: by mail-ed1-x534.google.com with SMTP id n22so2620799edt.4
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yLiICTPt0aNI+VMvgbXkQv6nz9Ww/XtwsC2eAX7Ngi8=;
 b=T09zr3yGEFyKt5pNj/z40FfHHpEtQ4dRJEYmDJZnnbZlohn8dGLb6frLGu7ZM+JJpk
 /7eU6dQCKthsdnEjHOmuJI6PhIZ8qB9cGvozqgN3ejko6SZtRYiP7E6VT+rKpOXXoXWl
 RSWaKy0Uko/wFoutRsExPW4A5B4SkbHvE/ERPFno1aZNFrJwzIc3S1wdkxu1DT3DnGRj
 jzV6iWsyNeKTWZR89M8MCDeFMXVI492pIyq/jLA9OMhEVXl/vjAiftClYMNdbZnogd+O
 kipo9EO+Z6ZXtF5QlhgwhKdDfpC2ivU6iZmqSBp14knQkbnsm4Q35wbOnN2/sfbrotbs
 ZmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yLiICTPt0aNI+VMvgbXkQv6nz9Ww/XtwsC2eAX7Ngi8=;
 b=CKE4tHUJOssm6I3t2jxu2Q32XJajs5Lw0pJ+jrMug9EAdC20DxzFT8J/y2EBEGDftz
 dzfhfKV9Iieo7sOPZ/UpYlVSHtcdeD0avuWRC//lHMgxwUJWPPZKaNWEpd0gxjNnElmf
 DZ6fCRWS3jUo1FFFuUgaZQDDt3tXI7aADL3vFsYq0GnItmuvzG6gE17mMT0rF2C2Ntnp
 BFcK7dP8EdAlMFG0I6Im6aUp3T0LB+I5XzVMqbXesFyL73So7WY+TmnpTDdPpAhVt1t+
 iOr23g+nS7SIDJl2IdJongHNv5JiUG+A2yHBXFRQnwD6idf7xc63rEarR0TsV12eAklk
 /QdQ==
X-Gm-Message-State: AOAM53216BLY9/cScnG8WgxaNdyuVo9/Sxx0ZFEHeIRE6sSIy6DEFkJk
 BlBefJ8/O4ZaYSCP0C+TX7VyjDvjnDJmyG5Gr9EeCg==
X-Google-Smtp-Source: ABdhPJxOCRIejcaiQrN2dqP2m8jIQ7OjH3PjSN582Vb+4iFt5TOwynY5XJzWS5W0mS90kclkm4Rh1oJnBN7ySPqXJYw=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr4218802edm.100.1599657580617; 
 Wed, 09 Sep 2020 06:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200908215239.3519638-1-ehabkost@redhat.com>
In-Reply-To: <20200908215239.3519638-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 14:19:29 +0100
Message-ID: <CAFEAcA9E04CfeD=75idggFOCX2Tv0SfK0SyQrUvK3VeO4N9VBQ@mail.gmail.com>
Subject: Re: [PULL 00/34] QOM boilerplate cleanup (v3)
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 8 Sep 2020 at 22:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Changes v2 -> v3:
> * Fix build errors: dropped all changes in
>   include/hw/riscv/sifive* and include/accel/accel.h
>
> The following changes since commit 6779038537360e957dbded830f76b08ef5070161:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-09-08' int=
> o staging (2020-09-08 17:23:31 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 7661577c45301bf37a56988eeb084e01bd119de7:
>
>   virtio-vga: Use typedef name for instance_size (2020-09-08 17:32:01 -0400)
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
> * OBJECT_DECLARE_* and OBJECT_DEFINE_* macros (Daniel P. Berrang=C3=A9)
> * DECLARE_*_CHECKER macros (Eduardo Habkost)
>
> Automated QOM boilerplate changes:
> * Automated changes to use DECLARE_*_CHECKER (Eduardo Habkost
> * Automated changes to use OBJECT_DECLARE* (Eduardo Habkost)

Link failure on FreeBSD trying to build tests/test-char:

cc  -o tests/test-char tests/test-char.p/test-char.c.o
tests/test-char.p/socket-helpers.c.o -Wl,--as-needed
-Wl,--no-undefined -pie -Wl,--whole-archive qom/libqom.fa io/libio.fa
crypto/libcrypto.fa authz/libauthz.fa chardev/libchardev.fa
-Wl,--no-whole-archive -Wl,-z,relro -Wl,-z,now -m64
-fstack-protector-strong -Wl,--start-group libqemuutil.a qom/libqom.fa
io/libio.fa crypto/libcrypto.fa authz/libauthz.fa
chardev/libchardev.fa -L/usr/local/lib -lgnutls -L/usr/local/lib
-lgio-2.0 -lgobject-2.0 -lglib-2.0 -lintl -L/usr/local/lib -lgio-2.0
-lgobject-2.0 -lglib-2.0 -lintl -pthread -lutil -lm -L/usr/local/lib
-lgthread-2.0 -lglib-2.0 -lintl -L/usr/local/lib -lgnutls
-L/usr/local/lib -lnettle -lpam -Wl,--end-group
ld: error: undefined symbol: PARALLEL_CHARDEV
>>> referenced by char-parallel.c:236 (../src/chardev/char-parallel.c:236)
>>>               char-parallel.c.o:(qmp_chardev_open_parallel) in archive chardev/libchardev.fa

ld: error: undefined symbol: PARALLEL_CHARDEV
>>> referenced by char-parallel.c:191 (../src/chardev/char-parallel.c:191)
>>>               char-parallel.c.o:(pp_ioctl) in archive chardev/libchardev.fa
cc: error: linker command failed with exit code 1 (use -v to see invocation)
gmake: *** [Makefile.ninja:5822: tests/test-char] Error 1
gmake: *** Waiting for unfinished jobs....

All other platforms built OK.

thanks
-- PMM

