Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00307C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE7D20658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5HjlQwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE7D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SaZ-0004Cf-Th
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8SZh-0003YM-Fd
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:12:37 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8SZf-00082n-IB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:12:37 -0400
Received: by mail-ed1-x543.google.com with SMTP id bs17so18887862edb.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I0DRYBjTQ7P6N8XyQEwE6Q2UN46ebi0hU9x/X0ugszQ=;
 b=u5HjlQwJ19eAs20l2oMEor3Td9eYA7akCJIJ5RYQHbWwPmQUxwDT+Cyf9lYwCRb/dW
 xkqW8jOqwNCRVKo75W5h3gps0WW6U8rm5fVluEUWMKHw4MJ9p+liJrTXxbo7lK8ACh2Y
 v2DPAY/hLgAaZGYQrY7lyjR83e/PCPUQjyaSOBMX9HDn9GrczccIEleNrug9yytKjsAe
 umDcqBcxcopg7n7e392SmJRb0sfyB/XTSpp58T7QbOrP/M5h7YNf7njQ/LvqQhERhYxs
 tOaOykGx6d6IRcgd4qCIAazm465CIGeka9VL20x/pJYVKOjHcJ8lc5qWAv8+zNiPoi1c
 sEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I0DRYBjTQ7P6N8XyQEwE6Q2UN46ebi0hU9x/X0ugszQ=;
 b=DTAzt785XC8ydbQ/5ORLrp8QQZGRmAYmBCNmN66Yv11GF624pQe7c6rKWxhsYE8qVa
 O1z3ZseAjbTkwcgwblqxN9fGS3Pii0crxPagcXavZQTK7hK5eCqVm0IPwgYbKWcm6r6G
 lZzw7/xRbAGCq8iLjrWogYXXgL8s1Dln2V5tIX9omI2EoT3cGqkLLXX/PQtQAuGOyXwu
 p55UwUKlPVmr1QedulKLruyNNtY4kRftBTDw2wHvf4IOPpOf/pOHFekp/AOn2Pl/KhQL
 lmeoJWgLkO23GNvAOSqCn03dXEtNQ5xxCPUZI/Gk0CEA0ZW5vy1XS9MUuuANUII5TQdz
 wlcg==
X-Gm-Message-State: AOAM532fRZuiIRqkjgzW87aP4fNC7ifctOS0AJY2rUVObtf9C2T2/+wl
 X/bwjFyAhP2g6D37+F57fBDvgmpgaW0VJjLZ3V5eZg==
X-Google-Smtp-Source: ABdhPJw+Acl2IyFiDyb4cQEK+YcblTaC+Aq/HXuUNF+XRvZbqSALE11Jl+6tsXBJoAywZl9kQ5lMH/HgcVIVzG1FgcA=
X-Received: by 2002:a05:6402:1218:: with SMTP id
 c24mr25202603edw.44.1597860752946; 
 Wed, 19 Aug 2020 11:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143525.2175-1-pbonzini@redhat.com>
In-Reply-To: <20200819143525.2175-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Aug 2020 19:12:21 +0100
Message-ID: <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Wed, 19 Aug 2020 at 15:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f5b5ef3b9f94d744f514f5469c97d3f80305111e:
>
>   docs: convert build system documentation to rST (2020-08-19 10:01:48 -0400)
>
> v5->v6: improved incremental build
>
> ----------------------------------------------------------------
> New build system.
>
> Missing:
> * converting configure tests
> * converting unit tests
> * converting some remaining parts of the installation

Testing with what I think is the later commit 84264b99322
the all-linux-static build fails "make check":

ccache gcc -iquote
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static -iquote
/home/petmay01/linaro/qemu-for
-merges/build/all-linux-static/tests -iquote tests -iquote
/home/petmay01/linaro/qemu-for-merges/tcg/i386 -isystem /ho
me/petmay01/linaro/qemu-for-merges/linux-headers
-I/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/linux-
headers -iquote . -iquote /home/petmay01/linaro/qemu-for-merges
-iquote /home/petmay01/linaro/qemu-for-merges/accel/tc
g -iquote /home/petmay01/linaro/qemu-for-merges/include -iquote
/home/petmay01/linaro/qemu-for-merges/disas/libvixl -W
error  -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -m64 -mcx16 -D_GNU_SOURCE
-D_FILE
_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
 -fno-strict-aliasing -fno-common -fwrapv  -Wold-style-declaration
-Wold-style-definition -Wtype-limits -Wformat-secur
ity -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body
-Wnested-externs -Wendif-labels -Wexpansion-to-defined
-Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
-fstack-protector-strong    -I/home/petmay01/linaro/qem
u-for-merges/capstone/include
-I/home/petmay01/linaro/qemu-for-merges/tests
-I/home/petmay01/linaro/qemu-for-merges/te
sts/qtest -MMD -MP -MT tests/check-qom-proplist.o -MF
tests/check-qom-proplist.d -g -std=gnu99 -Wall  -c -o tests/chec
k-qom-proplist.o
/home/petmay01/linaro/qemu-for-merges/tests/check-qom-proplist.c
make: Leaving directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
make: *** No rule to make target 'check-block', needed by 'check'. Stop.
make: *** Waiting for unfinished jobs....
[various other output from other parallel jobs snipped]

This is from the build whose configure rune is
'--cc=ccache gcc' '--enable-debug' '--static' '--disable-system'
'--disable-gnutls'

Also one of my random "just test linux-user" setups fails
because the build doesn't seem to have put the final binaries
in the right place:

make: Entering directory '/home/petmay01/linaro/linux-user-test-0.3'
./qemu-linux-user.sh
[qemu-i386]
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/i386-linux-user/qemu-i386
-L ./gnemul/qemu-i386 i386/ls -l dummyfile
./qemu-linux-user.sh: 54: ./qemu-linux-user.sh:
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/i386-linux-user/qemu-i386:
not found
Makefile:6: recipe for target 'test' failed
make: *** [test] Error 127
make: Leaving directory '/home/petmay01/linaro/linux-user-test-0.3'

I can live with the .o files moving around (though I would have
preferred it if they did not), but the final binaries should be
being built into the same places we always have. Otherwise we're
going to break a lot of "just run from the build tree" setups
and instructions.

Everything else seems to have passed.

thanks
-- PMM

