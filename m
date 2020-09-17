Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506FCC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6CE206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bsdimp-com.20150623.gappssmtp.com header.i=@bsdimp-com.20150623.gappssmtp.com header.b="0TWvU31I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6CE206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIw9h-000535-HV
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1kIw42-0000Zd-2g
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:43:14 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36]:45687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1kIw3p-0000nH-Fx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:43:13 -0400
Received: by mail-qv1-xf36.google.com with SMTP id cv8so1183364qvb.12
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Ec+/ZqYOLzMujKOL24DTtJiUkdEM7E1+WvdEhWyP2s=;
 b=0TWvU31IEKTIcCZgQtVn9ge6nqELvg51QlBaDWcheZFrljS+OGOelcbRTUjD9Xc4BK
 /7ItAjXoenR2DnFlOl2QPCnOCdn5h5oPAdXAG9nLp9C7/bUowXeJzkpcz6C2neqfASBo
 g3BkNZy/2nDJa8XLq4jBKOiv02+5+YXUeH5VI/0ojunwMmQedYVTjhPeKullZeXr8Lkb
 FqgOuoSdQpnWE92+W3TMLSWO7jPHToPy21O2dhF502RSip9WfWFFfHDvvZ7/XP0QHRPz
 lsz7nyXQLhZ1cZG7wglMFQt+3n/E2NmMndN4OPBn8fSxorFFelmoV2d/sZc7ajHRv4B2
 inAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Ec+/ZqYOLzMujKOL24DTtJiUkdEM7E1+WvdEhWyP2s=;
 b=ilTHAkBKByXz5g9eojEyv3RUupfW1ahdiPEPEQjeWsEg4w0KlqeEueWGJmXkSwkCuR
 nkM5/x8gORlYxTv86aBqMM16AO+rx1LI3IrgV4n84I+Bvl5JpRoA9l0wC6KTxfZ/grIA
 k4mkbWFjen/I4Li2X0xCigGzNHMFqcntmYfC40Hgcc++UMdTrRrQR3ZdszunqL+zasIj
 Aj/50zIUAhUlTrmc2Yq2Q7AZuEmA50D0VR1L9V1LiudoFZQ0ddbCaNMrw4PbNC6i6itV
 YsaJ4Zf4x/FjRo+zqlEa8JDuWU1dRv30CkTfQKhyIXah0ywExH/6OJhZiR7VWBcOnbP8
 v2XQ==
X-Gm-Message-State: AOAM531cBYW05ajLtUTF+UgF//riy8K47H1/OBEN/GI2RG2dzXlYtMCC
 OHhNlGMULpBe6JRRWyv2Zl15QPp7HEn38xHSkG+WRg==
X-Google-Smtp-Source: ABdhPJxEiWbhStJmtL+p4PXSGrh7GZL5mKuNiYJEUrB45iU9cjFz07AVh3o81jJKLKog5O9Wf+0HGxAWR9g2paeWMSM=
X-Received: by 2002:ad4:544a:: with SMTP id h10mr12954136qvt.35.1600357376716; 
 Thu, 17 Sep 2020 08:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com>
 <871rj0o1yk.fsf@dusky.pond.sub.org>
In-Reply-To: <871rj0o1yk.fsf@dusky.pond.sub.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 17 Sep 2020 09:42:45 -0600
Message-ID: <CANCZdfoML814K06BSg1C30pYve6qs2T-q8Z6scaGfO_LCtnacQ@mail.gmail.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f416c705af843c4d"
Received-SPF: none client-ip=2607:f8b0:4864:20::f36;
 envelope-from=wlosh@bsdimp.com; helo=mail-qv1-xf36.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f416c705af843c4d
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 17, 2020 at 9:37 AM Markus Armbruster <armbru@redhat.com> wrote:

> Thomas Huth <thuth@redhat.com> writes:
>
> > On 16/09/2020 16.00, Thomas Huth wrote:
> >> On 16/09/2020 14.30, Peter Maydell wrote:
> >>> On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com>
> wrote:
> >>>> We require Python 3.5.  It will reach its "end of life" at the end of
> >>>> September 2020[*].  Any reason not to require 3.6 for 5.2?
> qemu-iotests
> >>>> already does for its Python parts.
> >> [...]
> >>> The default should be
> >>> "leave the version dependency where it is", not "bump the version
> >>> dependency as soon as we can".
> >>
> >> OTOH, if none of our supported build systems uses python 3.5 by default
> >> anymore, it also will not get tested anymore, so bugs might creep in,
> >> which will of course end up in a bad experience for the users, too, that
> >> still try to build with such an old version. So limiting the version to
> >> the level that we also test is IMHO very reasonable.
> >>
> >> Let's have a look at the (older) systems that we support and the python
> >> versions according to repology.org:
> >> - FreeBSD Ports : >= 3.5.10 - but there is also 3.6 or newer
>

FreeBSD Ports can specify, on a per-port basis, which version of Python to
use:

USES= python:3.6+

So we're good there for all supported FreeBSD versions (11.x, 12.x and
-current).

Warner

--000000000000f416c705af843c4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 17, 2020 at 9:37 AM Marku=
s Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Thom=
as Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blank">thuth@red=
hat.com</a>&gt; writes:<br>
<br>
&gt; On 16/09/2020 16.00, Thomas Huth wrote:<br>
&gt;&gt; On 16/09/2020 14.30, Peter Maydell wrote:<br>
&gt;&gt;&gt; On Wed, 16 Sep 2020 at 08:43, Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrot=
e:<br>
&gt;&gt;&gt;&gt; We require Python 3.5.=C2=A0 It will reach its &quot;end o=
f life&quot; at the end of<br>
&gt;&gt;&gt;&gt; September 2020[*].=C2=A0 Any reason not to require 3.6 for=
 5.2?=C2=A0 qemu-iotests<br>
&gt;&gt;&gt;&gt; already does for its Python parts.<br>
&gt;&gt; [...]<br>
&gt;&gt;&gt; The default should be<br>
&gt;&gt;&gt; &quot;leave the version dependency where it is&quot;, not &quo=
t;bump the version<br>
&gt;&gt;&gt; dependency as soon as we can&quot;.<br>
&gt;&gt; <br>
&gt;&gt; OTOH, if none of our supported build systems uses python 3.5 by de=
fault<br>
&gt;&gt; anymore, it also will not get tested anymore, so bugs might creep =
in,<br>
&gt;&gt; which will of course end up in a bad experience for the users, too=
, that<br>
&gt;&gt; still try to build with such an old version. So limiting the versi=
on to<br>
&gt;&gt; the level that we also test is IMHO very reasonable.<br>
&gt;&gt; <br>
&gt;&gt; Let&#39;s have a look at the (older) systems that we support and t=
he python<br>
&gt;&gt; versions according to <a href=3D"http://repology.org" rel=3D"noref=
errer" target=3D"_blank">repology.org</a>:<br>&gt;&gt; - FreeBSD Ports : &g=
t;=3D 3.5.10 - but there is also 3.6 or newer<br></blockquote><div><br></di=
v><div>FreeBSD Ports can specify, on a per-port basis, which version of Pyt=
hon to use:</div><div><br></div><div>USES=3D python:3.6+</div><div><br></di=
v><div>So we&#39;re good there for all supported FreeBSD versions (11.x, 12=
.x and -current).</div><div><br></div><div>Warner</div></div></div>

--000000000000f416c705af843c4d--

