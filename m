Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EDCC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E1B2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tk3scmdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E1B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMlH-00043Z-M1
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBMkY-0003UB-7l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:35:50 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBMkW-00029K-FX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:35:49 -0400
Received: by mail-ej1-x643.google.com with SMTP id si26so8983711ejb.12
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ui/pfJ9r7NihFA3jOWeIkxOwSMYhEzAdE4/Tcy13x7Q=;
 b=Tk3scmdXqYUDjaSmd+7DVzGI9frbjoveBJOazbzB2E0ZsgAj7JRvItOi306N0rUfh7
 d9lHO5GN1ZRBJdWRroyWzUsompd9iJHVQ//Xem2FUZ939bsbwI0tJy1XF8QXXOq+t0i1
 Yd/fD5mS5plJrJ6+D+lyAfVqac/AHxMp/SE6nrX4xuIkgOQmqcfy0V04fs94QGtf3+w8
 XHlvNFQ9ny63Qjuz+itt483U9nzkcLw+5PGb7SkxOYDv+8XyyKrjZsTEn+83KHDpYDeg
 wXjTn5en1NeNzRC2NItp2MrFz0hjf7meZudfJastuqeelO5Z4HoTDuu8vKv35U3Av93B
 /jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ui/pfJ9r7NihFA3jOWeIkxOwSMYhEzAdE4/Tcy13x7Q=;
 b=OCR5QB37ITOvkyCfVbJ3TJumAm0J4I4eT0QePgm1OrVRRROKpSbuGdhlfRqbr3aXb4
 nLssUIZ78j1WrWJ6dJzowQaEQ/4KaluFl36fgw70m/h3DrAh553YeGxhhlqkj1tSiwca
 Emb01jItNjO47PitF9/bIR4B1zegimXNwxt5SB6eYrxbcu/H9BmfSqy3g/75Pd9sYxuu
 gje/e3pWLxBTK+bGE5kWyICEZ+hfpX81qjTGw75yjTS4ta6PjXvQ9PzG/jwlikjvM1R1
 kGWzu6PXwxKvRfqaafDA9lzDLx195rHbdqSwiwtp/dHL+m1XQD7Oq1qT5ykK+5S5bmJB
 BQ5Q==
X-Gm-Message-State: AOAM531kmcs0uDaHzfB1T5p0T9TCm2m/EwrZM7eb1xIuSsVsrdhUWb6a
 JPgFDYS9sg7mP0Iip2qhGI0b/t0hGGFmZiDhZEM=
X-Google-Smtp-Source: ABdhPJw/a7upVBY6KJJabbzlZWLYag2GaAyyPX3ph7/n/OT4YmuWNH0spXf+vTPCnM/BYQnpdECJISebdcKWPQjX/U4=
X-Received: by 2002:a17:906:b78e:: with SMTP id
 dt14mr18133199ejb.527.1598553346319; 
 Thu, 27 Aug 2020 11:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200827161826.1165971-1-marcandre.lureau@redhat.com>
 <c52960c3-d88c-010d-584a-75917bc9b702@redhat.com>
In-Reply-To: <c52960c3-d88c-010d-584a-75917bc9b702@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 27 Aug 2020 22:35:34 +0400
Message-ID: <CAJ+F1C+f+giaG4ZekLKes0-E64cE+0CX=AMVpNB-qfUMz-vQuw@mail.gmail.com>
Subject: Re: [PATCH] test-vmstate: fix bad GTree usage, use-after-free
To: Auger Eric <eric.auger@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005ca94605ade03408"
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
Cc: QEMU <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005ca94605ade03408
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Aug 27, 2020 at 8:34 PM Auger Eric <eric.auger@redhat.com> wrote:

> Hi Marc-Andre
>
> On 8/27/20 6:18 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > According to g_tree_foreach() documentation:
> > "The tree may not be modified while iterating over it (you can't
> > add/remove items)."
>
> Hum I did not see that.
> >
> > Fixes: 9a85e4b8f6 ("migration: Support gtree migration")
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/test-vmstate.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> > index f7b3868881..31aefa78f0 100644
> > --- a/tests/test-vmstate.c
> > +++ b/tests/test-vmstate.c
> > @@ -1078,7 +1078,6 @@ static gboolean diff_tree(gpointer key, gpointer
> value, gpointer data)
> >      struct match_node_data d =3D {tp->tree2, key, value};
> >
> >      g_tree_foreach(tp->tree2, tp->match_node, &d);
> > -    g_tree_remove(tp->tree1, key);
> it does not test the same thing I am afraid. If one of the trees
> contains more elements than the others this won't be detected.
>
>
-    assert(g_tree_nnodes(tree1) =3D=3D 0);

Was simply checking that all nodes from tree1 were deleted.

Whatever else must have been checked elsewhere or differently by new code.


> Also there is another case of removal inside the traversal in the
> match_node(): in match_interval_mapping_node() and match_domain_node()
>
>
Yes, but they don't update the traversed tree.

Thanks
>
> Eric
>
>
> >      return false;
> >  }
> >
> > @@ -1088,7 +1087,7 @@ static void compare_trees(GTree *tree1, GTree
> *tree2,
> >      struct tree_cmp_data tp =3D {tree1, tree2, function};
> >
> >      g_tree_foreach(tree1, diff_tree, &tp);
> > -    assert(g_tree_nnodes(tree1) =3D=3D 0);> +
> g_tree_destroy(g_tree_ref(tree1));
> >      assert(g_tree_nnodes(tree2) =3D=3D 0);
> >  }
> >
> >
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005ca94605ade03408
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 27, 2020 at 8:34 PM Aug=
er Eric &lt;<a href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i Marc-Andre<br>
<br>
On 8/27/20 6:18 PM, <a href=3D"mailto:marcandre.lureau@redhat.com" target=
=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; According to g_tree_foreach() documentation:<br>
&gt; &quot;The tree may not be modified while iterating over it (you can&#3=
9;t<br>
&gt; add/remove items).&quot;<br>
<br>
Hum I did not see that.<br>
&gt; <br>
&gt; Fixes: 9a85e4b8f6 (&quot;migration: Support gtree migration&quot;)<br>
&gt; Cc: Eric Auger &lt;<a href=3D"mailto:eric.auger@redhat.com" target=3D"=
_blank">eric.auger@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 tests/test-vmstate.c | 3 +--<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c<br>
&gt; index f7b3868881..31aefa78f0 100644<br>
&gt; --- a/tests/test-vmstate.c<br>
&gt; +++ b/tests/test-vmstate.c<br>
&gt; @@ -1078,7 +1078,6 @@ static gboolean diff_tree(gpointer key, gpointer=
 value, gpointer data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct match_node_data d =3D {tp-&gt;tree2, key, v=
alue};<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_tree_foreach(tp-&gt;tree2, tp-&gt;match_node, &a=
mp;d);<br>
&gt; -=C2=A0 =C2=A0 g_tree_remove(tp-&gt;tree1, key);<br>
it does not test the same thing I am afraid. If one of the trees<br>
contains more elements than the others this won&#39;t be detected.<br>
<br></blockquote><div><br></div><div>- =C2=A0 =C2=A0assert(g_tree_nnodes(tr=
ee1) =3D=3D 0);<br></div><div><br></div><div>Was simply checking that all n=
odes from tree1 were deleted.<br></div><div><br></div><div>Whatever else mu=
st have been checked elsewhere or differently by new code.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Also there is another case of removal inside the traversal in the<br>
match_node(): in match_interval_mapping_node() and match_domain_node()<br>
<br></blockquote><div><br></div><div>Yes, but they don&#39;t update the tra=
versed tree.</div><div> <br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Thanks<br>
<br>
Eric<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -1088,7 +1087,7 @@ static void compare_trees(GTree *tree1, GTree *t=
ree2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct tree_cmp_data tp =3D {tree1, tree2, functio=
n};<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_tree_foreach(tree1, diff_tree, &amp;tp);<br>
&gt; -=C2=A0 =C2=A0 assert(g_tree_nnodes(tree1) =3D=3D 0);&gt; +=C2=A0 =C2=
=A0 g_tree_destroy(g_tree_ref(tree1));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 assert(g_tree_nnodes(tree2) =3D=3D 0);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; <br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000005ca94605ade03408--

