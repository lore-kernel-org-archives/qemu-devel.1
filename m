Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B2CC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55D62065D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsFV9m4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55D62065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaf02-0001Zj-E8
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kaez7-0000oG-2f
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kaez3-0000dA-Ln
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604581640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZjvhQ+VyLDneEqqJ85vjkYZQugcXUEY1t8QBvzRR3g=;
 b=GsFV9m4ZGuz741kP3jHbv3GicY0wMESdSRnIUZiukcAz/bmdaGIkbn0wUmJzkPiGssaK2a
 M5nN82rdC6AdAr36z245YSMc/CHXfuanTjq/reGJ5F4FELhc1Dg2+zsnqAwQVxdBYRdWDF
 Vpps+/fow675n/5acbn2j4qyMLl7shw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-VY_XQ7BiMtesknmUbVTg6w-1; Thu, 05 Nov 2020 08:07:19 -0500
X-MC-Unique: VY_XQ7BiMtesknmUbVTg6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF9F980B71A;
 Thu,  5 Nov 2020 13:07:17 +0000 (UTC)
Received: from gondolin (ovpn-112-138.ams2.redhat.com [10.36.112.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8CD21002C31;
 Thu,  5 Nov 2020 13:06:55 +0000 (UTC)
Date: Thu, 5 Nov 2020 14:06:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-6.0 1/3] hw/virtio: Add configure switch to disable
 legacy VIRTIO
Message-ID: <20201105140652.6c975b9e.cohuck@redhat.com>
In-Reply-To: <20201105124353.3680057-2-philmd@redhat.com>
References: <20201105124353.3680057-1-philmd@redhat.com>
 <20201105124353.3680057-2-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Nov 2020 13:43:51 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Per [1] (Terminology):
>=20
>   Legacy interfaces are not required; ie. don=E2=80=99t implement them
>   unless you have a need for backwards compatibility!
>=20
> [2] (Version 1.0):
>=20
>   The device configuration space uses the little-endian format
>   for multi-byte fields.
>=20
> and [3] (Legacy Interface):
>=20
>   for legacy interfaces, device configuration space is generally
>   the guest=E2=80=99s native endian, rather than PCI=E2=80=99s little-end=
ian.
>   The correct endian-ness is documented for each device.
>=20
> Add the --disable-virtio-legacy configure flag to produce builds
> with VIRTIO 1.0 only, and the --enable-virtio-legacy to include
> legacy VIRTIO support (supporting legacy VIRTIO is the default).

This is only dealing with endianess issues; there are other differences
on the control plane as well.

Currently, virtio-pci has the option to make devices non-transitional,
but virtio-ccw has not (only for device types). For virtio-mmio, you
need to select one of legacy or non-transitional, IIRC.

>=20
> [1] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.h=
tml#x1-60001
> [2] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.h=
tml#x1-170003
> [3] http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.h=
tml#x1-200003
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  configure                         | 10 ++++++++++
>  meson.build                       |  1 +
>  include/hw/virtio/virtio-access.h | 19 +++++--------------
>  hw/virtio/virtio-legacy.c         | 29 +++++++++++++++++++++++++++++
>  hw/virtio/meson.build             |  1 +
>  5 files changed, 46 insertions(+), 14 deletions(-)
>  create mode 100644 hw/virtio/virtio-legacy.c

(...)

> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
> index 6818a23a2d3..b6c060f8cc6 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -20,24 +20,15 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-bus.h"
> =20
> -#if defined(TARGET_PPC64) || defined(TARGET_ARM)
> -#define LEGACY_VIRTIO_IS_BIENDIAN 1
> -#endif
> -
> +#ifdef CONFIG_VIRTIO_LEGACY
> +bool virtio_access_is_big_endian(VirtIODevice *vdev);
> +#else
>  static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>  {
> -#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> -    return virtio_is_big_endian(vdev);
> -#elif defined(TARGET_WORDS_BIGENDIAN)
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> -        return false;
> -    }
> -    return true;
> -#else
> +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>      return false;

This will make migration from a QEMU that has devices for which 1.0 has
not been negotiated fail.

> -#endif
>  }
> +#endif
> =20
>  static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
>  {


