Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E6C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4862A2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p6yGJmuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4862A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihAXo-0005nf-FS
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 05:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihAXD-0005P3-By
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihAXB-000688-U1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:56:59 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:46412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihAXB-00066n-Ov
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:56:57 -0500
Received: by mail-oi1-x22a.google.com with SMTP id p67so304392oib.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 02:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BZZbIwSAj+mpeIcY/6Nb8cF23JSB9yU7tqhakZrFxxc=;
 b=p6yGJmuUK6M2kLyJG5WsPRU2Dx3OZws8FEkuvVOL0mkMUfkuzFkLwrzsVh//nHYZa/
 psqA35pJnTdCqwW3X5ijOTQVD0RBI2g53BgSq4LljbcV+E4lilQtm5ZTvqHnIqBuYNpn
 OpShMbUAFkbAMEA0DIG0vLFIh9HXUb3Ir6SIsPxXBvq5sT8scTrxrOMoBK4daMuncLto
 O5HZb30jrgsq3NGUWBEyHQiHnlmOpHec6CWTVIesMRhc6PZqOtbuAi/eJ1SkVvRTMIXY
 EkcZP+dZSwcBVkR0UJ3T4apIr3cO+Hu4rbbUAYtQsWoE1P7mCB/kpkPI6htU31FenkHI
 Vr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BZZbIwSAj+mpeIcY/6Nb8cF23JSB9yU7tqhakZrFxxc=;
 b=O/EzIkY7Uzexq2v47eigAgCOrdsRUiRr41grHmou+OkyGQESijXrxo8Xe/As4UqDCr
 dare35PN70qsFljxj2c0G/M9ySqMwkbC0BPwGhXye+QFK/LZ1UpvVa6cjZnmDiF/G1o5
 VJCEpVBtP9sKXWzBm613iYhKN+Knm8HxyQGPJ7GYoKs5vEzlkbc3XwOXwLi0GM2rrcwd
 1AEkmhRipMxp1nQQ3svJ9YcmpHV+kZlBrEMecWYXFMTnoF32VcRDi9ASg/ZvYN+C1KG5
 kvdV6poy0tUl6NyRqq9WiG81GKu35HvPKre9PEdidy+SXGAPhazK4UNVVqsgviu6UvPD
 CxPQ==
X-Gm-Message-State: APjAAAXD4j5U1NBkbHxizCkLBKslPg1V418o3orfB9yPSELaAOOxP1aS
 RlCHNMAM08Y2C1Cl6igGv50zTnnFgrDPivYbSLx1DQ==
X-Google-Smtp-Source: APXvYqyKZUmbWlF/Ms0chsRpFh0B3wk5iIrE505RjFSg1A6M5rkUlJu+pnO2ygqsV1ezr0VL9lNY0H3YDaQoQVTtYM8=
X-Received: by 2002:aca:f484:: with SMTP id s126mr1160698oih.48.1576580216621; 
 Tue, 17 Dec 2019 02:56:56 -0800 (PST)
MIME-Version: 1.0
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 10:56:45 +0000
Message-ID: <CAFEAcA_kFsxDKY-ktQ5E4gHxpkQq0Go38DPevKxgf3pTimRxeg@mail.gmail.com>
Subject: Re: [PULL 00/62] Misc patches for 2019-12-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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

On Mon, 16 Dec 2019 at 16:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b7=
2f:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-12-13 18:14:07 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to cfba0eb1146e7ccf839df29fd99cb90dd3c7640a:
>
>   colo: fix return without releasing RCU (2019-12-16 17:25:46 +0100)
>
> ----------------------------------------------------------------
> * More uses of RCU_READ_LOCK_GUARD (Dave, myself)
> * QOM doc improvments (Greg)
> * Cleanups from the Meson conversion (Marc-Andr=C3=A9)
> * Support for multiple -accel options (myself)
> * Many x86 machine cleanup (Philippe, myself)
> * tests/migration-test cleanup (Juan)
>
> ----------------------------------------------------------------

This generates a set of extra warnings from the clang runtime
sanitizers:

(1) in the bios-tables-test:
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Di386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=3Dqemu-img tests/bios-tabl
es-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name=3D"bios-tables-test"
/home/petmay01/linaro/qemu-for-merges/qom/object.c:390:16: runtime
error: load of value 22, which is not a valid value for type 'bool'

Looking for expected file 'tests/data/acpi/pc/FACP'
Using expected file 'tests/data/acpi/pc/FACP'
Looking for expected file 'tests/data/acpi/pc/APIC'
Using expected file 'tests/data/acpi/pc/APIC'
Looking for expected file 'tests/data/acpi/pc/HPET'
Using expected file 'tests/data/acpi/pc/HPET'
Looking for expected file 'tests/data/acpi/pc/FACS'
Using expected file 'tests/data/acpi/pc/FACS'
Looking for expected file 'tests/data/acpi/pc/DSDT'
Using expected file 'tests/data/acpi/pc/DSDT'
PASS 1 bios-tables-test /i386/acpi/piix4
/home/petmay01/linaro/qemu-for-merges/qom/object.c:390:16: runtime
error: load of value 151, which is not a valid value for type 'bool'

(and others similar)

and in the migration-test:
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Di386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=3Dqemu-img tests/migration-test -m=3Dquick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name=3D"migration-test"
PASS 1 migration-test /i386/migration/deprecated
/home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:689:15:
runtime error: load of value 255, which is not a valid value for type
'bool'
/home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:690:16:
runtime error: null pointer passed as argument 1, which is declared to
never be null
/usr/include/unistd.h:828:48: note: nonnull attribute specified here
PASS 2 migration-test /i386/migration/bad_dest
PASS 3 migration-test /i386/migration/fd_proto
PASS 4 migration-test /i386/migration/validate_uuid
PASS 5 migration-test /i386/migration/validate_uuid_error

I also saw a hang in migration-test (x86 host, aarch64 guest),
but that didn't reoccur on my rerun, so it's intermittent and
might be present already in master.

thanks
-- PMM

