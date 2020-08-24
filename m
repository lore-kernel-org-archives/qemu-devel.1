Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62244C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 02:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25110206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 02:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25110206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA2EM-00023Y-BE
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 22:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kA2Dg-0001WI-SX; Sun, 23 Aug 2020 22:28:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2923 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kA2Dd-0004CQ-Cw; Sun, 23 Aug 2020 22:28:24 -0400
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id E26DC90F71A103F85115;
 Mon, 24 Aug 2020 10:28:03 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0487.000;
 Mon, 24 Aug 2020 10:27:54 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH RFC v2 01/10] qemu/: fix some comment spelling errors
Thread-Topic: [PATCH RFC v2 01/10] qemu/: fix some comment spelling errors
Thread-Index: AdZ5vfYloHTgAS5UQkWqt433A+9V3Q==
Date: Mon, 24 Aug 2020 02:27:53 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48A9CB8@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.201]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48A9CB8dggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 22:28:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhaolichang <zhaolichang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_640CDEE67BE2784FAE298BB2517210E48A9CB8dggemi522mbschina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
Changelog                   | 2 +-
accel/tcg/user-exec.c       | 2 +-
audio/audio.c               | 2 +-
block.c                     | 2 +-
configure                   | 2 +-
fsdev/virtfs-proxy-helper.c | 2 +-
hmp-commands.hx             | 2 +-
libdecnumber/decNumber.c    | 2 +-
qemu-img.c                  | 2 +-
qobject/qdict.c             | 2 +-
rules.mak                   | 2 +-
scsi/pr-manager-helper.c    | 2 +-
12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Changelog b/Changelog
index 4a90bb9..f7e178c 100644
--- a/Changelog
+++ b/Changelog
@@ -241,7 +241,7 @@ version 0.8.0:
version 0.7.2:
   - x86_64 fixes (Win2000 and Linux 2.6 boot in 32 bit)
-  - merge self modifying code handling in dirty ram page mecanism.
+  - merge self modifying code handling in dirty ram page mechanism.
   - MIPS fixes (Ralf Baechle)
   - better user net performances
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d8b027f..d1b3073 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -88,7 +88,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo=
_t *info,
          * use that value directly.  Within cpu_restore_state_from_tb, we
          * assume PC comes from GETPC(), as used by the helper functions,
          * so we adjust the address by -GETPC_ADJ to form an address that
-         * is within the call insn, so that the address does not accidenti=
ally
+         * is within the call insn, so that the address does not accidenta=
lly
          * match the beginning of the next guest insn.  However, when the
          * pc comes from the signal frame it points to the actual faulting
          * host memory insn and not the return from a call insn.
diff --git a/audio/audio.c b/audio/audio.c
index ce8c6de..1a68cfa 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1674,7 +1674,7 @@ static AudioState *audio_init(Audiodev *dev, const ch=
ar *name)
         head =3D audio_handle_legacy_opts();
         /*
          * In case of legacy initialization, all Audiodevs in the list wil=
l have
-         * the same configuration (except the driver), so it does't matter=
 which
+         * the same configuration (except the driver), so it doesn't matte=
r which
          * one we chose.  We need an Audiodev to set up AudioState before =
we can
          * init a driver.  Also note that dev at this point is still in th=
e
          * list.
diff --git a/block.c b/block.c
index d9ac0e0..ba03eaf 100644
--- a/block.c
+++ b/block.c
@@ -2602,7 +2602,7 @@ static void bdrv_replace_child_noperm(BdrvChild *chil=
d,
 /*
  * Updates @child to change its reference to point to @new_bs, including
- * checking and applying the necessary permisson updates both to the old n=
ode
+ * checking and applying the necessary permission updates both to the old =
node
  * and to @new_bs.
  *
  * NULL is passed as @new_bs for removing the reference before freeing @ch=
ild.
diff --git a/configure b/configure
index 2acc4d1..e34ef0c 100644
--- a/configure
+++ b/configure
@@ -3592,7 +3592,7 @@ EOF
     xfs=3D"yes"
   else
     if test "$xfs" =3D "yes" ; then
-      feature_not_found "xfs" "Instal xfsprogs/xfslibs devel"
+      feature_not_found "xfs" "Install xfsprogs/xfslibs devel"
     fi
     xfs=3Dno
   fi
diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index de061a8..15c0e79 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -518,7 +518,7 @@ static void statfs_to_prstatfs(ProxyStatFS *pr_stfs, st=
ruct statfs *stfs)
 /*
  * Gets stat/statfs information and packs in out_iovec structure
- * on success returns number of bytes packed in out_iovec struture
+ * on success returns number of bytes packed in out_iovec structure
  * otherwise returns -errno
  */
static int do_stat(int type, struct iovec *iovec, struct iovec *out_iovec)
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 60f395c..27c4bbe 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1267,7 +1267,7 @@ ERST
     },
SRST
``drive_backup``
-  Start a point-in-time copy of a block device to a specificed target.
+  Start a point-in-time copy of a block device to a specified target.
ERST
     {
diff --git a/libdecnumber/decNumber.c b/libdecnumber/decNumber.c
index 8c19702..1ffe458 100644
--- a/libdecnumber/decNumber.c
+++ b/libdecnumber/decNumber.c
@@ -5626,7 +5626,7 @@ static const uShort LNnn[90] =3D {
/*    would certainly save at least one if it were made ten times     */
/*    bigger, too (for truncated fractions 0.100 through 0.999).      */
/*    However, for most practical evaluations, at least four or five  */
-/*    iterations will be neede -- so this would only speed up by      */
+/*    iterations will be needed -- so this would only speed up by      */
/*    20-25% and that probably does not justify increasing the table  */
/*    size.                                                                =
  */
/*                                                                         =
 */
diff --git a/qemu-img.c b/qemu-img.c
index 5308773..26369b8 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1187,7 +1187,7 @@ static int64_t find_nonzero(const uint8_t *buf, int64=
_t n)
  * 'pnum' is set to the number of sectors (including and immediately follo=
wing
  * the first one) that are known to be in the same allocated/unallocated s=
tate.
  * The function will try to align the end offset to alignment boundaries s=
o
- * that the request will at least end aligned and consequtive requests wil=
l
+ * that the request will at least end aligned and consecutive requests wil=
l
  * also start at an aligned offset.
  */
static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 526de54..1079bd3 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -33,7 +33,7 @@ QDict *qdict_new(void)
}
 /**
- * tdb_hash(): based on the hash agorithm from gdbm, via tdb
+ * tdb_hash(): based on the hash algorithm from gdbm, via tdb
  * (from module-init-tools)
  */
static unsigned int tdb_hash(const char *name)
diff --git a/rules.mak b/rules.mak
index 694865b..07f0b4f 100644
--- a/rules.mak
+++ b/rules.mak
@@ -51,7 +51,7 @@ undefined-symbols =3D $(call find-symbols,$1,awk '$$2=3D=
=3D"U"{print $$1}')
# linking executables that will load them. So we can look up symbol referen=
ce
# in LINK.
#
-# This is necessary because the exectuable itself may not use the function=
, in
+# This is necessary because the executable itself may not use the function=
, in
# which case the function would not be linked in. Then the DSO loading will
# fail because of the missing symbol.
process-archive-undefs =3D $(filter-out %.a %.mo,$1) \
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 5acccfb..c16aae4 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -126,7 +126,7 @@ static int pr_manager_helper_initialize(PRManagerHelper=
 *pr_mgr,
     qio_channel_set_delay(QIO_CHANNEL(sioc), false);
     pr_mgr->ioc =3D QIO_CHANNEL(sioc);
-    /* A simple feature negotation protocol, even though there is
+    /* A simple feature negotiation protocol, even though there is
      * no optional feature right now.
      */
     r =3D pr_manager_helper_read(pr_mgr, &flags, sizeof(flags), errp);
--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48A9CB8dggemi522mbschina_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"text-justi=
fy-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">I found that there are many spe=
lling errors in the comments of qemu,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">so I used the spellcheck tool t=
o check the spelling errors<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">and finally found some spelling=
 errors in the folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Changelog&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">accel/tcg/user-exec.c&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">audio/audio.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43=
;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">block.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">configure&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">fsdev/virtfs-proxy-helper.c | 2=
 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">hmp-commands.hx&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">libdecnumber/decNumber.c&nbsp;&=
nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qemu-img.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;| 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qobject/qdict.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">rules.mak&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">scsi/pr-manager-helper.c&nbsp;&=
nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">12 files changed, 12 insertions=
(&#43;), 12 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/Changelog b/Change=
log<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 4a90bb9..f7e178c 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/Changelog<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/Changelog<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -241,7 &#43;241,7 @@ version=
 0.8.0:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">version 0.7.2:<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;- x86_64 fixe=
s (Win2000 and Linux 2.6 boot in 32 bit)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp; - merge self modifying =
code handling in dirty ram page mecanism.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; - merge self modify=
ing code handling in dirty ram page mechanism.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; - MIPS fixes (Ralf=
 Baechle)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; - better user net =
performances<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/accel/tcg/user-exe=
c.c b/accel/tcg/user-exec.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index d8b027f..d1b3073 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/accel/tcg/user-exec.c<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/accel/tcg/use=
r-exec.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -88,7 &#43;88,7 @@ static in=
line int handle_cpu_signal(uintptr_t pc, siginfo_t *info,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * use that value directly.&nbsp; Within cpu_restore=
_state_from_tb, we<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * assume PC comes from GETPC(), as used by the help=
er functions,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * so we adjust the address by -GETPC_ADJ to form an=
 address that<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * is within the call insn, so that the address does not =
accidentially<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * is within the call insn, so that the address does =
not accidentally<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * match the beginning of the next guest insn.&nbsp;=
 However, when the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * pc comes from the signal frame it points to the a=
ctual faulting<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * host memory insn and not the return from a call i=
nsn.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/audio/audio.c b/au=
dio/audio.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index ce8c6de..1a68cfa 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/audio/audio.c<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/audio/audio.c=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1674,7 &#43;1674,7 @@ stati=
c AudioState *audio_init(Audiodev *dev, const char *name)<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; head =3D audio_handle_legacy_opts();<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * In case of legacy initialization, all Audiodevs i=
n the list will have<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * the same configuration (except the driver), so it does=
't matter which<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; * the same configuration (except the driver), so it =
doesn't matter which<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * one we chose.&nbsp; We need an Audiodev to set up=
 AudioState before we can<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &nbsp;* init a driver.&nbsp; Also note that dev at this p=
oint is still in the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; * list.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/block.c b/block.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index d9ac0e0..ba03eaf 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/block.c<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/block.c<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -2602,7 &#43;2602,7 @@ stati=
c void bdrv_replace_child_noperm(BdrvChild *child,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Updates @child to chan=
ge its reference to point to @new_bs, including<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * checking and applying the n=
ecessary permisson updates both to the old node<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * checking and applying t=
he necessary permission updates both to the old node<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * and to @new_bs.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * NULL is passed as @new=
_bs for removing the reference before freeing @child.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/configure b/config=
ure<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 2acc4d1..e34ef0c 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/configure<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/configure<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -3592,7 &#43;3592,7 @@ EOF<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; xfs=3D=
&quot;yes&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; else<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; if tes=
t &quot;$xfs&quot; =3D &quot;yes&quot; ; then<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 feature_not_found &quot;xfs&quot; &quot;Instal xfsprogs/xfslibs devel&quot=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; feature_not_found &quot;xfs&quot; &quot;Install xfsprogs/xfslibs devel=
&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; fi<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; xfs=3D=
no<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; fi<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/fsdev/virtfs-proxy=
-helper.c b/fsdev/virtfs-proxy-helper.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index de061a8..15c0e79 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/fsdev/virtfs-proxy-helper=
.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/fsdev/virtfs-=
proxy-helper.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -518,7 &#43;518,7 @@ static =
void statfs_to_prstatfs(ProxyStatFS *pr_stfs, struct statfs *stfs)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Gets stat/statfs infor=
mation and packs in out_iovec structure<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * on success returns number o=
f bytes packed in out_iovec struture<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * on success returns numb=
er of bytes packed in out_iovec structure<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * otherwise returns -err=
no<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static int do_stat(int type, st=
ruct iovec *iovec, struct iovec *out_iovec)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/hmp-commands.hx b/=
hmp-commands.hx<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 60f395c..27c4bbe 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/hmp-commands.hx<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/hmp-commands.=
hx<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1267,7 &#43;1267,7 @@ ERST<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; },<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">SRST<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">``drive_backup``<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp; Start a point-in-time c=
opy of a block device to a specificed target.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp; Start a point-in-ti=
me copy of a block device to a specified target.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ERST<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/libdecnumber/decNu=
mber.c b/libdecnumber/decNumber.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 8c19702..1ffe458 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/libdecnumber/decNumber.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/libdecnumber/=
decNumber.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -5626,7 &#43;5626,7 @@ stati=
c const uShort LNnn[90] =3D {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*&nbsp;&nbsp;&nbsp; would cert=
ainly save at least one if it were made ten times&nbsp;&nbsp;&nbsp;&nbsp; *=
/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*&nbsp;&nbsp;&nbsp; bigger, to=
o (for truncated fractions 0.100 through 0.999).&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*&nbsp;&nbsp;&nbsp; However, f=
or most practical evaluations, at least four or five&nbsp; */<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-/*&nbsp;&nbsp;&nbsp; iteration=
s will be neede -- so this would only speed up by&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;/*&nbsp;&nbsp;&nbsp; itera=
tions will be needed -- so this would only speed up by&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*&nbsp;&nbsp;&nbsp; 20-25% and=
 that probably does not justify increasing the table&nbsp; */<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*&nbsp;&nbsp;&nbsp; size.&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/qemu-img.c b/qemu-=
img.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 5308773..26369b8 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/qemu-img.c<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/qemu-img.c<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -1187,7 &#43;1187,7 @@ stati=
c int64_t find_nonzero(const uint8_t *buf, int64_t n)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * 'pnum' is set to the n=
umber of sectors (including and immediately following<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * the first one) that ar=
e known to be in the same allocated/unallocated state.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * The function will try =
to align the end offset to alignment boundaries so<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * that the request will at le=
ast end aligned and consequtive requests will<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * that the request will a=
t least end aligned and consecutive requests will<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * also start at an align=
ed offset.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static int is_allocated_sectors=
(const uint8_t *buf, int n, int *pnum,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/qobject/qdict.c b/=
qobject/qdict.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 526de54..1079bd3 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/qobject/qdict.c<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/qobject/qdict=
.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -33,7 &#43;33,7 @@ QDict *qd=
ict_new(void)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;/**<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * tdb_hash(): based on the ha=
sh agorithm from gdbm, via tdb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * tdb_hash(): based on th=
e hash algorithm from gdbm, via tdb<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * (from module-init-tool=
s)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static unsigned int tdb_hash(co=
nst char *name)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/rules.mak b/rules.=
mak<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 694865b..07f0b4f 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/rules.mak<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/rules.mak<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -51,7 &#43;51,7 @@ undefined=
-symbols =3D $(call find-symbols,$1,awk '$$2=3D=3D&quot;U&quot;{print $$1}'=
)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># linking executables that will=
 load them. So we can look up symbol reference<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># in LINK.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-# This is necessary because th=
e exectuable itself may not use the function, in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;# This is necessary becaus=
e the executable itself may not use the function, in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># which case the function would=
 not be linked in. Then the DSO loading will<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># fail because of the missing s=
ymbol.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">process-archive-undefs =3D $(fi=
lter-out %.a %.mo,$1) \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/scsi/pr-manager-he=
lper.c b/scsi/pr-manager-helper.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 5acccfb..c16aae4 100644<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/scsi/pr-manager-helper.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/scsi/pr-manag=
er-helper.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -126,7 &#43;126,7 @@ static =
int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; qio_ch=
annel_set_delay(QIO_CHANNEL(sioc), false);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; pr_mgr=
-&gt;ioc =3D QIO_CHANNEL(sioc);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; /* A simple=
 feature negotation protocol, even though there is<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; /* A si=
mple feature negotiation protocol, even though there is<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* no optional feature right now.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; r =3D =
pr_manager_helper_read(pr_mgr, &amp;flags, sizeof(flags), errp);<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48A9CB8dggemi522mbschina_--

