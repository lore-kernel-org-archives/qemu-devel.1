Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D44C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410A020760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.gitlab.com header.i=@mg.gitlab.com header.b="HWYGCjjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410A020760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLgT-000786-JB
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1jrLfX-0005rM-Ni
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:23:55 -0400
Received: from do158-143.mg.gitlab.com ([192.237.158.143]:43266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1jrLfU-0001Pc-O4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:23:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.gitlab.com;
 q=dns/txt; 
 s=mailo; t=1593782633; h=List-Id: Content-Transfer-Encoding:
 Content-Type: Mime-Version: Subject: Message-ID: Reply-To: From: Date:
 Sender; bh=eKwGl4Y/pRszNK+H8FGA5sLSzGucAKQk1PBcSU/VNbA=;
 b=HWYGCjjU0vu5ZzeMWENHBJSUaXlGHQeK7eXiMKVB6ktjac7XNt1WSNgytalHSn/yp7LnmG71
 TQaesqhrHNySMfL7aoqeU/MYWHgnOzDYiAU+dtgrV3h25m/pc0TIoMiq/oY6Sa6VISoWIInt
 uzw9cPAX4fq6jXuPJRzxNUJw+Z8=
X-Mailgun-Sending-Ip: 192.237.158.143
X-Mailgun-Sid: WyI3MWYzYSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOTQ3YjQiXQ==
Received: from mg.gitlab.com (66.90.74.34.bc.googleusercontent.com
 [34.74.90.66]) by smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5eff3161356bcc26ab515f83 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Fri, 03 Jul 2020 13:23:45 GMT
Date: Fri, 03 Jul 2020 13:23:44 +0000
Message-ID: <5eff3160ed8bb_3d7c3fcc510fafe86794b@sidekiq-catchall-01-sv-gprd.mail>
Subject: QEMU | Pipeline #162858807 has failed for master | 6651620b
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_5eff3160e15f6_3d7c3fcc510fafe867861";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitLab-Project: QEMU
X-GitLab-Project-Id: 11167699
X-GitLab-Project-Path: qemu-project/qemu
X-GitLab-Pipeline-Id: 162858807
X-GitLab-Pipeline-Ref: master
X-GitLab-Pipeline-Status: failed
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
Received-SPF: pass client-ip=192.237.158.143;
 envelope-from=bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com;
 helo=do158-143.mg.gitlab.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:09:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_BL=0.01, RCVD_IN_MSPIKE_L4=1.7,
 REPLYTO_WITHOUT_TO_CC=1.552, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: GitLab <noreply@gitlab.com>, GitLab <gitlab@mg.gitlab.com>
From: GitLab via <qemu-devel@nongnu.org>


----==_mimepart_5eff3160e15f6_3d7c3fcc510fafe867861
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Your pipeline has failed.

Project: QEMU ( https://gitlab.com/qemu-project/qemu )
Branch: master ( https://gitlab.com/qemu-project/qemu/-/commits/master )

Commit: 6651620b ( https://gitlab.com/qemu-project/qemu/-/commit/6651620b=
92bc08cde07cb500e9a43dba7bd9b2b7 )
Commit Message: Merge remote-tracking branch 'remotes/kraxel/ta...
Commit Author: Peter Maydell ( https://gitlab.com/pm215 )

Pipeline #162858807 ( https://gitlab.com/qemu-project/qemu/-/pipelines/16=
2858807 ) triggered by Alex Benn=C3=A9e ( https://gitlab.com/stsquad )
had 2 failed builds.

Job #623043447 ( https://gitlab.com/qemu-project/qemu/-/jobs/623043447/ra=
w )

Stage: test
Name: build-tcg-disabled
Trace: 208      ...        [12:59:42]             ...              =

208      =1B[32mpass      =1B[0m [12:59:42] [12:59:42]   0s              =
 =

209      ...        [12:59:42]             ...              =

209      =1B[32mpass      =1B[0m [12:59:42] [12:59:42]   0s              =
 =

215      ...        [12:59:42]             ...              =

215      =1B[32mpass      =1B[0m [12:59:42] [13:01:01]  79s              =
 =

216      ...        [13:01:01]             ...              =

216      =1B[32mpass      =1B[0m [13:01:01] [13:01:05]   4s              =
 =

218      ...        [13:01:05]             ...              =

218      =1B[32mpass      =1B[0m [13:01:05] [13:01:07]   2s              =
 =

222      ...        [13:01:07]             ...              =

222      =1B[32mpass      =1B[0m [13:01:07] [13:01:07]   0s              =
 =

227      ...        [13:01:07]             ...              =

227      =1B[32mpass      =1B[0m [13:01:07] [13:01:08]   1s              =
 =

234      ...        [13:01:08]             ...              =

234      =1B[32mpass      =1B[0m [13:01:08] [13:01:08]   0s              =
 =

246      ...        [13:01:08]             ...              =

246      =1B[32mpass      =1B[0m [13:01:08] [13:01:09]   1s              =
 =

247      ...        [13:01:09]             ...              =

247      =1B[32mpass      =1B[0m [13:01:09] [13:01:10]   1s              =
 =

248      ...        [13:01:10]             ...              =

248      =1B[32mpass      =1B[0m [13:01:10] [13:01:10]   0s              =
 =

250      ...        [13:01:10]             ...              =

250      =1B[32mpass      =1B[0m [13:01:10] [13:01:11]   1s              =
 =

254      ...        [13:01:11]             ...              =

254      =1B[32mpass      =1B[0m [13:01:11] [13:01:11]   0s              =
 =

255      ...        [13:01:11]             ...              =

255      =1B[32mpass      =1B[0m [13:01:11] [13:01:13]   2s              =
 =

257      ...        [13:01:13]             ...              =

257      =1B[32mpass      =1B[0m [13:01:13] [13:01:23]  10s              =
 =

258      ...        [13:01:23]             ...              =

258      =1B[32mpass      =1B[0m [13:01:23] [13:01:24]   1s              =
 =

260      ...        [13:01:24]             ...              =

260      =1B[32mpass      =1B[0m [13:01:24] [13:01:25]   1s              =
 =

261      ...        [13:01:25]             ...              =

261      =1B[32mpass      =1B[0m [13:01:25] [13:01:50]  25s              =
 =

262      ...        [13:01:50]             ...              =

262      =1B[32mpass      =1B[0m [13:01:50] [13:01:50]   0s              =
 =

263      ...        [13:01:50]             ...              =

263      =1B[32mpass      =1B[0m [13:01:50] [13:01:53]   3s              =
 =

264      ...        [13:01:53]             ...              =

264      =1B[32mpass      =1B[0m [13:01:53] [13:01:57]   4s              =
 =

270      ...        [13:01:57]             ...              =

270      =1B[32mpass      =1B[0m [13:01:57] [13:01:58]   1s              =
 =

272      ...        [13:01:58]             ...              =

272      =1B[32mpass      =1B[0m [13:01:58] [13:01:59]   1s              =
 =

273      ...        [13:01:59]             ...              =

273      =1B[32mpass      =1B[0m [13:01:59] [13:01:59]   0s              =
 =

277      ...        [13:01:59]             ...              =

277      =1B[32mpass      =1B[0m [13:01:59] [13:02:01]   2s              =
 =

279      ...        [13:02:01]             ...              =

279      =1B[32mpass      =1B[0m [13:02:01] [13:02:01]   0s              =
 =

Failures: 051
Failed 1 of 57 iotests
section_end:1593781334:step_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #623043445 ( https://gitlab.com/qemu-project/qemu/-/jobs/623043445/ra=
w )

Stage: test
Name: build-disabled
Trace: =1B[0KRunning with gitlab-runner 13.1.0 (6214287e)
=1B[0;m=1B[0K  on docker-auto-scale 0277ea0f
=1B[0;msection_start:1593779910:prepare_executor
=1B[0K=1B[0K=1B[36;1mPreparing the "docker+machine" executor=1B[0;m
=1B[0;m=1B[0KUsing Docker executor with image fedora:latest ...
=1B[0;m=1B[0KPulling docker image fedora:latest ...
=1B[0;m=1B[0KUsing docker image sha256:adfbfa4a115a799771d3060d0aa213584c=
91e549187da4fb0036240294ca4a8f for fedora:latest ...
=1B[0;msection_end:1593779927:prepare_executor
=1B[0Ksection_start:1593779927:prepare_script
=1B[0K=1B[0K=1B[36;1mPreparing environment=1B[0;m
=1B[0;mRunning on runner-0277ea0f-project-11167699-concurrent-0 via runne=
r-0277ea0f-srm-1593779865-df1fb9e9...
section_end:1593779931:prepare_script
=1B[0Ksection_start:1593779931:get_sources
=1B[0K=1B[0K=1B[36;1mGetting source from Git repository=1B[0;m
=1B[0;m=1B[32;1m$ eval "$CI_PRE_CLONE_SCRIPT"=1B[0;m
=1B[32;1mFetching changes...=1B[0;m
Initialized empty Git repository in /builds/qemu-project/qemu/.git/
=1B[32;1mCreated fresh repository.=1B[0;m
=1B[32;1mChecking out 6651620b as master...=1B[0;m

=1B[32;1mSkipping Git submodules setup=1B[0;m
section_end:1593779990:get_sources
=1B[0Ksection_start:1593779990:step_script
=1B[0K=1B[0K=1B[36;1mExecuting "step_script" stage of the job script=1B[0=
;m
=1B[0;m=1B[32;1m$ dnf update -y=1B[0;m
Fedora Modular 31 - x86_64                      4.5 MB/s | 5.2 MB     00:=
01    =

Fedora Modular 31 - x86_64 - Updates            8.2 MB/s | 4.1 MB     00:=
00    =

Fedora 31 - x86_64 - Updates                    1.4 kB/s | 8.1 kB     00:=
05    =

Errors during downloading metadata for repository 'updates':
  - Downloading successful, but checksum doesn't match. Calculated: 0f5fc=
40ff497fe3cc6d2bf47de3d348674864633bd0663bbfc94ee405f737e697306dd1a94c716=
50d1578ce595bcf5b55e1122f4dc7246830cb52ef50e8f26cf(sha512) 0f5fc40ff497fe=
3cc6d2bf47de3d348674864633bd0663bbfc94ee405f737e697306dd1a94c71650d1578ce=
595bcf5b55e1122f4dc7246830cb52ef50e8f26cf(sha512) 0f5fc40ff497fe3cc6d2bf4=
7de3d348674864633bd0663bbfc94ee405f737e697306dd1a94c71650d1578ce595bcf5b5=
5e1122f4dc7246830cb52ef50e8f26cf(sha512)  Expected: c4d63059c930cf5f6574c=
119d7a25d543802581cfb6f175101aa0731f453e73b098b944ef737c7e4d48dde6a3a5607=
49bccc50eb51e4add0e9b67ccd1a4e638d(sha512) 3b1c65ee5ed1e1ab3be4c0170926d2=
415f68ddbd158272ecf51f3da4ad48c935d00a38a891f229bbd452e90e26a21432034e6a7=
2bf8f32bdb162c70955183367(sha512) 149dd4bef3cbe549550616451c11589547eea9f=
2305c72c5b74331dcf7bb86a2b5d6039301e9ff1553731e6daaf11d688b2d62252aa8b076=
ca3b6cab1fb56fcf(sha512) =

  - Downloading successful, but checksum doesn't match. Calculated: c46e0=
cbda8e48c658978e1b426d7753b64112430b24e3e59f51020313ff7e64ec3929eeaec32ba=
7d34998798ca47f84f943b49f92eb4ba10effb5bec81724efb(sha512) c46e0cbda8e48c=
658978e1b426d7753b64112430b24e3e59f51020313ff7e64ec3929eeaec32ba7d3499879=
8ca47f84f943b49f92eb4ba10effb5bec81724efb(sha512) c46e0cbda8e48c658978e1b=
426d7753b64112430b24e3e59f51020313ff7e64ec3929eeaec32ba7d34998798ca47f84f=
943b49f92eb4ba10effb5bec81724efb(sha512)  Expected: c4d63059c930cf5f6574c=
119d7a25d543802581cfb6f175101aa0731f453e73b098b944ef737c7e4d48dde6a3a5607=
49bccc50eb51e4add0e9b67ccd1a4e638d(sha512) 3b1c65ee5ed1e1ab3be4c0170926d2=
415f68ddbd158272ecf51f3da4ad48c935d00a38a891f229bbd452e90e26a21432034e6a7=
2bf8f32bdb162c70955183367(sha512) 149dd4bef3cbe549550616451c11589547eea9f=
2305c72c5b74331dcf7bb86a2b5d6039301e9ff1553731e6daaf11d688b2d62252aa8b076=
ca3b6cab1fb56fcf(sha512) =

Error: Failed to download metadata for repo 'updates': Cannot download re=
pomd.xml: Cannot download repodata/repomd.xml: All mirrors were tried
section_end:1593780000:step_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m


-- =

You're receiving this email because of your account on gitlab.com.




----==_mimepart_5eff3160e15f6_3d7c3fcc510fafe867861
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://ww=
w.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=3D"http://www.w3.org/1999/xhtml" lang=3D"en" xml:lang=3D"en">=

<head>
<meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type" =
/>
<meta content=3D"width=3Ddevice-width, initial-scale=3D1" name=3D"viewpor=
t" />
<meta content=3D"IE=3Dedge" http-equiv=3D"X-UA-Compatible" />
<title>QEMU | Pipeline #162858807 has failed for master | 6651620b</title=
>
<style data-premailer=3D"ignore" type=3D"text/css">
body,table,td,a{-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%}t=
able,td{mso-table-lspace:0pt;mso-table-rspace:0pt}img{-ms-interpolation-m=
ode:bicubic}.hidden{display:none !important;visibility:hidden !important}=
a[x-apple-data-detectors]{color:inherit !important;text-decoration:none !=
important;font-size:inherit !important;font-family:inherit !important;fon=
t-weight:inherit !important;line-height:inherit !important}div[style*=3D'=
margin: 16px 0']{margin:0 !important}@media only screen and (max-width: 6=
39px){body,#body{min-width:320px !important}table.wrapper{width:100% !imp=
ortant;min-width:320px !important}table.wrapper td.wrapper-cell{border-le=
ft:0 !important;border-right:0 !important;border-radius:0 !important;padd=
ing-left:10px !important;padding-right:10px !important}}

</style>

<style>body {
margin: 0 !important; background-color: #fafafa; padding: 0; text-align: =
center; min-width: 640px; width: 100%; height: 100%; font-family: "Helvet=
ica Neue", Helvetica, Arial, sans-serif;
}
</style></head>
<body style=3D"text-align: center; min-width: 640px; width: 100%; height:=
 100%; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-se=
rif; margin: 0; padding: 0;" bgcolor=3D"#fafafa">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" id=3D"body" style=
=3D"text-align: center; min-width: 640px; width: 100%; margin: 0; padding=
: 0;" bgcolor=3D"#fafafa">
<tbody>
<tr class=3D"line">
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif; height: 4px; font-size: 4px; line-height: 4px;" bgcolor=3D"#6b=
4fbb"></td>
</tr>
<tr class=3D"header">
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif; font-size: 13px; line-height: 1.6; color: #5c5c5c; padding: 25=
px 0;">

<img alt=3D"GitLab" src=3D"https://gitlab.com/assets/mailers/gitlab_heade=
r_logo-153749eaa7ea6fafcb995161abd3247bc4c4500f31498b0c4024f50093983ac0.g=
if" width=3D"55" height=3D"50" />
</td>
</tr>
<tr>
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"wrapper"=
 style=3D"width: 640px; border-collapse: separate; border-spacing: 0; mar=
gin: 0 auto;">
<tbody>
<tr>
<td class=3D"wrapper-cell" style=3D"font-family: &quot;Helvetica Neue&quo=
t;, Helvetica, Arial, sans-serif; border-radius: 3px; overflow: hidden; p=
adding: 18px 25px; border: 1px solid #ededed;" align=3D"left" bgcolor=3D"=
#ffffff">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"content"=
 style=3D"width: 100%; border-collapse: separate; border-spacing: 0;">
<tbody>
<tr class=3D"alert">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; bo=
rder-radius: 3px; font-size: 14px; line-height: 1.3; overflow: hidden; co=
lor: #ffffff; padding: 10px;" align=3D"center" bgcolor=3D"#d22f57">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse; margin: 0 auto;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #ffffff; padding-right: 5px; line-height: 1;" align=3D"center" valig=
n=3D"middle">
<img alt=3D"&#10006;" height=3D"13" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-inverted-06edddd39ba2a7f9a32f6201e420=
175db85a4b6ac0348203fdc069001b440149.gif" style=3D"display: block;" width=
=3D"13" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #ffffff;" align=3D"center" valign=3D"middle">
Your pipeline has failed.
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr class=3D"spacer">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; he=
ight: 18px; font-size: 18px; line-height: 18px;">
&#160;
</td>
</tr>
<tr class=3D"section">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; bo=
rder-radius: 3px; overflow: hidden; padding: 0 15px; border: 1px solid #e=
deded;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"table-in=
fo" style=3D"width: 100%;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; margin=
: 0; padding: 14px 0;">Project</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 500; color: #333333; width:=
 75%; margin: 0; padding: 14px 0 14px 5px;">
<a class=3D"muted" href=3D"https://gitlab.com/qemu-project" style=3D"colo=
r: #333333; text-decoration: none;">
QEMU
</a>
/
<a class=3D"muted" href=3D"https://gitlab.com/qemu-project/qemu" style=3D=
"color: #333333; text-decoration: none;">
QEMU
</a>
</td>
</tr>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; border=
-top-width: 1px; border-top-color: #ededed; border-top-style: solid; marg=
in: 0; padding: 14px 0;">Branch</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 500; color: #333333; width:=
 75%; border-top-width: 1px; border-top-color: #ededed; border-top-style:=
 solid; margin: 0; padding: 14px 0 14px 5px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px;" valign=3D"middle">
<img alt=3D"" height=3D"13" src=3D"https://gitlab.com/assets/mailers/ci_p=
ipeline_notif_v1/icon-branch-gray-53618a7fc19d4d32ccbabac2f6d59bebe67202a=
9f2f1255e3f72c69756c0dd9c.gif" style=3D"display: block;" width=3D"13" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4;" valign=3D"middle">
<a class=3D"muted" href=3D"https://gitlab.com/qemu-project/qemu/-/commits=
/master" style=3D"color: #333333; text-decoration: none;">
master
</a>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; border=
-top-width: 1px; border-top-color: #ededed; border-top-style: solid; marg=
in: 0; padding: 14px 0;">Commit</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 400; color: #333333; width:=
 75%; border-top-width: 1px; border-top-color: #ededed; border-top-style:=
 solid; margin: 0; padding: 14px 0 14px 5px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px;" valign=3D"middle">
<img alt=3D"" height=3D"13" src=3D"https://gitlab.com/assets/mailers/ci_p=
ipeline_notif_v1/icon-commit-gray-c10243ac24cde64b549aec91de35e6b49c8739b=
506b86472b54614c10d8b4aac.gif" style=3D"display: block;" width=3D"13" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4;" valign=3D"middle">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/6651620b92bc08cd=
e07cb500e9a43dba7bd9b2b7" style=3D"color: #3777b0; text-decoration: none;=
">
6651620b
</a>
</td>
</tr>
</tbody>
</table>
<div class=3D"commit" style=3D"color: #5c5c5c; font-weight: 300;">
Merge remote-tracking branch 'remotes/kraxel/ta...
</div>
</td>
</tr>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; border=
-top-width: 1px; border-top-color: #ededed; border-top-style: solid; marg=
in: 0; padding: 14px 0;">Commit Author</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 500; color: #333333; width:=
 75%; border-top-width: 1px; border-top-color: #ededed; border-top-style:=
 solid; margin: 0; padding: 14px 0 14px 5px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px;" valign=3D"middle">
<img alt=3D"" class=3D"avatar" height=3D"24" src=3D"https://secure.gravat=
ar.com/avatar/98261ce19b4e9da714d577154686723a?s=3D48&amp;d=3Didenticon" =
style=3D"display: block; border-radius: 12px; margin: -2px 0;" width=3D"2=
4" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4;" valign=3D"middle">
<a class=3D"muted" href=3D"https://gitlab.com/pm215" style=3D"color: #333=
333; text-decoration: none;">
Peter Maydell
</a>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr class=3D"spacer">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; he=
ight: 18px; font-size: 18px; line-height: 18px;">
&#160;
</td>
</tr>
<tr class=3D"pre-section">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #333333; font-size: 15px; font-weight: 400; line-height: 1.4; paddin=
g: 15px 5px 0;" align=3D"center">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse; margin: 0 auto;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; font-weight: 500; line-height: 1.4;" valign=3D"baseline">
Pipeline
<a href=3D"https://gitlab.com/qemu-project/qemu/-/pipelines/162858807" st=
yle=3D"color: #3777b0; text-decoration: none;">
#162858807
</a>
triggered by
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px; padding-left: 5px;" =
width=3D"24" valign=3D"middle">
<img alt=3D"" class=3D"avatar" height=3D"24" src=3D"https://secure.gravat=
ar.com/avatar/a7d7f408c0b3370bbbeb98833d6c50e4?s=3D48&amp;d=3Didenticon" =
style=3D"display: block; border-radius: 12px; margin: -2px 0;" width=3D"2=
4" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; font-weight: 500; line-height: 1.4;" valign=3D"baseline">
<a class=3D"muted" href=3D"https://gitlab.com/stsquad" style=3D"color: #3=
33333; text-decoration: none;">
Alex Benn&#233;e
</a>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr>
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; color: #333333; font-size: 14px; font-weight: 400; line-heigh=
t: 1.4; padding: 0 8px 16px;" align=3D"center">
had
2
failed
builds.
</td>
</tr>
<tr class=3D"table-warning">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; bo=
rder-radius: 4px 4px 0 0; overflow: hidden; color: #d22852; font-size: 14=
px; line-height: 1.4; padding: 8px 16px; border-color: #ededed; border-st=
yle: solid; border-width: 1px 1px 0;" align=3D"center" bgcolor=3D"#fdf4f6=
">
Logs may contain sensitive data. Please consider before forwarding this e=
mail.
</td>
</tr>
<tr class=3D"section">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; ov=
erflow: hidden; border-radius: 0 0 4px 4px; padding: 0 16px; border-color=
: #ededed; border-style: solid; border-width: 0 1px 1px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"builds" =
style=3D"width: 100%; border-collapse: collapse;">
<tbody>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
test
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/623043447" style=3D=
"color: #3777b0; text-decoration: none;">
build-tcg-disabled
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>208      =
...        [12:59:42]             ...              =

208      </span><span class=3D"term-fg-green">pass      </span><span> [12=
:59:42] [12:59:42]   0s               <br />209      ...        [12:59:42=
]             ...              =

209      </span><span class=3D"term-fg-green">pass      </span><span> [12=
:59:42] [12:59:42]   0s               <br />215      ...        [12:59:42=
]             ...              =

215      </span><span class=3D"term-fg-green">pass      </span><span> [12=
:59:42] [13:01:01]  79s               <br />216      ...        [13:01:01=
]             ...              =

216      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:01] [13:01:05]   4s               <br />218      ...        [13:01:05=
]             ...              =

218      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:05] [13:01:07]   2s               <br />222      ...        [13:01:07=
]             ...              =

222      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:07] [13:01:07]   0s               <br />227      ...        [13:01:07=
]             ...              =

227      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:07] [13:01:08]   1s               <br />234      ...        [13:01:08=
]             ...              =

234      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:08] [13:01:08]   0s               <br />246      ...        [13:01:08=
]             ...              =

246      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:08] [13:01:09]   1s               <br />247      ...        [13:01:09=
]             ...              =

247      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:09] [13:01:10]   1s               <br />248      ...        [13:01:10=
]             ...              =

248      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:10] [13:01:10]   0s               <br />250      ...        [13:01:10=
]             ...              =

250      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:10] [13:01:11]   1s               <br />254      ...        [13:01:11=
]             ...              =

254      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:11] [13:01:11]   0s               <br />255      ...        [13:01:11=
]             ...              =

255      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:11] [13:01:13]   2s               <br />257      ...        [13:01:13=
]             ...              =

257      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:13] [13:01:23]  10s               <br />258      ...        [13:01:23=
]             ...              =

258      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:23] [13:01:24]   1s               <br />260      ...        [13:01:24=
]             ...              =

260      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:24] [13:01:25]   1s               <br />261      ...        [13:01:25=
]             ...              =

261      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:25] [13:01:50]  25s               <br />262      ...        [13:01:50=
]             ...              =

262      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:50] [13:01:50]   0s               <br />263      ...        [13:01:50=
]             ...              =

263      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:50] [13:01:53]   3s               <br />264      ...        [13:01:53=
]             ...              =

264      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:53] [13:01:57]   4s               <br />270      ...        [13:01:57=
]             ...              =

270      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:57] [13:01:58]   1s               <br />272      ...        [13:01:58=
]             ...              =

272      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:58] [13:01:59]   1s               <br />273      ...        [13:01:59=
]             ...              =

273      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:59] [13:01:59]   0s               <br />277      ...        [13:01:59=
]             ...              =

277      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:01:59] [13:02:01]   2s               <br />279      ...        [13:02:01=
]             ...              =

279      </span><span class=3D"term-fg-green">pass      </span><span> [13=
:02:01] [13:02:01]   0s               <br />Failures: 051<br />Failed 1 o=
f 57 iotests<br /></span><span class=3D"term-fg-l-red term-bold">ERROR: J=
ob failed: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
test
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/623043445" style=3D=
"color: #3777b0; text-decoration: none;">
build-disabled
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>Running w=
ith gitlab-runner 13.1.0 (6214287e)<br /></span><span>  on docker-auto-sc=
ale 0277ea0f<br /></span><div class=3D"section-start" data-timestamp=3D"1=
593779910" data-section=3D"prepare-executor" role=3D"button"></div><span =
class=3D"term-fg-l-cyan term-bold section section-header js-s-prepare-exe=
cutor">Preparing the "docker+machine" executor</span><span class=3D"secti=
on section-header js-s-prepare-executor"><br /></span><span class=3D"sect=
ion line js-s-prepare-executor">Using Docker executor with image fedora:l=
atest ...<br /></span><span class=3D"section line js-s-prepare-executor">=
Pulling docker image fedora:latest ...<br /></span><span class=3D"section=
 line js-s-prepare-executor">Using docker image sha256:adfbfa4a115a799771=
d3060d0aa213584c91e549187da4fb0036240294ca4a8f for fedora:latest ...<br /=
></span><div class=3D"section-end" data-section=3D"prepare-executor"></di=
v><div class=3D"section-start" data-timestamp=3D"1593779927" data-section=
=3D"prepare-script" role=3D"button"></div><span class=3D"term-fg-l-cyan t=
erm-bold section section-header js-s-prepare-script">Preparing environmen=
t</span><span class=3D"section section-header js-s-prepare-script"><br />=
</span><span class=3D"section line js-s-prepare-script">Running on runner=
-0277ea0f-project-11167699-concurrent-0 via runner-0277ea0f-srm-159377986=
5-df1fb9e9...<br /></span><div class=3D"section-end" data-section=3D"prep=
are-script"></div><div class=3D"section-start" data-timestamp=3D"15937799=
31" data-section=3D"get-sources" role=3D"button"></div><span class=3D"ter=
m-fg-l-cyan term-bold section section-header js-s-get-sources">Getting so=
urce from Git repository</span><span class=3D"section section-header js-s=
-get-sources"><br /></span><span class=3D"term-fg-l-green term-bold secti=
on line js-s-get-sources">$ eval "$CI_PRE_CLONE_SCRIPT"</span><span class=
=3D"section line js-s-get-sources"><br /></span><span class=3D"term-fg-l-=
green term-bold section line js-s-get-sources">Fetching changes...</span>=
<span class=3D"section line js-s-get-sources"><br />Initialized empty Git=
 repository in /builds/qemu-project/qemu/.git/<br /></span><span class=3D=
"term-fg-l-green term-bold section line js-s-get-sources">Created fresh r=
epository.</span><span class=3D"section line js-s-get-sources"><br /></sp=
an><span class=3D"term-fg-l-green term-bold section line js-s-get-sources=
">Checking out 6651620b as master...</span><span class=3D"section line js=
-s-get-sources"><br /><br /></span><span class=3D"term-fg-l-green term-bo=
ld section line js-s-get-sources">Skipping Git submodules setup</span><sp=
an class=3D"section line js-s-get-sources"><br /></span><div class=3D"sec=
tion-end" data-section=3D"get-sources"></div><div class=3D"section-start"=
 data-timestamp=3D"1593779990" data-section=3D"step-script" role=3D"butto=
n"></div><span class=3D"term-fg-l-cyan term-bold section section-header j=
s-s-step-script">Executing "step_script" stage of the job script</span><s=
pan class=3D"section section-header js-s-step-script"><br /></span><span =
class=3D"term-fg-l-green term-bold section line js-s-step-script">$ dnf u=
pdate -y</span><span class=3D"section line js-s-step-script"><br />Fedora=
 Modular 31 - x86_64                      4.5 MB/s | 5.2 MB     00:01    =
<br />Fedora Modular 31 - x86_64 - Updates            8.2 MB/s | 4.1 MB  =
   00:00    <br />Fedora 31 - x86_64 - Updates                    1.4 kB/=
s | 8.1 kB     00:05    <br />Errors during downloading metadata for repo=
sitory 'updates':<br />  - Downloading successful, but checksum doesn't m=
atch. Calculated: 0f5fc40ff497fe3cc6d2bf47de3d348674864633bd0663bbfc94ee4=
05f737e697306dd1a94c71650d1578ce595bcf5b55e1122f4dc7246830cb52ef50e8f26cf=
(sha512) 0f5fc40ff497fe3cc6d2bf47de3d348674864633bd0663bbfc94ee405f737e69=
7306dd1a94c71650d1578ce595bcf5b55e1122f4dc7246830cb52ef50e8f26cf(sha512) =
0f5fc40ff497fe3cc6d2bf47de3d348674864633bd0663bbfc94ee405f737e697306dd1a9=
4c71650d1578ce595bcf5b55e1122f4dc7246830cb52ef50e8f26cf(sha512)  Expected=
: c4d63059c930cf5f6574c119d7a25d543802581cfb6f175101aa0731f453e73b098b944=
ef737c7e4d48dde6a3a560749bccc50eb51e4add0e9b67ccd1a4e638d(sha512) 3b1c65e=
e5ed1e1ab3be4c0170926d2415f68ddbd158272ecf51f3da4ad48c935d00a38a891f229bb=
d452e90e26a21432034e6a72bf8f32bdb162c70955183367(sha512) 149dd4bef3cbe549=
550616451c11589547eea9f2305c72c5b74331dcf7bb86a2b5d6039301e9ff1553731e6da=
af11d688b2d62252aa8b076ca3b6cab1fb56fcf(sha512) <br />  - Downloading suc=
cessful, but checksum doesn't match. Calculated: c46e0cbda8e48c658978e1b4=
26d7753b64112430b24e3e59f51020313ff7e64ec3929eeaec32ba7d34998798ca47f84f9=
43b49f92eb4ba10effb5bec81724efb(sha512) c46e0cbda8e48c658978e1b426d7753b6=
4112430b24e3e59f51020313ff7e64ec3929eeaec32ba7d34998798ca47f84f943b49f92e=
b4ba10effb5bec81724efb(sha512) c46e0cbda8e48c658978e1b426d7753b64112430b2=
4e3e59f51020313ff7e64ec3929eeaec32ba7d34998798ca47f84f943b49f92eb4ba10eff=
b5bec81724efb(sha512)  Expected: c4d63059c930cf5f6574c119d7a25d543802581c=
fb6f175101aa0731f453e73b098b944ef737c7e4d48dde6a3a560749bccc50eb51e4add0e=
9b67ccd1a4e638d(sha512) 3b1c65ee5ed1e1ab3be4c0170926d2415f68ddbd158272ecf=
51f3da4ad48c935d00a38a891f229bbd452e90e26a21432034e6a72bf8f32bdb162c70955=
183367(sha512) 149dd4bef3cbe549550616451c11589547eea9f2305c72c5b74331dcf7=
bb86a2b5d6039301e9ff1553731e6daaf11d688b2d62252aa8b076ca3b6cab1fb56fcf(sh=
a512) <br />Error: Failed to download metadata for repo 'updates': Cannot=
 download repomd.xml: Cannot download repodata/repomd.xml: All mirrors we=
re tried<br /></span><div class=3D"section-end" data-section=3D"step-scri=
pt"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: exit=
 code 1<br /></span></pre>
</td>
</tr>
</tbody>
</table>
</td>
</tr>


</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>

<tr class=3D"footer">
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif; font-size: 13px; line-height: 1.6; color: #5c5c5c; padding: 25=
px 0;">
<img alt=3D"GitLab" height=3D"33" src=3D"https://gitlab.com/assets/mailer=
s/gitlab_footer_logo-078860f148cc9596195e6bb3fa7db31c30538355576c5c3b569c=
414902e3d095.gif" width=3D"90" style=3D"display: block; margin: 0 auto 1e=
m;" />
<div>
You're receiving this email because of your account on gitlab.com. <a cla=
ss=3D"mng-notif-link" href=3D"https://gitlab.com/profile/notifications" s=
tyle=3D"color: #3777b0; text-decoration: none;">Manage all notifications<=
/a> &#183; <a class=3D"help-link" href=3D"https://gitlab.com/help" style=3D=
"color: #3777b0; text-decoration: none;">Help</a>
</div>
</td>
</tr>

<tr>
<td class=3D"footer-message" style=3D"font-family: &quot;Helvetica Neue&q=
uot;, Helvetica, Arial, sans-serif; font-size: 13px; line-height: 1.6; co=
lor: #5c5c5c; padding: 25px 0;">

</td>
</tr>
</tbody>
</table>
</body>
</html>

----==_mimepart_5eff3160e15f6_3d7c3fcc510fafe867861--

