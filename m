Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E681C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F0D20663
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G45vjkH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F0D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgrCV-0001TT-H4
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgrBq-0000wV-Ap
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:49:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jgrBp-0003ba-77
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:49:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id r9so5520383wmh.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HJ7bynhheHPNWRabn2JkgZ2lO8ihuajCCTPwNwa0nYI=;
 b=G45vjkH9Kr6ZMuaFk5Wz126Di44pQPS9GQYAoi581XpLr9tqvZSVDTxM5443rcA0uJ
 I5mYQNn8fkRDlsuiD0IL2/XNo9AjGdttOcv41rviMtPuvbq7KMSoOQWoMSxPCqAQ9NYC
 nZ7afStmQeqUtFJnlYWtAEyHe/hrR8BVfDKlEXCDlBXV5VeBp74i5ZtRAKmPpM0vaVx+
 buoLpb1vfe2J47kTUpwIcXTSirsTz7qmq8rOX8C7OAGAHqMvAf8uZttPdTJSwpzAgBc7
 23bdzkRcmVsedz7h/ONfUVm73K6dOZl5266V87a0rePMWTfTUdOaG2uoVaJ4m501DXc3
 Qyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HJ7bynhheHPNWRabn2JkgZ2lO8ihuajCCTPwNwa0nYI=;
 b=a8pPp+rcBxX83Y7VPYZkuSRb03FquOg5WXlJrG9itUweE6GinH3i3BE8cINBTv1FjG
 aalVhda9eQiKagY33GiapExFajGWpj0ju5fYEm9k2DoOmqgxWkubFrsv5h3lbOxGniNw
 AGgdrQLD44sQ0m4Q+24TmmhaQB3YdPeGifV+BnwsJLeX1E9OUBagn9i82s6tt9NGI9NA
 BPEhXyZZKoWNkXyt8rzwjxIGtwsza/VIPc9H8IFo+DDNyAeWeROAdBUxWQGAYAvN1+E/
 vpG6s/bERJkjDPnecmJa/bPRNA44SUAVk7+CbrlJ1grGjqxNDpPCRCJxxTDohskF4BN9
 fgiA==
X-Gm-Message-State: AOAM5324gsiYIYdJwPDFfHpz8sZypWIVWs2EaTWrzXr/4mtFi61YBJ1a
 e+MzITzprqs5IV12AqJV21je8jqNzAAiIlfPfNY=
X-Google-Smtp-Source: ABdhPJyptRTIE/UDrdzCiXSqBZ9GeUOGY9XoTl3Pik8Ph/TLKynpUVzfakVBtXJo5DLYiAGUHBOLFWJOf10AqPmFDEg=
X-Received: by 2002:a1c:6606:: with SMTP id a6mr4177724wmc.37.1591282191698;
 Thu, 04 Jun 2020 07:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-8-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-8-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jun 2020 16:49:40 +0200
Message-ID: <CAJ+F1C+aPMkPcMkCBE6vO_PHLKS-jTYA+YqpG3Dc1TROBXL71g@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] Support ram slot configuration in libvhost-user
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: multipart/alternative; boundary="000000000000c6112505a7434195"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Raphael Norwitz <raphael.s.norwitz@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c6112505a7434195
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.co=
m>
wrote:

> The VHOST_USER_GET_MAX_MEM_SLOTS message allows a vhost-user backend to
> specify a maximum number of ram slots it is willing to support. This
> change adds support for libvhost-user to process this message. For now
> the backend will reply with 8 as the maximum number of regions
> supported.
>
> libvhost-user does not yet support the vhost-user protocol feature
> VHOST_USER_PROTOCOL_F_CONFIGIRE_MEM_SLOTS, so qemu should never
> send the VHOST_USER_GET_MAX_MEM_SLOTS message. Therefore this new
> functionality is not currently used.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  contrib/libvhost-user/libvhost-user.c | 19 +++++++++++++++++++
>  contrib/libvhost-user/libvhost-user.h |  1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index cccfa22..9f039b7 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -137,6 +137,7 @@ vu_request_to_string(unsigned int req)
>          REQ(VHOST_USER_SET_INFLIGHT_FD),
>          REQ(VHOST_USER_GPU_SET_SOCKET),
>          REQ(VHOST_USER_VRING_KICK),
> +        REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
>          REQ(VHOST_USER_MAX),
>      };
>  #undef REQ
> @@ -1565,6 +1566,22 @@ vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vms=
g)
>      return false;
>  }
>
> +static bool vu_handle_get_max_memslots(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    vmsg->flags =3D VHOST_USER_REPLY_MASK | VHOST_USER_VERSION;
> +    vmsg->size  =3D sizeof(vmsg->payload.u64);
> +    vmsg->payload.u64 =3D VHOST_MEMORY_MAX_NREGIONS;
> +    vmsg->fd_num =3D 0;
> +
> +    if (!vu_message_write(dev, dev->sock, vmsg)) {
> +        vu_panic(dev, "Failed to send max ram slots: %s\n",
> strerror(errno));
> +    }
> +
> +    DPRINT("u64: 0x%016"PRIx64"\n", (uint64_t) VHOST_MEMORY_MAX_NREGIONS=
);
> +
> +    return false;
> +}
> +
>  static bool
>  vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -1649,6 +1666,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_set_inflight_fd(dev, vmsg);
>      case VHOST_USER_VRING_KICK:
>          return vu_handle_vring_kick(dev, vmsg);
> +    case VHOST_USER_GET_MAX_MEM_SLOTS:
> +        return vu_handle_get_max_memslots(dev, vmsg);
>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> diff --git a/contrib/libvhost-user/libvhost-user.h
> b/contrib/libvhost-user/libvhost-user.h
> index f30394f..88ef40d 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -97,6 +97,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_INFLIGHT_FD =3D 32,
>      VHOST_USER_GPU_SET_SOCKET =3D 33,
>      VHOST_USER_VRING_KICK =3D 35,
> +    VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>
> --
> 1.8.3.1
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c6112505a7434195
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 21, 2020 at 7:00 AM Rapha=
el Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutanix.com">raphael.norwi=
tz@nutanix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">The VHOST_USER_GET_MAX_MEM_SLOTS message allows a vhost-user =
backend to<br>
specify a maximum number of ram slots it is willing to support. This<br>
change adds support for libvhost-user to process this message. For now<br>
the backend will reply with 8 as the maximum number of regions<br>
supported.<br>
<br>
libvhost-user does not yet support the vhost-user protocol feature<br>
VHOST_USER_PROTOCOL_F_CONFIGIRE_MEM_SLOTS, so qemu should never<br>
send the VHOST_USER_GET_MAX_MEM_SLOTS message. Therefore this new<br>
functionality is not currently used.<br>
<br>
Signed-off-by: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nutani=
x.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br></blockquot=
e><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div>=
<div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0contrib/libvhost-user/libvhost-user.c | 19 +++++++++++++++++++<br>
=C2=A0contrib/libvhost-user/libvhost-user.h |=C2=A0 1 +<br>
=C2=A02 files changed, 20 insertions(+)<br>
<br>
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c<br>
index cccfa22..9f039b7 100644<br>
--- a/contrib/libvhost-user/libvhost-user.c<br>
+++ b/contrib/libvhost-user/libvhost-user.c<br>
@@ -137,6 +137,7 @@ vu_request_to_string(unsigned int req)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REQ(VHOST_USER_SET_INFLIGHT_FD),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REQ(VHOST_USER_GPU_SET_SOCKET),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REQ(VHOST_USER_VRING_KICK),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 REQ(VHOST_USER_GET_MAX_MEM_SLOTS),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REQ(VHOST_USER_MAX),<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0#undef REQ<br>
@@ -1565,6 +1566,22 @@ vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vmsg)=
<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
<br>
+static bool vu_handle_get_max_memslots(VuDev *dev, VhostUserMsg *vmsg)<br>
+{<br>
+=C2=A0 =C2=A0 vmsg-&gt;flags =3D VHOST_USER_REPLY_MASK | VHOST_USER_VERSIO=
N;<br>
+=C2=A0 =C2=A0 vmsg-&gt;size=C2=A0 =3D sizeof(vmsg-&gt;payload.u64);<br>
+=C2=A0 =C2=A0 vmsg-&gt;payload.u64 =3D VHOST_MEMORY_MAX_NREGIONS;<br>
+=C2=A0 =C2=A0 vmsg-&gt;fd_num =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (!vu_message_write(dev, dev-&gt;sock, vmsg)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_panic(dev, &quot;Failed to send max ram slo=
ts: %s\n&quot;, strerror(errno));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 DPRINT(&quot;u64: 0x%016&quot;PRIx64&quot;\n&quot;, (uint64_=
t) VHOST_MEMORY_MAX_NREGIONS);<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
=C2=A0static bool<br>
=C2=A0vu_process_message(VuDev *dev, VhostUserMsg *vmsg)<br>
=C2=A0{<br>
@@ -1649,6 +1666,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vu_set_inflight_fd(dev, vmsg);<br>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_VRING_KICK:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return vu_handle_vring_kick(dev, vmsg);<b=
r>
+=C2=A0 =C2=A0 case VHOST_USER_GET_MAX_MEM_SLOTS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vu_handle_get_max_memslots(dev, vmsg);<=
br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsg_close_fds(vmsg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vu_panic(dev, &quot;Unhandled request: %d=
&quot;, vmsg-&gt;request);<br>
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/=
libvhost-user.h<br>
index f30394f..88ef40d 100644<br>
--- a/contrib/libvhost-user/libvhost-user.h<br>
+++ b/contrib/libvhost-user/libvhost-user.h<br>
@@ -97,6 +97,7 @@ typedef enum VhostUserRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_SET_INFLIGHT_FD =3D 32,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_SET_SOCKET =3D 33,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_VRING_KICK =3D 35,<br>
+=C2=A0 =C2=A0 VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_MAX<br>
=C2=A0} VhostUserRequest;<br>
<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000c6112505a7434195--

