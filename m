Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15569C43459
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D2420768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcG2HRyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D2420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyapQ-00073X-V9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyaoX-0006Os-H9; Thu, 23 Jul 2020 08:59:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:55069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jyaoQ-0008Ju-8D; Thu, 23 Jul 2020 08:59:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id o8so4874802wmh.4;
 Thu, 23 Jul 2020 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CiHBJ8Fm7Fw+byqoSR3craa+SAlPgQDaNxuH17HkSCg=;
 b=RcG2HRyCXYI01lD31Gwa3PYYjydpWoqgV0FOB96OYPdBtjJHXc80JgMkMHOek7QfQZ
 x0+qGfe3PpSkAZKBdy/5MW3owWh1vP9pRSXcYE/pO3ZLcAkhpZJZPfTyEnsSwK0/JP/L
 zXhN32uBdDwdizIfOYE7eRemNEGJwA11+gK9Eq0qFd9CsL/gZh6Ya6/T3Cl77MrR2C5b
 g61VZ3gFvxnXzGucYX317yxR6gY2253iBDBh9mZpQFzg5ILMAysLtdz6UJMFddGGdmGr
 ifL3qq4ugZWO6OZT+orLePuCkUuKlgKx+dBOpLbt28DslSnfJf05CWlD/0zTNtYRwk8R
 ThgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CiHBJ8Fm7Fw+byqoSR3craa+SAlPgQDaNxuH17HkSCg=;
 b=XQ0VGBIejNUJs4unaJsRVsGMrAB70XLrrk8CSIf428+jBSgCrb+WOoWTSwCjhMLljU
 rb0z/mLfJNrnwdA++A3f/0WVV5HpVcBWhG/WvQw3l2cCn5PfajHdvrOeQ0pqSNflHhdF
 D3tDHew2EXbgO0GE6aN4kcBZpjfCGDRVHahrZwM9iTW01q2GFBHIWAWvFFrTePwOxu2l
 a8jEXzOtT28EfSBBCiCz8wSMBRqBLHlUqDUiHVRvoNAmiYF6/b0LdWcbQxWlk/KGNvZ7
 HDTVu2yHI6DRQTOR76HOQHxwVYzBVF6MPmJaiXKpUvT5K93I+nP7sVelPr8s0b3Yts7P
 Sz2Q==
X-Gm-Message-State: AOAM532ei87QIiipYUIYe8K3q+6CSDeaxrDUMe0ZcVTqA5qZkI/w4LMi
 cZVzlAKskfVYUMW1vNigHzJAUUWeTVZf0fIcNM0=
X-Google-Smtp-Source: ABdhPJxhxV9/AmVQjnmEMaiPpKiiIX7XIZ+rCrH0S+2klK7BV+rOLThbIWD7itVP9nhBWfr11Tsu+fNR/7Ij6dIWF00=
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr3995406wmg.55.1595509140330;
 Thu, 23 Jul 2020 05:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
 <20200709194234.2117650-14-marcandre.lureau@redhat.com>
 <20200723123141.GP3888@redhat.com>
In-Reply-To: <20200723123141.GP3888@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Jul 2020 16:58:48 +0400
Message-ID: <CAJ+F1CKW8gEQ1fEng_W3HnBVk0Suxu21AyGuLKWGroQ8QTWsrA@mail.gmail.com>
Subject: Re: [PATCH 13/13] ssh: add GUri-based URI parsing
To: "Richard W.M. Jones" <rjones@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008b9f1205ab1b6b65"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 sheepdog@lists.wpkg.org, "open list:Block layer core" <qemu-block@nongnu.org>,
 Peter Lieven <pl@kamp.de>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008b9f1205ab1b6b65
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 23, 2020 at 4:33 PM Richard W.M. Jones <rjones@redhat.com>
wrote:

> On Thu, Jul 09, 2020 at 11:42:34PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  block/ssh.c | 75 +++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 58 insertions(+), 17 deletions(-)
> >
> > diff --git a/block/ssh.c b/block/ssh.c
> > index c8f6ad79e3c..d2bc6277613 100644
> > --- a/block/ssh.c
> > +++ b/block/ssh.c
> > @@ -180,9 +180,37 @@ static void sftp_error_trace(BDRVSSHState *s, cons=
t
> char *op)
> >
> >  static int parse_uri(const char *filename, QDict *options, Error **err=
p)
> >  {
> > +    g_autofree char *port_str =3D NULL;
> > +    const char *scheme, *server, *path, *user, *key, *value;
> > +    gint port;
> > +
> > +#ifdef HAVE_GLIB_GURI
> > +    g_autoptr(GUri) uri =3D NULL;
> > +    g_autoptr(GHashTable) params =3D NULL;
> > +    g_autoptr(GError) err =3D NULL;
> > +    GHashTableIter iter;
> > +
> > +    uri =3D g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
> > +    if (!uri) {
> > +        error_setg(errp, "Failed to parse SSH URI: %s", err->message);
> > +        return -EINVAL;
> > +    }
> > +
> > +    params =3D g_uri_parse_params(g_uri_get_query(uri), -1,
> > +                                "&;", G_URI_PARAMS_NONE, &err);
> > +    if (err) {
> > +        error_report("Failed to parse SSH URI query: %s", err->message=
);
> > +        return -EINVAL;
> > +    }
> > +
> > +    scheme =3D g_uri_get_scheme(uri);
> > +    user =3D g_uri_get_user(uri);
> > +    server =3D g_uri_get_host(uri);
> > +    path =3D g_uri_get_path(uri);
> > +    port =3D g_uri_get_port(uri);
> > +#else
> >      g_autoptr(URI) uri =3D NULL;
> >      g_autoptr(QueryParams) qp =3D NULL;
> > -    g_autofree char *port_str =3D NULL;
> >      int i;
>
> As Dan said already, this conditional code looks horrible and is going
> to be a maintenance burden.  Was there a later version of this patch
> series that resolved this?  I don't think I saw one.
>

The patch is quite experimental. glib didn't even yet receive a release
with GUri! But since I am working on the glib side, I wanted to make sure
it covers qemu needs.

I will revisit the series once GUri is frozen & released (in
mid-september),and use a copy version fallback.

Although, as I said in the cover, this is a bit riskier than having a
transition period with both the old libxml-based parser and glib-based one
for very recent distro.

Tbh, I think having both is not a big burden, because there is very low
activity around those functions. Iow, we are not spreading qemu with a lot
of extra conditionals, but only in very limited mostly static places.


> Rich.
>
>
> >      uri =3D uri_parse(filename);
> > @@ -190,44 +218,57 @@ static int parse_uri(const char *filename, QDict
> *options, Error **errp)
> >          return -EINVAL;
> >      }
> >
> > -    if (g_strcmp0(uri->scheme, "ssh") !=3D 0) {
> > -        error_setg(errp, "URI scheme must be 'ssh'");
> > +    qp =3D query_params_parse(uri->query);
> > +    if (!qp) {
> > +        error_setg(errp, "could not parse query parameters");
> >          return -EINVAL;
> >      }
> >
> > -    if (!uri->server || strcmp(uri->server, "") =3D=3D 0) {
> > -        error_setg(errp, "missing hostname in URI");
> > +    scheme =3D uri->scheme;
> > +    user =3D uri->user;
> > +    server =3D uri->server;
> > +    path =3D uri->path;
> > +    port =3D uri->port;
> > +#endif
> > +    if (g_strcmp0(scheme, "ssh") !=3D 0) {
> > +        error_setg(errp, "URI scheme must be 'ssh'");
> >          return -EINVAL;
> >      }
> >
> > -    if (!uri->path || strcmp(uri->path, "") =3D=3D 0) {
> > -        error_setg(errp, "missing remote path in URI");
> > +    if (!server || strcmp(server, "") =3D=3D 0) {
> > +        error_setg(errp, "missing hostname in URI");
> >          return -EINVAL;
> >      }
> >
> > -    qp =3D query_params_parse(uri->query);
> > -    if (!qp) {
> > -        error_setg(errp, "could not parse query parameters");
> > +    if (!path || strcmp(path, "") =3D=3D 0) {
> > +        error_setg(errp, "missing remote path in URI");
> >          return -EINVAL;
> >      }
> >
> > -    if(uri->user && strcmp(uri->user, "") !=3D 0) {
> > -        qdict_put_str(options, "user", uri->user);
> > +    if (user && strcmp(user, "") !=3D 0) {
> > +        qdict_put_str(options, "user", user);
> >      }
> >
> > -    qdict_put_str(options, "server.host", uri->server);
> > +    qdict_put_str(options, "server.host", server);
> >
> > -    port_str =3D g_strdup_printf("%d", uri->port ?: 22);
> > +    port_str =3D g_strdup_printf("%d", port ?: 22);
> >      qdict_put_str(options, "server.port", port_str);
> >
> > -    qdict_put_str(options, "path", uri->path);
> > +    qdict_put_str(options, "path", path);
> >
> >      /* Pick out any query parameters that we understand, and ignore
> >       * the rest.
> >       */
> > +#ifdef HAVE_GLIB_GURI
> > +    g_hash_table_iter_init(&iter, params);
> > +    while (g_hash_table_iter_next(&iter, (void **)&key, (void
> **)&value)) {
> > +#else
> >      for (i =3D 0; i < qp->n; ++i) {
> > -        if (strcmp(qp->p[i].name, "host_key_check") =3D=3D 0) {
> > -            qdict_put_str(options, "host_key_check", qp->p[i].value);
> > +        key =3D qp->p[i].name;
> > +        value =3D qp->p[i].value;
> > +#endif
> > +        if (g_strcmp0(key, "host_key_check") =3D=3D 0) {
> > +            qdict_put_str(options, "host_key_check", value);
> >          }
> >      }
> >
> > --
> > 2.27.0.221.ga08a83db2b
>
> --
> Richard Jones, Virtualization Group, Red Hat
> http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> libguestfs lets you edit virtual machines.  Supports shell scripting,
> bindings from many languages.  http://libguestfs.org
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000008b9f1205ab1b6b65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 23, 2020 at 4:33 PM Ric=
hard W.M. Jones &lt;<a href=3D"mailto:rjones@redhat.com">rjones@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Thu, Jul 09, 2020 at 11:42:34PM +0400, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 block/ssh.c | 75 +++++++++++++++++++++++++++++++++++++++++------=
------<br>
&gt;=C2=A0 1 file changed, 58 insertions(+), 17 deletions(-)<br>
&gt; <br>
&gt; diff --git a/block/ssh.c b/block/ssh.c<br>
&gt; index c8f6ad79e3c..d2bc6277613 100644<br>
&gt; --- a/block/ssh.c<br>
&gt; +++ b/block/ssh.c<br>
&gt; @@ -180,9 +180,37 @@ static void sftp_error_trace(BDRVSSHState *s, con=
st char *op)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int parse_uri(const char *filename, QDict *options, Error=
 **errp)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *port_str =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 const char *scheme, *server, *path, *user, *key, *value=
;<br>
&gt; +=C2=A0 =C2=A0 gint port;<br>
&gt; +<br>
&gt; +#ifdef HAVE_GLIB_GURI<br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GUri) uri =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GHashTable) params =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 GHashTableIter iter;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uri =3D g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY=
, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (!uri) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to parse SS=
H URI: %s&quot;, err-&gt;message);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 params =3D g_uri_parse_params(g_uri_get_query(uri), -1,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&amp;;&quot;, G_URI_PARAMS=
_NONE, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to parse SSH UR=
I query: %s&quot;, err-&gt;message);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 scheme =3D g_uri_get_scheme(uri);<br>
&gt; +=C2=A0 =C2=A0 user =3D g_uri_get_user(uri);<br>
&gt; +=C2=A0 =C2=A0 server =3D g_uri_get_host(uri);<br>
&gt; +=C2=A0 =C2=A0 path =3D g_uri_get_path(uri);<br>
&gt; +=C2=A0 =C2=A0 port =3D g_uri_get_port(uri);<br>
&gt; +#else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(URI) uri =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(QueryParams) qp =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 g_autofree char *port_str =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
<br>
As Dan said already, this conditional code looks horrible and is going<br>
to be a maintenance burden.=C2=A0 Was there a later version of this patch<b=
r>
series that resolved this?=C2=A0 I don&#39;t think I saw one.<br></blockquo=
te><div><br></div><div>The patch is quite experimental. glib didn&#39;t eve=
n yet receive a release with GUri! But since I am working on the glib side,=
 I wanted to make sure it covers qemu needs.</div><div><br></div><div>I wil=
l revisit the series once GUri is frozen &amp; released (in mid-september),=
and use a copy version fallback.</div><div><br></div><div>Although, as I sa=
id in the cover, this is a bit riskier than having a transition period with=
 both the old libxml-based parser and glib-based one for very recent distro=
.<br></div><div><br></div><div>Tbh, I think having both is not a big burden=
, because there is very low activity around those functions. Iow, we are no=
t spreading qemu with a lot of extra conditionals, but only in very limited=
 mostly static places.<br></div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
Rich.<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uri =3D uri_parse(filename);<br>
&gt; @@ -190,44 +218,57 @@ static int parse_uri(const char *filename, QDict=
 *options, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (g_strcmp0(uri-&gt;scheme, &quot;ssh&quot;) !=3D 0) =
{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;URI scheme must be=
 &#39;ssh&#39;&quot;);<br>
&gt; +=C2=A0 =C2=A0 qp =3D query_params_parse(uri-&gt;query);<br>
&gt; +=C2=A0 =C2=A0 if (!qp) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;could not parse qu=
ery parameters&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (!uri-&gt;server || strcmp(uri-&gt;server, &quot;&qu=
ot;) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;missing hostname i=
n URI&quot;);<br>
&gt; +=C2=A0 =C2=A0 scheme =3D uri-&gt;scheme;<br>
&gt; +=C2=A0 =C2=A0 user =3D uri-&gt;user;<br>
&gt; +=C2=A0 =C2=A0 server =3D uri-&gt;server;<br>
&gt; +=C2=A0 =C2=A0 path =3D uri-&gt;path;<br>
&gt; +=C2=A0 =C2=A0 port =3D uri-&gt;port;<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 if (g_strcmp0(scheme, &quot;ssh&quot;) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;URI scheme must be=
 &#39;ssh&#39;&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (!uri-&gt;path || strcmp(uri-&gt;path, &quot;&quot;)=
 =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;missing remote pat=
h in URI&quot;);<br>
&gt; +=C2=A0 =C2=A0 if (!server || strcmp(server, &quot;&quot;) =3D=3D 0) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;missing hostname i=
n URI&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 qp =3D query_params_parse(uri-&gt;query);<br>
&gt; -=C2=A0 =C2=A0 if (!qp) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;could not parse qu=
ery parameters&quot;);<br>
&gt; +=C2=A0 =C2=A0 if (!path || strcmp(path, &quot;&quot;) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;missing remote pat=
h in URI&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if(uri-&gt;user &amp;&amp; strcmp(uri-&gt;user, &quot;&=
quot;) !=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_put_str(options, &quot;user&quot;, =
uri-&gt;user);<br>
&gt; +=C2=A0 =C2=A0 if (user &amp;&amp; strcmp(user, &quot;&quot;) !=3D 0) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_put_str(options, &quot;user&quot;, =
user);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 qdict_put_str(options, &quot;server.host&quot;, uri-&gt=
;server);<br>
&gt; +=C2=A0 =C2=A0 qdict_put_str(options, &quot;server.host&quot;, server)=
;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 port_str =3D g_strdup_printf(&quot;%d&quot;, uri-&gt;po=
rt ?: 22);<br>
&gt; +=C2=A0 =C2=A0 port_str =3D g_strdup_printf(&quot;%d&quot;, port ?: 22=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qdict_put_str(options, &quot;server.port&quot;, po=
rt_str);<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 qdict_put_str(options, &quot;path&quot;, uri-&gt;path);=
<br>
&gt; +=C2=A0 =C2=A0 qdict_put_str(options, &quot;path&quot;, path);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Pick out any query parameters that we understan=
d, and ignore<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* the rest.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +#ifdef HAVE_GLIB_GURI<br>
&gt; +=C2=A0 =C2=A0 g_hash_table_iter_init(&amp;iter, params);<br>
&gt; +=C2=A0 =C2=A0 while (g_hash_table_iter_next(&amp;iter, (void **)&amp;=
key, (void **)&amp;value)) {<br>
&gt; +#else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; qp-&gt;n; ++i) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(qp-&gt;p[i].name, &quot;host_k=
ey_check&quot;) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_put_str(options, &quo=
t;host_key_check&quot;, qp-&gt;p[i].value);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D qp-&gt;p[i].name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D qp-&gt;p[i].value;<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strcmp0(key, &quot;host_key_check&q=
uot;) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdict_put_str(options, &quo=
t;host_key_check&quot;, value);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.27.0.221.ga08a83db2b<br>
<br>
-- <br>
Richard Jones, Virtualization Group, Red Hat <a href=3D"http://people.redha=
t.com/~rjones" rel=3D"noreferrer" target=3D"_blank">http://people.redhat.co=
m/~rjones</a><br>
Read my programming and virtualization blog: <a href=3D"http://rwmj.wordpre=
ss.com" rel=3D"noreferrer" target=3D"_blank">http://rwmj.wordpress.com</a><=
br>
libguestfs lets you edit virtual machines.=C2=A0 Supports shell scripting,<=
br>
bindings from many languages.=C2=A0 <a href=3D"http://libguestfs.org" rel=
=3D"noreferrer" target=3D"_blank">http://libguestfs.org</a><br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000008b9f1205ab1b6b65--

