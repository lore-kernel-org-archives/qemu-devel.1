Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2500C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B047D20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 07:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B047D20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqCB-0006ht-Un
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 03:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq9k-0001eu-Ta; Wed, 26 Aug 2020 03:47:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2535 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kAq9i-00027O-2F; Wed, 26 Aug 2020 03:47:40 -0400
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 744E4494B988589E294A;
 Wed, 26 Aug 2020 15:47:35 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.252]) by
 dggemi401-hub.china.huawei.com ([10.3.17.134]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 15:47:28 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH V2 06/10] linux-user/: fix some comment spelling errors
Thread-Topic: [PATCH V2 06/10] linux-user/: fix some comment spelling errors
Thread-Index: AdZ7fCiFmI5TQf6xTrCZ0G7eSMl9KQ==
Date: Wed, 26 Aug 2020 07:47:28 +0000
Message-ID: <640CDEE67BE2784FAE298BB2517210E48AC3F2@dggemi522-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.186.227]
Content-Type: multipart/alternative;
 boundary="_000_640CDEE67BE2784FAE298BB2517210E48AC3F2dggemi522mbschina_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:46:00
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

--_000_640CDEE67BE2784FAE298BB2517210E48AC3F2dggemi522mbschina_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the linux-user folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
---
linux-user/aarch64/signal.c              | 2 +-
linux-user/cris/target_syscall.h         | 4 ++--
linux-user/flat.h                        | 2 +-
linux-user/flatload.c                    | 4 ++--
linux-user/host/ppc64/safe-syscall.inc.S | 2 +-
linux-user/syscall.c                     | 4 ++--
6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/linux-user/aarch64/signal.c b/linux-user/aarch64/signal.c
index cd521ee42d..d50c1ae583 100644
--- a/linux-user/aarch64/signal.c
+++ b/linux-user/aarch64/signal.c
@@ -78,7 +78,7 @@ struct target_sve_context {
     struct target_aarch64_ctx head;
     uint16_t vl;
     uint16_t reserved[3];
-    /* The actual SVE data immediately follows.  It is layed out
+    /* The actual SVE data immediately follows.  It is laid out
      * according to TARGET_SVE_SIG_{Z,P}REG_OFFSET, based off of
      * the original struct pointer.
      */
diff --git a/linux-user/cris/target_syscall.h b/linux-user/cris/target_sysc=
all.h
index 29d69009ff..c7ae89d73a 100644
--- a/linux-user/cris/target_syscall.h
+++ b/linux-user/cris/target_syscall.h
@@ -4,7 +4,7 @@
#define UNAME_MACHINE "cris"
#define UNAME_MINIMUM_RELEASE "2.6.32"

-/* pt_regs not only specifices the format in the user-struct during
+/* pt_regs not only specifies the format in the user-struct during
  * ptrace but is also the frame format used in the kernel prologue/epilogu=
es
  * themselves
  */
@@ -32,7 +32,7 @@ struct target_pt_regs {
         unsigned long spc;
         unsigned long ccs;
         unsigned long srp;
-        unsigned long erp; /* This is actually the debugged process' PC */
+        unsigned long erp; /* This is actually the debugged process's PC *=
/
         /* For debugging purposes; saved only when needed. */
         unsigned long exs;
         unsigned long eda;
diff --git a/linux-user/flat.h b/linux-user/flat.h
index 1e44b33443..ed518e2013 100644
--- a/linux-user/flat.h
+++ b/linux-user/flat.h
@@ -43,7 +43,7 @@ struct flat_hdr {
         abi_ulong reloc_count;  /* Number of relocation records */
         abi_ulong flags;
         abi_ulong build_date;   /* When the program/library was built */
-        abi_ulong filler[5];    /* Reservered, set to zero */
+       abi_ulong filler[5];    /* Reserved, set to zero */
};

#define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 8fb448f0bf..14d2999d15 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -442,7 +442,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     indx_len =3D (indx_len + 15) & ~(abi_ulong)15;

     /*
-     * Alloate the address space.
+     * Allocate the address space.
      */
     probe_guest_base(bprm->filename, 0,
                      text_len + data_len + extra + indx_len);
@@ -794,7 +794,7 @@ int load_flt_binary(struct linux_binprm *bprm, struct i=
mage_info *info)
#error here
     for (i =3D MAX_SHARED_LIBS-1; i>0; i--) {
             if (libinfo[i].loaded) {
-                    /* Push previos first to call address */
+                    /* Push previous first to call address */
                     --sp;
                     if (put_user_ual(start_addr, sp))
                         return -EFAULT;
diff --git a/linux-user/host/ppc64/safe-syscall.inc.S b/linux-user/host/ppc=
64/safe-syscall.inc.S
index 8ed73a5b86..875133173b 100644
--- a/linux-user/host/ppc64/safe-syscall.inc.S
+++ b/linux-user/host/ppc64/safe-syscall.inc.S
@@ -84,7 +84,7 @@ safe_syscall_end:

       /* code path when we didn't execute the syscall */
0:      addi 3, 0, -TARGET_ERESTARTSYS
-        ld 14, 16(1) /* restore r14 to its orginal value */
+       ld 14, 16(1) /* restore r14 to its original value */
         blr
         .cfi_endproc

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b4a7b605f3..bdfa51dde8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -477,7 +477,7 @@ _syscall4(int, sys_prlimit64, pid_t, pid, int, resource=
,

 #if defined(TARGET_NR_timer_create)
-/* Maxiumum of 32 active POSIX timers allowed at any one time. */
+/* Maximum of 32 active POSIX timers allowed at any one time. */
static timer_t g_posix_timers[32] =3D { 0, } ;

static inline int next_free_host_timer(void)
@@ -7800,7 +7800,7 @@ static abi_long do_syscall1(void *cpu_env, int num, a=
bi_long arg1,
     switch(num) {
     case TARGET_NR_exit:
         /* In old applications this may be used to implement _exit(2).
-           However in threaded applictions it is used for thread terminati=
on,
+           However in threaded applications it is used for thread terminat=
ion,
            and _exit_group is used for application termination.
            Do thread termination if we have more then one thread.  */

--
2.26.2.windows.1


--_000_640CDEE67BE2784FAE298BB2517210E48AC3F2dggemi522mbschina_
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
 errors in the linux-user folder.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Signed-off-by: zhaolichang &lt;=
zhaolichang@huawei.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reviewed-by: Alex Benn=E9e &lt;=
alex.bennee@linaro.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">linux-user/aarch64/signal.c&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
| 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">linux-user/cris/target_syscall.=
h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">linux-user/flat.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">linux-user/flatload.c&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">linux-user/host/ppc64/safe-sysc=
all.inc.S | 2 &#43;-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">linux-user/syscall.c&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4 &#43;&#43;--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">6 files changed, 9 insertions(&=
#43;), 9 deletions(-)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/linux-user/aarch64=
/signal.c b/linux-user/aarch64/signal.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index cd521ee42d..d50c1ae583 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/linux-user/aarch64/signal=
.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/linux-user/aa=
rch64/signal.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -78,7 &#43;78,7 @@ struct ta=
rget_sve_context {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; struct=
 target_aarch64_ctx head;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; uint16=
_t vl;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; uint16=
_t reserved[3];<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp; /* The actu=
al SVE data immediately follows.&nbsp; It is layed out<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp; /* The =
actual SVE data immediately follows.&nbsp; It is laid out<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* according to TARGET_SVE_SIG_{Z,P}REG_OFFSET, based off of<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
* the original struct pointer.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/linux-user/cris/ta=
rget_syscall.h b/linux-user/cris/target_syscall.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 29d69009ff..c7ae89d73a 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/linux-user/cris/target_sy=
scall.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/linux-user/cr=
is/target_syscall.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -4,7 &#43;4,7 @@<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define UNAME_MACHINE &quot;cri=
s&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define UNAME_MINIMUM_RELEASE &=
quot;2.6.32&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-/* pt_regs not only specifices=
 the format in the user-struct during<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;/* pt_regs not only specif=
ies the format in the user-struct during<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * ptrace but is also the=
 frame format used in the kernel prologue/epilogues<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; * themselves<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -32,7 &#43;32,7 @@ struct ta=
rget_pt_regs {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; unsigned long spc;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;unsigned long ccs;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; unsigned long srp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; unsigned long erp; /* This is actually the debugged process' P=
C */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; unsigned long erp; /* This is actually the debugged proces=
s's PC */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* For debugging purposes; saved only when needed. */<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; unsigned long exs;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; unsigned long eda;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/linux-user/flat.h =
b/linux-user/flat.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 1e44b33443..ed518e2013 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/linux-user/flat.h<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/linux-user/fl=
at.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -43,7 &#43;43,7 @@ struct fl=
at_hdr {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; abi_ulong reloc_count;&nbsp; /* Number of relocation reco=
rds */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; abi_ulong flags;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; abi_ulong build_date;&nbsp;&nbsp; /* When the program/lib=
rary was built */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; abi_ulong filler[5];&nbsp;&nbsp;&nbsp; /* Reservered, set to z=
ero */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; abi_ulong filler[5];&nbsp;&nbsp;&nbsp; /* Reserved, set to zero =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#define FLAT_FLAG_RAM&nbsp;&nbs=
p;&nbsp; 0x0001 /* load program entirely into RAM */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/linux-user/flatloa=
d.c b/linux-user/flatload.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 8fb448f0bf..14d2999d15 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/linux-user/flatload.c<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/linux-user/fl=
atload.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -442,7 &#43;442,7 @@ static =
int load_flat_file(struct linux_binprm * bprm,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; indx_l=
en =3D (indx_len &#43; 15) &amp; ~(abi_ulong)15;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp; * All=
oate the address space.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp; *=
 Allocate the address space.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; probe_=
guest_base(bprm-&gt;filename, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; text_len &#43; data_len &#43; extra &#43; indx_len);<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -794,7 &#43;794,7 @@ int loa=
d_flt_binary(struct linux_binprm *bprm, struct image_info *info)<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#error here<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; for (i=
 =3D MAX_SHARED_LIBS-1; i&gt;0; i--) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (libinfo[i].loaded) {<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; /* Push previos first to call address */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* Push previous first to call address */<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; --sp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (put_user_ual(start_addr, sp))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/linux-user/host/pp=
c64/safe-syscall.inc.S b/linux-user/host/ppc64/safe-syscall.inc.S<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index 8ed73a5b86..875133173b 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/linux-user/host/ppc64/saf=
e-syscall.inc.S<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/linux-user/ho=
st/ppc64/safe-syscall.inc.S<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -84,7 &#43;84,7 @@ safe_sysc=
all_end:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; /* code path when we didn't execute the syscall */<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; addi 3, 0, -TARGET_ERESTARTSYS<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; ld 14, 16(1) /* restore r14 to its orginal value */<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ld 14, 16(1) /* restore r14 to its original value */<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; blr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .cfi_endproc<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">diff --git a/linux-user/syscall=
.c b/linux-user/syscall.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">index b4a7b605f3..bdfa51dde8 10=
0644<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">--- a/linux-user/syscall.c<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&#43;&#43; b/linux-user/sy=
scall.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -477,7 &#43;477,7 @@ _syscal=
l4(int, sys_prlimit64, pid_t, pid, int, resource,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;#if defined(TARGET_NR_tim=
er_create)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-/* Maxiumum of 32 active POSIX=
 timers allowed at any one time. */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;/* Maximum of 32 active PO=
SIX timers allowed at any one time. */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static timer_t g_posix_timers[3=
2] =3D { 0, } ;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">static inline int next_free_hos=
t_timer(void)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">@@ -7800,7 &#43;7800,7 @@ stati=
c abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; switch=
(num) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp; case T=
ARGET_NR_exit:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* In old applications this may be used to implement _exi=
t(2).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; However in threaded applictions it is used f=
or thread termination,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; However in threaded applications it is u=
sed for thread termination,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and _exit_group is used for application=
 termination.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Do thread termination if we have more t=
hen one thread.&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2.26.2.windows.1<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_640CDEE67BE2784FAE298BB2517210E48AC3F2dggemi522mbschina_--

