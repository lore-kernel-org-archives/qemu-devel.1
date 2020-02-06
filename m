Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C2EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A22214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="rgcgT//w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A22214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=synology.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgtV-000322-It
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuchenlin@synology.com>) id 1izgmq-0007rt-EH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuchenlin@synology.com>) id 1izgmm-00012t-Mo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:01:38 -0500
Received: from mail.synology.com ([211.23.38.101]:55326 helo=synology.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuchenlin@synology.com>)
 id 1izgml-0000NI-FZ; Thu, 06 Feb 2020 08:01:36 -0500
Received: from Mail (localhost [127.0.0.1])
 by synology.com (Postfix) with ESMTPA id 092F4DB18A73;
 Thu,  6 Feb 2020 21:01:25 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
 t=1580994085; bh=tD84ieRT+2q9tPQRHGkaRwGivCuspul2L89HBjm4yd4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=rgcgT//w1f5rJId7BWw81J21ATBEIH/U4F6i8UtXPufqss6gg7nbNgi1oYfSGE1/e
 T0zbtmtTR9feG6ncXtvm3eB0mG/eQBqeygHNlY3at0Mo+8YnePLS6mH7h9/W2ebbGi
 O/XMmnGLkn7ULeaRARoEywj8yAPW96kAuXOZpsUY=
Date: Thu, 6 Feb 2020 21:01:25 +0800
From: yuchenlin <yuchenlin@synology.com>
To: "Yu-Chen Lin" <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@redhat.com, qemu-trivial@nongnu.org, 
 "Yu-Chen Lin" <npes87184@gmail.com>
Message-ID: <ea0e651e-e1ad-4389-9428-5746444469ca@Mail>
In-Reply-To: <20200206125504.7150-1-npes87184@gmail.com>
References: <20200206125504.7150-1-npes87184@gmail.com>
Subject: Re: [PATCH v2] mailmap: Add entry for Yu-Chen Lin
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5e3c0e25_5f2dd0d8_8c84"
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 211.23.38.101
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5e3c0e25_5f2dd0d8_8c84
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Acked-by: Yu-Chen Lin <yuchenlin=40synology.com> -- Best Regards, Yu-Chen=
 Lin =238243 Yu-Chen Lin <npes87184=40gmail.com> =E6=96=BC 2020-02-06 20:=
55 =E5=AF=AB=E9=81=93=EF=BC=9A > > I have two mail address, add entries f=
or > showing author and email correctly. > > Signed-off-by: Yu-Chen Lin <=
npes87184=40gmail.com> > --- > v1 -> v2: > * Change subject > > .mailmap =
=7C 3 ++- > 1 file changed, 2 insertions(+), 1 deletion(-) > > diff --git=
 a/.mailmap b/.mailmap > index 3816e4effe..3fbf3902a3 100644 > --- a/.mai=
lmap > +++ b/.mailmap > =40=40 -151,7 +151,8 =40=40 Xiaoqiang Zhao <zxq=5F=
yx=5F007=40163.com> > Xinhua Cao <caoxinhua=40huawei.com> > Xiong Zhang <=
xiong.y.zhang=40intel.com> > Yin Yin <yin.yin=40cs2c.com.cn> > -yuchenlin=
 <npes87184=40gmail.com> > +Yu-Chen Lin <npes87184=40gmail.com> > +Yu-Che=
n Lin <npes87184=40gmail.com> <yuchenlin=40synology.com> > YunQiang Su <s=
yq=40debian.org> > YunQiang Su <ysu=40wavecomp.com> > Yuri Pudgorodskiy <=
yur=40virtuozzo.com> > -- > 2.17.1 >

--5e3c0e25_5f2dd0d8_8c84
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><span style=3D=22color: =23222222; font-family: Arial, Helvetica, sa=
ns-serif; font-size: small; font-style: normal; font-variant-ligatures: n=
ormal; font-variant-caps: normal; font-weight: 400; letter-spacing: norma=
l; orphans: 2; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px; background-color: =23ffffff; text-decoration-style: initial; t=
ext-decoration-color: initial; display: inline =21important; float: none;=
=22>Acked-by:&nbsp;<span style=3D=22color: =23222222; font-family: arial,=
 helvetica, sans-serif; font-size: 13.3333px; font-style: normal; font-va=
riant-ligatures: normal; font-variant-caps: normal; font-weight: 400; let=
ter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; tex=
t-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -we=
bkit-text-stroke-width: 0px; background-color: =23ffffff; text-decoration=
-style: initial; text-decoration-color: initial; display: inline =21impor=
tant; float: none;=22>Yu-Chen Lin&nbsp;&lt;yuchenlin=40synology.com&gt;</=
span></span></div>
<div>&nbsp;</div>
<div class=3D=22syno-mc-signature=22>
<div><span style=3D=22font-family: 'comic sans ms', sans-serif;=22>--</sp=
an></div>
<div><span style=3D=22font-family: arial, helvetica, sans-serif;=22>Best =
Regards,</span></div>
<div><span style=3D=22font-family: arial, helvetica, sans-serif;=22>Yu-Ch=
en Lin =238243</span></div>
</div>
<div>&nbsp;</div>
<div class=3D=22=22>
<div>Yu-Chen Lin &lt;npes87184=40gmail.com&gt; =E6=96=BC 2020-02-06 20:55=
 =E5=AF=AB=E9=81=93=EF=BC=9A</div>
<blockquote class=3D=22syno-mc-blockquote=22 style=3D=22padding-left: 5px=
; margin-left: 5px; border-left: =23c8d2dc 2px solid;=22>
<pre>I have two mail address, add entries for<br />showing author and ema=
il correctly.<br /><br />Signed-off-by: Yu-Chen Lin &lt;npes87184=40gmail=
.com&gt;<br />---<br />v1 -&gt; v2:<br />* Change subject<br /><br /> .ma=
ilmap =7C 3 ++-<br /> 1 file changed, 2 insertions(+), 1 deletion(-)<br /=
><br />diff --git a/.mailmap b/.mailmap<br />index 3816e4effe..3fbf3902a3=
 100644<br />--- a/.mailmap<br />+++ b/.mailmap<br />=40=40 -151,7 +151,8=
 =40=40 Xiaoqiang Zhao &lt;zxq=5Fyx=5F007=40163.com&gt;<br /> Xinhua Cao =
&lt;caoxinhua=40huawei.com&gt;<br /> Xiong Zhang &lt;xiong.y.zhang=40inte=
l.com&gt;<br /> Yin Yin &lt;yin.yin=40cs2c.com.cn&gt;<br />-yuchenlin &lt=
;npes87184=40gmail.com&gt;<br />+Yu-Chen Lin &lt;npes87184=40gmail.com&gt=
;<br />+Yu-Chen Lin &lt;npes87184=40gmail.com&gt; &lt;yuchenlin=40synolog=
y.com&gt;<br /> YunQiang Su &lt;syq=40debian.org&gt;<br /> YunQiang Su &l=
t;ysu=40wavecomp.com&gt;<br /> Yuri Pudgorodskiy &lt;yur=40virtuozzo.com&=
gt;<br />-- <br />2.17.1<br /><br /></pre></blockquote>
</div>


--5e3c0e25_5f2dd0d8_8c84--


