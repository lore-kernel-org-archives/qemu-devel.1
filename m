Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5D8C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7265206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7265206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvpG-0002zE-VQ
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 04:03:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvmS-0007ne-UH
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvZM-0007gQ-83
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJvZM-0007fC-1r
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:46:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DA1CC7A16
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:46:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E94A5D70A;
	Fri, 26 Apr 2019 07:46:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 306E211AAA; Fri, 26 Apr 2019 09:46:45 +0200 (CEST)
Date: Fri, 26 Apr 2019 09:46:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190426074645.zgm2lxfpfwdo2nni@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423132004.13725-9-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 26 Apr 2019 07:46:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 08/11] contrib: add vhost-user-gpu
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426074645.lcQpAR4uLTnbWyLM_txSUNdou8B-MSQ1F40wF3dxhwU@z>

  Hi,

> +#ifdef CONFIG_LIBDRM_INTEL
> +static bool
> +intel_alloc_bo(struct drm_buffer *buf)
> +{
> +    uint32_t tiling = I915_TILING_NONE;
> +
> +    buf->intel_bo = drm_intel_bo_alloc_tiled(buf->dev->bufmgr, "vhost-user-gpu",
> +                                             buf->width, buf->height,
> +                                             (buf->bpp / 8), &tiling,
> +                                             &buf->stride, 0);

Why do you go for intel specific code here?

Can't you do the same with gbm_bo_create() or
gbm_bo_create_with_modifiers() ?

> +static bool
> +intel_map_bo(struct drm_buffer *buf)
> +{
> +    if (drm_intel_gem_bo_map_gtt(buf->intel_bo) != 0) {
> +        return false;
> +    }

gbm_bo_map()

> +static bool
> +intel_export_bo_to_prime(struct drm_buffer *buffer, int *fd)
> +{
> +    if (drm_intel_bo_gem_export_to_prime(buffer->intel_bo, fd) < 0) {
> +        return false;
> +    }

gbm_bo_get_fd()

> +get_pixman_format(uint32_t virtio_gpu_format)
> +{
> +    switch (virtio_gpu_format) {
> +#ifdef HOST_WORDS_BIGENDIAN
> +    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> +        return PIXMAN_b8g8r8x8;

Move that to a header for sharing?  Simliar to the bswap helpers?

> +static void
> +virgl_cmd_create_resource_3d(VuGpu *g,
> +                             struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_resource_create_3d c3d;
> +    struct virgl_renderer_resource_create_args args;
> +
> +    VUGPU_FILL_CMD(c3d);
> +
> +    args.handle = c3d.resource_id;
> +    args.target = c3d.target;
> +    args.format = c3d.format;
> +    args.bind = c3d.bind;
> +    args.width = c3d.width;
> +    args.height = c3d.height;
> +    args.depth = c3d.depth;
> +    args.array_size = c3d.array_size;
> +    args.last_level = c3d.last_level;
> +    args.nr_samples = c3d.nr_samples;
> +    args.flags = c3d.flags;
> +    virgl_renderer_resource_create(&args, NULL, 0);
> +}

The virtio_gpu_resource_create_3d -> virgl_renderer_resource_create_args
mapping looks like an opportunity for code sharing too.

Hmm, but virgl_renderer_resource_create seems to be the only call with
an args struct, so maybe not worth the effort for this single case.

cheers,
  Gerd


