Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF01C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 19:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1712075E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 19:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aD9w7I95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1712075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k87Gu-00069q-3b
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 15:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k87G4-0005Vh-Lt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 15:26:56 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:43081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k87G2-00063b-LK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 15:26:56 -0400
Received: by mail-ej1-x629.google.com with SMTP id m22so23401641eje.10
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cPhBugeFIa8t83g2sjSkSD6SE/byWDXA1iikLhxjCTk=;
 b=aD9w7I95qpp2LTHAaxmm6D4hqaD2o/7cQqhTuKphEhDKe4kb2RIKOqEMhFalDnSy/K
 ullKLFZhpPh2v95MLWsUxZlwtYup79uq0O/HJjY1LTva3qk3UtvqH6DukKfQOcB+Qf88
 Ku2r21+wIfB6o2yLQWqV047SADJwxx+jwkSXSFEx5Sn9W33/Y8Xnv52DAxpLrE4J4dyq
 fP5l8YnOZQXYLGW1u/KHe3MjCYEVijP4CZ82WBWnba+Ub7sVv3b+QuNCOnXO+v4VoSeD
 TFApfpDq4ORpO4627VMd3yOPBjjzvyLHX8ylbVZ/A61vsQcH9EthmzHI3wka1Mn3VWLY
 x00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cPhBugeFIa8t83g2sjSkSD6SE/byWDXA1iikLhxjCTk=;
 b=BeHcruIjiD8uracgpjx2NcPr+aJEf93xhmkvq7PdNeQFJJRk3+62bT+OjYifs6hfA9
 QdaF+vPD6Q6CHcisVdDkeBKDCBLtHTTL5zfMQKNlieHFjFl8ybWM1y7rgsdHoqIIjWrx
 ZggvWLsBLkune6hj0j4DdE7ZyG3oIkyBL2DN1fF3iAUqOvssrHk5oMBaXTdkHpkv+nXs
 PVZbJDXgszZrlgDirAaLvwte1p+V8RzQH98wTDERCGQO6lPmdHmAANghmcApzRn59CkX
 Zns9H07n4SKbTvuA0EqA2+sh5Rmycx03pDaQdgiDEsMqBwpAmLrwuUQB39MgT2Yn4i7S
 m2cA==
X-Gm-Message-State: AOAM530nOr4TYzb3dIdlEgqK8pU8XzjSgd1rx8Tnf1SLjcCkgVAsy2qd
 WShxA5NI6s/qBrtNsPPEOI0bRCkHycVge3WqYq2UZg==
X-Google-Smtp-Source: ABdhPJyoddWG6s/ATf03+Bi/s8jLKNBspjHDx4C72H1vTSQhJqr1aMQlJYRVW8V6dJRahTQ6ubh/e2ZSAWTXtoXqevI=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr21001821ejr.250.1597778812755; 
 Tue, 18 Aug 2020 12:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200818141025.21608-1-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2020 20:26:41 +0100
Message-ID: <CAFEAcA_k1iBQtkdRqQLYUNaJ6QuxHmbz47WpXHRhDgWKfHMm+A@mail.gmail.com>
Subject: Re: [PULL 000/150] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 at 15:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3aecbe785d65e3b92a3617c60e4d226362d9bdd5:
>
>   docs: convert build system documentation to rST (2020-08-18 10:02:43 -0400)


With what I think is the latest version of this pullreq
(commit ea922aa50b2a8688) w32 crossbuilds still fail, even
after a complete blow-away-builddir and rebuild from scratch.

ccache cc -Itarget/s390x/gen-features.p -Itarget/s390x
-I../../target/s390x -fdiagnostics-color=always -pipe
-D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Werror -g -MD -MQ
target/s390x/gen-features.p/gen-features.c.o -MF
target/s390x/gen-features.p/gen-features.c.o.d -o
target/s390x/gen-features.p/gen-features.c.o -c
../../target/s390x/gen-features.c
cc -Ilibqemu-s390x-softmmu.fa.p -I. -I../.. -Itarget/s390x
-I../../target/s390x -Iqapi -Itrace -Iui -Iui/shader
-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/pixman-1
-I/home/petmay01/qemu-for-merges/dtc/libfdt
-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/glib-2.0
-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/glib-2.0/include
-I/home/petmay01/qemu-for-merges/capstone/include
-fdiagnostics-color=always -pipe -Wall -Winvalid-pch -Werror
-std=gnu99 -g -Werror -mms-bitfields -m32 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv -Werror
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wempty-body -Wnested-externs -Wendif-labels -Wno-missing-include-dirs
-Wno-psabi -fstack-protector-strong -iquote
/home/petmay01/qemu-for-merges/tcg/i386 -iquote . -iquote
/home/petmay01/qemu-for-merges -iquote
/home/petmay01/qemu-for-merges/accel/tcg -iquote
/home/petmay01/qemu-for-merges/include -iquote
/home/petmay01/qemu-for-merges/disas/libvixl -DNEED_CPU_H
'-DCONFIG_TARGET="s390x-softmmu-config-target.h"'
'-DCONFIG_DEVICES="s390x-softmmu-config-devices.h"' -MP -o
target/s390x/gen-features target/s390x/gen-features.p/gen-features.c.o
-Wl,--as-needed -Wl,--allow-shlib-undefined
/usr/bin/ld: i386:x86-64 architecture of input file
`target/s390x/gen-features.p/gen-features.c.o' is incompatible with
i386 output
/usr/bin/ld: target/s390x/gen-features.p/gen-features.c.o: file class
ELFCLASS64 incompatible with ELFCLASS32
/usr/bin/ld: final link failed: File in wrong format
collect2: error: ld returned 1 exit status

This is supposed to be building an executable for the
host, but something has gone wrong with the flags passed
to cc for the link. In particular:

-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/pixman-1
and similar are for target-compiles, not host-compiles;
-m32 is the immediate cause of the linker failure since
it's asking the host cc to do a 32-bit build, which then
barfs when fed the 64-bit .o file;
-mms-bitfields is an option that only makes sense for the
target windows builds.

The flags used for the cc-to-build-o-file look more reasonable
(though they're missing a lot of -W options that we could
probably pass it).

thanks
-- PMM

