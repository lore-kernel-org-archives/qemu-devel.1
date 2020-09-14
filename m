Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBECEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF0420EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtDko3ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF0420EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqwh-0005o6-C3
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHqsL-0003DA-Vd; Mon, 14 Sep 2020 11:58:45 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHqsJ-00009w-Jp; Mon, 14 Sep 2020 11:58:41 -0400
Received: by mail-lf1-x143.google.com with SMTP id z19so14011921lfr.4;
 Mon, 14 Sep 2020 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=WL2Nsav9eFo5xBWvEC2Fha+5e5vE6zOruBdaIc3Xvx0=;
 b=GtDko3ctTf2LvHnj6EUb7is2mj0DeOBmii1tUsj7O0dm6f38LMEYRfIF/BlNlZghp0
 Hn0wnopnxlh46IvCid75/BzplADwbTEBRntGMUZVAwZdD5+CAxVLhzZvYWNGHtAE1VqG
 QHQ5FxxapSpvDl+cp70hV2M18jw2/09QUKDQr+oYxtbOfEGbvhsQ7U9O4P7zeZATlwHQ
 GRZ2N7GBc5KNBZ54F/3FXeSX4E2KskVwPhkpw/7Xg7i+A0ZUO7MG+M6NyJya9b5ssYJX
 SjWOqquJyqks2H+Nq5uqnHauu+SBcc79QU9in2nGsQKc4qQJ0pY1RgEGWJ65YGr3hY5K
 y4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=WL2Nsav9eFo5xBWvEC2Fha+5e5vE6zOruBdaIc3Xvx0=;
 b=IFekywsVCPSQinO1Kh4vlruocgKEiXXxUac6qPU0naHuiBe1AI0sGJCtTEr2b+zM8E
 ZZM2p0zxhTBfBaAAMRyyy+fTUy+4g3KGlxY8GYUp20bOllUNXy84tJUDfoI5CbDtbVF2
 oW/NEfx7IkNxJPuXEbD6Xc+TlRtgrC1n2KX4f2JY7YqIu1W92vTPD271NKAYZo0Nv2rK
 FVCXEsC8k/fnvXYo/5hjEmsETN/Ukm2vtR5bijwmCl5Xz2K3arr6vpuA5J8kCa3tnIo4
 5v5l1orTre0XnXVtl2CnTRrBgLlfM5APUUBNJHrPQm/Hm4mslgDtG8DIKa6e9HPdoXfC
 QBAA==
X-Gm-Message-State: AOAM533DdbByVUEs/4qsp6THE5lYRneq/28KB74X6VzE9TZmVEYWJtQ4
 QIRtBnfV80PdoNacVRe9XzLrVqB2/Jj+QJghRmc=
X-Google-Smtp-Source: ABdhPJxTDNLT0n4znwBpuwsXQ/uOTPF/x2tvWXrkcnRzX7+vJOI+hQ1RCa6c2sljDcWYhplNs70U7dKV0mG1ay0kgkU=
X-Received: by 2002:a19:9141:: with SMTP id y1mr4140895lfj.554.1600099117041; 
 Mon, 14 Sep 2020 08:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-14-luoyonggang@gmail.com>
 <119be52f-fc8b-dd37-e3d6-04a13109c845@redhat.com>
 <CAE2XoE-Qi1aZhq09QEswq-NFYRYWV+ZM4YZz=pGCynMd5Ova8Q@mail.gmail.com>
 <fb3a1a4f-fb60-00f2-878a-f61241adcfb3@redhat.com>
In-Reply-To: <fb3a1a4f-fb60-00f2-878a-f61241adcfb3@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 23:58:24 +0800
Message-ID: <CAE2XoE_SQ9i4RHq9=SDukVag=cYvv6BNo_aQv9PSq3box4keiQ@mail.gmail.com>
Subject: Re: [PATCH v8 13/27] tests: Enable crypto tests under msys2/mingw
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007a119505af481b12"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-level <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007a119505af481b12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 7:07 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 14/09/2020 10.19, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> > On Mon, Sep 14, 2020 at 3:23 PM Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> wrote:
> >>
> >> On 13/09/2020 00.44, Yonggang Luo wrote:
> >> > Fixes following tests on msys2/mingw
> >> >       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
> > 'pkix_asn1_tab.c',
> >> >                                    tasn1, crypto],
> >> >       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c',
> > 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
> >> >                                  tasn1, crypto],
> >> >       'test-io-channel-tls': ['io-channel-helpers.c',
> > 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
> >> >                               tasn1, io, crypto]}
> >> > These tests are failure with:
> >> > ERROR test-crypto-tlscredsx509 - missing test plan
> >> > ERROR test-crypto-tlssession - missing test plan
> >> > ERROR test-io-channel-tls - missing test plan
> >> >
> >> > Because on win32 those test case are all disabled in the header
> >> >
> >> > Add qemu_socket_pair for cross platform support, convert file system
> >> > handling functions to glib
> >> > Add qemu_link function instead posix only link function.
> >> > Use send ad recv from qemu that convert Windows Socks error
> >> > to errno properly.
> >> >
> >> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> > <mailto:luoyonggang@gmail.com>>
> >> > ---
> [...]
> >> Where do you've got this code from? It seems like this has been taken
> >> from a 3rd party source? E.g.:
> >>
> >>  https://blog.csdn.net/wufuhuai/article/details/79761889
> >>
> >> What's the license of this new code? ... please clarify such details i=
n
> >> the commit description.
> >
> > The original code have no license information, neither copyleft nor
> > copyright, what's your suggestion
> > or rewrite it?
> >
>
> You can not simply copy code without license information and submit this
> as if it was your own! Please never do that again!
> With your Signed-off-by line, you basically acknowledge that you've read
> and followed the Developer Certificate of Origin:
>
>  https://developercertificate.org/
>
> If you haven't done that yet, please do it now!
>
> And for this patch here, I don't think that it is acceptable without
> proper license information.
>
>  Thomas
>
See that, How about using
https://developer.gnome.org/glib/stable/glib-IO-Channels.html#g-io-channel-=
new-file
to act as socketpair? and it's cross-platform, I don't need to add
platform-dependent codes.

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000007a119505af481b12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 14, 2020 at 7:07 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; On 14/09/2020 10.19, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote=
:<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; On Mon, Sep 14, 2020 at 3:23 PM Th=
omas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a><br>&=
gt; &gt; &lt;mailto:<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a=
>&gt;&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; On 13/09/2020 00.44, Yon=
ggang Luo wrote:<br>&gt; &gt;&gt; &gt; Fixes following tests on msys2/mingw=
<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 &#39;test-crypto-tlscredsx509&#=
39;: [&#39;crypto-tls-x509-helpers.c&#39;,<br>&gt; &gt; &#39;pkix_asn1_tab.=
c&#39;,<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0tasn1, crypto],<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 &#39;test-=
crypto-tlssession&#39;: [&#39;crypto-tls-x509-helpers.c&#39;,<br>&gt; &gt; =
&#39;pkix_asn1_tab.c&#39;, &#39;crypto-tls-psk-helpers.c&#39;,<br>&gt; &gt;=
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tasn1, crypto],<br>&=
gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 &#39;test-io-channel-tls&#39;: [&#39=
;io-channel-helpers.c&#39;,<br>&gt; &gt; &#39;crypto-tls-x509-helpers.c&#39=
;, &#39;pkix_asn1_tab.c&#39;,<br>&gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tasn1, io, crypto]}<br>&gt; &gt;&gt; &gt; These tests are failur=
e with:<br>&gt; &gt;&gt; &gt; ERROR test-crypto-tlscredsx509 - missing test=
 plan<br>&gt; &gt;&gt; &gt; ERROR test-crypto-tlssession - missing test pla=
n<br>&gt; &gt;&gt; &gt; ERROR test-io-channel-tls - missing test plan<br>&g=
t; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Because on win32 those test case are=
 all disabled in the header<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Add=
 qemu_socket_pair for cross platform support, convert file system<br>&gt; &=
gt;&gt; &gt; handling functions to glib<br>&gt; &gt;&gt; &gt; Add qemu_link=
 function instead posix only link function.<br>&gt; &gt;&gt; &gt; Use send =
ad recv from qemu that convert Windows Socks error<br>&gt; &gt;&gt; &gt; to=
 errno properly.<br>&gt; &gt;&gt; &gt;<br>&gt; &gt;&gt; &gt; Signed-off-by:=
 Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmai=
l.com</a><br>&gt; &gt; &lt;mailto:<a href=3D"mailto:luoyonggang@gmail.com">=
luoyonggang@gmail.com</a>&gt;&gt;<br>&gt; &gt;&gt; &gt; ---<br>&gt; [...]<b=
r>&gt; &gt;&gt; Where do you&#39;ve got this code from? It seems like this =
has been taken<br>&gt; &gt;&gt; from a 3rd party source? E.g.:<br>&gt; &gt;=
&gt;<br>&gt; &gt;&gt; =C2=A0<a href=3D"https://blog.csdn.net/wufuhuai/artic=
le/details/79761889">https://blog.csdn.net/wufuhuai/article/details/7976188=
9</a><br>&gt; &gt;&gt;<br>&gt; &gt;&gt; What&#39;s the license of this new =
code? ... please clarify such details in<br>&gt; &gt;&gt; the commit descri=
ption.<br>&gt; &gt;<br>&gt; &gt; The original code have no license informat=
ion, neither copyleft nor<br>&gt; &gt; copyright, what&#39;s your suggestio=
n<br>&gt; &gt; or rewrite it?<br>&gt; &gt; =C2=A0<br>&gt;<br>&gt; You can n=
ot simply copy code without license information and submit this<br>&gt; as =
if it was your own! Please never do that again!<br>&gt; With your Signed-of=
f-by line, you basically acknowledge that you&#39;ve read<br>&gt; and follo=
wed the Developer Certificate of Origin:<br>&gt;<br>&gt; =C2=A0<a href=3D"h=
ttps://developercertificate.org/">https://developercertificate.org/</a><br>=
&gt;<br>&gt; If you haven&#39;t done that yet, please do it now!<br>&gt;<br=
>&gt; And for this patch here, I don&#39;t think that it is acceptable with=
out<br>&gt; proper license information.<br>&gt;<br>&gt; =C2=A0Thomas<br>&gt=
;<br>See that, How about using=C2=A0<a href=3D"https://developer.gnome.org/=
glib/stable/glib-IO-Channels.html#g-io-channel-new-file">https://developer.=
gnome.org/glib/stable/glib-IO-Channels.html#g-io-channel-new-file</a><div>t=
o act as socketpair? and it&#39;s cross-platform, I don&#39;t need to add p=
latform-dependent codes.<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000007a119505af481b12--

