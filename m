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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05734C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 18:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B3420731
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsfwRBGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B3420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHtI0-00026W-Cz
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 14:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHtG4-0001Yb-5F; Mon, 14 Sep 2020 14:31:20 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHtG0-000750-Qp; Mon, 14 Sep 2020 14:31:19 -0400
Received: by mail-lj1-x241.google.com with SMTP id y4so524626ljk.8;
 Mon, 14 Sep 2020 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=VkQsTW3nPEL7/8nGpq6aCOZGmShbZVHMJB+drDtGd1E=;
 b=nsfwRBGSRaJXY3sFDCIJpOMJUvoOfsWkK6xiraNRQd1jACaYLDL7lvTGCjDHffV95p
 gwy5deEWgveiFzqPMVZDNYQ/OOggmB/V3/q0y7cII8SoRiQ9O8VG7MYIY4YLGc9cLGVX
 eIAtDwGIrWQYyjjq98qMEAq/7t63uZv3H1EEFSKqH0AZFmXdS655BrMB5Dy0lYMaw801
 bMj0r5gUMHRIsHuqIFaxL3zq991HjFjThQFIvv2yr+ESCiPIhHc514u9X4dvZM4Cevqj
 gPWD9+eXRUiLy+3Q7ClYqHC+r6zxvPUlpkdkLcURjDIWXOWS6oMEUSGbZEqRiH2Ysde8
 Sy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=VkQsTW3nPEL7/8nGpq6aCOZGmShbZVHMJB+drDtGd1E=;
 b=DoBYIopo/imTH7CBdWh6WkajTd6G5+IU6fmshowE0navI8nyaieu7L14xp1VDxHWLR
 pSrzQdFs6lGwottPIok+GLhNlHPr9X3/hoAIv8VvgAXHJdOlTyMWysY5f5MaoljEqvTp
 NdQtjUkuQvbZ/dK4bU20Jnqz5AI3TvwXLKklnATTarriUI0u1T1I69cM5prhG5YcCeae
 uiAyAfngONgvK+rNg/OSM+7fknJ5yGGMyNal8pMlv3PpHwIaZ2BRMyxdUwAgowI3vIDJ
 kS1nkpHqQx/CWoMVUpVGirw9RbChA2REo/ZsAACsRZLD262r6vFj+TWMZARyqrQtaTSX
 K/uw==
X-Gm-Message-State: AOAM533SjLoWe364trBfgQpe6xvgt+p5Bfe7vBUYFZN4KELyhQQagYBW
 r5IrJMtwO593Jlk+N82B6VBdSNyQY/us5mF8Vtg=
X-Google-Smtp-Source: ABdhPJwfQbTLaue/CslOieaCrhUWcFu79MlShXP164vHqU84RxwAFurMgx53dwAye9ZkuWdR3WhfYudCwv1GgQfNeZI=
X-Received: by 2002:a2e:89d6:: with SMTP id c22mr5798527ljk.242.1600108274716; 
 Mon, 14 Sep 2020 11:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-14-luoyonggang@gmail.com>
 <119be52f-fc8b-dd37-e3d6-04a13109c845@redhat.com>
 <CAE2XoE-Qi1aZhq09QEswq-NFYRYWV+ZM4YZz=pGCynMd5Ova8Q@mail.gmail.com>
 <fb3a1a4f-fb60-00f2-878a-f61241adcfb3@redhat.com>
 <CAE2XoE_SQ9i4RHq9=SDukVag=cYvv6BNo_aQv9PSq3box4keiQ@mail.gmail.com>
 <20200914161330.GP1252186@redhat.com>
In-Reply-To: <20200914161330.GP1252186@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 15 Sep 2020 02:31:02 +0800
Message-ID: <CAE2XoE8yjs95iGshtvyvdWgzH=vLR72diXWadSTofhTDXCaupA@mail.gmail.com>
Subject: Re: [PATCH v8 13/27] tests: Enable crypto tests under msys2/mingw
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000051163305af4a3dc7"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-level <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000051163305af4a3dc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 12:14 AM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:
>
> On Mon, Sep 14, 2020 at 11:58:24PM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yon=
ggang Luo) wrote:
> > On Mon, Sep 14, 2020 at 7:07 PM Thomas Huth <thuth@redhat.com> wrote:
> > >
> > > On 14/09/2020 10.19, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > > >
> > > >
> > > > On Mon, Sep 14, 2020 at 3:23 PM Thomas Huth <thuth@redhat.com
> > > > <mailto:thuth@redhat.com>> wrote:
> > > >>
> > > >> On 13/09/2020 00.44, Yonggang Luo wrote:
> > > >> > Fixes following tests on msys2/mingw
> > > >> >       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
> > > > 'pkix_asn1_tab.c',
> > > >> >                                    tasn1, crypto],
> > > >> >       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c',
> > > > 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
> > > >> >                                  tasn1, crypto],
> > > >> >       'test-io-channel-tls': ['io-channel-helpers.c',
> > > > 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
> > > >> >                               tasn1, io, crypto]}
> > > >> > These tests are failure with:
> > > >> > ERROR test-crypto-tlscredsx509 - missing test plan
> > > >> > ERROR test-crypto-tlssession - missing test plan
> > > >> > ERROR test-io-channel-tls - missing test plan
> > > >> >
> > > >> > Because on win32 those test case are all disabled in the header
> > > >> >
> > > >> > Add qemu_socket_pair for cross platform support, convert file
system
> > > >> > handling functions to glib
> > > >> > Add qemu_link function instead posix only link function.
> > > >> > Use send ad recv from qemu that convert Windows Socks error
> > > >> > to errno properly.
> > > >> >
> > > >> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> > > > <mailto:luoyonggang@gmail.com>>
> > > >> > ---
> > > [...]
> > > >> Where do you've got this code from? It seems like this has been
taken
> > > >> from a 3rd party source? E.g.:
> > > >>
> > > >>  https://blog.csdn.net/wufuhuai/article/details/79761889
> > > >>
> > > >> What's the license of this new code? ... please clarify such
details in
> > > >> the commit description.
> > > >
> > > > The original code have no license information, neither copyleft nor
> > > > copyright, what's your suggestion
> > > > or rewrite it?
> > > >
> > >
> > > You can not simply copy code without license information and submit
this
> > > as if it was your own! Please never do that again!
> > > With your Signed-off-by line, you basically acknowledge that you've
read
> > > and followed the Developer Certificate of Origin:
> > >
> > >  https://developercertificate.org/
> > >
> > > If you haven't done that yet, please do it now!
> > >
> > > And for this patch here, I don't think that it is acceptable without
> > > proper license information.
> > >
> > >  Thomas
> > >
> > See that, How about using
> >
https://developer.gnome.org/glib/stable/glib-IO-Channels.html#g-io-channel-=
new-file
> > to act as socketpair? and it's cross-platform, I don't need to add
> > platform-dependent codes.
>
> That doesn't provide socketpair functionality. QEMU already has its
> QIOChannel impl that is more advanced, but again that doesn't have
> socketpair either because Windows lacks that.

Doesn't need the   socketpair  functionality, we just need two FIFO, and
handle the fifo full empty by raising
EAGAIN error at
```
static ssize_t testWrite(const char *buf, size_t len, void *opaque)
{
    int *fd =3D opaque;
    int written =3D send(*fd, buf, len, 0);
    return written;
}

static ssize_t testRead(char *buf, size_t len, void *opaque)
{
    int *fd =3D opaque;

    int readed =3D recv(*fd, buf, len, 0);
    return readed;
}
```
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
https://www.instagram.com/dberrange :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000051163305af4a3dc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Sep 15, 2020 at 12:14 AM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Mon, Sep 14, 2020 at 11:58:24PM +0800, =E7=BD=
=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>&gt; &gt; On Mon, Sep 14, 202=
0 at 7:07 PM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redh=
at.com</a>&gt; wrote:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; On 14/09/2020 10.=
19, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>&gt; &gt; &gt; &gt;=
<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; On Mon, Sep 14, 2020 at 3:23=
 PM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a=
><br>&gt; &gt; &gt; &gt; &lt;mailto:<a href=3D"mailto:thuth@redhat.com">thu=
th@redhat.com</a>&gt;&gt; wrote:<br>&gt; &gt; &gt; &gt;&gt;<br>&gt; &gt; &g=
t; &gt;&gt; On 13/09/2020 00.44, Yonggang Luo wrote:<br>&gt; &gt; &gt; &gt;=
&gt; &gt; Fixes following tests on msys2/mingw<br>&gt; &gt; &gt; &gt;&gt; &=
gt; =C2=A0 =C2=A0 =C2=A0 &#39;test-crypto-tlscredsx509&#39;: [&#39;crypto-t=
ls-x509-helpers.c&#39;,<br>&gt; &gt; &gt; &gt; &#39;pkix_asn1_tab.c&#39;,<b=
r>&gt; &gt; &gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tasn1, crypto],<br>&gt; &gt; &gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 &#39;test-crypto-tlssession&#39;: [&#39;crypto-tls-x509-helpers.c&#39;,=
<br>&gt; &gt; &gt; &gt; &#39;pkix_asn1_tab.c&#39;, &#39;crypto-tls-psk-help=
ers.c&#39;,<br>&gt; &gt; &gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0tasn1, crypto],<br>&gt; &gt; &gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =
=C2=A0 &#39;test-io-channel-tls&#39;: [&#39;io-channel-helpers.c&#39;,<br>&=
gt; &gt; &gt; &gt; &#39;crypto-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab.=
c&#39;,<br>&gt; &gt; &gt; &gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tasn1=
, io, crypto]}<br>&gt; &gt; &gt; &gt;&gt; &gt; These tests are failure with=
:<br>&gt; &gt; &gt; &gt;&gt; &gt; ERROR test-crypto-tlscredsx509 - missing =
test plan<br>&gt; &gt; &gt; &gt;&gt; &gt; ERROR test-crypto-tlssession - mi=
ssing test plan<br>&gt; &gt; &gt; &gt;&gt; &gt; ERROR test-io-channel-tls -=
 missing test plan<br>&gt; &gt; &gt; &gt;&gt; &gt;<br>&gt; &gt; &gt; &gt;&g=
t; &gt; Because on win32 those test case are all disabled in the header<br>=
&gt; &gt; &gt; &gt;&gt; &gt;<br>&gt; &gt; &gt; &gt;&gt; &gt; Add qemu_socke=
t_pair for cross platform support, convert file system<br>&gt; &gt; &gt; &g=
t;&gt; &gt; handling functions to glib<br>&gt; &gt; &gt; &gt;&gt; &gt; Add =
qemu_link function instead posix only link function.<br>&gt; &gt; &gt; &gt;=
&gt; &gt; Use send ad recv from qemu that convert Windows Socks error<br>&g=
t; &gt; &gt; &gt;&gt; &gt; to errno properly.<br>&gt; &gt; &gt; &gt;&gt; &g=
t;<br>&gt; &gt; &gt; &gt;&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=
=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a><br>&gt; &gt; &g=
t; &gt; &lt;mailto:<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gma=
il.com</a>&gt;&gt;<br>&gt; &gt; &gt; &gt;&gt; &gt; ---<br>&gt; &gt; &gt; [.=
..]<br>&gt; &gt; &gt; &gt;&gt; Where do you&#39;ve got this code from? It s=
eems like this has been taken<br>&gt; &gt; &gt; &gt;&gt; from a 3rd party s=
ource? E.g.:<br>&gt; &gt; &gt; &gt;&gt;<br>&gt; &gt; &gt; &gt;&gt; =C2=A0<a=
 href=3D"https://blog.csdn.net/wufuhuai/article/details/79761889">https://b=
log.csdn.net/wufuhuai/article/details/79761889</a><br>&gt; &gt; &gt; &gt;&g=
t;<br>&gt; &gt; &gt; &gt;&gt; What&#39;s the license of this new code? ... =
please clarify such details in<br>&gt; &gt; &gt; &gt;&gt; the commit descri=
ption.<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; The original code have=
 no license information, neither copyleft nor<br>&gt; &gt; &gt; &gt; copyri=
ght, what&#39;s your suggestion<br>&gt; &gt; &gt; &gt; or rewrite it?<br>&g=
t; &gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; You can not simply co=
py code without license information and submit this<br>&gt; &gt; &gt; as if=
 it was your own! Please never do that again!<br>&gt; &gt; &gt; With your S=
igned-off-by line, you basically acknowledge that you&#39;ve read<br>&gt; &=
gt; &gt; and followed the Developer Certificate of Origin:<br>&gt; &gt; &gt=
;<br>&gt; &gt; &gt; =C2=A0<a href=3D"https://developercertificate.org/">htt=
ps://developercertificate.org/</a><br>&gt; &gt; &gt;<br>&gt; &gt; &gt; If y=
ou haven&#39;t done that yet, please do it now!<br>&gt; &gt; &gt;<br>&gt; &=
gt; &gt; And for this patch here, I don&#39;t think that it is acceptable w=
ithout<br>&gt; &gt; &gt; proper license information.<br>&gt; &gt; &gt;<br>&=
gt; &gt; &gt; =C2=A0Thomas<br>&gt; &gt; &gt;<br>&gt; &gt; See that, How abo=
ut using<br>&gt; &gt; <a href=3D"https://developer.gnome.org/glib/stable/gl=
ib-IO-Channels.html#g-io-channel-new-file">https://developer.gnome.org/glib=
/stable/glib-IO-Channels.html#g-io-channel-new-file</a><br>&gt; &gt; to act=
 as socketpair? and it&#39;s cross-platform, I don&#39;t need to add<br>&gt=
; &gt; platform-dependent codes.<br>&gt;<br>&gt; That doesn&#39;t provide s=
ocketpair functionality. QEMU already has its<br>&gt; QIOChannel impl that =
is more advanced, but again that doesn&#39;t have<br>&gt; socketpair either=
 because Windows lacks that.<br><br>Doesn&#39;t need the =C2=A0 socketpair =
=C2=A0functionality, we just need two FIFO, and handle the fifo full empty =
by raising <br>EAGAIN error at<br>```<br>static ssize_t testWrite(const cha=
r *buf, size_t len, void *opaque)<br>{<br>=C2=A0 =C2=A0 int *fd =3D opaque;=
<br>=C2=A0 =C2=A0 int written =3D send(*fd, buf, len, 0);<br>=C2=A0 =C2=A0 =
return written;<br>}<br><br>static ssize_t testRead(char *buf, size_t len, =
void *opaque)<br>{<br>=C2=A0 =C2=A0 int *fd =3D opaque;<br><br>=C2=A0 =C2=
=A0 int readed =3D recv(*fd, buf, len, 0);<br>=C2=A0 =C2=A0 return readed;<=
br>}<br>```<br>&gt;<br>&gt; Regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <=
a href=3D"https://berrange.com">https://berrange.com</a> =C2=A0 =C2=A0 =C2=
=A0-o- =C2=A0 =C2=A0<a href=3D"https://www.flickr.com/photos/dberrange">htt=
ps://www.flickr.com/photos/dberrange</a> :|<br>&gt; |: <a href=3D"https://l=
ibvirt.org">https://libvirt.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://fstop138.berrange.com"=
>https://fstop138.berrange.com</a> :|<br>&gt; |: <a href=3D"https://entangl=
e-photo.org">https://entangle-photo.org</a> =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<=
a href=3D"https://www.instagram.com/dberrange">https://www.instagram.com/db=
errange</a> :|<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--00000000000051163305af4a3dc7--

