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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE083C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA7822249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhTzH3Wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA7822249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8md-0001s7-IJ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kV8ld-0001MF-Ag
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:42:41 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kV8lb-0007Lc-9U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:42:40 -0400
Received: by mail-ej1-x644.google.com with SMTP id qp15so1785749ejb.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2TPdyzEujHwRfsJ8BlJRsL6Dq3laopX6V1kaWO7HRf0=;
 b=MhTzH3Wy3tiKgK1DDDd9QOkDuTSggAGbFIT7UX/inHSIrgtR5fzvnJ93kK+rWv7Hj6
 qz4Oovh7bc7bIge+qgyuwl9s0DQQRVDcq6MjQAs7zORWqPdXrQZv5Y8JXpKWrGNlZZs3
 AHP9LnBoYqYRVAPZxN+rNH9Scf8lD90196BTOpKsrBWFTqF8aYuXvwpVhiCA/F3oRayN
 1fyCnA85OJPd/0HU8I+mrsI+ZkIP4RUP/qOkpnQ50mNURI5x1XxeRh4BPGUjD2qNEyy9
 UChkVoKdUKXj9m0a5eha4KK9uRlhIZot6EyZ3nCBhSQ+X258HbNtdUBB7lMh/r+sXnNz
 IIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2TPdyzEujHwRfsJ8BlJRsL6Dq3laopX6V1kaWO7HRf0=;
 b=rF7qQYJCfNddnZmvckrZbf1PSX/UB7MFx45RoXtOQn9ff7QrckhkERFSSSgV1mo4pl
 qN1cMLygwqBdWPyzsj1xH7PVF7l4Mj4UEHpspghfH9OKQwVCSyV5BmPjT/iDGX69rSJp
 4FajmFTtLDRJUrKQEL8nf/Y+0SqZ6JSSGWTBy15wHI6oWm7BMM3nFhWWWZaCp79FPBKK
 G3AwueRZjbYdwS+eGIJaqU68ZKt6sE9T93600b3leyaa7/7BFGCTTGQpFWGvoQ0kNwyY
 62LGbfWceOCSyp8hY1f2TUsg3Jet3qZjx0cyxsF76mmtsPXLdGyaR44aiXIzulZh4UdA
 ojhQ==
X-Gm-Message-State: AOAM531SbfWbMv/QMuTz9hIy6u+TJzmfjafggeIm71p53wJpD8Jo3Nor
 ueNUNhqhAU7w5WR6Ylpl8HHykRHdsWOclWKTnww=
X-Google-Smtp-Source: ABdhPJw6XI3hjx5AWooDdRXiVzKuMbbIGXxMfPnG2NDSLKDUaVjg9Gvo8caMzN3iaRgk8/tq4Jo/SWZ0LnBCQ8lDUSA=
X-Received: by 2002:a17:906:388d:: with SMTP id
 q13mr2092654ejd.92.1603266157626; 
 Wed, 21 Oct 2020 00:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201021071520.2168877-1-armbru@redhat.com>
 <20201021071520.2168877-3-armbru@redhat.com>
In-Reply-To: <20201021071520.2168877-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 21 Oct 2020 11:42:25 +0400
Message-ID: <CAJ+F1CJUp=iND2PM2Pk4WiXGDYNGfcL=LPBCx9Cu1fo_mqTmHg@mail.gmail.com>
Subject: Re: [PATCH 2/4] qga: Use common time encoding for guest-get-devices
 'driver-date'
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ce4a5b05b2297dcb"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
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

--000000000000ce4a5b05b2297dcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 21, 2020 at 11:18 AM Markus Armbruster <armbru@redhat.com>
wrote:

> guest-get-devices returns 'driver-date' as string in the format
> YYYY-MM-DD.  Goes back to recent commit 2e4211cee4 "qga: add command
> guest-get-devices for reporting VirtIO devices".
>
> We should avoid use of multiple encodings for the same kind of data.
> Especially string encodings.  Change it to return nanoseconds since
> the epoch, like guest-get-time does.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

I think I assumed it was free form human-friendly string, but it has a
strict YYYY-MM-DD format in the doc, so let's use the existing one instead.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qga/qapi-schema.json |  4 ++--
>  qga/commands-win32.c | 19 +++++++++++--------
>  2 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index f2c81cda2b..c7bfb8bf6a 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1282,7 +1282,7 @@
>  # @GuestDeviceInfo:
>  #
>  # @driver-name: name of the associated driver
> -# @driver-date: driver release date in format YYYY-MM-DD
> +# @driver-date: driver release date, in nanoseconds since the epoch
>  # @driver-version: driver version
>  # @id: device ID
>  #
> @@ -1291,7 +1291,7 @@
>  { 'struct': 'GuestDeviceInfo',
>    'data': {
>        'driver-name': 'str',
> -      '*driver-date': 'str',
> +      '*driver-date': 'int',
>        '*driver-version': 'str',
>        '*id': 'GuestDeviceId'
>    } }
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 879b02b6c3..b01616a992 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1641,6 +1641,12 @@ out:
>      return head;
>  }
>
> +static int64_t filetime_to_ns(const FILETIME *tf)
> +{
> +    return ((((int64_t)tf->dwHighDateTime << 32) | tf->dwLowDateTime)
> +            - W32_FT_OFFSET) * 100;
> +}
> +
>  int64_t qmp_guest_get_time(Error **errp)
>  {
>      SYSTEMTIME ts =3D {0};
> @@ -1657,8 +1663,7 @@ int64_t qmp_guest_get_time(Error **errp)
>          return -1;
>      }
>
> -    return ((((int64_t)tf.dwHighDateTime << 32) | tf.dwLowDateTime)
> -                - W32_FT_OFFSET) * 100;
> +    return filetime_to_ns(&tf);
>  }
>
>  void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
> @@ -2363,7 +2368,6 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>      slog("enumerating devices");
>      for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i+=
+) {
>          bool skip =3D true;
> -        SYSTEMTIME utc_date;
>          g_autofree LPWSTR name =3D NULL;
>          g_autofree LPFILETIME date =3D NULL;
>          g_autofree LPWSTR version =3D NULL;
> @@ -2434,13 +2438,12 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error
> **errp)
>              slog("failed to get driver date");
>              continue;
>          }
> -        FileTimeToSystemTime(date, &utc_date);
> -        device->driver_date =3D g_strdup_printf("%04d-%02d-%02d",
> -            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
> +        device->driver_date =3D filetime_to_ns(date);
>          device->has_driver_date =3D true;
>
> -        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
> -            device->driver_date, device->driver_version);
> +        slog("driver: %s\ndriver version: %" PRId64 ",%s\n",
> +             device->driver_name, device->driver_date,
> +             device->driver_version);
>          item =3D g_new0(GuestDeviceInfoList, 1);
>          item->value =3D g_steal_pointer(&device);
>          if (!cur_item) {
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ce4a5b05b2297dcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 21, 2020 at 11:18 AM Markus Armbr=
uster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">guest-get-d=
evices returns &#39;driver-date&#39; as string in the format<br>
YYYY-MM-DD.=C2=A0 Goes back to recent commit 2e4211cee4 &quot;qga: add comm=
and<br>
guest-get-devices for reporting VirtIO devices&quot;.<br>
<br>
We should avoid use of multiple encodings for the same kind of data.<br>
Especially string encodings.=C2=A0 Change it to return nanoseconds since<br=
>
the epoch, like guest-get-time does.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>I think I assumed it was free form human-friendly string, but it has a =
strict YYYY-MM-DD format in the doc, so let&#39;s use the existing one inst=
ead.<br></div><div><br></div><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau =
&lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.=
com</a>&gt;</div><div> <br></div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
---<br>
=C2=A0qga/qapi-schema.json |=C2=A0 4 ++--<br>
=C2=A0qga/commands-win32.c | 19 +++++++++++--------<br>
=C2=A02 files changed, 13 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index f2c81cda2b..c7bfb8bf6a 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1282,7 +1282,7 @@<br>
=C2=A0# @GuestDeviceInfo:<br>
=C2=A0#<br>
=C2=A0# @driver-name: name of the associated driver<br>
-# @driver-date: driver release date in format YYYY-MM-DD<br>
+# @driver-date: driver release date, in nanoseconds since the epoch<br>
=C2=A0# @driver-version: driver version<br>
=C2=A0# @id: device ID<br>
=C2=A0#<br>
@@ -1291,7 +1291,7 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestDeviceInfo&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;driver-name&#39;: &#39;str&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 &#39;*driver-date&#39;: &#39;str&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*driver-date&#39;: &#39;int&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*driver-version&#39;: &#39;str&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*id&#39;: &#39;GuestDeviceId&#39;<br>
=C2=A0 =C2=A0} }<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 879b02b6c3..b01616a992 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1641,6 +1641,12 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
<br>
+static int64_t filetime_to_ns(const FILETIME *tf)<br>
+{<br>
+=C2=A0 =C2=A0 return ((((int64_t)tf-&gt;dwHighDateTime &lt;&lt; 32) | tf-&=
gt;dwLowDateTime)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - W32_FT_OFFSET) * 100;<br>
+}<br>
+<br>
=C2=A0int64_t qmp_guest_get_time(Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SYSTEMTIME ts =3D {0};<br>
@@ -1657,8 +1663,7 @@ int64_t qmp_guest_get_time(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return ((((int64_t)tf.dwHighDateTime &lt;&lt; 32) | tf.dwLow=
DateTime)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - W32_FT_OFFSET) *=
 100;<br>
+=C2=A0 =C2=A0 return filetime_to_ns(&amp;tf);<br>
=C2=A0}<br>
<br>
=C2=A0void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)=
<br>
@@ -2363,7 +2368,6 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0slog(&quot;enumerating devices&quot;);<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; SetupDiEnumDeviceInfo(dev_info, i, &amp;d=
ev_info_data); i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool skip =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 SYSTEMTIME utc_date;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree LPWSTR name =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree LPFILETIME date =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree LPWSTR version =3D NULL;<br>
@@ -2434,13 +2438,12 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **=
errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0slog(&quot;failed to get dr=
iver date&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 FileTimeToSystemTime(date, &amp;utc_date);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;driver_date =3D g_strdup_printf(&qu=
ot;%04d-%02d-%02d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 utc_date.wYear, utc_date.wMonth,=
 utc_date.wDay);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;driver_date =3D filetime_to_ns(date=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device-&gt;has_driver_date =3D true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;driver: %s\ndriver version: %s,%s\n=
&quot;, device-&gt;driver_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device-&gt;driver_date, device-&=
gt;driver_version);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slog(&quot;driver: %s\ndriver version: %&quot;=
 PRId64 &quot;,%s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device-&gt;driver_name, de=
vice-&gt;driver_date,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device-&gt;driver_version)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0item =3D g_new0(GuestDeviceInfoList, 1);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0item-&gt;value =3D g_steal_pointer(&amp;d=
evice);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!cur_item) {<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ce4a5b05b2297dcb--

