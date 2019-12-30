Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1455FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FDA20730
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I63uBrV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FDA20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iltKL-0000Uw-Ql
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iltJO-0008FI-DM
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iltJM-0007ZD-6q
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:34:14 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iltJL-0007X5-UE; Mon, 30 Dec 2019 06:34:12 -0500
Received: by mail-io1-xd42.google.com with SMTP id r13so21107206ioa.3;
 Mon, 30 Dec 2019 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UvT7Unor9M3eflo5yQDL/TjbsnMQ6Gi8P0jhCttW2S4=;
 b=I63uBrV0C7P9yGBlOg9o5Xq27pdMZ9KGBQ3sW7+dt0u5wJJIheCuqnH/BWHdNnefDb
 QoxgISi+sDHzH60jrg5ME7Bv/sjkjGLt+Qh2JJ2uOLd4sqYNPS+8hGbyaMrKp1AwBE4b
 OkeYP9Rn4tQfjZzcS+nM3k+nuEeWWdTFlSgsXGHMRIhCcQ4wsSzHcr7p1XpcHMXpiSfT
 disfJVGnyDvKHKSuLmBhn4Z0QjbjhAHqO84dwhnbtnAM3d7LC7q0gPAnxTMM31ZtrXXh
 KJ67scZDE1CC5cgwZS1KBAwRmHtDKoOwuLp2A2wknXJjE9bWZZBtpnn8llyiJhxIkqA+
 rYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UvT7Unor9M3eflo5yQDL/TjbsnMQ6Gi8P0jhCttW2S4=;
 b=aRWok2NQ8jphQeFTXSpGPzWr3W/emeC3C45Tl04DR3X9BSpLpT7jGHxDKI6R9cMPPR
 OuffurTAFaNTANPWth7F5MmiWk6Mcz931KMs5YaY+y5KneK5y996GAGLYIwsKCPyV1Ra
 7ZKkQ8IuErLw/FzAHNHOeHfCHbxwXlGvMCJUUdLNYsYaGnPo9LkIO9e7jW8YhzULoCJa
 rMW+C7TUvlZmIHfCDJg60UOOwtWSjgXz4OUH/qGMbZv9LJJNIHXoOexZj1E/FMzrLQcF
 p2dHaoWSpu3m6C9bf1I4+XICLsJ2JddhoKRXWSSS19yO/OFVM4F8+r6bES+sOuVXKARJ
 LvFw==
X-Gm-Message-State: APjAAAVBfBzy0Wg8lWWG2oPe7VDIHCeQLCLCVVO3v8YjWcedB5srXXuX
 jbbx2u7GxVRQqG3nLdSi8Wp1bCUaa5neNSVetQA=
X-Google-Smtp-Source: APXvYqyPBwL6ASBueqR5If8MxbgSFvxgQ9sBnBAKX+F3hqBZJ0IvLS8HqQP7YTJnFL5OHPVVz7jX7V071uKCH1XGzAE=
X-Received: by 2002:a02:8817:: with SMTP id r23mr53067919jai.120.1577705650467; 
 Mon, 30 Dec 2019 03:34:10 -0800 (PST)
MIME-Version: 1.0
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-7-f4bug@amsat.org>
In-Reply-To: <20191230110953.25496-7-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 30 Dec 2019 12:33:59 +0100
Message-ID: <CAPan3WrBN77rcczzQ1knMEKCaCUSCb6RtdhSMiDWE9Ah7jvgjg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] hw/arm/cubieboard: Disable unsupported M-USB in
 device tree blob
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000db36df059aea38a4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000db36df059aea38a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

I have a suggestion: probably you can apply (almost) the same patch to get
USB
working for A10 as I did in the Allwinner H3, in patch #4 "add USB host
controller" [1]
That way you can avoid the DTB modifications and with low effort get USB
working as well for this board.
As far as I can see, in Section 21.1 in the A10 user manual [2] has the
same description
as for the H3. It basically has the standard EHCI and OHCI interfaces.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03266.html
[2] https://linux-sunxi.org/File:Allwinner_A10_User_manual_V1.5.pdf

Regards,
Niek

On Mon, Dec 30, 2019 at 12:10 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> We do not model the Sunxi Multipoint USB.
> The Linux kernel OOPS when booting:
>
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 144 at drivers/usb/musb/sunxi.c:400
> sunxi_musb_ep_offset+0x39/0x3c
>   sunxi_musb_ep_offset called with non 0 offset
>   Modules linked in:
>   CPU: 0 PID: 144 Comm: kworker/0:2 Not tainted 4.20.7-sunxi #5.75
>   Hardware name: Allwinner sun4i/sun5i Families
>   Workqueue: events deferred_probe_work_func
>   [<c010d77d>] (unwind_backtrace) from [<c010a425>] (show_stack+0x11/0x14=
)
>   [<c010a425>] (show_stack) from [<c08d9141>] (dump_stack+0x69/0x78)
>   [<c08d9141>] (dump_stack) from [<c011b161>] (__warn+0xa1/0xb4)
>   [<c011b161>] (__warn) from [<c011b1a7>] (warn_slowpath_fmt+0x33/0x48)
>   [<c011b1a7>] (warn_slowpath_fmt) from [<c0725c81>]
> (sunxi_musb_ep_offset+0x39/0x3c)
>   [<c0725c81>] (sunxi_musb_ep_offset) from [<c071b481>]
> (ep_config_from_hw+0x99/0x104)
>   [<c071b481>] (ep_config_from_hw) from [<c071c8d9>]
> (musb_probe+0x765/0xa0c)
>   [<c071c8d9>] (musb_probe) from [<c063fa4f>]
> (platform_drv_probe+0x33/0x68)
>   [<c063fa4f>] (platform_drv_probe) from [<c063e4ef>]
> (really_probe+0x16f/0x1e0)
>   [<c063e4ef>] (really_probe) from [<c063e67f>]
> (driver_probe_device+0x43/0x11c)
>   [<c063e67f>] (driver_probe_device) from [<c063d0cf>]
> (bus_for_each_drv+0x37/0x70)
>   [<c063d0cf>] (bus_for_each_drv) from [<c063e32f>]
> (__device_attach+0x83/0xc8)
>   [<c063e32f>] (__device_attach) from [<c063da8b>]
> (bus_probe_device+0x5b/0x60)
>   [<c063da8b>] (bus_probe_device) from [<c063b7a5>]
> (device_add+0x2f5/0x474)
>   [<c063b7a5>] (device_add) from [<c063f8ef>]
> (platform_device_add+0xb7/0x184)
>   [<c063f8ef>] (platform_device_add) from [<c06400df>]
> (platform_device_register_full+0xb3/0xc4)
>   [<c06400df>] (platform_device_register_full) from [<c0725a2f>]
> (sunxi_musb_probe+0x1d7/0x2f4)
>   [<c0725a2f>] (sunxi_musb_probe) from [<c063fa4f>]
> (platform_drv_probe+0x33/0x68)
>   [<c063fa4f>] (platform_drv_probe) from [<c063e4ef>]
> (really_probe+0x16f/0x1e0)
>   [<c063e4ef>] (really_probe) from [<c063e67f>]
> (driver_probe_device+0x43/0x11c)
>   [<c063e67f>] (driver_probe_device) from [<c063d0cf>]
> (bus_for_each_drv+0x37/0x70)
>   [<c063d0cf>] (bus_for_each_drv) from [<c063e32f>]
> (__device_attach+0x83/0xc8)
>   [<c063e32f>] (__device_attach) from [<c063da8b>]
> (bus_probe_device+0x5b/0x60)
>   [<c063da8b>] (bus_probe_device) from [<c063ddcf>]
> (deferred_probe_work_func+0x4b/0x6c)
>   [<c063ddcf>] (deferred_probe_work_func) from [<c012e38b>]
> (process_one_work+0x167/0x384)
>   [<c012e38b>] (process_one_work) from [<c012f07d>]
> (worker_thread+0x251/0x3fc)
>   [<c012f07d>] (worker_thread) from [<c0132949>] (kthread+0xfd/0x104)
>   [<c0132949>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)
>   Exception stack(0xc6999fb0 to 0xc6999ff8)
>   9fa0:                                     00000000 00000000 00000000
> 00000000
>   9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
>   9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>   ---[ end trace b309edbca98c7de2 ]---
>   musb-sunxi 1c13000.usb: Error unknown readb offset 128
>   musb-hdrc musb-hdrc.1.auto: musb_init_controller failed with status -22
>   musb-hdrc: probe of musb-hdrc.1.auto failed with error -22
>
> This is not critical but confusing. To avoid the Linux kernel to
> probe this device, mark it disabled in the device tree blob.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I'm not sure if this is a QEMU anti-pattern or bad practice.
> I know we prefer to be as close to the hardware as possible,
> but here the hardware is not changed, the dtb is. However
> this makes the guest behave differently. At least we don't
> have to manually edit the dts. If this is only annoying for
> acceptance testing, we might consider manually editing the
> dts in the tests setup().
> ---
>  hw/arm/cubieboard.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index 6dc2f1d6b6..dd10577696 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -22,10 +22,34 @@
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
>  #include "hw/arm/allwinner-a10.h"
> +#include <libfdt.h>
> +
> +static void cubieboard_modify_dtb(const struct arm_boot_info *info, void
> *fdt)
> +{
> +    static const char unsupported_compat[] =3D "allwinner,sun4i-a10-musb=
";
> +    char node_path[72];
> +    int offset;
> +
> +    offset =3D fdt_node_offset_by_compatible(fdt, -1, unsupported_compat=
);
> +    while (offset >=3D 0) {
> +        int r =3D fdt_get_path(fdt, offset, node_path, sizeof(node_path)=
);
> +        assert(r >=3D 0);
> +        r =3D fdt_setprop_string(fdt, offset, "status", "disabled");
> +        if (r < 0) {
> +            error_report("%s: Couldn't disable %s: %s", __func__,
> +                         unsupported_compat, fdt_strerror(r));
> +            exit(1);
> +        }
> +        warn_report("cubieboard: disabled unsupported node %s (%s) "
> +                    "in device tree", node_path, unsupported_compat);
> +        offset =3D fdt_node_offset_by_compatible(fdt, offset,
> unsupported_compat);
> +    }
> +}
>
>  static struct arm_boot_info cubieboard_binfo =3D {
>      .loader_start =3D AW_A10_SDRAM_BASE,
>      .board_id =3D 0x1008,
> +    .modify_dtb =3D cubieboard_modify_dtb,
>  };
>
>  typedef struct CubieBoardState {
> --
> 2.21.0
>
>

--=20
Niek Linnenbank

--000000000000db36df059aea38a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Philippe,</div><div><br></div><div>I have a sug=
gestion: probably you can apply (almost) the same patch to get USB</div><di=
v>working for A10 as I did in the Allwinner H3, in patch #4 &quot;add USB h=
ost controller&quot; [1]</div><div>That way you can avoid the DTB modificat=
ions and with low effort get USB working as well for this board.<br></div><=
div>As far as I can see, in Section 21.1 in the A10 user manual [2] has the=
 same description</div><div>as for the H3. It basically has the standard EH=
CI and OHCI interfaces.<br></div><div><br></div><div>[1] <a href=3D"https:/=
/lists.gnu.org/archive/html/qemu-devel/2019-12/msg03266.html">https://lists=
.gnu.org/archive/html/qemu-devel/2019-12/msg03266.html</a></div><div>[2] <a=
 href=3D"https://linux-sunxi.org/File:Allwinner_A10_User_manual_V1.5.pdf">h=
ttps://linux-sunxi.org/File:Allwinner_A10_User_manual_V1.5.pdf</a></div><di=
v><br></div><div>Regards,</div><div>Niek<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 30, 2019 at 1=
2:10 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">=
f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">We do not model the Sunxi Multipoint USB.<br>
The Linux kernel OOPS when booting:<br>
<br>
=C2=A0 ------------[ cut here ]------------<br>
=C2=A0 WARNING: CPU: 0 PID: 144 at drivers/usb/musb/sunxi.c:400 sunxi_musb_=
ep_offset+0x39/0x3c<br>
=C2=A0 sunxi_musb_ep_offset called with non 0 offset<br>
=C2=A0 Modules linked in:<br>
=C2=A0 CPU: 0 PID: 144 Comm: kworker/0:2 Not tainted 4.20.7-sunxi #5.75<br>
=C2=A0 Hardware name: Allwinner sun4i/sun5i Families<br>
=C2=A0 Workqueue: events deferred_probe_work_func<br>
=C2=A0 [&lt;c010d77d&gt;] (unwind_backtrace) from [&lt;c010a425&gt;] (show_=
stack+0x11/0x14)<br>
=C2=A0 [&lt;c010a425&gt;] (show_stack) from [&lt;c08d9141&gt;] (dump_stack+=
0x69/0x78)<br>
=C2=A0 [&lt;c08d9141&gt;] (dump_stack) from [&lt;c011b161&gt;] (__warn+0xa1=
/0xb4)<br>
=C2=A0 [&lt;c011b161&gt;] (__warn) from [&lt;c011b1a7&gt;] (warn_slowpath_f=
mt+0x33/0x48)<br>
=C2=A0 [&lt;c011b1a7&gt;] (warn_slowpath_fmt) from [&lt;c0725c81&gt;] (sunx=
i_musb_ep_offset+0x39/0x3c)<br>
=C2=A0 [&lt;c0725c81&gt;] (sunxi_musb_ep_offset) from [&lt;c071b481&gt;] (e=
p_config_from_hw+0x99/0x104)<br>
=C2=A0 [&lt;c071b481&gt;] (ep_config_from_hw) from [&lt;c071c8d9&gt;] (musb=
_probe+0x765/0xa0c)<br>
=C2=A0 [&lt;c071c8d9&gt;] (musb_probe) from [&lt;c063fa4f&gt;] (platform_dr=
v_probe+0x33/0x68)<br>
=C2=A0 [&lt;c063fa4f&gt;] (platform_drv_probe) from [&lt;c063e4ef&gt;] (rea=
lly_probe+0x16f/0x1e0)<br>
=C2=A0 [&lt;c063e4ef&gt;] (really_probe) from [&lt;c063e67f&gt;] (driver_pr=
obe_device+0x43/0x11c)<br>
=C2=A0 [&lt;c063e67f&gt;] (driver_probe_device) from [&lt;c063d0cf&gt;] (bu=
s_for_each_drv+0x37/0x70)<br>
=C2=A0 [&lt;c063d0cf&gt;] (bus_for_each_drv) from [&lt;c063e32f&gt;] (__dev=
ice_attach+0x83/0xc8)<br>
=C2=A0 [&lt;c063e32f&gt;] (__device_attach) from [&lt;c063da8b&gt;] (bus_pr=
obe_device+0x5b/0x60)<br>
=C2=A0 [&lt;c063da8b&gt;] (bus_probe_device) from [&lt;c063b7a5&gt;] (devic=
e_add+0x2f5/0x474)<br>
=C2=A0 [&lt;c063b7a5&gt;] (device_add) from [&lt;c063f8ef&gt;] (platform_de=
vice_add+0xb7/0x184)<br>
=C2=A0 [&lt;c063f8ef&gt;] (platform_device_add) from [&lt;c06400df&gt;] (pl=
atform_device_register_full+0xb3/0xc4)<br>
=C2=A0 [&lt;c06400df&gt;] (platform_device_register_full) from [&lt;c0725a2=
f&gt;] (sunxi_musb_probe+0x1d7/0x2f4)<br>
=C2=A0 [&lt;c0725a2f&gt;] (sunxi_musb_probe) from [&lt;c063fa4f&gt;] (platf=
orm_drv_probe+0x33/0x68)<br>
=C2=A0 [&lt;c063fa4f&gt;] (platform_drv_probe) from [&lt;c063e4ef&gt;] (rea=
lly_probe+0x16f/0x1e0)<br>
=C2=A0 [&lt;c063e4ef&gt;] (really_probe) from [&lt;c063e67f&gt;] (driver_pr=
obe_device+0x43/0x11c)<br>
=C2=A0 [&lt;c063e67f&gt;] (driver_probe_device) from [&lt;c063d0cf&gt;] (bu=
s_for_each_drv+0x37/0x70)<br>
=C2=A0 [&lt;c063d0cf&gt;] (bus_for_each_drv) from [&lt;c063e32f&gt;] (__dev=
ice_attach+0x83/0xc8)<br>
=C2=A0 [&lt;c063e32f&gt;] (__device_attach) from [&lt;c063da8b&gt;] (bus_pr=
obe_device+0x5b/0x60)<br>
=C2=A0 [&lt;c063da8b&gt;] (bus_probe_device) from [&lt;c063ddcf&gt;] (defer=
red_probe_work_func+0x4b/0x6c)<br>
=C2=A0 [&lt;c063ddcf&gt;] (deferred_probe_work_func) from [&lt;c012e38b&gt;=
] (process_one_work+0x167/0x384)<br>
=C2=A0 [&lt;c012e38b&gt;] (process_one_work) from [&lt;c012f07d&gt;] (worke=
r_thread+0x251/0x3fc)<br>
=C2=A0 [&lt;c012f07d&gt;] (worker_thread) from [&lt;c0132949&gt;] (kthread+=
0xfd/0x104)<br>
=C2=A0 [&lt;c0132949&gt;] (kthread) from [&lt;c01010f9&gt;] (ret_from_fork+=
0x11/0x38)<br>
=C2=A0 Exception stack(0xc6999fb0 to 0xc6999ff8)<br>
=C2=A0 9fa0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0000000=
00 00000000 00000000 00000000<br>
=C2=A0 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000=
 00000000<br>
=C2=A0 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000<br>
=C2=A0 ---[ end trace b309edbca98c7de2 ]---<br>
=C2=A0 musb-sunxi 1c13000.usb: Error unknown readb offset 128<br>
=C2=A0 musb-hdrc musb-hdrc.1.auto: musb_init_controller failed with status =
-22<br>
=C2=A0 musb-hdrc: probe of musb-hdrc.1.auto failed with error -22<br>
<br>
This is not critical but confusing. To avoid the Linux kernel to<br>
probe this device, mark it disabled in the device tree blob.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
I&#39;m not sure if this is a QEMU anti-pattern or bad practice.<br>
I know we prefer to be as close to the hardware as possible,<br>
but here the hardware is not changed, the dtb is. However<br>
this makes the guest behave differently. At least we don&#39;t<br>
have to manually edit the dts. If this is only annoying for<br>
acceptance testing, we might consider manually editing the<br>
dts in the tests setup().<br>
---<br>
=C2=A0hw/arm/cubieboard.c | 24 ++++++++++++++++++++++++<br>
=C2=A01 file changed, 24 insertions(+)<br>
<br>
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c<br>
index 6dc2f1d6b6..dd10577696 100644<br>
--- a/hw/arm/cubieboard.c<br>
+++ b/hw/arm/cubieboard.c<br>
@@ -22,10 +22,34 @@<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/boards.h&quot;<br>
=C2=A0#include &quot;hw/arm/allwinner-a10.h&quot;<br>
+#include &lt;libfdt.h&gt;<br>
+<br>
+static void cubieboard_modify_dtb(const struct arm_boot_info *info, void *=
fdt)<br>
+{<br>
+=C2=A0 =C2=A0 static const char unsupported_compat[] =3D &quot;allwinner,s=
un4i-a10-musb&quot;;<br>
+=C2=A0 =C2=A0 char node_path[72];<br>
+=C2=A0 =C2=A0 int offset;<br>
+<br>
+=C2=A0 =C2=A0 offset =3D fdt_node_offset_by_compatible(fdt, -1, unsupporte=
d_compat);<br>
+=C2=A0 =C2=A0 while (offset &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r =3D fdt_get_path(fdt, offset, node_path,=
 sizeof(node_path));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(r &gt;=3D 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D fdt_setprop_string(fdt, offset, &quot;st=
atus&quot;, &quot;disabled&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Couldn&#3=
9;t disable %s: %s&quot;, __func__,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0unsupported_compat, fdt_strerror(r));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;cubieboard: disabled unsuppo=
rted node %s (%s) &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;in device tree&quot;, node_path, unsupported_compat);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D fdt_node_offset_by_compatible(fdt, =
offset, unsupported_compat);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
<br>
=C2=A0static struct arm_boot_info cubieboard_binfo =3D {<br>
=C2=A0 =C2=A0 =C2=A0.loader_start =3D AW_A10_SDRAM_BASE,<br>
=C2=A0 =C2=A0 =C2=A0.board_id =3D 0x1008,<br>
+=C2=A0 =C2=A0 .modify_dtb =3D cubieboard_modify_dtb,<br>
=C2=A0};<br>
<br>
=C2=A0typedef struct CubieBoardState {<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--000000000000db36df059aea38a4--

