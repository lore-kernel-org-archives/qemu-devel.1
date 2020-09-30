Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6897DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7042075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b281skf4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7042075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNX1s-0001NI-Ch
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kNX0r-0000bx-N4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kNX0o-00055Z-EV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:58:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601452732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UK1L1ZkImu26Sre+1+L0kxvnt8evmM4tiE1NkrMAeg=;
 b=b281skf4qGtyA8i4V0uphLdjBQwZG2uDpL6HYR72ZrIl3cwtK4C+72UCxrlGslGzSk/6aU
 x3hTAL8vmf43m74DCag4cqbTiOe/nQ+yChChLwGr1H/K0cnYdp1ymE2I9Wb85klWy8LpPx
 NXOh1jKAtLwLozpnaWf+KdmPjHZcJzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-TJ916KJOOwqggiYIDRRdIw-1; Wed, 30 Sep 2020 03:58:46 -0400
X-MC-Unique: TJ916KJOOwqggiYIDRRdIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C030E1074652;
 Wed, 30 Sep 2020 07:58:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE085C1CF;
 Wed, 30 Sep 2020 07:58:42 +0000 (UTC)
Date: Wed, 30 Sep 2020 09:58:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v4 00/12] Support disabling TCG on ARM (part 2)
Message-ID: <20200930095841.3df7f8ee@redhat.com>
In-Reply-To: <20200929224355.1224017-1-philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Sep 2020 00:43:43 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Cover from Samuel Ortiz from (part 1) [1]:
>=20
>   This patchset allows for building and running ARM targets with TCG
>   disabled. [...]
>=20
>   The rationale behind this work comes from the NEMU project where we're
>   trying to only support x86 and ARM 64-bit architectures, without
>   including the TCG code base. We can only do so if we can build and run
>   ARM binaries with TCG disabled.

I don't recall exact reason but TCG variant is used by bios-tables-test
to test arm/virt so it will probably break that
(it has something to do with how KVM uses CPU/GIC, which was making
ACPI tables not stable (i.e. depend on host), so comparison with master
tables was failing)


>=20
> v4 almost 2 years later... [2]:
> - Rebased on Meson
> - Addressed Richard review comments
> - Addressed Claudio review comments
>=20
> v3 almost 18 months later [3]:
> - Rebased
> - Addressed Thomas review comments
> - Added Travis-CI job to keep building --disable-tcg on ARM
>=20
> v2 [4]:
> - Addressed review comments from Richard and Thomas from v1 [1]
>=20
> Regards,
>=20
> Phil.
>=20
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html
> [2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html
> [3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg641796.html
> [4]: https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05003.html
>=20
> Green CI:
> - https://cirrus-ci.com/build/4572961761918976
> - https://gitlab.com/philmd/qemu/-/pipelines/196047779
> - https://travis-ci.org/github/philmd/qemu/builds/731370972
>=20
> Based-on: <20200929125609.1088330-1-philmd@redhat.com>
> "hw/arm: Restrict APEI tables generation to the 'virt' machine"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg745792.html
>=20
> Philippe Mathieu-Daud=C3=A9 (10):
>   accel/tcg: Add stub for cpu_loop_exit()
>   meson: Allow optional target/${ARCH}/Kconfig
>   target/arm: Select SEMIHOSTING if TCG is available
>   target/arm: Restrict ARMv4 cpus to TCG accel
>   target/arm: Restrict ARMv5 cpus to TCG accel
>   target/arm: Restrict ARMv6 cpus to TCG accel
>   target/arm: Restrict ARMv7 R-profile cpus to TCG accel
>   target/arm: Restrict ARMv7 M-profile cpus to TCG accel
>   target/arm: Reorder meson.build rules
>   .travis.yml: Add a KVM-only Aarch64 job
>=20
> Samuel Ortiz (1):
>   target/arm: Do not build TCG objects when TCG is off
>=20
> Thomas Huth (1):
>   target/arm: Make m_helper.c optional via CONFIG_ARM_V7M
>=20
>  default-configs/arm-softmmu.mak |  3 --
>  meson.build                     |  8 +++-
>  target/arm/cpu.h                | 12 ------
>  accel/stubs/tcg-stub.c          |  5 +++
>  target/arm/cpu_tcg.c            |  4 +-
>  target/arm/helper.c             |  7 ----
>  target/arm/m_helper-stub.c      | 73 +++++++++++++++++++++++++++++++++
>  .travis.yml                     | 35 ++++++++++++++++
>  hw/arm/Kconfig                  | 32 +++++++++++++++
>  target/arm/Kconfig              |  4 ++
>  target/arm/meson.build          | 40 +++++++++++-------
>  11 files changed, 184 insertions(+), 39 deletions(-)
>  create mode 100644 target/arm/m_helper-stub.c
>  create mode 100644 target/arm/Kconfig
>=20


