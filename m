Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7B5C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE3622249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEYsfuiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE3622249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8i4-0006Cz-IQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kV8gC-0005Fp-9j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:37:04 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:39553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kV8gA-0005QJ-8R
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:37:03 -0400
Received: by mail-ej1-x643.google.com with SMTP id lw21so1748327ejb.6
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nQFgrTOS09pTXFb0Fm5sIX6jY0r0sw83iMxZrEr+tvQ=;
 b=BEYsfuiVM6RrYgfgfddVrWYOBndeo9RKfLym9IitQtAtuNs+MCnlLpcn94RkY8pSw+
 uh31Q92atEr3UL/FOmhlOhOcHzsYMILylpMo1sGpD1ySIuNp2epUPNWQYhx7zPDdZzpn
 AUT9YQ/w5qLqAHrgHw/vXKFuxXHqkpUzNTtPLnWpgOykIpQMq+aX9QoVJ/HBRy3x4DLt
 KxBSlJlOdpcEf5RwnKd/GFHxN4sZhT6ia1HVSRE0PaQad+r3ozsmkmA+TxrMUuCNWX+H
 E/Mk4Mf+hDNnTK+g1o0dqLhKDIBC/9lJBS0h2vuKUWREvWRcOFaOB4UQKTIe91lTHSgt
 al6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nQFgrTOS09pTXFb0Fm5sIX6jY0r0sw83iMxZrEr+tvQ=;
 b=isIdgrlX8TbA3mtsbvbT4LXdjl6I77blb/9meZ+glii8siIldCJEurKEjk3eKdBOYk
 n/HVQTEuF8a20HoWpb1HemUUrsnlD1gGyOMJ/XAOqRIPPIe0/RkNPQB95Z4N+CjTCJXC
 DiWrQrRcqUuX/8q1a551E7ITObLiWC2a1aLXjCFp7Garvg/GKh7jsDDGhVGxyi82YM5x
 lGHMqcwmdZBq1K61fbEzNeudOuf2ysK5n2fBUQfY/JXGqM7ExQQ6aeJqBPc+lu8GumFv
 BUlq+9hWm2WGobo2y+CEQs+a9Pn27AY3xYmlPexC5KBZuf5z4GKz4svm/xgrWP+Bym0H
 Aj3A==
X-Gm-Message-State: AOAM530AJeVtvVZ2vqfMd4ZCDCE9/x/w2yy4U57n81kHm0zsSXp56auL
 v9/SOsgo8KDvHDfq4XR2hQ56npBJEP4dYq2xUmU=
X-Google-Smtp-Source: ABdhPJyeP0Uc4M2FpwasZUqROncsgcrnTJbLxnJB0lCCEhYZqFHJIPdk5hedg1bKEiL86Ihnr0nSeyvIfaDi4eLesQ8=
X-Received: by 2002:a17:906:1a11:: with SMTP id
 i17mr2080114ejf.381.1603265820066; 
 Wed, 21 Oct 2020 00:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201021071520.2168877-1-armbru@redhat.com>
 <20201021071520.2168877-5-armbru@redhat.com>
In-Reply-To: <20201021071520.2168877-5-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 21 Oct 2020 11:36:48 +0400
Message-ID: <CAJ+F1C+Pp72UX1wDAxirOpaJbg0SBO9r2dGWKcRf2ynG-VKh5g@mail.gmail.com>
Subject: Re: [PATCH 4/4] qga: Flatten simple union GuestDeviceId
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000af89c705b2296956"
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
Cc: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000af89c705b2296956
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 11:16 AM Markus Armbruster <armbru@redhat.com>
wrote:

> Simple unions are simpler than flat unions in the schema, but more
> complicated in C and on the QMP wire: there's extra indirection in C
> and extra nesting on the wire, both pointless.  They should be avoided
> in new code.
>
> GuestDeviceId was recently added for guest-get-devices.  Convert it to
> a flat union.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  qga/qapi-schema.json | 8 ++++++++
>  qga/commands-win32.c | 9 ++++-----
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c7bfb8bf6a..fe10631e4c 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1256,6 +1256,12 @@
>  { 'command': 'guest-get-osinfo',
>    'returns': 'GuestOSInfo' }
>
> +##
> +# @GuestDeviceType:
> +##
> +{ 'enum': 'GuestDeviceType',
> +  'data': [ 'pci' ] }
> +
>  ##
>  # @GuestDeviceIdPCI:
>  #
> @@ -1276,6 +1282,8 @@
>  # Since: 5.2
>  ##
>  { 'union': 'GuestDeviceId',
> +  'base': { 'type': 'GuestDeviceType' },
> +  'discriminator': 'type',
>    'data': { 'pci': 'GuestDeviceIdPCI' } }
>
>  ##
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 1efe3ba076..0c33d48aaa 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2400,16 +2400,15 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>              }
>              skip =3D false;
>
> -            id =3D g_new0(GuestDeviceIdPCI, 1);
>              vendor_id =3D g_match_info_fetch(match_info, 1);
>              device_id =3D g_match_info_fetch(match_info, 2);
> -            id->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 16);
> -            id->device_id =3D g_ascii_strtoull(device_id, NULL, 16);
>
>              device->id =3D g_new0(GuestDeviceId, 1);
>              device->has_id =3D true;
> -            device->id->type =3D GUEST_DEVICE_ID_KIND_PCI;
> -            device->id->u.pci.data =3D id;
> +            device->id->type =3D GUEST_DEVICE_TYPE_PCI;
> +            id =3D &device->id->u.pci;
> +            id->vendor_id =3D g_ascii_strtoull(vendor_id, NULL, 16);
> +            id->device_id =3D g_ascii_strtoull(device_id, NULL, 16);
>
>              g_match_info_free(match_info);
>              break;
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000af89c705b2296956
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 21, 2020 at 11:16 AM Mark=
us Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sim=
ple unions are simpler than flat unions in the schema, but more<br>
complicated in C and on the QMP wire: there&#39;s extra indirection in C<br=
>
and extra nesting on the wire, both pointless.=C2=A0 They should be avoided=
<br>
in new code.<br>
<br>
GuestDeviceId was recently added for guest-get-devices.=C2=A0 Convert it to=
<br>
a flat union.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qga/qapi-schema.json | 8 ++++++++<br>
=C2=A0qga/commands-win32.c | 9 ++++-----<br>
=C2=A02 files changed, 12 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index c7bfb8bf6a..fe10631e4c 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1256,6 +1256,12 @@<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-osinfo&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: &#39;GuestOSInfo&#39; }<br>
<br>
+##<br>
+# @GuestDeviceType:<br>
+##<br>
+{ &#39;enum&#39;: &#39;GuestDeviceType&#39;,<br>
+=C2=A0 &#39;data&#39;: [ &#39;pci&#39; ] }<br>
+<br>
=C2=A0##<br>
=C2=A0# @GuestDeviceIdPCI:<br>
=C2=A0#<br>
@@ -1276,6 +1282,8 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;union&#39;: &#39;GuestDeviceId&#39;,<br>
+=C2=A0 &#39;base&#39;: { &#39;type&#39;: &#39;GuestDeviceType&#39; },<br>
+=C2=A0 &#39;discriminator&#39;: &#39;type&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;pci&#39;: &#39;GuestDeviceIdPCI&#39; } =
}<br>
<br>
=C2=A0##<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 1efe3ba076..0c33d48aaa 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2400,16 +2400,15 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **=
errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0skip =3D false;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id =3D g_new0(GuestDeviceIdPCI, =
1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vendor_id =3D g_match_info_=
fetch(match_info, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_id =3D g_match_info_=
fetch(match_info, 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id-&gt;vendor_id =3D g_ascii_str=
toull(vendor_id, NULL, 16);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id-&gt;device_id =3D g_ascii_str=
toull(device_id, NULL, 16);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device-&gt;id =3D g_new0(Gu=
estDeviceId, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device-&gt;has_id =3D true;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;id-&gt;type =3D GUEST=
_DEVICE_ID_KIND_PCI;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;id-&gt;u.pci.data =3D=
 id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;id-&gt;type =3D GUEST=
_DEVICE_TYPE_PCI;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id =3D &amp;device-&gt;id-&gt;u.=
pci;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id-&gt;vendor_id =3D g_ascii_str=
toull(vendor_id, NULL, 16);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id-&gt;device_id =3D g_ascii_str=
toull(device_id, NULL, 16);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_match_info_free(match_inf=
o);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000af89c705b2296956--

