Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF446C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95BB20786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z14XV1cN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95BB20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7DG-00088I-Uw
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 04:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jl7CS-0007eJ-Ha
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:44:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jl7CQ-0008Jp-CP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:44:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id p5so19813612wrw.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ByNQ/liGGy4Z830PVlmVMPKgU16UvyuMbr2+nXzH0Ic=;
 b=Z14XV1cNdBoHYhHq2WMYo1+giP4G/huwXiRh9lKY6/AOMSxZeSC2R+eq6quBwlGT7h
 8r/LiwB51Uws3ZVvJeaZczF6xI4CVV7WGpSTPTmFNvCeDR+5fHiXTB267lPfbbsDSxJ8
 dnucDuzMt8PdJpS5JWxnHJ9iKiXoUeB9THQseyWmRfyeOMciHszmm2M5aHWtqVUez4m8
 ZBCYiL/CKHMi7G3jQQ0BBoRkDYV49yXAmF3FqJLZJYvWTDqrSanlGYKdWEZ3KS3Jy3Ot
 0PNd8zD18D48aEEGV58vzBtlZjCgREzOs/3yavWnDlJuQ8jl08wdkaudlKIZ/tsZ/ZEL
 TM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ByNQ/liGGy4Z830PVlmVMPKgU16UvyuMbr2+nXzH0Ic=;
 b=mvvaxU32cm3IqCeR8HasHzpPE/YMNlSJJzEeaE+csMVy/vrGdZH4Tek+zJDyjdVcF0
 O1YxGs+UHHEUd4ed2q/Ykqa8cBcabf4AQHB1gO6XBlwR3kRQFB6coiW/jHEFglsPgILM
 nZH1SQ6/kWKo3rsGMPvPSGr4fA9sJo++IT/4DwZBxTrprIyLG6pbrlj8REZa3OSlCmyx
 RDyNtckhRGy9AqQu6ndnprteTpXoeMx2VmxR/+3/9jCUIR2/K7lHgW9y8jiDRCHgflXE
 dzvWuHEXVg7xcKmSX/jjYClLh0L+e9T/O2IwT6wXtDD38xSZi5GJZ6zKbXJXu0bVgrPD
 IHCg==
X-Gm-Message-State: AOAM53132GH7Y976cZKOhxdeVHy1W8uSJLmgBCiRGs6iNe3EmF9HZ5zh
 elQtB/C0KexkFeZem567EguwaYrni6wqna8U6qk=
X-Google-Smtp-Source: ABdhPJxlvpo7AwamrUGYiWPCfGPd7jcibdeX61iLDDMvHcCDOjVrQk9efmuyNWyYBHbZ0ySxlJsf5QMnqzMxn7rlE/4=
X-Received: by 2002:adf:9544:: with SMTP id 62mr1805767wrs.32.1592297044552;
 Tue, 16 Jun 2020 01:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <8e73f685e10c684eb5e2c88c2185504d26f024fc.1592296355.git.mprivozn@redhat.com>
In-Reply-To: <8e73f685e10c684eb5e2c88c2185504d26f024fc.1592296355.git.mprivozn@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 16 Jun 2020 12:43:52 +0400
Message-ID: <CAJ+F1CKGhOjD78PduiBaLdUFGezKw23w1LKCGE6PtP9pizagMQ@mail.gmail.com>
Subject: Re: [PATCH] qga: Use gethostname() instead of g_get_host_name()
To: Michal Privoznik <mprivozn@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b7afc805a82f8be5"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>,
 Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b7afc805a82f8be5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 16, 2020 at 12:35 PM Michal Privoznik <mprivozn@redhat.com>
wrote:

> Problem with g_get_host_name() is that on the first call it saves
> the hostname into a global variable and from then on, every
> subsequent call returns the saved hostname. Even if the hostname
> changes. This doesn't play nicely with guest agent, because if
> the hostname is acquired before the guest is set up (e.g. on the
> first boot, or before DHCP) we will report old, invalid hostname.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1845127


lgtm,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(fwiw, I opened a glib issue:
https://gitlab.gnome.org/GNOME/glib/-/issues/2130)


>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  qga/commands.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/qga/commands.c b/qga/commands.c
> index efc8b90281..ce3c2041a6 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -512,14 +512,62 @@ int ga_parse_whence(GuestFileWhence *whence, Error
> **errp)
>      return -1;
>  }
>
> +#ifndef HOST_NAME_MAX
> +# ifdef _POSIX_HOST_NAME_MAX
> +#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
> +# else
> +#  define HOST_NAME_MAX 255
> +# endif
> +#endif
> +
>  GuestHostName *qmp_guest_get_host_name(Error **errp)
>  {
>      GuestHostName *result =3D NULL;
> -    gchar const *hostname =3D g_get_host_name();
> -    if (hostname !=3D NULL) {
> -        result =3D g_new0(GuestHostName, 1);
> -        result->host_name =3D g_strdup(hostname);
> +    g_autofree char *hostname =3D NULL;
> +
> +    /*
> +     * We want to avoid using g_get_host_name() because that
> +     * caches the result and we wouldn't reflect changes in the
> +     * host name.
> +     */
> +
> +#ifndef G_OS_WIN32
> +    long len =3D -1;
> +
> +#ifdef _SC_HOST_NAME_MAX
> +    len =3D sysconf(_SC_HOST_NAME_MAX);
> +#endif /* _SC_HOST_NAME_MAX */
> +
> +    if (len < 0) {
> +        len =3D HOST_NAME_MAX;
>      }
> +
> +    hostname =3D g_malloc0(len + 1);
> +
> +    if (gethostname(hostname, len) < 0) {
> +        return NULL;
> +    }
> +
> +#else /* G_OS_WIN32 */
> +
> +    wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
> +    DWORD size =3D G_N_ELEMENTS(tmp);
> +
> +    if (GetComputerNameW(tmp, &size) !=3D 0) {
> +        /*
> +         * Indeed, on Windows retval of zero means failure
> +         * and nonzero means success.
> +         */
> +        hostname =3D g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
> +    }
> +#endif /* G_OS_WIN32 */
> +
> +    if (!hostname) {
> +        hostname =3D g_strdup("localhost");
> +    }
> +
> +    result =3D g_new0(GuestHostName, 1);
> +    result->host_name =3D g_steal_pointer(&hostname);
>      return result;
>  }
>
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b7afc805a82f8be5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 16, 2020 at 12:35 PM Mi=
chal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.com">mprivozn@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Problem with g_get_host_name() is that on the first call it saves<br>
the hostname into a global variable and from then on, every<br>
subsequent call returns the saved hostname. Even if the hostname<br>
changes. This doesn&#39;t play nicely with guest agent, because if<br>
the hostname is acquired before the guest is set up (e.g. on the<br>
first boot, or before DHCP) we will report old, invalid hostname.<br>
<br>
Fixes: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1845127" re=
l=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi=
?id=3D1845127</a></blockquote><div><br></div><div>lgtm,</div><div>Reviewed-=
by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m">marcandre.lureau@redhat.com</a>&gt;</div><div><br></div><div>(fwiw, I op=
ened a glib issue: <a href=3D"https://gitlab.gnome.org/GNOME/glib/-/issues/=
2130">https://gitlab.gnome.org/GNOME/glib/-/issues/2130</a>)</div><div><br>=
 </div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Signed-off-by: Michal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.com" =
target=3D"_blank">mprivozn@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---=
-<br>
=C2=A01 file changed, 52 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/qga/commands.c b/qga/commands.c<br>
index efc8b90281..ce3c2041a6 100644<br>
--- a/qga/commands.c<br>
+++ b/qga/commands.c<br>
@@ -512,14 +512,62 @@ int ga_parse_whence(GuestFileWhence *whence, Error **=
errp)<br>
=C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0}<br>
<br>
+#ifndef HOST_NAME_MAX<br>
+# ifdef _POSIX_HOST_NAME_MAX<br>
+#=C2=A0 define HOST_NAME_MAX _POSIX_HOST_NAME_MAX<br>
+# else<br>
+#=C2=A0 define HOST_NAME_MAX 255<br>
+# endif<br>
+#endif<br>
+<br>
=C2=A0GuestHostName *qmp_guest_get_host_name(Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GuestHostName *result =3D NULL;<br>
-=C2=A0 =C2=A0 gchar const *hostname =3D g_get_host_name();<br>
-=C2=A0 =C2=A0 if (hostname !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_new0(GuestHostName, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;host_name =3D g_strdup(hostname);<b=
r>
+=C2=A0 =C2=A0 g_autofree char *hostname =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We want to avoid using g_get_host_name() because tha=
t<br>
+=C2=A0 =C2=A0 =C2=A0* caches the result and we wouldn&#39;t reflect change=
s in the<br>
+=C2=A0 =C2=A0 =C2=A0* host name.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+#ifndef G_OS_WIN32<br>
+=C2=A0 =C2=A0 long len =3D -1;<br>
+<br>
+#ifdef _SC_HOST_NAME_MAX<br>
+=C2=A0 =C2=A0 len =3D sysconf(_SC_HOST_NAME_MAX);<br>
+#endif /* _SC_HOST_NAME_MAX */<br>
+<br>
+=C2=A0 =C2=A0 if (len &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D HOST_NAME_MAX;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 hostname =3D g_malloc0(len + 1);<br>
+<br>
+=C2=A0 =C2=A0 if (gethostname(hostname, len) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#else /* G_OS_WIN32 */<br>
+<br>
+=C2=A0 =C2=A0 wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];<br>
+=C2=A0 =C2=A0 DWORD size =3D G_N_ELEMENTS(tmp);<br>
+<br>
+=C2=A0 =C2=A0 if (GetComputerNameW(tmp, &amp;size) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Indeed, on Windows retval of zero mean=
s failure<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and nonzero means success.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hostname =3D g_utf16_to_utf8(tmp, size, NULL, =
NULL, NULL);<br>
+=C2=A0 =C2=A0 }<br>
+#endif /* G_OS_WIN32 */<br>
+<br>
+=C2=A0 =C2=A0 if (!hostname) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hostname =3D g_strdup(&quot;localhost&quot;);<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 result =3D g_new0(GuestHostName, 1);<br>
+=C2=A0 =C2=A0 result-&gt;host_name =3D g_steal_pointer(&amp;hostname);<br>
=C2=A0 =C2=A0 =C2=A0return result;<br>
=C2=A0}<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000b7afc805a82f8be5--

