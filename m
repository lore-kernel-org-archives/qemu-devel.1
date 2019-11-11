Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54498C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1928720659
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPcWJw+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1928720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9pu-0006Rs-9v
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iU9pC-0005w5-25
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iU9pA-0007Nk-KW
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:33:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iU9p7-0007Mh-DX; Mon, 11 Nov 2019 08:33:41 -0500
Received: by mail-ot1-x344.google.com with SMTP id r24so11202109otk.12;
 Mon, 11 Nov 2019 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=HJgXaBh1vCYCXSH3H5FddeAoROhRWDADqESEXjBjdpU=;
 b=rPcWJw+q6AVSdOZ2XU72yZS8shvTeRUbSuS+DMUz3Y9nkHz0XxCNxOdZ1rcR7zIl6t
 J/c+I3+fBw7Ednu6tp36UtKID2RTe6Sb9Y5Wf4U9pZP/j8L+eWvdwOLFfyOhm4HYAdC4
 qc+AOgaLIKXFsKhePo/lE6G5lAfMdi6x0w1+swd4QqSNA4J7YwhvSwayrJetx5TN4B8E
 +86Tx7lp6wiDB16x40EUKirEvEKG5JfCQGugCAEPy82U8KCIIGshUH5BXu88WSOkLUCE
 5s4qNkC5dxFmGTW78S0y4YdPd+ECQXyAXs9zdfstgO/k06rWXzKteWljMmBVtSf20b0c
 f+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=HJgXaBh1vCYCXSH3H5FddeAoROhRWDADqESEXjBjdpU=;
 b=H5eN9ykYSeigidvXUvcsZcvncCzgK4uwxBHT4KCFvgCwe7e8BHb//urIcCMkRzDmty
 vrlkf5RWfjQU8Mv5jXjg+CNWZUG/6srDgr+ar80VxbQstdTxkUGVy4MSD9ScVeYWlxwv
 NFUSrP6VPLoi1oRGarLzdiS4G47hmwfJbg2JPCkWlqq+sNWSgwdiynT2Y8l9WmtQax0r
 vpXcFCIDXzzGgL6CspE2iQy7Hvl81YUljW1XbOoWZNoLqvgDmWWIgzQDEEQuED1GeUju
 XpeF/AdMZE3zRqx5s6xApkanRNuJvKrSrFKZzNlSUUW+JM2MS61TIHqh22elzO1DeVMh
 ND5A==
X-Gm-Message-State: APjAAAW06PfADBcv90QC+YhgPXQYpLN6dwLT1FqIKVGWTiwU8QegCGar
 fkU6TtrC4glCION5rTQOmO/DHtYfs2qpFOkFWZk=
X-Google-Smtp-Source: APXvYqyU/W7kRyaqqyFuH3TNN6lkXYk6+gY37ctTIW1+0g/qMfvkwnXdbwsCFg31OO5yAMBTM3DQzyqxdB/x0IX041U=
X-Received: by 2002:a9d:7986:: with SMTP id h6mr8298209otm.295.1573479220049; 
 Mon, 11 Nov 2019 05:33:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:5e89:0:0:0:0:0 with HTTP; Mon, 11 Nov 2019 05:33:39
 -0800 (PST)
In-Reply-To: <ac065856-56e2-bceb-851c-a9c150068e71@redhat.com>
References: <20191108102805.8258-1-philmd@redhat.com>
 <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
 <00cca0a5-7a51-f2d1-5120-821c335954b8@redhat.com>
 <51f9b2d9-b196-c30e-dc67-988e29b5df47@redhat.com>
 <CAFEAcA8EijZRqhFerQbq5cCbaq-qzrMzOrQjc6Ro=v2p6=W_pA@mail.gmail.com>
 <ac065856-56e2-bceb-851c-a9c150068e71@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 11 Nov 2019 14:33:39 +0100
Message-ID: <CAL1e-=jOcLGdMM0vzdCxXHuu3cBp=VX9vkaxp7GPQZQtTF52FQ@mail.gmail.com>
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f8fabe0597122d2b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f8fabe0597122d2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, November 11, 2019, Thomas Huth <thuth@redhat.com> wrote:

> On 08/11/2019 18.10, Peter Maydell wrote:
> > On Fri, 8 Nov 2019 at 17:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
> wrote:
> >> On 11/8/19 4:43 PM, Eric Blake wrote:
> >>> bzip2 is no longer a favored compression.  If we are trying to pick a
> >>> compression that is most likely to be present on any system, go with
> >>> gzip.  If we are trying to pick a compression that packs tighter and
> >>> uncompresses faster, pick xz or zstd.  But bzip2 does neither: it pac=
ks
> >>> slightly tighter than gzip but has slower performance in doing so, an=
d
> >>> thus is no longer used as a default compression.
> >>
> >> The problem was with OpenBSD 6.1 which hadn't xz available.
> >>
> >> In commit 12745eaa02 Gerd updated the VM to OpenBSD 6.5 and we now hav=
e
> >> access to xz. IIRC OSX supported versions also provide xz.
> >>
> >> If we want to revert Laszlo's patches and apply his first version (usi=
ng
> >> xz), we should do that during 5.0 dev cycle, now it is too late.
> >> I'd prefer we simply fix bzip2 for the next release.
> >
> > I don't think we should try to use 'xz' because I don't see
> > the point. We should use something that's generally available,
> > whether that's bzip2 or gzip. Life's too short to deal with
> > yet another file compression tool and format.
>
> FWIW, on the weekend, I accidentially came accross this page:
>
>  https://www.nongnu.org/lzip/xz_inadequate.html
>
> After reading that, I also don't think anymore that we should switch to
> 'xz'.



Off topic, but, from the page you linked to:

There are two ways of constructing a software design: One way is to make it
so simple that there are obviously no deficiencies and the other way is to
make it so complicated that there are no obvious deficiencies. The first
method is far more difficult.
-- C.A.R. Hoare

Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away.
-- Antoine de Saint-Exupery

Perhaps we should display these quotes at some highly visible place on our
dev QEMU website. ;)

Aleksandar



>
>  Thomas
>
>
>

--000000000000f8fabe0597122d2b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 11, 2019, Thomas Huth &lt;<a href=3D"mailto:thu=
th@redhat.com">thuth@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">On 08/11/2019 18.10, Peter Maydell wrote:<br>
&gt; On Fri, 8 Nov 2019 at 17:07, Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br>
&gt;&gt; On 11/8/19 4:43 PM, Eric Blake wrote:<br>
&gt;&gt;&gt; bzip2 is no longer a favored compression.=C2=A0 If we are tryi=
ng to pick a<br>
&gt;&gt;&gt; compression that is most likely to be present on any system, g=
o with<br>
&gt;&gt;&gt; gzip.=C2=A0 If we are trying to pick a compression that packs =
tighter and<br>
&gt;&gt;&gt; uncompresses faster, pick xz or zstd.=C2=A0 But bzip2 does nei=
ther: it packs<br>
&gt;&gt;&gt; slightly tighter than gzip but has slower performance in doing=
 so, and<br>
&gt;&gt;&gt; thus is no longer used as a default compression.<br>
&gt;&gt;<br>
&gt;&gt; The problem was with OpenBSD 6.1 which hadn&#39;t xz available.<br=
>
&gt;&gt;<br>
&gt;&gt; In commit 12745eaa02 Gerd updated the VM to OpenBSD 6.5 and we now=
 have<br>
&gt;&gt; access to xz. IIRC OSX supported versions also provide xz.<br>
&gt;&gt;<br>
&gt;&gt; If we want to revert Laszlo&#39;s patches and apply his first vers=
ion (using<br>
&gt;&gt; xz), we should do that during 5.0 dev cycle, now it is too late.<b=
r>
&gt;&gt; I&#39;d prefer we simply fix bzip2 for the next release.<br>
&gt; <br>
&gt; I don&#39;t think we should try to use &#39;xz&#39; because I don&#39;=
t see<br>
&gt; the point. We should use something that&#39;s generally available,<br>
&gt; whether that&#39;s bzip2 or gzip. Life&#39;s too short to deal with<br=
>
&gt; yet another file compression tool and format.<br>
<br>
FWIW, on the weekend, I accidentially came accross this page:<br>
<br>
=C2=A0<a href=3D"https://www.nongnu.org/lzip/xz_inadequate.html" target=3D"=
_blank">https://www.nongnu.org/lzip/<wbr>xz_inadequate.html</a><br>
<br>
After reading that, I also don&#39;t think anymore that we should switch to=
<br>
&#39;xz&#39;.</blockquote><div><br></div><div><br></div><div>Off topic, but=
, from the page you linked to:</div><div><br></div><div><blockquote style=
=3D"font-family:&#39;Times New Roman&#39;;font-size:medium"><p>There are tw=
o ways of constructing a software design: One way is to make it so simple t=
hat there are obviously no deficiencies and the other way is to make it so =
complicated that there are no obvious deficiencies. The first method is far=
 more difficult.<br>-- C.A.R. Hoare</p></blockquote><blockquote style=3D"fo=
nt-family:&#39;Times New Roman&#39;;font-size:medium"><p>Perfection is reac=
hed, not when there is no longer anything to add, but when there is no long=
er anything to take away.<br>-- Antoine de Saint-Exupery</p><div><br></div>=
</blockquote></div><div>Perhaps we should display these quotes at some high=
ly visible place on our dev QEMU website. ;)</div><div><br></div><div>Aleks=
andar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
<br>
</blockquote>

--000000000000f8fabe0597122d2b--

