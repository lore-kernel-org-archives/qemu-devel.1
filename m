Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C247EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CBF20716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.gitlab.com header.i=@mg.gitlab.com header.b="eOnxrVs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CBF20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJUX-0001Z4-IN
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1jnJTg-00017b-2d
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:15:00 -0400
Received: from do158-143.mg.gitlab.com ([192.237.158.143]:23112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1jnJTc-0000ln-E0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:14:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.gitlab.com;
 q=dns/txt; 
 s=mailo; t=1592820897; h=List-Id: Content-Transfer-Encoding:
 Content-Type: Mime-Version: Subject: Message-ID: Reply-To: From: Date:
 Sender; bh=ExHDBc54EnszINXhUdICQZfh0klYsmrtTX/9XlNpuxI=;
 b=eOnxrVs+tG5T9NICRo64PFOZNqTYN/UhdO/80f5WqDjzTM7jZA9lmcrNsjT52lHLAUzdJWpf
 tKQqXPVtMciAtCdHhr/2C2IBP4OFnrBE0JytOZQv7kGNPbAwhpgBv5wrYNLUNxJe/9ooL5JK
 hr2xHTegMu2BaYVHCvHfI9Cpxr0=
X-Mailgun-Sending-Ip: 192.237.158.143
X-Mailgun-Sid: WyI3MWYzYSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOTQ3YjQiXQ==
Received: from mg.gitlab.com (69.90.74.34.bc.googleusercontent.com
 [34.74.90.69]) by smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ef084943a8a8b20b8d66a13 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 22 Jun 2020 10:14:44 GMT
Date: Mon, 22 Jun 2020 10:14:42 +0000
Message-ID: <5ef08492e64b7_2be83fb856c2b00c34739c@sidekiq-catchall-06-sv-gprd.mail>
Subject: QEMU | Pipeline #158179489 has failed for master | 06c4cc36
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_5ef08492dab1a_2be83fb856c2b00c34728f";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitLab-Project: QEMU
X-GitLab-Project-Id: 11167699
X-GitLab-Project-Path: qemu-project/qemu
X-GitLab-Pipeline-Id: 158179489
X-GitLab-Pipeline-Ref: master
X-GitLab-Pipeline-Status: failed
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
Received-SPF: pass client-ip=192.237.158.143;
 envelope-from=bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com;
 helo=do158-143.mg.gitlab.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:58:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_BL=0.01, RCVD_IN_MSPIKE_L5=2.5,
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


----==_mimepart_5ef08492dab1a_2be83fb856c2b00c34728f
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Your pipeline has failed.

Project: QEMU ( https://gitlab.com/qemu-project/qemu )
Branch: master ( https://gitlab.com/qemu-project/qemu/-/commits/master )

Commit: 06c4cc36 ( https://gitlab.com/qemu-project/qemu/-/commit/06c4cc36=
60b366278bdc7bc8b6677032d7b1118c )
Commit Message: qht: Fix threshold rate calculation

tests/qht-...
Commit Author: Richard Henderson ( https://gitlab.com/rth7680 )
Committed by: Peter Maydell ( https://gitlab.com/pm215 )

Pipeline #158179489 ( https://gitlab.com/qemu-project/qemu/-/pipelines/15=
8179489 ) triggered by Alex Benn=C3=A9e ( https://gitlab.com/stsquad )
had 2 failed builds.

Job #605436374 ( https://gitlab.com/qemu-project/qemu/-/jobs/605436374/ra=
w )

Stage: test
Name: build-disabled
Trace: qemu-system-i386: falling back to tcg
Could not access KVM kernel module: No such file or directory
qemu-system-i386: -accel kvm: failed to initialize kvm: No such file or d=
irectory
qemu-system-i386: falling back to tcg
  TEST    check-qtest-i386: tests/qtest/device-introspect-test
  TEST    check-qtest-i386: tests/qtest/machine-none-test
  TEST    check-qtest-i386: tests/qtest/qmp-test
  TEST    check-qtest-i386: tests/qtest/qmp-cmd-test
  TEST    check-qtest-i386: tests/qtest/qom-test
  TEST    check-qtest-i386: tests/qtest/test-hmp
  TEST    check-qtest-i386: tests/qtest/qos-test
  TEST    check-qtest-mips64: tests/qtest/endianness-test
  TEST    check-qtest-mips64: tests/qtest/display-vga-test
  TEST    check-qtest-mips64: tests/qtest/cdrom-test
  TEST    check-qtest-mips64: tests/qtest/device-introspect-test
  TEST    check-qtest-mips64: tests/qtest/machine-none-test
  TEST    check-qtest-mips64: tests/qtest/qmp-test
  TEST    check-qtest-mips64: tests/qtest/qmp-cmd-test
  TEST    check-qtest-mips64: tests/qtest/qom-test
  TEST    check-qtest-mips64: tests/qtest/test-hmp
  TEST    check-qtest-mips64: tests/qtest/qos-test
qemu-system-ppc64: warning: machine has no BMC device. Use '-device ipmi-=
bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device ipmi-=
bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device ipmi-=
bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define one
  TEST    check-qtest-ppc64: tests/qtest/machine-none-test
  TEST    check-qtest-ppc64: tests/qtest/qmp-test
  TEST    check-qtest-ppc64: tests/qtest/qmp-cmd-test
  TEST    check-qtest-ppc64: tests/qtest/qom-test
section_end:1592820790:step_script
=1B[0K=1B[31;1mERROR: Job failed: execution took longer than 1h0m0s secon=
ds
=1B[0;m

Job #603546725 ( https://gitlab.com/qemu-project/qemu/-/jobs/603546725/ra=
w )

Stage: test
Name: build-tcg-disabled
Trace: 208      ...        [19:33:53]             ...              =

208      =1B[32mpass      =1B[0m [19:33:53] [19:33:53]   0s              =
 =

209      ...        [19:33:53]             ...              =

209      =1B[32mpass      =1B[0m [19:33:53] [19:33:54]   1s              =
 =

215      ...        [19:33:54]             ...              =

215      =1B[32mpass      =1B[0m [19:33:54] [19:35:15]  81s              =
 =

216      ...        [19:35:15]             ...              =

216      =1B[32mpass      =1B[0m [19:35:15] [19:35:19]   4s              =
 =

218      ...        [19:35:19]             ...              =

218      =1B[32mpass      =1B[0m [19:35:19] [19:35:20]   1s              =
 =

222      ...        [19:35:20]             ...              =

222      =1B[32mpass      =1B[0m [19:35:20] [19:35:21]   1s              =
 =

227      ...        [19:35:21]             ...              =

227      =1B[32mpass      =1B[0m [19:35:21] [19:35:21]   0s              =
 =

234      ...        [19:35:21]             ...              =

234      =1B[32mpass      =1B[0m [19:35:21] [19:35:22]   1s              =
 =

246      ...        [19:35:22]             ...              =

246      =1B[32mpass      =1B[0m [19:35:22] [19:35:23]   1s              =
 =

247      ...        [19:35:23]             ...              =

247      =1B[32mpass      =1B[0m [19:35:23] [19:35:24]   1s              =
 =

248      ...        [19:35:24]             ...              =

248      =1B[32mpass      =1B[0m [19:35:24] [19:35:24]   0s              =
 =

250      ...        [19:35:24]             ...              =

250      =1B[32mpass      =1B[0m [19:35:24] [19:35:25]   1s              =
 =

254      ...        [19:35:25]             ...              =

254      =1B[32mpass      =1B[0m [19:35:25] [19:35:25]   0s              =
 =

255      ...        [19:35:25]             ...              =

255      =1B[32mpass      =1B[0m [19:35:25] [19:35:27]   2s              =
 =

257      ...        [19:35:27]             ...              =

257      =1B[32mpass      =1B[0m [19:35:27] [19:35:37]  10s              =
 =

258      ...        [19:35:37]             ...              =

258      =1B[32mpass      =1B[0m [19:35:37] [19:35:38]   1s              =
 =

260      ...        [19:35:38]             ...              =

260      =1B[32mpass      =1B[0m [19:35:38] [19:35:38]   0s              =
 =

261      ...        [19:35:38]             ...              =

261      =1B[32mpass      =1B[0m [19:35:38] [19:36:03]  25s              =
 =

262      ...        [19:36:03]             ...              =

262      =1B[32mpass      =1B[0m [19:36:03] [19:36:04]   1s              =
 =

263      ...        [19:36:04]             ...              =

263      =1B[32mpass      =1B[0m [19:36:04] [19:36:06]   2s              =
 =

264      ...        [19:36:06]             ...              =

264      =1B[32mpass      =1B[0m [19:36:06] [19:36:10]   4s              =
 =

270      ...        [19:36:10]             ...              =

270      =1B[32mpass      =1B[0m [19:36:10] [19:36:12]   2s              =
 =

272      ...        [19:36:12]             ...              =

272      =1B[32mpass      =1B[0m [19:36:12] [19:36:13]   1s              =
 =

273      ...        [19:36:13]             ...              =

273      =1B[32mpass      =1B[0m [19:36:13] [19:36:13]   0s              =
 =

277      ...        [19:36:13]             ...              =

277      =1B[32mpass      =1B[0m [19:36:13] [19:36:14]   1s              =
 =

279      ...        [19:36:14]             ...              =

279      =1B[32mpass      =1B[0m [19:36:14] [19:36:14]   0s              =
 =

Failures: 051
Failed 1 of 57 iotests
section_end:1592595388:step_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m


-- =

You're receiving this email because of your account on gitlab.com.




----==_mimepart_5ef08492dab1a_2be83fb856c2b00c34728f
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
<title>QEMU | Pipeline #158179489 has failed for master | 06c4cc36</title=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/06c4cc3660b36627=
8bdc7bc8b6677032d7b1118c" style=3D"color: #3777b0; text-decoration: none;=
">
06c4cc36
</a>
</td>
</tr>
</tbody>
</table>
<div class=3D"commit" style=3D"color: #5c5c5c; font-weight: 300;">
qht: Fix threshold rate calculation

tests/qht-...
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
ar.com/avatar/b725160a480d51c1f98761d799d7a682?s=3D48&amp;d=3Didenticon" =
style=3D"display: block; border-radius: 12px; margin: -2px 0;" width=3D"2=
4" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4;" valign=3D"middle">
<a class=3D"muted" href=3D"https://gitlab.com/rth7680" style=3D"color: #3=
33333; text-decoration: none;">
Richard Henderson
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
in: 0; padding: 14px 0;">Committed by</td>
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/pipelines/158179489" st=
yle=3D"color: #3777b0; text-decoration: none;">
#158179489
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/605436374" style=3D=
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
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>qemu-syst=
em-i386: falling back to tcg<br />Could not access KVM kernel module: No =
such file or directory<br />qemu-system-i386: -accel kvm: failed to initi=
alize kvm: No such file or directory<br />qemu-system-i386: falling back =
to tcg<br />  TEST    check-qtest-i386: tests/qtest/device-introspect-tes=
t<br />  TEST    check-qtest-i386: tests/qtest/machine-none-test<br />  T=
EST    check-qtest-i386: tests/qtest/qmp-test<br />  TEST    check-qtest-=
i386: tests/qtest/qmp-cmd-test<br />  TEST    check-qtest-i386: tests/qte=
st/qom-test<br />  TEST    check-qtest-i386: tests/qtest/test-hmp<br />  =
TEST    check-qtest-i386: tests/qtest/qos-test<br />  TEST    check-qtest=
-mips64: tests/qtest/endianness-test<br />  TEST    check-qtest-mips64: t=
ests/qtest/display-vga-test<br />  TEST    check-qtest-mips64: tests/qtes=
t/cdrom-test<br />  TEST    check-qtest-mips64: tests/qtest/device-intros=
pect-test<br />  TEST    check-qtest-mips64: tests/qtest/machine-none-tes=
t<br />  TEST    check-qtest-mips64: tests/qtest/qmp-test<br />  TEST    =
check-qtest-mips64: tests/qtest/qmp-cmd-test<br />  TEST    check-qtest-m=
ips64: tests/qtest/qom-test<br />  TEST    check-qtest-mips64: tests/qtes=
t/test-hmp<br />  TEST    check-qtest-mips64: tests/qtest/qos-test<br />q=
emu-system-ppc64: warning: machine has no BMC device. Use '-device ipmi-b=
mc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define one<b=
r />qemu-system-ppc64: warning: machine has no BMC device. Use '-device i=
pmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define =
one<br />qemu-system-ppc64: warning: machine has no BMC device. Use '-dev=
ice ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to de=
fine one<br />  TEST    check-qtest-ppc64: tests/qtest/machine-none-test<=
br />  TEST    check-qtest-ppc64: tests/qtest/qmp-test<br />  TEST    che=
ck-qtest-ppc64: tests/qtest/qmp-cmd-test<br />  TEST    check-qtest-ppc64=
: tests/qtest/qom-test<br /></span><span class=3D"term-fg-l-red term-bold=
">ERROR: Job failed: execution took longer than 1h0m0s seconds<br /></spa=
n></pre>
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/603546725" style=3D=
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
...        [19:33:53]             ...              =

208      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:33:53] [19:33:53]   0s               <br />209      ...        [19:33:53=
]             ...              =

209      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:33:53] [19:33:54]   1s               <br />215      ...        [19:33:54=
]             ...              =

215      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:33:54] [19:35:15]  81s               <br />216      ...        [19:35:15=
]             ...              =

216      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:15] [19:35:19]   4s               <br />218      ...        [19:35:19=
]             ...              =

218      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:19] [19:35:20]   1s               <br />222      ...        [19:35:20=
]             ...              =

222      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:20] [19:35:21]   1s               <br />227      ...        [19:35:21=
]             ...              =

227      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:21] [19:35:21]   0s               <br />234      ...        [19:35:21=
]             ...              =

234      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:21] [19:35:22]   1s               <br />246      ...        [19:35:22=
]             ...              =

246      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:22] [19:35:23]   1s               <br />247      ...        [19:35:23=
]             ...              =

247      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:23] [19:35:24]   1s               <br />248      ...        [19:35:24=
]             ...              =

248      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:24] [19:35:24]   0s               <br />250      ...        [19:35:24=
]             ...              =

250      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:24] [19:35:25]   1s               <br />254      ...        [19:35:25=
]             ...              =

254      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:25] [19:35:25]   0s               <br />255      ...        [19:35:25=
]             ...              =

255      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:25] [19:35:27]   2s               <br />257      ...        [19:35:27=
]             ...              =

257      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:27] [19:35:37]  10s               <br />258      ...        [19:35:37=
]             ...              =

258      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:37] [19:35:38]   1s               <br />260      ...        [19:35:38=
]             ...              =

260      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:38] [19:35:38]   0s               <br />261      ...        [19:35:38=
]             ...              =

261      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:35:38] [19:36:03]  25s               <br />262      ...        [19:36:03=
]             ...              =

262      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:03] [19:36:04]   1s               <br />263      ...        [19:36:04=
]             ...              =

263      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:04] [19:36:06]   2s               <br />264      ...        [19:36:06=
]             ...              =

264      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:06] [19:36:10]   4s               <br />270      ...        [19:36:10=
]             ...              =

270      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:10] [19:36:12]   2s               <br />272      ...        [19:36:12=
]             ...              =

272      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:12] [19:36:13]   1s               <br />273      ...        [19:36:13=
]             ...              =

273      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:13] [19:36:13]   0s               <br />277      ...        [19:36:13=
]             ...              =

277      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:13] [19:36:14]   1s               <br />279      ...        [19:36:14=
]             ...              =

279      </span><span class=3D"term-fg-green">pass      </span><span> [19=
:36:14] [19:36:14]   0s               <br />Failures: 051<br />Failed 1 o=
f 57 iotests<br /></span><span class=3D"term-fg-l-red term-bold">ERROR: J=
ob failed: exit code 1<br /></span></pre>
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

----==_mimepart_5ef08492dab1a_2be83fb856c2b00c34728f--

