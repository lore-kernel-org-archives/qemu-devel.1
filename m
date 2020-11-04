Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8264EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6491B208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="UHh3nTAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6491B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHqh-0001uX-5p
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kaHk8-00049o-MN; Wed, 04 Nov 2020 07:18:24 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:34605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kaHk6-0008PB-Em; Wed, 04 Nov 2020 07:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/krue73RQvdTWcIblo1I9y7H3d6eOwA1QW3W+4qPpfE=; b=UHh3nTAHNFB2zk0OC/yuN81pAX
 CS3ZhcW/5BcC89K1b2ChCpUquZyD+PzyaUgL8Ho7EDpDwJWA4IZVim23uFNMgtdvecrENGVrtNs2s
 01CK686+wZcKvd7lPZ4BljzXHhOrbVziSz4mYY3VQhU3yOXXGKCChQqqoT2rcJmAmr2UXXkkkV5YI
 nEEBDTWC5LDAqsGp0wZ54FJwoMtufRgdiU+Q8GSfgHfUx2o/UucIDGu5/lFc3X6JJWD/K6rFc0p3x
 3W0m4ixzxQyWOR/ZZ6nRUGTW5O/CaDlLZDTngBRDb28ytW7EQURadvxENGyH+Lk6t++V7qYkPetk7
 UcDWglqg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH-for-5.2 v3 2/4] hw/9pfs: Fix Kconfig dependency problem
 between 9pfs and Xen
Date: Wed, 04 Nov 2020 13:18:09 +0100
Message-ID: <8965407.pN9RvXrJQ9@silver>
In-Reply-To: <20201104115706.3101190-3-philmd@redhat.com>
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201104115706.3101190-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:58:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 4. November 2020 12:57:04 CET Philippe Mathieu-Daud=E9 wrote:
> Commit b2c00bce54c ("meson: convert hw/9pfs, cleanup") introduced
> CONFIG_9PFS (probably a wrong conflict resolution). This config is
> not used anywhere. Backends depend on CONFIG_FSDEV_9P which itself
> depends on CONFIG_VIRTFS.
>=20
> Remove the invalid CONFIG_9PFS and use CONFIG_FSDEV_9P instead, to
> fix the './configure --without-default-devices --enable-xen' build:
>=20
>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function
> `xen_be_register_common': hw/xen/xen-legacy-backend.c:754: undefined
> reference to `xen_9pfs_ops' /usr/bin/ld:
> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undefined reference =
to
> `local_ops' /usr/bin/ld:
> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): undefined reference
> to `synth_ops' /usr/bin/ld:
> libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): undefined reference
> to `proxy_ops' collect2: error: ld returned 1 exit status
>=20
> Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Greg Kurz <groug@kaod.org>
> Tested-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

> ---
> v2: Reworded description (Greg)
>=20
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/Kconfig     | 4 ----
>  hw/9pfs/meson.build | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
> index d3ebd737301..3ae57496613 100644
> --- a/hw/9pfs/Kconfig
> +++ b/hw/9pfs/Kconfig
> @@ -2,12 +2,8 @@ config FSDEV_9P
>      bool
>      depends on VIRTFS
>=20
> -config 9PFS
> -    bool
> -
>  config VIRTIO_9P
>      bool
>      default y
>      depends on VIRTFS && VIRTIO
>      select FSDEV_9P
> -    select 9PFS
> diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
> index cc094262122..99be5d91196 100644
> --- a/hw/9pfs/meson.build
> +++ b/hw/9pfs/meson.build
> @@ -15,6 +15,6 @@
>    'coxattr.c',
>  ))
>  fs_ss.add(when: 'CONFIG_XEN', if_true: files('xen-9p-backend.c'))
> -softmmu_ss.add_all(when: 'CONFIG_9PFS', if_true: fs_ss)
> +softmmu_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
>=20
>  specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true:
> files('virtio-9p-device.c'))

Best regards,
Christian Schoenebeck



