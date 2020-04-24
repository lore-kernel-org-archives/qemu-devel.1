Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72032C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 02:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203B920728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 02:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuP6W+tN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203B920728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRoG0-0004QK-01
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 22:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.s.norwitz@gmail.com>) id 1jRoF5-0003jl-KL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 22:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <raphael.s.norwitz@gmail.com>) id 1jRoF2-0008Fh-LN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 22:39:02 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:44746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jRoF1-00088G-Oy
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 22:38:59 -0400
Received: by mail-io1-xd41.google.com with SMTP id z2so8797153iol.11
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=muofnJBsIZgl/+PzM/70OgKnAC05r+Pzz0zttgTostw=;
 b=GuP6W+tNl4OKtKrANG2SVuuZ534tP2sN/TrSreMAASeT+ujDWEOOIEGa8qhJVRiNtz
 Cs2pyeOgV/ySs5fXZ0eAmLinjafVuaTqYbFAkws5lvzJlKRQjXVtmWroXSV8UQhCNjIr
 Yvg20uWQ1NvGsujJrJrLkXaHMQ5fX8JZcr75pkn43rj0Rlt62FZ0VdY6hgeDLIRefDeD
 MfkOsdlSofZg5R0R/VlDjEgwooUMk9u5D9peFHBO85RNHro/fCujK3sO8C9s5r0yQLjo
 JwltUDqzxMJWteXSJrkz+KD9r0TgWspQ8XFpvyCyefjbPg+4d7uc1751CGE/gmVAgj57
 D9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=muofnJBsIZgl/+PzM/70OgKnAC05r+Pzz0zttgTostw=;
 b=tVAG1GsTkKHWWXcbjxeU97ouBe7jWRnKBqb8NeRgW/VVWnj2U9t8riblL3Ce5IxuwM
 Qrv4aoQja2XeoYREikNVTbM0Lyi/6zXxTOksALPWQDxtEkb6pVvotfZ7OO0C5qeKZL36
 HV/fuN6J2z/8SuZ1RJm1/WYKkuxlBizZJmxy/6bTDpd/6+BNqQePQ/S0Zn/lk437LDtk
 NpiiyUmyompwLitOosrsRvO4JTZQz+nDXg694mV98GCmQnILN2DZ0XZMLjwrBFm8h11n
 6K59WS3kq84+TGioEVGmTvQ6cTexQQobkzYX9JF3wZ9A5eO3vgjpCcibkzUkd/ilBi28
 gL+A==
X-Gm-Message-State: AGi0PuZNAuFjEQd783AebpYr60CJaYaSJNSN+HgO53VLdHp19+XiQ9aG
 uFKT0hP4nOnW1oQyD6RDuoqzLSv/VCIc2wvjo7/IUsUJ9v0=
X-Google-Smtp-Source: APiQypKgOVXcN6g/QiaG+pkIlK0UIc87HdWVU+/rcChykhn8bJI3rhJu2+84F98Zzx3ebgHHSIhi2W7Ez98dA2iOAKU=
X-Received: by 2002:a5d:9354:: with SMTP id i20mr6585812ioo.207.1587695937319; 
 Thu, 23 Apr 2020 19:38:57 -0700 (PDT)
MIME-Version: 1.0
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 23 Apr 2020 22:38:46 -0400
Message-ID: <CAFubqFv8B-hDD8RAz7HvYCQ+VkZFFwEEBsCncjugXF+C6YeL6w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/7] vhost-user-blk: add mechanism to track the
 guest notifiers init state
To: dimastep@yandex-team.ru
Content-Type: multipart/alternative; boundary="0000000000005af88405a4004495"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005af88405a4004495
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are some problems with this patch. It doesn't apply cleanly.

Are you sure you=E2=80=99re developing on an up to date master branch?

On Thu, Apr 23, 2020 at 09:39:36PM +0300, Dima Stepanov wrote:
>
> In case of the vhost-user devices the daemon can be killed at any
> moment. Since QEMU supports the reconnet functionality the guest
> notifiers should be reset and disabled after "disconnect" event. The
> most issues were found if the "disconnect" event happened during vhost
> device initialization step.
> The disconnect event leads to the call of the vhost_dev_cleanup()
> routine. Which memset to 0 a vhost device structure. Because of this, if
> device was not started (dev.started =3D=3D false) and the connection is
> broken, then the set_guest_notifier method will produce assertion error.
> Also connection can be broken after the dev.started field is set to
> true.
> A new notifiers_set field is added to the vhost_dev structure to track
> the state of the guest notifiers during the initialization process.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  hw/block/vhost-user-blk.c |  8 ++++----
>  hw/virtio/vhost.c         | 11 +++++++++++
>  include/hw/virtio/vhost.h |  1 +
>  3 files changed, 16 insertions(+), 4 deletions(-)
> @@ -1449,6 +1456,10 @@ int vhost_dev_drop_guest_notifiers(struct
vhost_dev *hdev,

I can=E2=80=99t find the function vhost_dev_drop_guest_notifiers() in
/hw/virtio/vhost.c, or anywhere in the codebase.

Where does this code come from?

>      VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>      int ret;
>
> +    if (!hdev->notifiers_set) {
> +        return 0;
> +    }
> +
>      ret =3D k->set_guest_notifiers(qbus->parent, nvqs, false);
>      if (ret < 0) {
>          error_report("Error reset guest notifier: %d", -ret);
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 4d0d2e2..e3711a7 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -90,6 +90,7 @@ struct vhost_dev {
>      QLIST_HEAD(, vhost_iommu) iommu_list;
>      IOMMUNotifier n;
>      const VhostDevConfigOps *config_ops;
> +    bool notifiers_set;
>  };
>
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> --
> 2.7.4
>
>

--0000000000005af88405a4004495
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-family:-webkit-standar=
d">There are some problems with this patch. It doesn&#39;t apply cleanly.</=
div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard"><br></div>=
<div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">Are you sure y=
ou=E2=80=99re developing on an up to date master branch?</div><div style=3D=
"color:rgb(0,0,0);font-family:-webkit-standard"><br></div><div style=3D"col=
or:rgb(0,0,0);font-family:-webkit-standard">On Thu, Apr 23, 2020 at 09:39:3=
6PM +0300, Dima Stepanov wrote:</div><div style=3D"color:rgb(0,0,0);font-fa=
mily:-webkit-standard">&gt;<span class=3D"gmail-Apple-converted-space">=C2=
=A0</span></div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard=
">&gt; In case of the vhost-user devices the daemon can be killed at any</d=
iv><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; moment=
. Since QEMU supports the reconnet functionality the guest</div><div style=
=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; notifiers should be=
 reset and disabled after &quot;disconnect&quot; event. The</div><div style=
=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; most issues were fo=
und if the &quot;disconnect&quot; event happened during vhost</div><div sty=
le=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; device initializa=
tion step.</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard=
">&gt; The disconnect event leads to the call of the vhost_dev_cleanup()</d=
iv><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; routin=
e. Which memset to 0 a vhost device structure. Because of this, if</div><di=
v style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; device was n=
ot started (dev.started =3D=3D false) and the connection is</div><div style=
=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; broken, then the se=
t_guest_notifier method will produce assertion error.</div><div style=3D"co=
lor:rgb(0,0,0);font-family:-webkit-standard">&gt; Also connection can be br=
oken after the dev.started field is set to</div><div style=3D"color:rgb(0,0=
,0);font-family:-webkit-standard">&gt; true.</div><div style=3D"color:rgb(0=
,0,0);font-family:-webkit-standard">&gt; A new notifiers_set field is added=
 to the vhost_dev structure to track</div><div style=3D"color:rgb(0,0,0);fo=
nt-family:-webkit-standard">&gt; the state of the guest notifiers during th=
e initialization process.</div><div style=3D"color:rgb(0,0,0);font-family:-=
webkit-standard">&gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</sp=
an></div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; =
Signed-off-by: Dima Stepanov &lt;<a href=3D"mailto:dimastep@yandex-team.ru"=
>dimastep@yandex-team.ru</a>&gt;</div><div style=3D"color:rgb(0,0,0);font-f=
amily:-webkit-standard">&gt; ---</div><div style=3D"color:rgb(0,0,0);font-f=
amily:-webkit-standard">&gt;=C2=A0=C2=A0hw/block/vhost-user-blk.c |=C2=A0=
=C2=A08 ++++----</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-st=
andard">&gt;=C2=A0=C2=A0hw/virtio/vhost.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 +++++++++++</div><div style=3D"color:rgb(0,0,0);font-f=
amily:-webkit-standard">&gt;=C2=A0=C2=A0include/hw/virtio/vhost.h |=C2=A0=
=C2=A01 +</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard"=
>&gt;=C2=A0=C2=A03 files changed, 16 insertions(+), 4 deletions(-)</div><di=
v style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; @@ -1449,6 +=
1456,10 @@ int vhost_dev_drop_guest_notifiers(struct vhost_dev *hdev,</div>=
<div style=3D"color:rgb(0,0,0);font-family:-webkit-standard"><br></div><div=
 style=3D"color:rgb(0,0,0);font-family:-webkit-standard">I can=E2=80=99t fi=
nd the function vhost_dev_drop_guest_notifiers() in</div><div style=3D"colo=
r:rgb(0,0,0);font-family:-webkit-standard">/hw/virtio/vhost.c, or anywhere =
in the codebase.</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-st=
andard"><br></div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standa=
rd">Where does this code come from?</div><div style=3D"color:rgb(0,0,0);fon=
t-family:-webkit-standard"><br></div><div style=3D"color:rgb(0,0,0);font-fa=
mily:-webkit-standard">&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VirtioBusCla=
ss *k =3D VIRTIO_BUS_GET_CLASS(qbus);</div><div style=3D"color:rgb(0,0,0);f=
ont-family:-webkit-standard">&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int re=
t;</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt;=
=C2=A0=C2=A0</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standa=
rd">&gt; +=C2=A0=C2=A0=C2=A0=C2=A0if (!hdev-&gt;notifiers_set) {</div><div =
style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; +=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;</div><div style=3D"color:rgb(=
0,0,0);font-family:-webkit-standard">&gt; +=C2=A0=C2=A0=C2=A0=C2=A0}</div><=
div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; +</div><di=
v style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D k-&gt;set_guest_notifiers(qbus-&gt;parent, =
nvqs, false);</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-stand=
ard">&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret &lt; 0) {</div><div st=
yle=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report(&quot;Error reset=
 guest notifier: %d&quot;, -ret);</div><div style=3D"color:rgb(0,0,0);font-=
family:-webkit-standard">&gt; diff --git a/include/hw/virtio/vhost.h b/incl=
ude/hw/virtio/vhost.h</div><div style=3D"color:rgb(0,0,0);font-family:-webk=
it-standard">&gt; index 4d0d2e2..e3711a7 100644</div><div style=3D"color:rg=
b(0,0,0);font-family:-webkit-standard">&gt; --- a/include/hw/virtio/vhost.h=
</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; +++=
 b/include/hw/virtio/vhost.h</div><div style=3D"color:rgb(0,0,0);font-famil=
y:-webkit-standard">&gt; @@ -90,6 +90,7 @@ struct vhost_dev {</div><div sty=
le=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0QLIST_HEAD(, vhost_iommu) iommu_list;</div><div style=3D"=
color:rgb(0,0,0);font-family:-webkit-standard">&gt;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0IOMMUNotifier n;</div><div style=3D"color:rgb(0,0,0);font-famil=
y:-webkit-standard">&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const VhostDevC=
onfigOps *config_ops;</div><div style=3D"color:rgb(0,0,0);font-family:-webk=
it-standard">&gt; +=C2=A0=C2=A0=C2=A0=C2=A0bool notifiers_set;</div><div st=
yle=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt;=C2=A0=C2=A0};</d=
iv><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt;=C2=A0=
=C2=A0</div><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&g=
t;=C2=A0=C2=A0int vhost_dev_init(struct vhost_dev *hdev, void *opaque,</div=
><div style=3D"color:rgb(0,0,0);font-family:-webkit-standard">&gt; --<span =
class=3D"gmail-Apple-converted-space">=C2=A0</span></div><div style=3D"colo=
r:rgb(0,0,0);font-family:-webkit-standard">&gt; 2.7.4</div><div style=3D"co=
lor:rgb(0,0,0);font-family:-webkit-standard">&gt;<span class=3D"gmail-Apple=
-converted-space">=C2=A0</span></div><div style=3D"color:rgb(0,0,0);font-fa=
mily:-webkit-standard">&gt;</div></div>

--0000000000005af88405a4004495--

