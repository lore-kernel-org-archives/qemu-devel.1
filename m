Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F80C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1955E2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8XkE+DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1955E2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVtTm-00026m-DI
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVtSe-0001bC-Pj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:34:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVtSc-0003Z1-Ng
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 05:34:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id e2so782974wme.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=H2iRsKVL6EY6l0LBosnmoseFejYzzjApIoYOrRbruAw=;
 b=c8XkE+DJg6F4FPpNendbCZHBEUvxKY3bE4MI8sLOc3NwZlToeblcnB2ubko0knuvTH
 t81PR/oQMo5wBIG1F4k4b1La0nFEHENx7c2U0g5W6wWFg0RBFqMm/zN+dujZU4K5D9bT
 1c9lI7f4Cc0HvAxvsLznzFsHLv6KKoTTRSvXSFl4tVEVKBAB45xgfR66TJnoBm1nS6pi
 Z1bHCRxpPYhZeE3yD6RIRCsutrT+Qi6DyFLahE3ZKhmucOFjWfSYxC37hplj9AdXi5pg
 Yfz7zZcPYMJE/44CGOLbeFbZW6HVcHoyuM5kWbfoXIYRZ/fLdM5fQ9dneYZnohu491Ze
 1HlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=H2iRsKVL6EY6l0LBosnmoseFejYzzjApIoYOrRbruAw=;
 b=T5K6xub9ErfAqEa3izjIA+A7GjGlv7Tvicb8T0q5HyC9ObRIZORk/AijxL6wlpYE+n
 +rUMsaYb0kaOH3obU+2adWkXukB3SGsJX8Mmi624vHZ2klkCtBfzxarJ5Rtv2kKAaop2
 /OKrFLBrRiCQZ/BfWSpc9wdFt/UllklMiv2PbL1LV7J/qf4AcRNetz7MrFA+BQMdbM4F
 0/f9Nk4CxixJ7zlg+lZle9Zr6dMeRJIPEt5+asY8Br91G0dkGiKDckVSoGfpmgK7Iini
 mbrS5TqMudGC7UdlbbXS+Z83rp0Mx8vXI9ZhxTx40+r0x4DcN4pNresuwsAGb/jJUtus
 AgbA==
X-Gm-Message-State: AOAM530oje52AZSFCIDkOQHuirWMgB4cYAKPB9tptF6fq7lZrxPXDWhd
 SrwJ/WtVDPU30cc1NT88aerBgw==
X-Google-Smtp-Source: ABdhPJxdwrejujsZesd3qo4d9ytaAwax+qR8L9XHxi+e9uNQ3OeXHVYxMJm7ZbRjHslTofJULWJ68A==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr1368077wmi.50.1603445648679; 
 Fri, 23 Oct 2020 02:34:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm2026330wro.13.2020.10.23.02.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 02:34:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 214BE1FF7E;
 Fri, 23 Oct 2020 10:34:07 +0100 (BST)
References: <87o8kttj2e.fsf@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Tips for debugging GPU acceleration.
In-reply-to: <87o8kttj2e.fsf@linaro.org>
Date: Fri, 23 Oct 2020 10:34:07 +0100
Message-ID: <87imb1thf4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
Cc: qemu-devel@nongnu.org, agl-dev-community@lists.automotivelinux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

(fix the qemu-devel address)

> Hi Gerd,
>
> I'm currently trying to get accelerated graphics working on an AArch64
> AGL distribution (both in KVM and TCG builds). As far as I can tell the
> device is being correctly created and I do get a working DRI based
> display. However the Weston based compositor falls back to the softpipe
> rendering:
>
>   Date: 2020-10-22 UTC
>   [19:37:22.296] Using config file '/etc/xdg/weston/weston.ini'.
>   [19:37:22.297] Output repaint window is 7 ms maximum.
>   [19:37:22.298] Loading module '/usr/lib/libweston-8/drm-backend.so'
>   [19:37:22.318] initializing drm backend
>   [19:37:22.323] logind: not running in a systemd session
>   [19:37:22.323] logind: cannot setup systemd-logind helper (-61), using =
legacy fallback
>   [19:37:22.370] using /dev/dri/card0
>   [19:37:22.370] DRM: supports universal planes
>   [19:37:22.370] DRM: supports atomic modesetting
>   [19:37:22.370] DRM: supports picture aspect ratio
>   [19:37:22.373] Loading module '/usr/lib/libweston-8/gl-renderer.so'
>   [19:37:22.540] EGL client extensions: EGL_EXT_client_extensions
>                  EGL_EXT_device_base EGL_EXT_device_enumeration
>                  EGL_EXT_device_query EGL_EXT_platform_base
>                  EGL_KHR_client_get_all_proc_addresses EGL_KHR_debug
>                  EGL_EXT_platform_wayland EGL_MESA_platform_gbm
>                  EGL_MESA_platform_surfaceless EGL_EXT_platform_device
>   [19:37:22.542] EGL version: 1.4
>   [19:37:22.542] EGL vendor: Mesa Project
>   [19:37:22.542] EGL client APIs: OpenGL OpenGL_ES=20
>   [19:37:22.542] EGL extensions: EGL_ANDROID_blob_cache EGL_EXT_buffer_age
>                  EGL_EXT_image_dma_buf_import EGL_KHR_cl_event2
>                  EGL_KHR_config_attribs EGL_KHR_create_context
>                  EGL_KHR_create_context_no_error EGL_KHR_fence_sync
>                  EGL_KHR_get_all_proc_addresses EGL_KHR_gl_colorspace
>                  EGL_KHR_gl_renderbuffer_image EGL_KHR_gl_texture_2D_image
>                  EGL_KHR_gl_texture_3D_image EGL_KHR_gl_texture_cubemap_i=
mage
>                  EGL_KHR_image EGL_KHR_image_base EGL_KHR_image_pixmap
>                  EGL_KHR_no_config_context EGL_KHR_reusable_sync
>                  EGL_KHR_surfaceless_context EGL_EXT_pixel_format_float
>                  EGL_KHR_wait_sync EGL_MESA_configless_context
>                  EGL_MESA_image_dma_buf_export EGL_MESA_query_driver
>   [19:37:22.542] warning: Disabling render GPU timeline and explicit sync=
hronization due to missing EGL_ANDROID_native_fence_sync extension
>   [19:37:22.542] EGL_KHR_surfaceless_context available
>   [19:37:22.819] GL version: OpenGL ES 3.1 Mesa 20.0.2
>   [19:37:22.819] GLSL version: OpenGL ES GLSL ES 3.10
>   [19:37:22.819] GL vendor: VMware, Inc.
>   [19:37:22.819] GL renderer: softpipe
>   [19:37:22.819] GL extensions: GL_EXT_blend_minmax GL_EXT_multi_draw_arr=
ays
>
> I know the kernel has the right bits enabled (VIRTIO_DRM_GPU) but the
> kernel seems to think the host needs something else to support it:
>
>   [    2.743035] virtio-pci 0000:00:04.0: enabling device (0000 -> 0003)
>   [    2.746441] virtio-pci 0000:00:05.0: enabling device (0000 -> 0002)
>   [    2.778843] random: fast init done
>   [    2.780024] random: crng init done
>   [    2.781054] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuff=
ers: bar 0: 0x10000000 -> 0x10ffffff
>   [    2.781597] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuff=
ers: bar 2: 0x11014000 -> 0x11014fff
>   [    2.786609] bochs-drm 0000:00:02.0: enabling device (0000 -> 0002)
>   [    2.789259] [drm] Found bochs VGA, ID 0xb0c5.
>   [    2.789639] [drm] Framebuffer size 16384 kB @ 0x10000000, mmio @ 0x1=
1014000.
>   [    2.791527] [TTM] Zone  kernel: Available graphics memory: 2015562 K=
iB
>   [    2.792300] [TTM] Initializing pool allocator
>   [    2.793275] [TTM] Initializing DMA pool allocator
>   [    2.801629] [drm] Found EDID data blob.
>   [    2.809735] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:0=
2.0 on minor 0
>   [    2.903431] Console: switching to colour frame buffer device 128x48
>   [    2.928141] bochs-drm 0000:00:02.0: fb0: bochs-drmdrmfb frame buffer=
 device
>   [    2.929844] [drm] pci: virtio-gpu-pci detected at 0000:00:05.0
>   [    2.930300] [drm] virgl 3d acceleration not supported by host
>   [    2.930484] [drm] EDID support available.
>   [    2.931193] [drm] number of scanouts: 1
>   [    2.931318] [drm] number of cap sets: 0
>   [    2.935329] [drm] Initialized virtio_gpu 0.1.0 0 for virtio4 on mino=
r 1
>   [    3.058526] virtio_gpu virtio4: fb1: virtio_gpudrmfb frame buffer de=
vice
>
> I'm invoking QEMU on both systems with:
>
>   -device virtio-gpu-pci,virgl=3Dtrue
>
> The full TCG command line is:
>
>   ./aarch64-softmmu/qemu-system-aarch64 -cpu cortex-a57 \
>     -machine type=3Dvirt,virtualization=3Don,gic-version=3D3 \
>     -serial mon:stdio \
>     -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
>     -device virtio-net-device,netdev=3Dunet,id=3Dvirt-net \
>     -drive id=3Ddisk0,file=3D$HOME/images/agl/agl-demo-platform-crosssdk-=
qemuarm64.ext4,if=3Dnone,format=3Draw \
>     -device virtio-blk-device,drive=3Ddisk0 \
>     -soundhw hda \
>     -device qemu-xhci \
>     -device usb-tablet \
>     -device usb-kbd \
>     -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
>     -device virtio-rng-pci,rng=3Drng0 \
>     -device virtio-serial-device \
>     -chardev null,id=3Dvirtcon \
>     -device virtconsole,chardev=3Dvirtcon \
>     -m 4096 \
>     -kernel ~/images/agl/Image \
>     -append "console=3DttyAMA0 root=3D/dev/vda" \
>     -display gtk,show-cursor=3Don \
>     -smp 4 \
>     -device virtio-gpu-pci,virgl=3Dtrue
>
> Any tips on how to track down where things are going wrong?


--=20
Alex Benn=C3=A9e

