Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6171C433E5
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E3E206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ez4Lm9n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E3E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCDq-0004bd-Kd
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jtCD9-00048o-Qt
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:42:15 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:46682)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1jtCD4-0006ip-6a
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=MIME-Version:From:Subject:Date:Message-Id; bh=LAK1j
 Ak7/3fcl0oXPsjSop8i70P6WIQChHo4lKIkydw=; b=Ez4Lm9n1s9JONGnY7cA5u
 vj/lBTRD/+8qmzfpK78crH+Uc28iLCccARov287p73V3hxlTNvOe9iGBFUR5Ztk2
 Mfye4SpHKkmqazFe916zha3UcwJNg5XewDs4F/zI1nx8SPNudb2Z6de3Axi+Dj5D
 uMXV96cTXPtoWlEFtotC8I=
Received: from [IPv6:::ffff:192.168.0.106] (unknown [115.216.109.18])
 by smtp1 (Coremail) with SMTP id GdxpCgDHVnxB6QVf5woWAA--.2613S3;
 Wed, 08 Jul 2020 23:41:53 +0800 (CST)
MIME-Version: 1.0
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "eblake@redhat.com" <eblake@redhat.com>, 
 "liq3ea@gmail.com" <liq3ea@gmail.com>
From: Li Qiang <liq3ea@163.com>
Subject: build error of unused function as MACRO
 G_DEFINE_AUTOPTR_CLEANUP_FUNC expand
Date: Wed, 8 Jul 2020 23:41:53 +0800
Importance: normal
X-Priority: 3
Content-Type: multipart/alternative;
 boundary="_4AB942F3-3671-45B5-BD9B-40B8339085FA_"
X-CM-TRANSID: GdxpCgDHVnxB6QVf5woWAA--.2613S3
Message-Id: <5F05E942.FB9110.20278@mail-m971.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1UAw18Wr4fGw4DtFyxKrg_yoWrZF17pF
 n8Ca1UKFyUGFW8GrZ5Za4SgF1ftFs8WryrCr9rtF10gF1aqr1kuFZ2vw4jgF9rGrs7G3yr
 Ca4UW3s5K3yku3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXtxgUUUUU=
X-Originating-IP: [115.216.109.18]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoQJbbVQHKtTmOwAAsl
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 11:41:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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

--_4AB942F3-3671-45B5-BD9B-40B8339085FA_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hello all,

I build qemu with fuzzing enabled using clang and following error come.

nbd/server.c:1937:1: error: unused function 'glib_listautoptr_cleanup_NBDEx=
tentArray' [-Werror,-Wunused-function]
G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
^
/usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro 'G_D=
EFINE_AUTOPTR_CLEANUP_FUNC'
  static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l) { =
g_list_free_full (*_l, (GDestroyNotify) func); } \
                     ^
/usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro '_GL=
IB_AUTOPTR_LIST_FUNC_NAME'
#define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) glib_listautoptr_cleanup_##T=
ypeName
                                               ^
<scratch space>:170:1: note:   CC      crypto/hash-glib.o
expanded from here
glib_listautoptr_cleanup_NBDExtentArray
^
nbd/server.c:1937:1: error: unused function 'glib_slistautoptr_cleanup_NBDE=
xtentArray' [-Werror,-Wunused-function]
/usr/include/glib-2.0/glib/gmacros.h:463:22: note: expanded from macro 'G_D=
EFINE_AUTOPTR_CLEANUP_FUNC'
  static inline void _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) (GSList **_l) =
{ g_slist_free_full (*_l, (GDestroyNotify) func); } \
                     ^
/usr/include/glib-2.0/glib/gmacros.h:445:49: note: expanded from macro '_GL=
IB_AUTOPTR_SLIST_FUNC_NAME'
#define _GLIB_AUTOPTR_SLIST_FUNC_NAME(TypeName) glib_slistautoptr_cleanup_#=
#TypeName
                                                ^
<scratch space>:171:1: note: expanded from here
glib_slistautoptr_cleanup_NBDExtentArray


I see Eric=E2=80=99s patch 9bda600b083(=E2=80=9Cbuild: Silence clang warnin=
g on older glib autoptr usage=E2=80=9D)
So I know there should be a =E2=80=98-Wno-unused-function=E2=80=99 in CFLAG=
S. It is after ./configure:

CFLAGS            -g  -Wno-unused-function
QEMU_CFLAGS       -I/usr/include/pixman-1  -Werror  -pthread -I/usr/include=
/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mc=
x16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-pro=
totypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototype=
s -fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99  -Wno-string-plus-i=
nt -Wno-typedef-redefinition -Wno-initializer-overrides -Wexpansion-to-defi=
ned -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wem=
pty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wigno=
red-qualifiers -Wold-style-definition -Wtype-limits -fstack-protector-stron=
g -I$(SRC_PATH)/capstone/include

However while I =E2=80=98make V=3D1=E2=80=99 I see the build nbd/serer.c us=
ing following command:
clang-8 -iquote /home/test/qemu/nbd -iquote nbd -iquote /home/test/qemu/tcg=
/i386 -isystem /home/test/qemu/linux-headers -isystem /home/test/qemu/linux=
-headers -iquote . -iquote /home/test/qemu -iquote /home/test/qemu/accel/tc=
g -iquote /home/test/qemu/include -iquote /home/test/qemu/disas/libvixl -I/=
usr/include/pixman-1  -Werror  -pthread -I/usr/include/glib-2.0 -I/usr/lib/=
x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_=
FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-d=
ecls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasin=
g -fno-common -fwrapv -std=3Dgnu99  -Wno-string-plus-int -Wno-typedef-redef=
inition -Wno-initializer-overrides -Wexpansion-to-defined -Wendif-labels -W=
no-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-ext=
erns -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-=
style-definition -Wtype-limits -fstack-protector-strong -I/home/test/qemu/c=
apstone/include -I/home/test/qemu/tests -I/home/test/qemu/tests/qtest -MMD =
-MP -MT nbd/server.o -MF nbd/server.d -fsanitize=3Daddress,fuzzer-no-link  =
-c -o nbd/server.o nbd/server.c

There=E2=80=99s no CFLAGS =E2=80=98-Wno-unused-function=E2=80=99.

So I want to know:
1. Wha=E2=80=99t the relation of CFLAGS and QEMU_CFLAGS, it seems the CFLAG=
S doesn=E2=80=99t work in this.
2. Any hits to solve this? My env error or needs a patch?

I use following command in Ubuntu 18.04.1.
CC=3Dclang-8 CXX=3Dclang++-8  ./configure  --target-list=3D"i386-softmmu"  =
--enable-debug --enable-debug  --enable-kvm --enable-fuzzing


Thanks,
Li Qiang

--_4AB942F3-3671-45B5-BD9B-40B8339085FA_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta ht=
tp-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta name=
=3DGenerator content=3D"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-indent:21.0pt;
	font-size:10.5pt;
	font-family:DengXian;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:846943407;
	mso-list-type:hybrid;
	mso-list-template-ids:666134558 -1 67698713 67698715 67698703 67698713 676=
98715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
@list l1
	{mso-list-id:2101632866;
	mso-list-type:hybrid;
	mso-list-template-ids:347384516 -1 67698713 67698715 67698703 67698713 676=
98715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%2\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:63.0pt;
	text-indent:-21.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%5\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:126.0pt;
	text-indent:-21.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-text:"%8\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:189.0pt;
	text-indent:-21.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style></head><body lang=3DZH-CN link=3Dblue vlink=3D"#954F72"><div cla=
ss=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-siz=
e:12.0pt'>Hello all,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=3D=
MsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>I build qemu with f=
uzzing enabled using clang and following error come.<o:p></o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbs=
p;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-si=
ze:12.0pt'>nbd/server.c:1937:1: error: unused function 'glib_listautoptr_cl=
eanup_NBDExtentArray' [-Werror,-Wunused-function]<o:p></o:p></span></p><p c=
lass=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>G_DEFINE_AUT=
OPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);<o:p></o:p></span>=
</p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>^<o:=
p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-si=
ze:12.0pt'>/usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from=
 macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'<o:p></o:p></span></p><p class=3DMsoN=
ormal><span lang=3DEN-US style=3D'font-size:12.0pt'>=C2=A0 static inline vo=
id _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList **_l) { g_list_free_full (=
*_l, (GDestroyNotify) func); } \<o:p></o:p></span></p><p class=3DMsoNormal>=
<span lang=3DEN-US style=3D'font-size:12.0pt'>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^<o:p></o:p></span></p><p class=3DMsoNormal><span lang=
=3DEN-US style=3D'font-size:12.0pt'>/usr/include/glib-2.0/glib/gmacros.h:44=
3:48: note: expanded from macro '_GLIB_AUTOPTR_LIST_FUNC_NAME'<o:p></o:p></=
span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'=
>#define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) glib_listautoptr_cleanup_##=
TypeName<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=
=3D'font-size:12.0pt'>=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
^<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'fon=
t-size:12.0pt'>&lt;scratch space&gt;:170:1: note:=C2=A0=C2=A0 CC=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 crypto/hash-glib.o<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>expanded from here<o:=
p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-si=
ze:12.0pt'>glib_listautoptr_cleanup_NBDExtentArray<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>^<o:p></o:p=
></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0=
pt'>nbd/server.c:1937:1: error: unused function 'glib_slistautoptr_cleanup_=
NBDExtentArray' [-Werror,-Wunused-function]<o:p></o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>/usr/include/gli=
b-2.0/glib/gmacros.h:463:22: note: expanded from macro 'G_DEFINE_AUTOPTR_CL=
EANUP_FUNC'<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US st=
yle=3D'font-size:12.0pt'>=C2=A0 static inline void _GLIB_AUTOPTR_SLIST_FUNC=
_NAME(TypeName) (GSList **_l) { g_slist_free_full (*_l, (GDestroyNotify) fu=
nc); } \<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=
=3D'font-size:12.0pt'>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<o:p=
></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-siz=
e:12.0pt'>/usr/include/glib-2.0/glib/gmacros.h:445:49: note: expanded from =
macro '_GLIB_AUTOPTR_SLIST_FUNC_NAME'<o:p></o:p></span></p><p class=3DMsoNo=
rmal><span lang=3DEN-US style=3D'font-size:12.0pt'>#define _GLIB_AUTOPTR_SL=
IST_FUNC_NAME(TypeName) glib_slistautoptr_cleanup_##TypeName<o:p></o:p></sp=
an></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0^<o:p></o:p></spa=
n></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>&l=
t;scratch space&gt;:171:1: note: expanded from here<o:p></o:p></span></p><p=
 class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>glib_slist=
autoptr_cleanup_NBDExtentArray<o:p></o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbsp;=
</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size=
:12.0pt'>I see Eric=E2=80=99s patch 9bda600b083(=E2=80=9Cbuild: Silence cla=
ng warning on older glib autoptr usage=E2=80=9D)<o:p></o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>So I know the=
re should be a =E2=80=98-Wno-unused-function=E2=80=99 in CFLAGS. It is afte=
r ./configure:<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US=
 style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNorma=
l><span lang=3DEN-US style=3D'font-size:12.0pt'>CFLAGS=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -g=C2=A0 -Wno-unused-function=
<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font=
-size:12.0pt'>QEMU_CFLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -I/usr/includ=
e/pixman-1=C2=A0 -Werror=C2=A0 -pthread -I/usr/include/glib-2.0 -I/usr/lib/=
x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_=
FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-d=
ecls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasin=
g -fno-common -fwrapv -std=3Dgnu99=C2=A0 -Wno-string-plus-int -Wno-typedef-=
redefinition -Wno-initializer-overrides -Wexpansion-to-defined -Wendif-labe=
ls -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wneste=
d-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -=
Wold-style-definition -Wtype-limits -fstack-protector-strong -I$(SRC_PATH)/=
capstone/include<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
US style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNor=
mal><span lang=3DEN-US style=3D'font-size:12.0pt'>However while I =E2=80=98=
make V=3D1=E2=80=99 I see the build nbd/serer.c using following command:<o:=
p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-si=
ze:12.0pt'>clang-8 -iquote /home/test/qemu/nbd -iquote nbd -iquote /home/te=
st/qemu/tcg/i386 -isystem /home/test/qemu/linux-headers -isystem /home/test=
/qemu/linux-headers -iquote . -iquote /home/test/qemu -iquote /home/test/qe=
mu/accel/tcg -iquote /home/test/qemu/include -iquote /home/test/qemu/disas/=
libvixl -I/usr/include/pixman-1=C2=A0 -Werror=C2=A0 -pthread -I/usr/include=
/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPIE -DPIE -m64 -mc=
x16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-pro=
totypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototype=
s -fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99=C2=A0 -Wno-string-p=
lus-int -Wno-typedef-redefinition -Wno-initializer-overrides -Wexpansion-to=
-defined -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs=
 -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -=
Wignored-qualifiers -Wold-style-definition -Wtype-limits -fstack-protector-=
strong -I/home/test/qemu/capstone/include -I/home/test/qemu/tests -I/home/t=
est/qemu/tests/qtest -MMD -MP -MT nbd/server.o -MF nbd/server.d -fsanitize=
=3Daddress,fuzzer-no-link=C2=A0 -c -o nbd/server.o nbd/server.c<o:p></o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt=
'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=
=3D'font-size:12.0pt'>There=E2=80=99s no CFLAGS =E2=80=98-Wno-unused-functi=
on=E2=80=99.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US s=
tyle=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal>=
<span lang=3DEN-US style=3D'font-size:12.0pt'>So I want to know:<o:p></o:p>=
</span></p><p class=3DMsoListParagraph style=3D'margin-left:18.0pt;text-ind=
ent:-18.0pt;mso-list:l1 level1 lfo2'><![if !supportLists]><span lang=3DEN-U=
S style=3D'font-size:12.0pt'><span style=3D'mso-list:Ignore'>1.<span style=
=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span></span><=
![endif]><span lang=3DEN-US style=3D'font-size:12.0pt'>Wha=E2=80=99t the re=
lation of CFLAGS and QEMU_CFLAGS, it seems the CFLAGS doesn=E2=80=99t work =
in this.<o:p></o:p></span></p><p class=3DMsoListParagraph style=3D'margin-l=
eft:18.0pt;text-indent:-18.0pt;mso-list:l1 level1 lfo2'><![if !supportLists=
]><span lang=3DEN-US style=3D'font-size:12.0pt'><span style=3D'mso-list:Ign=
ore'>2.<span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </sp=
an></span></span><![endif]><span lang=3DEN-US style=3D'font-size:12.0pt'>An=
y hits to solve this? My env error or needs a patch?<o:p></o:p></span></p><=
p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbs=
p;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-si=
ze:12.0pt'>I use following command in Ubuntu 18.04.1.<o:p></o:p></span></p>=
<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>CC=3Dcla=
ng-8 CXX=3Dclang++-8=C2=A0 ./configure=C2=A0 --target-list=3D&quot;i386-sof=
tmmu&quot;=C2=A0 --enable-debug --enable-debug=C2=A0 --enable-kvm --enable-=
fuzzing<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=
=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><spa=
n lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p cl=
ass=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>Thanks,<o:p><=
/o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:=
12.0pt'>Li Qiang<o:p></o:p></span></p></div></body></html>=

--_4AB942F3-3671-45B5-BD9B-40B8339085FA_--


