Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B3C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A759020707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A759020707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqAs-0003d6-W2
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq9Q-0000rz-T9; Wed, 26 Aug 2020 03:47:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2103 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq9O-00024L-04; Wed, 26 Aug 2020 03:47:20 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 5A17D83BF21275014EFC;
 Wed, 26 Aug 2020 15:47:13 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:47:04 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 05/10] util/: fix some comment spelling errors
Thread-Topic: [PATCH V2 05/10] util/: fix some comment spelling errors
Thread-Index: AdZ7fA5ARD06DsV/RbafQUaDtvlmZw==
Date: Wed, 26 Aug 2020 07:47:04 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC3E1@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC3E1dggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:47:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_640CDEE67BE2784FAE298BB2517210E48AC3E1dggemi522mbschina_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the util folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
---
util/osdep.c             | 2 +-
util/qemu-progress.c     | 2 +-
util/qemu-sockets.c      | 2 +-
util/qemu-thread-win32.c | 2 +-
util/qht.c               | 2 +-
util/trace-events        | 2 +-
6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 4829c07ff6..e50dc2214e 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -392,7 +392,7 @@ int qemu_unlink(const char *name)
  * Set errno if fewer than `count' bytes are written.
  *
  * This function don't work with non-blocking fd's.
- * Any of the possibilities with non-bloking fd's is bad:
+ * Any of the possibilities with non-blocking fd's is bad:
  *   - return a short write (then name is wrong)
  *   - busy wait adding (errno =3D=3D EAGAIN) to the loop
  */
diff --git a/util/qemu-progress.c b/util/qemu-progress.c
index 3c2223c1a2..20d51f8c12 100644
--- a/util/qemu-progress.c
+++ b/util/qemu-progress.c
@@ -131,7 +131,7 @@ void qemu_progress_end(void)
/*
  * Report progress.
  * @delta is how much progress we made.
- * If @max is zero, @delta is an absolut value of the total job done.
+ * If @max is zero, @delta is an absolute value of the total job done.
  * Else, @delta is a progress delta since the last call, as a fraction
  * of @max.  I.e. the delta is @delta * @max / 100. This allows
  * relative accounting of functions which may be a different fraction of
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b37d288866..99ce2fd5e6 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -416,7 +416,7 @@ static struct addrinfo *inet_parse_connect_saddr(InetSo=
cketAddress *saddr,

     /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
      * then don't implement it in their getaddrinfo(). Detect
-     * this and retry without the flag since that's preferrable
+     * this and retry without the flag since that's preferable
      * to a fatal error
      */
     if (rc =3D=3D EAI_BADFLAGS &&
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 56a83333da..d207b0cb58 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -289,7 +289,7 @@ void qemu_event_wait(QemuEvent *ev)
             ResetEvent(ev->event);

             /* Tell qemu_event_set that there are waiters.  No need to ret=
ry
-             * because there cannot be a concurent busy->free transition.
+             * because there cannot be a concurrent busy->free transition.
              * After the CAS, the event will be either set or busy.
              */
             if (atomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) =3D=3D EV_SET=
) {
diff --git a/util/qht.c b/util/qht.c
index 67e5d5b916..b2e020c398 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -49,7 +49,7 @@
  * it anymore.
  *
  * Writers check for concurrent resizes by comparing ht->map before and af=
ter
- * acquiring their bucket lock. If they don't match, a resize has occured
+ * acquiring their bucket lock. If they don't match, a resize has occurred
  * while the bucket spinlock was being acquired.
  *
  * Related Work:
diff --git a/util/trace-events b/util/trace-events
index 0ce42822eb..4bc01808af 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -28,7 +28,7 @@ qemu_file_monitor_add_watch(void *mon, const char *dirpat=
h, const char *filename
qemu_file_monitor_remove_watch(void *mon, const char *dirpath, int64_t id) =
"File monitor %p remove watch dir=3D'%s' id=3D%" PRId64
qemu_file_monitor_new(void *mon, int fd) "File monitor %p created fd=3D%d"
qemu_file_monitor_enable_watch(void *mon, const char *dirpath, int id) "Fil=
e monitor %p enable watch dir=3D'%s' id=3D%u"
-qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) "F=
le monitor %p disable watch dir=3D'%s' id=3D%u"
+qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) "F=
ile monitor %p disable watch dir=3D'%s' id=3D%u"
qemu_file_monitor_event(void *mon, const char *dirpath, const char *filenam=
e, int mask, unsigned int id) "File monitor %p event dir=3D'%s' file=3D'%s'=
 mask=3D0x%x id=3D%u"
qemu_file_monitor_dispatch(void *mon, const char *dirpath, const char *file=
name, int ev, void *cb, void *opaque, int64_t id) "File monitor %p dispatch=
 dir=3D'%s' file=3D'%s' ev=3D%d cb=3D%p opaque=3D%p id=3D%" PRId64

--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC3E1dggemi522mbschina_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
	font-size:10.0pt;
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
 errors in the util folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by: Alex Benn=E9e &lt;=
alex.bennee@linaro.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">util/osdep.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">util/qemu-progress.c&nbsp;&nbsp=
;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">util/qemu-sockets.c&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">util/qemu-thread-win32.c | 2 &#=
43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">util/qht.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">util/trace-events&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">6 files changed, 6 insertions(&=
#43;), 6 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/util/osdep.c b/uti=
l/osdep.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 4829c07ff6..e50dc2214e 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/util/osdep.c<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/util/osdep.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -392,7 &#43;392,7 @@ int qem=
u_unlink(const char *name)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Set errno if fewer tha=
n `count' bytes are written.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * This function don't wo=
rk with non-blocking fd's.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * Any of the possibilities wi=
th non-bloking fd's is bad:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * Any of the possibilitie=
s with non-blocking fd's is bad:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *&nbsp;&nbsp; - return a=
 short write (then name is wrong)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *&nbsp;&nbsp; - busy wai=
t adding (errno =3D=3D EAGAIN) to the loop<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/util/qemu-progress=
.c b/util/qemu-progress.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 3c2223c1a2..20d51f8c12 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/util/qemu-progress.c<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/util/qemu-pro=
gress.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -131,7 &#43;131,7 @@ void qe=
mu_progress_end(void)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">/*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Report progress.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * @delta is how much pro=
gress we made.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * If @max is zero, @delta is =
an absolut value of the total job done.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * If @max is zero, @delta=
 is an absolute value of the total job done.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Else, @delta is a prog=
ress delta since the last call, as a fraction<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * of @max.&nbsp; I.e. th=
e delta is @delta * @max / 100. This allows<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * relative accounting of=
 functions which may be a different fraction of<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/util/qemu-sockets.=
c b/util/qemu-sockets.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index b37d288866..99ce2fd5e6 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/util/qemu-sockets.c<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/util/qemu-soc=
kets.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -416,7 &#43;416,7 @@ static =
struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /* At =
least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* then don't implement it in their getaddrinfo(). Detect<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * thi=
s and retry without the flag since that's preferrable<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 this and retry without the flag since that's preferable<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* to a fatal error<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; if (rc=
 =3D=3D EAI_BADFLAGS &amp;&amp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/util/qemu-thread-w=
in32.c b/util/qemu-thread-win32.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 56a83333da..d207b0cb58 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/util/qemu-thread-win32.c<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/util/qemu-thr=
ead-win32.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -289,7 &#43;289,7 @@ void qe=
mu_event_wait(QemuEvent *ev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ResetEvent(ev-&gt;event);<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tell qemu_event_set that there=
 are waiters.&nbsp; No need to retry<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because there cannot be a conc=
urent busy-&gt;free transition.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because there cannot be a =
concurrent busy-&gt;free transition.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * After the CAS, the event =
will be either set or busy.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_cmpxchg(&amp;ev-&gt;va=
lue, EV_FREE, EV_BUSY) =3D=3D EV_SET) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/util/qht.c b/util/=
qht.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 67e5d5b916..b2e020c398 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/util/qht.c<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/util/qht.c<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -49,7 &#43;49,7 @@<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * it anymore.<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Writers check for conc=
urrent resizes by comparing ht-&gt;map before and after<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">- * acquiring their bucket lock=
. If they don't match, a resize has occured<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43; * acquiring their bucket =
lock. If they don't match, a resize has occurred<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * while the bucket spinl=
ock was being acquired.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; *<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * Related Work:<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/util/trace-events =
b/util/trace-events<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 0ce42822eb..4bc01808af 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/util/trace-events<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/util/trace-ev=
ents<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -28,7 &#43;28,7 @@ qemu_file=
_monitor_add_watch(void *mon, const char *dirpath, const char *filename<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qemu_file_monitor_remove_watch(=
void *mon, const char *dirpath, int64_t id) &quot;File monitor %p remove wa=
tch dir=3D'%s' id=3D%&quot; PRId64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qemu_file_monitor_new(void *mon=
, int fd) &quot;File monitor %p created fd=3D%d&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qemu_file_monitor_enable_watch(=
void *mon, const char *dirpath, int id) &quot;File monitor %p enable watch =
dir=3D'%s' id=3D%u&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-qemu_file_monitor_disable_watc=
h(void *mon, const char *dirpath, int id) &quot;Fle monitor %p disable watc=
h dir=3D'%s' id=3D%u&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;qemu_file_monitor_disable_=
watch(void *mon, const char *dirpath, int id) &quot;File monitor %p disable=
 watch dir=3D'%s' id=3D%u&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qemu_file_monitor_event(void *m=
on, const char *dirpath, const char *filename, int mask, unsigned int id) &=
quot;File monitor %p event dir=3D'%s' file=3D'%s' mask=3D0x%x id=3D%u&quot;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">qemu_file_monitor_dispatch(void=
 *mon, const char *dirpath, const char *filename, int ev, void *cb, void *o=
paque, int64_t id) &quot;File monitor %p dispatch dir=3D'%s' file=3D'%s' ev=
=3D%d cb=3D%p opaque=3D%p id=3D%&quot; PRId64<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC3E1dggemi522mbschina_--

