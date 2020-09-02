Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB4C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA6920678
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.gitlab.com header.i=@mg.gitlab.com header.b="gytvnTou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA6920678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUnp-0002GW-Ka
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1kDUmd-0001Pz-7V
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:34:47 -0400
Received: from do158-143.mg.gitlab.com ([192.237.158.143]:55804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1kDUmY-0003C7-6v
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:34:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.gitlab.com;
 q=dns/txt; 
 s=mailo; t=1599060884; h=List-Id: Content-Transfer-Encoding:
 Content-Type: Mime-Version: Subject: Message-ID: Reply-To: From: Date:
 Sender; bh=Y+uKBCJrOlsBEtXYO4kNx3FHNAYWD+RU43eeYX/RCvI=;
 b=gytvnTouw0zvIgMCR4jBNrRiYJLe+zCwXJljGM4vwyyho13BFzGj9tIq1LIZh3MyfhNTSEZN
 bdaDJVLQIsvx+ujlrDfngf607G6fL3sAmldWunaM0Aeo9UK+R5f3Wn6+Y3gp5MN2ijhl87+d
 rp5/nSY7qqCSAkIY/gWBzx8SZhc=
X-Mailgun-Sending-Ip: 192.237.158.143
X-Mailgun-Sid: WyI3MWYzYSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOTQ3YjQiXQ==
Received: from mg.gitlab.com (77.90.74.34.bc.googleusercontent.com
 [34.74.90.77]) by smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f4fbb7925e1ee7586ccf486 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Wed, 02 Sep 2020 15:34:17 GMT
Date: Wed, 02 Sep 2020 15:34:15 +0000
Message-ID: <5f4fbb77e7d7d_19ad3faf0435968c2319e6@sidekiq-catchall-06-sv-gprd.mail>
Subject: QEMU | Pipeline #184857844 has failed for master | 7068d5ef
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_5f4fbb77da7d2_19ad3faf0435968c2318e7";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitLab-Project: QEMU
X-GitLab-Project-Id: 11167699
X-GitLab-Project-Path: qemu-project/qemu
X-GitLab-Pipeline-Id: 184857844
X-GitLab-Pipeline-Ref: master
X-GitLab-Pipeline-Status: failed
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
Received-SPF: pass client-ip=192.237.158.143;
 envelope-from=bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com;
 helo=do158-143.mg.gitlab.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:06:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, REPLYTO_WITHOUT_TO_CC=1.552,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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


----==_mimepart_5f4fbb77da7d2_19ad3faf0435968c2318e7
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Your pipeline has failed.

Project: QEMU ( https://gitlab.com/qemu-project/qemu )
Branch: master ( https://gitlab.com/qemu-project/qemu/-/commits/master )

Commit: 7068d5ef ( https://gitlab.com/qemu-project/qemu/-/commit/7068d5ef=
399b4682d9ad77164d700fcca3c77485 )
Commit Message: Merge remote-tracking branch 'remotes/rth/tags/...
Commit Author: Peter Maydell ( https://gitlab.com/pm215 )

Pipeline #184857844 ( https://gitlab.com/qemu-project/qemu/-/pipelines/18=
4857844 ) triggered by Alex Benn=C3=A9e ( https://gitlab.com/stsquad )
had 2 failed builds.

Job #716158591 ( https://gitlab.com/qemu-project/qemu/-/jobs/716158591/ra=
w )

Stage: test
Name: acceptance-system-centos
Trace: 15:23:30 ERROR|   File "/builds/qemu-project/qemu/python/qemu/mach=
ine.py", line 342, in launch
    self._launch()

15:23:30 ERROR|   File "/builds/qemu-project/qemu/python/qemu/machine.py"=
, line 369, in _launch
    self._post_launch()

15:23:30 ERROR|   File "/builds/qemu-project/qemu/python/qemu/machine.py"=
, line 288, in _post_launch
    self._qmp.accept()

15:23:30 ERROR|   File "/builds/qemu-project/qemu/python/qemu/qmp.py", li=
ne 236, in accept
    return self.__negotiate_capabilities()

15:23:30 ERROR|   File "/builds/qemu-project/qemu/python/qemu/qmp.py", li=
ne 129, in __negotiate_capabilities
    resp =3D self.cmd('qmp_capabilities')

15:23:30 ERROR|   File "/builds/qemu-project/qemu/python/qemu/qmp.py", li=
ne 266, in cmd
    return self.cmd_obj(qmp_cmd)

15:23:30 ERROR|   File "/builds/qemu-project/qemu/python/qemu/qmp.py", li=
ne 249, in cmd_obj
    raise QMPConnectError("Unexpected empty reply from server")

15:23:30 ERROR| qemu.qmp.QMPConnectError: Unexpected empty reply from ser=
ver

15:23:30 ERROR| ERROR 34-tests/acceptance/vnc.py:Vnc.test_change_password=
 -> QMPConnectError: Unexpected empty reply from server
15:23:30 INFO | =

=1B[32;1m$ du -chs ${CI_PROJECT_DIR}/avocado-cache=1B[0;m
1.2G	/builds/qemu-project/qemu/avocado-cache
1.2G	total
section_end:1599060216:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #716158589 ( https://gitlab.com/qemu-project/qemu/-/jobs/716158589/ra=
w )

Stage: test
Name: acceptance-system-fedora
Trace: 15:19:09 ERROR| =

15:19:09 ERROR| Reproduced traceback from: /builds/qemu-project/qemu/buil=
d/tests/venv/lib64/python3.8/site-packages/avocado/core/test.py:846
15:19:09 ERROR| Traceback (most recent call last):
15:19:09 ERROR|   File "/builds/qemu-project/qemu/build/tests/acceptance/=
avocado_qemu/__init__.py", line 171, in setUp
15:19:09 ERROR|     self.cancel("No QEMU binary defined or found in the b=
uild tree")
15:19:09 ERROR|   File "/builds/qemu-project/qemu/build/tests/venv/lib64/=
python3.8/site-packages/avocado/core/test.py", line 1081, in cancel
15:19:09 ERROR|     raise exceptions.TestCancel(message)
15:19:09 ERROR| avocado.core.exceptions.TestCancel: No QEMU binary define=
d or found in the build tree
15:19:09 ERROR| =

15:19:09 ERROR| CANCEL 31-tests/acceptance/vnc.py:Vnc.test_change_passwor=
d_requires_a_password -> TestCancel: No QEMU binary defined or found in t=
he build tree
15:19:09 INFO | =

15:19:09 DEBUG| PARAMS (key=3Darch, path=3D*, default=3DNone) =3D> None
15:19:09 DEBUG| PARAMS (key=3Dmachine, path=3D*, default=3DNone) =3D> Non=
e
15:19:09 DEBUG| PARAMS (key=3Dqemu_bin, path=3D*, default=3DNone) =3D> No=
ne
15:19:09 ERROR| =

15:19:09 ERROR| Reproduced traceback from: /builds/qemu-project/qemu/buil=
d/tests/venv/lib64/python3.8/site-packages/avocado/core/test.py:846
15:19:09 ERROR| Traceback (most recent call last):
15:19:09 ERROR|   File "/builds/qemu-project/qemu/build/tests/acceptance/=
avocado_qemu/__init__.py", line 171, in setUp
15:19:09 ERROR|     self.cancel("No QEMU binary defined or found in the b=
uild tree")
15:19:09 ERROR|   File "/builds/qemu-project/qemu/build/tests/venv/lib64/=
python3.8/site-packages/avocado/core/test.py", line 1081, in cancel
15:19:09 ERROR|     raise exceptions.TestCancel(message)
15:19:09 ERROR| avocado.core.exceptions.TestCancel: No QEMU binary define=
d or found in the build tree
15:19:09 ERROR| =

15:19:09 ERROR| CANCEL 32-tests/acceptance/vnc.py:Vnc.test_change_passwor=
d -> TestCancel: No QEMU binary defined or found in the build tree
15:19:09 INFO | =

=1B[32;1m$ du -chs ${CI_PROJECT_DIR}/avocado-cache=1B[0;m
323M	/builds/qemu-project/qemu/avocado-cache
323M	total
section_end:1599059952:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m


-- =

You're receiving this email because of your account on gitlab.com.




----==_mimepart_5f4fbb77da7d2_19ad3faf0435968c2318e7
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
<title>QEMU | Pipeline #184857844 has failed for master | 7068d5ef</title=
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
#fff">
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/7068d5ef399b4682=
d9ad77164d700fcca3c77485" style=3D"color: #3777b0; text-decoration: none;=
">
7068d5ef
</a>
</td>
</tr>
</tbody>
</table>
<div class=3D"commit" style=3D"color: #5c5c5c; font-weight: 300;">
Merge remote-tracking branch 'remotes/rth/tags/...
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/pipelines/184857844" st=
yle=3D"color: #3777b0; text-decoration: none;">
#184857844
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/716158591" style=3D=
"color: #3777b0; text-decoration: none;">
acceptance-system-centos
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>15:23:30 =
ERROR|   File "/builds/qemu-project/qemu/python/qemu/machine.py", line 34=
2, in launch<br />    self._launch()<br /><br />15:23:30 ERROR|   File "/=
builds/qemu-project/qemu/python/qemu/machine.py", line 369, in _launch<br=
 />    self._post_launch()<br /><br />15:23:30 ERROR|   File "/builds/qem=
u-project/qemu/python/qemu/machine.py", line 288, in _post_launch<br />  =
  self._qmp.accept()<br /><br />15:23:30 ERROR|   File "/builds/qemu-proj=
ect/qemu/python/qemu/qmp.py", line 236, in accept<br />    return self.__=
negotiate_capabilities()<br /><br />15:23:30 ERROR|   File "/builds/qemu-=
project/qemu/python/qemu/qmp.py", line 129, in __negotiate_capabilities<b=
r />    resp =3D self.cmd('qmp_capabilities')<br /><br />15:23:30 ERROR| =
  File "/builds/qemu-project/qemu/python/qemu/qmp.py", line 266, in cmd<b=
r />    return self.cmd_obj(qmp_cmd)<br /><br />15:23:30 ERROR|   File "/=
builds/qemu-project/qemu/python/qemu/qmp.py", line 249, in cmd_obj<br /> =
   raise QMPConnectError("Unexpected empty reply from server")<br /><br /=
>15:23:30 ERROR| qemu.qmp.QMPConnectError: Unexpected empty reply from se=
rver<br /><br />15:23:30 ERROR| ERROR 34-tests/acceptance/vnc.py:Vnc.test=
_change_password -&gt; QMPConnectError: Unexpected empty reply from serve=
r<br />15:23:30 INFO | <br /></span><span class=3D"term-fg-l-green term-b=
old">$ du -chs ${CI_PROJECT_DIR}/avocado-cache</span><span><br />1.2G	/bu=
ilds/qemu-project/qemu/avocado-cache<br />1.2G	total<br /></span><span cl=
ass=3D"term-fg-l-red term-bold">ERROR: Job failed: exit code 1<br /></spa=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/716158589" style=3D=
"color: #3777b0; text-decoration: none;">
acceptance-system-fedora
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>15:19:09 =
ERROR| <br />15:19:09 ERROR| Reproduced traceback from: /builds/qemu-proj=
ect/qemu/build/tests/venv/lib64/python3.8/site-packages/avocado/core/test=
.py:846<br />15:19:09 ERROR| Traceback (most recent call last):<br />15:1=
9:09 ERROR|   File "/builds/qemu-project/qemu/build/tests/acceptance/avoc=
ado_qemu/__init__.py", line 171, in setUp<br />15:19:09 ERROR|     self.c=
ancel("No QEMU binary defined or found in the build tree")<br />15:19:09 =
ERROR|   File "/builds/qemu-project/qemu/build/tests/venv/lib64/python3.8=
/site-packages/avocado/core/test.py", line 1081, in cancel<br />15:19:09 =
ERROR|     raise exceptions.TestCancel(message)<br />15:19:09 ERROR| avoc=
ado.core.exceptions.TestCancel: No QEMU binary defined or found in the bu=
ild tree<br />15:19:09 ERROR| <br />15:19:09 ERROR| CANCEL 31-tests/accep=
tance/vnc.py:Vnc.test_change_password_requires_a_password -&gt; TestCance=
l: No QEMU binary defined or found in the build tree<br />15:19:09 INFO |=
 <br />15:19:09 DEBUG| PARAMS (key=3Darch, path=3D*, default=3DNone) =3D&=
gt; None<br />15:19:09 DEBUG| PARAMS (key=3Dmachine, path=3D*, default=3D=
None) =3D&gt; None<br />15:19:09 DEBUG| PARAMS (key=3Dqemu_bin, path=3D*,=
 default=3DNone) =3D&gt; None<br />15:19:09 ERROR| <br />15:19:09 ERROR| =
Reproduced traceback from: /builds/qemu-project/qemu/build/tests/venv/lib=
64/python3.8/site-packages/avocado/core/test.py:846<br />15:19:09 ERROR| =
Traceback (most recent call last):<br />15:19:09 ERROR|   File "/builds/q=
emu-project/qemu/build/tests/acceptance/avocado_qemu/__init__.py", line 1=
71, in setUp<br />15:19:09 ERROR|     self.cancel("No QEMU binary defined=
 or found in the build tree")<br />15:19:09 ERROR|   File "/builds/qemu-p=
roject/qemu/build/tests/venv/lib64/python3.8/site-packages/avocado/core/t=
est.py", line 1081, in cancel<br />15:19:09 ERROR|     raise exceptions.T=
estCancel(message)<br />15:19:09 ERROR| avocado.core.exceptions.TestCance=
l: No QEMU binary defined or found in the build tree<br />15:19:09 ERROR|=
 <br />15:19:09 ERROR| CANCEL 32-tests/acceptance/vnc.py:Vnc.test_change_=
password -&gt; TestCancel: No QEMU binary defined or found in the build t=
ree<br />15:19:09 INFO | <br /></span><span class=3D"term-fg-l-green term=
-bold">$ du -chs ${CI_PROJECT_DIR}/avocado-cache</span><span><br />323M	/=
builds/qemu-project/qemu/avocado-cache<br />323M	total<br /></span><span =
class=3D"term-fg-l-red term-bold">ERROR: Job failed: exit code 1<br /></s=
pan></pre>
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

----==_mimepart_5f4fbb77da7d2_19ad3faf0435968c2318e7--

