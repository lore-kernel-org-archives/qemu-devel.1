Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2C0C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 08:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48A820723
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 08:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bU47Gr8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48A820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVtca-0004DR-Td
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 03:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yanminhui163@163.com>) id 1iVo6h-0007V7-3o
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 21:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yanminhui163@163.com>) id 1iVo6d-0001uh-EB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 21:46:36 -0500
Received: from m12-15.163.com ([220.181.12.15]:53538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yanminhui163@163.com>)
 id 1iVo6b-0001nE-6n
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 21:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Mime-Version:Subject:Message-Id:Date; bh=qPzj4
 1RDt4hto8evY5bhWfELvs3ScEfxppgzaqRPRLo=; b=bU47Gr8RKmMkP5RLmi18q
 vIyDvCCHRl96zFQVW1q8k2SW9P55ahTyWdA49m4AbVZCHq6NSEv3iiK30e6Ywc6W
 O2l01iwALZnU9ShODXSMgqUCm7M+yFC91e+MxTUERKXcinLHd496GyPQTtwssyVq
 uNwZEQH3OhGNxx8Yvf+Lxk=
Received: from [192.168.1.101] (unknown [113.18.255.205])
 by smtp11 (Coremail) with SMTP id D8CowABXnSr3Ys9dnZN0AA--.10023S3;
 Sat, 16 Nov 2019 10:46:16 +0800 (CST)
From: =?gb2312?B?0dXD9rvU?= <yanminhui163@163.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_84C52CB5-B189-4A46-AFBB-CBA36C370A76"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: ui/gtk: fix gettext message's charset. #85
Message-Id: <CBC44ED0-976E-4CDA-9E7B-C7E0B86B2873@163.com>
Date: Sat, 16 Nov 2019 10:46:15 +0800
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3445.104.11)
X-CM-TRANSID: D8CowABXnSr3Ys9dnZN0AA--.10023S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrZ2TUUUUU
X-Originating-IP: [113.18.255.205]
X-CM-SenderInfo: 51dqzx5qkxxiiwt6il2tof0z/xtbB0gJvwlUMS2R4KwABsZ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.12.15
X-Mailman-Approved-At: Sat, 16 Nov 2019 03:39:02 -0500
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


--Apple-Mail=_84C52CB5-B189-4A46-AFBB-CBA36C370A76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Detail see: https://github.com/qemu/qemu/pull/85 =
<https://github.com/qemu/qemu/pull/85>


--Apple-Mail=_84C52CB5-B189-4A46-AFBB-CBA36C370A76
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_9CC71966-D944-4F65-86FA-1513755BB411"


--Apple-Mail=_9CC71966-D944-4F65-86FA-1513755BB411
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv="Content-Type" content="text/html; charset=us-ascii"></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;" class=""><div class="">Detail see: <a href="https://github.com/qemu/qemu/pull/85" class="">https://github.com/qemu/qemu/pull/85</a></div><div class=""><br class=""></div></body></html>
--Apple-Mail=_9CC71966-D944-4F65-86FA-1513755BB411
Content-Disposition: attachment;
	filename=0001-ui-gtk-fix-gettext-message-s-charset.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-ui-gtk-fix-gettext-message-s-charset.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20861c284b6f27c722d452bcd893613b4e28e93fdf=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20yanminhui=20<yanminhui163@163.com>=0ADate:=20=
Fri,=2015=20Nov=202019=2021:13:53=20+0800=0ASubject:=20[PATCH]=20ui/gtk:=20=
fix=20gettext=20message's=20charset.=0A=0A---=0A=20po/zh_CN.po=20|=202=20=
+-=0A=20ui/gtk.c=20=20=20=20|=201=20+=0A=202=20files=20changed,=202=20=
insertions(+),=201=20deletion(-)=0A=0Adiff=20--git=20a/po/zh_CN.po=20=
b/po/zh_CN.po=0Aindex=20b25e8e3c02..38de6a4f2a=20100644=0A---=20=
a/po/zh_CN.po=0A+++=20b/po/zh_CN.po=0A@@=20-66,7=20+66,7=20@@=20msgid=20=
"Detach=20Tab"=0A=20msgstr=20"=E5=88=86=E7=A6=BB=E6=A0=87=E7=AD=BE=E9=A1=B5=
"=0A=20=0A=20msgid=20"Show=20Menubar"=0A-msgstr=20""=0A+msgstr=20=
"=E6=98=BE=E7=A4=BA=E8=8F=9C=E5=8D=95=E6=A0=8F"=0A=20=0A=20msgid=20=
"_Machine"=0A=20msgstr=20"=E8=99=9A=E6=8B=9F=E6=9C=BA(_M)"=0Adiff=20=
--git=20a/ui/gtk.c=20b/ui/gtk.c=0Aindex=202f23922afc..692ccc7bbb=20=
100644=0A---=20a/ui/gtk.c=0A+++=20b/ui/gtk.c=0A@@=20-2215,6=20+2215,7=20=
@@=20static=20void=20gtk_display_init(DisplayState=20*ds,=20=
DisplayOptions=20*opts)=0A=20=20=20=20=20setlocale(LC_MESSAGES,=20"");=0A=
=20=20=20=20=20setlocale(LC_CTYPE,=20"C.UTF-8");=0A=20=20=20=20=20=
bindtextdomain("qemu",=20CONFIG_QEMU_LOCALEDIR);=0A+=20=20=20=20=
bind_textdomain_codeset("qemu",=20"UTF-8");=0A=20=20=20=20=20=
textdomain("qemu");=0A=20=0A=20=20=20=20=20window_display=20=3D=20=
gtk_widget_get_display(s->window);=0A--=20=0A2.22.0=0A=0A=

--Apple-Mail=_9CC71966-D944-4F65-86FA-1513755BB411
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv="Content-Type" content="text/html; charset=us-ascii"></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; line-break: after-white-space;" class=""><div class=""></div></body></html>
--Apple-Mail=_9CC71966-D944-4F65-86FA-1513755BB411--

--Apple-Mail=_84C52CB5-B189-4A46-AFBB-CBA36C370A76--


