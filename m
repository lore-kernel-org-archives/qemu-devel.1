Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCBAC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA43206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lRarsm2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA43206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9w4-00007p-4O
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liewkj@yahoo.com>) id 1is9u6-00070H-Gj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liewkj@yahoo.com>) id 1is9u2-0000CY-5J
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:30:02 -0500
Received: from sonic302-49.consmr.mail.ne1.yahoo.com ([66.163.186.175]:34773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liewkj@yahoo.com>) id 1is9u1-0000BR-Th
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1579199396; bh=ikC7tfnjvwKDZUP/GZ0mw2t0Yq7u5wMDeuaWkuERGeQ=;
 h=To:From:Subject:Date:From:Subject;
 b=lRarsm2p7paB0tDUc1kvcUtniCIH/uKYeCMS4khovA9QPjEYWBsHXuFQ66pmeAwGPIPizLInQU7lrkFuaug8Lqb7C/SErDjp401vq5gLR4FY1ZPjiQ3gGkSi7tFOFaxix9LkuVY2a96kl4NmY8oWQVQb7qYG8WBBBFYnY/jL6HxUdH1sAwhmnoukkRElWUW2CtJlpEqMby3YuiXwonxFBgtXR0It/zIAl0sj67xm1/xbW71Z1vg1KyJQWLRlxSRnWaH6rMWa9EZb3TVRVuGeVKbw2UgoYhUMY/PiBBU52CGlkFhMskloxAWDprRnukG3CIwqhauyvtsNDpT3HLkInw==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Jan 2020 18:29:56 +0000
Received: by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 4578ede4a4603a83d0d8939b329614be; 
 Thu, 16 Jan 2020 18:27:55 +0000 (UTC)
MIME-Version: 1.0
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: KJ Liew <liewkj@yahoo.com>
Subject: Fixed unknown audio format with SDL2
Date: Thu, 16 Jan 2020 10:27:54 -0800
Importance: normal
X-Priority: 3
Content-Type: multipart/alternative;
 boundary="_CF1149E1-8C72-45AB-A0D7-8AC725A428E6_"
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
Message-ID: <E1is9u1-0000BR-Th@eggs.gnu.org>
X-Received-From: 66.163.186.175
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

--_CF1149E1-8C72-45AB-A0D7-8AC725A428E6_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"


SDL2 (version >=3D2.0) prefers float32 audio format over integer audio form=
at. QEMU sdlaudio.c does not handle any kind of AUDIO_F32 formats, but SDL_=
OpenAudio(req, obt) will return float32 audio format in obt and QEMU prints=
 error about unknown format 33056 (0x8120).

The following simple patch fix the error by forcing SDL2 internal audio for=
mat conversion.

diff -ru ../orig/qemu-4.2.0/audio/sdlaudio.c ../qemu-4.2.0/audio/sdlaudio.c
--- ../orig/qemu-4.2.0/audio/sdlaudio.c 2019-12-12 10:20:47.000000000 -0800
+++ ../qemu-4.2.0/audio/sdlaudio.c      2020-01-15 15:56:25.059841600 -0800
@@ -147,10 +147,11 @@
     }
 #endif

-    status =3D SDL_OpenAudio (req, obt);
+    status =3D SDL_OpenAudio (req, NULL);
     if (status) {
         sdl_logerr ("SDL_OpenAudio failed\n");
     }
+    memcpy(obt, req, sizeof(SDL_AudioSpec));

 #ifndef _WIN32
     err =3D pthread_sigmask (SIG_SETMASK, &old, NULL);

--_CF1149E1-8C72-45AB-A0D7-8AC725A428E6_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3DEN-US><div class=3DWordSection1><p class=3DM=
soNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>SDL2 (version &gt;=3D2.0=
) prefers float32 audio format over integer audio format. QEMU sdlaudio.c d=
oes not handle any kind of AUDIO_F32 formats, but SDL_OpenAudio(req, obt) w=
ill return float32 audio format in obt and QEMU prints error about unknown =
format 33056 (0x8120).</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p clas=
s=3DMsoNormal>The following simple patch fix the error by forcing SDL2 inte=
rnal audio format conversion.</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p>=
<p class=3DMsoNormal>diff -ru ../orig/qemu-4.2.0/audio/sdlaudio.c ../qemu-4=
.2.0/audio/sdlaudio.c</p><p class=3DMsoNormal>--- ../orig/qemu-4.2.0/audio/=
sdlaudio.c 2019-12-12 10:20:47.000000000 -0800</p><p class=3DMsoNormal>+++ =
../qemu-4.2.0/audio/sdlaudio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2020-01-15 15:=
56:25.059841600 -0800</p><p class=3DMsoNormal>@@ -147,10 +147,11 @@</p><p c=
lass=3DMsoNormal>=C2=A0=C2=A0=C2=A0=C2=A0 }</p><p class=3DMsoNormal> #endif=
</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>-=C2=A0=
=C2=A0=C2=A0 status =3D SDL_OpenAudio (req, obt);</p><p class=3DMsoNormal>+=
=C2=A0=C2=A0=C2=A0 status =3D SDL_OpenAudio (req, NULL);</p><p class=3DMsoN=
ormal>=C2=A0=C2=A0=C2=A0=C2=A0 if (status) {</p><p class=3DMsoNormal>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdl_logerr (&quot;SDL_OpenAudio =
failed\n&quot;);</p><p class=3DMsoNormal>=C2=A0=C2=A0=C2=A0=C2=A0 }</p><p c=
lass=3DMsoNormal>+=C2=A0=C2=A0=C2=A0 memcpy(obt, req, sizeof(SDL_AudioSpec)=
);</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal> #ifnd=
ef _WIN32</p><p class=3DMsoNormal>=C2=A0=C2=A0=C2=A0=C2=A0 err =3D pthread_=
sigmask (SIG_SETMASK, &amp;old, NULL);</p></div></body></html>=

--_CF1149E1-8C72-45AB-A0D7-8AC725A428E6_--


