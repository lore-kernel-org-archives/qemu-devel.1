Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B84AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6538622253
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAsopSTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6538622253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVs6U-0000El-9b
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVs5L-0007Yu-VO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:06:03 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVs5J-0006Lj-Ut
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:06:03 -0400
Received: by mail-ej1-x643.google.com with SMTP id c15so1156699ejs.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CS9HTdrhUV9OsVNdmyf38kkBA3wNT8t1M62rGmTPbr8=;
 b=oAsopSTut94VsBKtDeIEaWUkgXu8KJWYZrQXK5FgFhaZFRxzJ4IGAWnnXCgQU/DSCI
 omxFDcyK+sjd+OwGrkhx8Dq2WuO9qBOMQVAU7uH1pJh+/j6Nkelm9UFBZGqlDCxxcrBu
 8GUt+yJMxaIYaTwsWu4waSbjGLeDnWWJS/TIqug1R8S7EbW5+26YLiymEi4/dTfVOtGm
 3m++pduvQDnINWEJVzij4xsEJIf4GYc7c+oeyIhaNBCz0in3k1mMalnnF1xksPSErKug
 F63Xskp7xFPGbf2ETCjoHyUdrxG6wGCwgDrEkyb13Lk7eJ0SG4lgBtgpCPVD+Hx/IHRn
 muKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CS9HTdrhUV9OsVNdmyf38kkBA3wNT8t1M62rGmTPbr8=;
 b=YFLuMxOgXS/N9Ivgmvk+IVphfqAtnBauSpX2+mc5szB48HRj52XwNLQiVXNLKmuPb0
 cp4xpnEPczf9r9vDdM6ilocxnBQddokV9NvPuV+w2Ki5HCrT3ZzZHieaZL3c+nYVtCL2
 vPrfeDSs9wQURWaJgqmlgU3S395HdDrMQsGvTcX44WpfMVSg2ltjtUSIg89fYwgBk5t+
 ignkH+0Gk3TTub1siyU/JZHmVIuTT/+MWmPwq+AdvngAp2bY4shV2KDkOMTgPfGTFolN
 O6d+yFNFuqLj1WMVT436LJK/bZ8m7vYawJdRnb1w5aXTaCzKYgM6KtUZliQyEraLErpd
 8m9w==
X-Gm-Message-State: AOAM530Q358eEGROl0wzWhoO2vUtw++MZom5lOM4aa7DLwHtIh6E+B4e
 Ia+FV/P7ag9DDgewKxZg6253MnUFL3zLUlUBcOM=
X-Google-Smtp-Source: ABdhPJz2ZQiFYEY4MFSQHQSdF6vnwQkBPj1NOjnSM6VeF08kyT5vPoeh6t9q6oQGd1aAsaxL3BEjCChd0zwVYiNPqlg=
X-Received: by 2002:a17:906:388d:: with SMTP id
 q13mr801497ejd.92.1603440359918; 
 Fri, 23 Oct 2020 01:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201023064618.21409-1-kraxel@redhat.com>
 <20201023064618.21409-2-kraxel@redhat.com>
In-Reply-To: <20201023064618.21409-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Oct 2020 12:05:48 +0400
Message-ID: <CAJ+F1CK0A1+vOMZq55guJi9OPg1zyVyRQ_azYA7NNVg5Kx5hDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-gpu: add virtio-gpu-pci module
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000012519105b2520d6a"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000012519105b2520d6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 10:46 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Build virtio-gpu pci devices modular.  Must be a separate module because
> not all qemu softmmu variants come with PCI support.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

Hmm, I realize we have a different behaviour when building devices as
modules shared by different qemu system binaries.

It will attempt to load any kind of modules:

./qemu-system-m68k  -kernel ~/Downloads/vmlinux-5.8.0-3-m68k  -device
virtio-gpu-pci
Failed to open module:
/home/elmarco/src/qemu/buildnodoc/hw-display-virtio-gpu-pci.so: undefined
symbol: virtio_instance_init_common
qemu-system-m68k: -device virtio-gpu-pci: 'virtio-gpu-pci' is not a valid
device model name


And this is not a new problem, for example with qemu 5.1.0-5.fc33:

$ qemu-system-m68k -device help
Failed to open module: /usr/lib64/qemu/hw-usb-smartcard.so: undefined
symbol: ccid_card_send_apdu_to_guest
Failed to open module: /usr/lib64/qemu/hw-display-qxl.so: undefined symbol:
vga_ioport_read
...

What would be the solution? load modules from an arch-specific directory?
link to a common shared library location? Ex:
/usr/lib64/qemu/x86_64/hw-usb-smartcard.so ->
/usr/lib64/qemu/hw-usb-smartcard.so


---
>  util/module.c          |  3 +++
>  hw/display/meson.build | 11 +++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/util/module.c b/util/module.c
> index fe3b82dd4d37..9490f975d303 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -301,6 +301,9 @@ static struct {
>      { "qxl",                   "hw-", "display-qxl"           },
>      { "virtio-gpu-device",     "hw-", "display-virtio-gpu"    },
>      { "vhost-user-gpu",        "hw-", "display-virtio-gpu"    },
> +    { "virtio-gpu-pci-base",   "hw-", "display-virtio-gpu-pci" },
> +    { "virtio-gpu-pci",        "hw-", "display-virtio-gpu-pci" },
> +    { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu-pci" },
>      { "chardev-braille",       "chardev-", "baum"             },
>      { "chardev-spicevmc",      "chardev-", "spice"            },
>      { "chardev-spiceport",     "chardev-", "spice"            },
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 0d5ddecd6503..669935371335 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -62,8 +62,15 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>    hw_display_modules +=3D {'virtio-gpu': virtio_gpu_ss}
>  endif
>
> -softmmu_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI'], if_true=
:
> files('virtio-gpu-pci.c'))
> -softmmu_ss.add(when: ['CONFIG_VHOST_USER_GPU', 'CONFIG_VIRTIO_PCI'],
> if_true: files('vhost-user-gpu-pci.c'))
> +if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
> +  virtio_gpu_pci_ss =3D ss.source_set()
> +  virtio_gpu_pci_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI']=
,
> +                        if_true: [files('virtio-gpu-pci.c'), pixman])
> +  virtio_gpu_pci_ss.add(when: ['CONFIG_VHOST_USER_GPU',
> 'CONFIG_VIRTIO_PCI'],
> +                        if_true: files('vhost-user-gpu-pci.c'))
> +  hw_display_modules +=3D {'virtio-gpu-pci': virtio_gpu_pci_ss}
> +endif
> +
>  softmmu_ss.add(when: 'CONFIG_VIRTIO_VGA', if_true: files('virtio-vga.c')=
)
>  softmmu_ss.add(when: 'CONFIG_VHOST_USER_VGA', if_true:
> files('vhost-user-vga.c'))
>
> --
> 2.27.0
>
>
>
Otherwise patch works well:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000012519105b2520d6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 10:46 AM Gerd=
 Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Build v=
irtio-gpu pci devices modular.=C2=A0 Must be a separate module because<br>
not all qemu softmmu variants come with PCI support.<br>
<br>
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" targe=
t=3D"_blank">kraxel@redhat.com</a>&gt;<br></blockquote><br></div><div class=
=3D"gmail_quote">Hmm, I realize we have a different behaviour when building=
 devices as modules shared by different qemu system binaries.<br></div><div=
 class=3D"gmail_quote"><div><br></div><div>It will attempt to load any kind=
 of modules:</div><div><br></div><div>./qemu-system-m68k =C2=A0-kernel ~/Do=
wnloads/vmlinux-5.8.0-3-m68k =C2=A0-device virtio-gpu-pci<br>Failed to open=
 module: /home/elmarco/src/qemu/buildnodoc/hw-display-virtio-gpu-pci.so: un=
defined symbol: virtio_instance_init_common<br>qemu-system-m68k: -device vi=
rtio-gpu-pci: &#39;virtio-gpu-pci&#39; is not a valid device model name</di=
v><div><br></div><div><br></div><div>And this is not a new problem, for exa=
mple with qemu 5.1.0-5.fc33:</div><div><br></div><div>$ qemu-system-m68k -d=
evice help =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>Faile=
d to open module: /usr/lib64/qemu/hw-usb-smartcard.so: undefined symbol: cc=
id_card_send_apdu_to_guest<br>Failed to open module: /usr/lib64/qemu/hw-dis=
play-qxl.so: undefined symbol: vga_ioport_read</div><div>...</div><div><br>=
</div><div>What would be the solution? load modules from an arch-specific d=
irectory? link to a common shared library location? Ex:<br></div><div>/usr/=
lib64/qemu/x86_64/hw-usb-smartcard.so -&gt; /usr/lib64/qemu/hw-usb-smartcar=
d.so</div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
---<br>
=C2=A0util/module.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +++<br>
=C2=A0hw/display/meson.build | 11 +++++++++--<br>
=C2=A02 files changed, 12 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/util/module.c b/util/module.c<br>
index fe3b82dd4d37..9490f975d303 100644<br>
--- a/util/module.c<br>
+++ b/util/module.c<br>
@@ -301,6 +301,9 @@ static struct {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;qxl&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;hw-&quot;, &quot;display-qxl&quot;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;virtio-gpu-device&quot;,=C2=A0 =C2=A0 =C2=A0&qu=
ot;hw-&quot;, &quot;display-virtio-gpu&quot;=C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;vhost-user-gpu&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;hw-&quot;, &quot;display-virtio-gpu&quot;=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 { &quot;virtio-gpu-pci-base&quot;,=C2=A0 =C2=A0&quot;hw-&quo=
t;, &quot;display-virtio-gpu-pci&quot; },<br>
+=C2=A0 =C2=A0 { &quot;virtio-gpu-pci&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 &qu=
ot;hw-&quot;, &quot;display-virtio-gpu-pci&quot; },<br>
+=C2=A0 =C2=A0 { &quot;vhost-user-gpu-pci&quot;,=C2=A0 =C2=A0 &quot;hw-&quo=
t;, &quot;display-virtio-gpu-pci&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;chardev-braille&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;chardev-&quot;, &quot;baum&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;chardev-spicevmc&quot;,=C2=A0 =C2=A0 =C2=A0 &qu=
ot;chardev-&quot;, &quot;spice&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;chardev-spiceport&quot;,=C2=A0 =C2=A0 =C2=A0&qu=
ot;chardev-&quot;, &quot;spice&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 },<br>
diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
index 0d5ddecd6503..669935371335 100644<br>
--- a/hw/display/meson.build<br>
+++ b/hw/display/meson.build<br>
@@ -62,8 +62,15 @@ if config_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39=
;)<br>
=C2=A0 =C2=A0hw_display_modules +=3D {&#39;virtio-gpu&#39;: virtio_gpu_ss}<=
br>
=C2=A0endif<br>
<br>
-softmmu_ss.add(when: [&#39;CONFIG_VIRTIO_GPU&#39;, &#39;CONFIG_VIRTIO_PCI&=
#39;], if_true: files(&#39;virtio-gpu-pci.c&#39;))<br>
-softmmu_ss.add(when: [&#39;CONFIG_VHOST_USER_GPU&#39;, &#39;CONFIG_VIRTIO_=
PCI&#39;], if_true: files(&#39;vhost-user-gpu-pci.c&#39;))<br>
+if config_all_devices.has_key(&#39;CONFIG_VIRTIO_PCI&#39;)<br>
+=C2=A0 virtio_gpu_pci_ss =3D ss.source_set()<br>
+=C2=A0 virtio_gpu_pci_ss.add(when: [&#39;CONFIG_VIRTIO_GPU&#39;, &#39;CONF=
IG_VIRTIO_PCI&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if_true: [files(&#39;virtio-gpu-pci.c&#39;), pixman])<br>
+=C2=A0 virtio_gpu_pci_ss.add(when: [&#39;CONFIG_VHOST_USER_GPU&#39;, &#39;=
CONFIG_VIRTIO_PCI&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if_true: files(&#39;vhost-user-gpu-pci.c&#39;))<br>
+=C2=A0 hw_display_modules +=3D {&#39;virtio-gpu-pci&#39;: virtio_gpu_pci_s=
s}<br>
+endif<br>
+<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_VIRTIO_VGA&#39;, if_true: files(&#39=
;virtio-vga.c&#39;))<br>
=C2=A0softmmu_ss.add(when: &#39;CONFIG_VHOST_USER_VGA&#39;, if_true: files(=
&#39;vhost-user-vga.c&#39;))<br>
<br>
-- <br>
2.27.0<br>
<br>
<br>
</blockquote></div><div><br></div><div>Otherwise patch works well:</div><di=
v><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:=
marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br></div><=
br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau=
<br></div></div>

--00000000000012519105b2520d6a--

