Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEBFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3432720679
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3432720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFL1-00048M-2L
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kaFJv-0003iF-D7
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:43:11 -0500
Received: from 9.mo51.mail-out.ovh.net ([46.105.48.137]:60426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kaFJt-0004yZ-Ac
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:43:11 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.47])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 389B1232EDE;
 Wed,  4 Nov 2020 10:43:04 +0100 (CET)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 4 Nov 2020
 10:43:03 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00225ad514c-a9bd-4a8c-ab32-ef9d4c5470ae,
 B675344909C57F45DE6B9FBDE8367EDF8CA03E23) smtp.auth=groug@kaod.org
Date: Wed, 4 Nov 2020 10:43:01 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v2 2/4] hw/9pfs: Fix Kconfig dependency problem
 between 9pfs and Xen
Message-ID: <20201104104301.6a6e0009@bahia.lan>
In-Reply-To: <20201104084327.3010593-3-philmd@redhat.com>
References: <20201104084327.3010593-1-philmd@redhat.com>
 <20201104084327.3010593-3-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: aae0851a-7046-4d90-b8af-7274b98f0a0c
X-Ovh-Tracer-Id: 8622141487906920720
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopeigvghnqdguvghvvghlsehlihhsthhsrdigvghnphhrohhjvggtthdrohhrgh
Received-SPF: pass client-ip=46.105.48.137; envelope-from=groug@kaod.org;
 helo=9.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 04:43:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia
 Huck <cohuck@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, Anthony
 Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  4 Nov 2020 09:43:25 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Fixes './configure --without-default-devices --enable-xen' build:
>=20
>   /usr/bin/ld: libcommon.fa.p/hw_xen_xen-legacy-backend.c.o: in function =
`xen_be_register_common':
>   hw/xen/xen-legacy-backend.c:754: undefined reference to `xen_9pfs_ops'
>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x8): undef=
ined reference to `local_ops'
>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x20): unde=
fined reference to `synth_ops'
>   /usr/bin/ld: libcommon.fa.p/fsdev_qemu-fsdev.c.o:(.data.rel+0x38): unde=
fined reference to `proxy_ops'
>   collect2: error: ld returned 1 exit status
>=20
> Fixes: b2c00bce54c ("meson: convert hw/9pfs, cleanup")
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> I'm not sure b2c00bce54c is the real culprit
>=20

FWIW this commit introduced the 9PFS config which isn't used
anywhere. Backends depend on FSDEV_9P which itself depends
on VIRTFS. So I tend to think b2c00bce54c is the culprit
but _of couse_ I could be wrong :)

Anyway, this patch (+ patch 1) fix the build break mentioned
in the changelog so:

Acked-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>

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
> =20
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
> =20
>  specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-devi=
ce.c'))


