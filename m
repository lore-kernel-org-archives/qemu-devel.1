Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_ONLY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707E12071A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="nsYf+4Q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707E12071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyFHH-0004hj-PF
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vit9696@protonmail.com>)
 id 1jyFGi-0004HG-QB
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:58:49 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:22616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vit9696@protonmail.com>)
 id 1jyFGf-0005sd-6I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:58:48 -0400
Date: Wed, 22 Jul 2020 13:53:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1595426007;
 bh=BaxiNXGZ50QK7GCApgawAd/+8ErXfm22kB4+uv99z/k=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=nsYf+4Q/4Cr53B+1TZZVLMQHC/dT/+jfjPgOGernPe2UftGR3YOwXEFO2Bdo0CTO/
 3WLe4DHBRx5o+37X6H565xQH5dG7Ug6Q2HTpIJNdyQ+lTyqmlPDwHdIUT9q81LyAvE
 Gpp8Cq7lJzQV7AZiLPpuJdCn5k1DLzoHfITgT5as=
To: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: mhaeuser@posteo.de, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu devel list <qemu-devel@nongnu.org>
Subject: Re: OVMF and PCI0 UID
Message-ID: <YOYfNLw-NvrJb0_cXoe66EsssRZYv1T099QNHtlpvktzBndo6yIfecUZ2XeybP7TBaibMAyDxa_jZV-2ZVytTDTTvE_dFjRkmolDYi_8Hjs=@protonmail.com>
In-Reply-To: <BF9EF866-55D1-47A4-85F5-3E654F825AEF@protonmail.com>
References: <56E4DCD4-DBA1-4A41-8568-1CBBB37ED320@protonmail.com>
 <829eba8a-d9a7-a335-6b85-91e64462e64b@redhat.com>
 <20200721025745-mutt-send-email-mst@kernel.org>
 <BF9EF866-55D1-47A4-85F5-3E654F825AEF@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="---------------------d79141e4cfab7771263c551880342dd4";
 charset=utf-8
Received-SPF: pass client-ip=185.70.40.22; envelope-from=vit9696@protonmail.com;
 helo=mail2.protonmail.ch
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 09:58:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLYTO_END_DIGIT=0.25, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-to: vit9696 <vit9696@protonmail.com>, vit9696 <vit9696@protonmail.com>
From: vit9696 via <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
-----------------------d79141e4cfab7771263c551880342dd4
Content-Type: multipart/mixed; boundary="732d27ff1e3b3cbc6c95a22b922a6039db2a5e51"

--732d27ff1e3b3cbc6c95a22b922a6039db2a5e51
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

  Hello,<div><br></div><div>We can confirm that the suggested change to zer=
o UIDs&nbsp;<caret></caret>resolves the problem. It will be great if you co=
uld handle the rest as you see fit. Thank you!</div><div><br></div><div>Bes=
t regards,</div><div>Vitaly<br> <div><br></div><div><br></div>=D0=92 =D0=B2=
=D1=82, =D0=B8=D1=8E=D0=BB=D1=8F 21, 2020 =D0=B2 12:24, vit9696 &lt;<a href=
=3D"mailto:vit9696@protonmail.com" class=3D"">vit9696@protonmail.com</a>&gt=
; =D0=BF=D0=B8=D1=88=D0=B5=D1=82:<blockquote class=3D"protonmail_quote" typ=
e=3D"cite">  Thank you, we will provide an update whether this solves the p=
roblem.<div class=3D""><br class=3D""></div><div class=3D"">Besides, this i=
s not the only case where UIDs are wrong for the PCI bus. In&nbsp;hw/arm/vi=
rt-acpi-build.c there is the following code:</div><div class=3D""><br class=
=3D""></div><div class=3D""><div class=3D"">&nbsp; &nbsp; Aml *dev =3D aml_=
device("%s", "PCI0");</div><div class=3D"">&nbsp; &nbsp; aml_append(dev, am=
l_name_decl("_HID", aml_string("PNP0A08")));</div><div class=3D"">&nbsp; &n=
bsp; aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));</div><d=
iv class=3D"">&nbsp; &nbsp; aml_append(dev, aml_name_decl("_SEG", aml_int(0=
)));</div><div class=3D"">&nbsp; &nbsp; aml_append(dev, aml_name_decl("_BBN=
", aml_int(0)));</div><div class=3D"">&nbsp; &nbsp; aml_append(dev, aml_nam=
e_decl("_ADR", aml_int(0)));</div><div class=3D"">&nbsp; &nbsp; aml_append(=
dev, aml_name_decl("_UID", aml_string("PCI0")));</div><div class=3D"">&nbsp=
; &nbsp; aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")=
));</div><div class=3D"">&nbsp; &nbsp; aml_append(dev, aml_name_decl("_CCA"=
, aml_int(1)));</div><div class=3D""><br class=3D""></div><div class=3D""><=
a href=3D"https://github.com/qemu/qemu/blob/2c1fb4d/hw/arm/virt-acpi-build.=
c#L168-L175" class=3D"">https://github.com/qemu/qemu/blob/2c1fb4d/hw/arm/vi=
rt-acpi-build.c#L168-L175</a></div><div class=3D""><br class=3D""></div><di=
v class=3D"">It makes UID on ARM builds a string, which is certainly not ex=
pected. We do not have ARM test setups, but I hope this can be useful too.<=
/div><div class=3D""><br class=3D""></div><div class=3D"">Best wishes,</div=
><div class=3D"">Vitaly</div><div><br class=3D""><blockquote type=3D"cite" =
class=3D""><div class=3D"">21 =D0=B8=D1=8E=D0=BB=D1=8F 2020 =D0=B3., =D0=B2=
 09:58, Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" class=3D""=
>mst@redhat.com</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):=
</div><br class=3D"Apple-interchange-newline"><div class=3D""><br style=3D"=
caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-st=
yle: normal; font-variant-caps: normal; font-weight: normal; letter-spacing=
: normal; text-align: start; text-indent: 0px; text-transform: none; white-=
space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-deco=
ration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-fa=
mily: Helvetica; font-size: 12px; font-style: normal; font-variant-caps: no=
rmal; font-weight: normal; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; display=
: inline !important;" class=3D"">On Mon, Jul 20, 2020 at 11:25:58PM +0200, =
Laszlo Ersek wrote:</span><br style=3D"caret-color: rgb(0, 0, 0); font-fami=
ly: Helvetica; font-size: 12px; font-style: normal; font-variant-caps: norm=
al; font-weight: normal; letter-spacing: normal; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -w=
ebkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><blockquot=
e type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; font-styl=
e: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-s=
ize-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" c=
lass=3D"">Hi Vitaly,<br class=3D""><br class=3D"">adding Igor, Michael, Mar=
cel, and qemu-devel.<br class=3D""><br class=3D"">On 07/20/20 11:06, vit969=
6 wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">Hello,<br class=
=3D""><br class=3D"">I discovered an issue with inconsistent QEMU/OVMF devi=
ce paths, and<br class=3D"">while I am unsure whether directing this e-mail=
 is appropriate to you,<br class=3D"">I believe that you likely have the co=
ntacts you could forward this<br class=3D"">e-mail to.<br class=3D""><br cl=
ass=3D"">macOS uses ACPI UIDs to build the DevicePath for NVRAM boot option=
s,<br class=3D"">while OVMF firmware gets them via an internal channel thro=
ugh QEMU.<br class=3D"">Due to a bug in QEMU (or OVMF) currently UEFI firmw=
are and ACPI have<br class=3D"">different values, and this makes the underl=
ying operating system<br class=3D"">unable to report its boot option.<br cl=
ass=3D""><br class=3D"">The particular node in question is the primary PciR=
oot (PCI0 in ACPI),<br class=3D"">which for some reason gets assigned 1 in =
ACPI UID and 0 in the<br class=3D"">DevicePath. To me this looks like a bug=
 here:<br class=3D""><a href=3D"https://github.com/qemu/qemu/blob/8f06f22/h=
w/i386/acpi-build.c#L1511-L1515" class=3D"">https://github.com/qemu/qemu/bl=
ob/8f06f22/hw/i386/acpi-build.c#L1511-L1515</a><br class=3D"">Which does no=
t correspond to the primary PCI identifier here:<br class=3D"">https://gith=
ub.com/qemu/qemu/blob/5a79d10/hw/pci/pci.c#L160-L162<br class=3D""><br clas=
s=3D"">Reference with the device paths, OVMF startup logs, and ACPI table<b=
r class=3D"">dumps (SysReport):<br class=3D"">https://github.com/acidanther=
a/bugtracker/issues/1050<br class=3D""><br class=3D"">Would you be able to =
forward this to the right people or perhaps keep<br class=3D"">an eye on th=
e issue itself?<br class=3D""></blockquote><br class=3D"">I think you are r=
ight.<br class=3D""><br class=3D"">In UEFI v2.8, section "10.4.2 Rules with=
 ACPI _HID and _UID" ends with<br class=3D"">the paragraph,<br class=3D""><=
br class=3D"">&nbsp;&nbsp;&nbsp;Root PCI bridges will use the plug and play=
 ID of PNP0A03, This will<br class=3D"">&nbsp;&nbsp;&nbsp;be stored in the =
ACPI Device Path _HID field, or in the Expanded<br class=3D"">&nbsp;&nbsp;&=
nbsp;ACPI Device Path _CID field to match the ACPI name space. The _UID<br =
class=3D"">&nbsp;&nbsp;&nbsp;in the ACPI Device Path structure must match t=
he _UID in the ACPI<br class=3D"">&nbsp;&nbsp;&nbsp;name space.<br class=3D=
""><br class=3D"">(See especially the last sentence.)<br class=3D""><br cla=
ss=3D"">Considering *extra* root bridges / root buses (with bus number &gt;=
 0),<br class=3D"">QEMU's ACPI generator actually does the right thing; sin=
ce QEMU commit<br class=3D"">c96d9286a6d7 ("i386/acpi-build: more tradition=
al _UID and _HID for PXB<br class=3D"">root buses", 2015-06-11).<br class=
=3D""><br class=3D"">However, the _UID values for root bridge zero (on both=
 i440fx and q35)<br class=3D"">have always been "wrong" (from UEFI perspect=
ive), going back in QEMU to<br class=3D"">commit 74523b850189 ("i386: add A=
CPI table files from seabios",<br class=3D"">2013-10-14).<br class=3D""><br=
 class=3D"">Even in SeaBIOS, these _UID values have always been 1; see comm=
it<br class=3D"">a4d357638c57 ("Port rombios32 code from bochs-bios.", 2008=
-03-08) for<br class=3D"">i440fx, and commit ecbe3fd61511 ("seabios: q35: a=
dd dsdt", 2012-12-01)<br class=3D"">for q35.<br class=3D""><br class=3D"">D=
oes the following patch work for you? (I can see you proposed the same<br c=
lass=3D"">in<br class=3D"">&lt;<a href=3D"https://github.com/acidanthera/bu=
gtracker/issues/1050#issuecomment-660734139" class=3D"">https://github.com/=
acidanthera/bugtracker/issues/1050#issuecomment-660734139</a>&gt;)<br class=
=3D""><br class=3D""><blockquote type=3D"cite" class=3D"">diff --git a/hw/i=
386/acpi-build.c b/hw/i386/acpi-build.c<br class=3D"">index b7bcbbbb2a35..7=
a5a8b3521b0 100644<br class=3D"">--- a/hw/i386/acpi-build.c<br class=3D"">+=
++ b/hw/i386/acpi-build.c<br class=3D"">@@ -1496,9 +1496,9 @@ build_dsdt(GA=
rray *table_data, BIOSLinker *linker,<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;sb_scope =3D aml_scope("_SB");<br class=3D"">&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev =3D aml_device("PCI0");<br c=
lass=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_append(dev, a=
ml_name_decl("_HID", aml_eisaid("PNP0A03")));<br class=3D"">&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_append(dev, aml_name_decl("_ADR", aml_=
int(0)));<br class=3D"">- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_app=
end(dev, aml_name_decl("_UID", aml_int(1)));<br class=3D"">+ &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_append(dev, aml_name_decl("_UID", aml_int(0=
)));<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_appe=
nd(sb_scope, dev);<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;aml_append(dsdt, sb_scope);<br class=3D""><br class=3D"">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;build_hpet_aml(dsdt);<br class=3D"">@@ =
-1511,9 +1511,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,<br cl=
ass=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev =3D aml_device=
("PCI0");<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml=
_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));<br class=3D"">&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_append(dev, aml_name_dec=
l("_CID", aml_eisaid("PNP0A03")));<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;aml_append(dev, aml_name_decl("_ADR", aml_int(0)));<b=
r class=3D"">- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_append(dev, am=
l_name_decl("_UID", aml_int(1)));<br class=3D"">+ &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;aml_append(dev, aml_name_decl("_UID", aml_int(0)));<br cla=
ss=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aml_append(dev, bui=
ld_q35_osc_method());<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;aml_append(sb_scope, dev);<br class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;aml_append(dsdt, sb_scope);<br class=3D""></blockquo=
te><br class=3D"">If it does, I suggest submitting the above patch to qemu-=
devel, and/or<br class=3D"">filing a bug for upstream QEMU at &lt;<a href=
=3D"https://bugs.launchpad.net/qemu/" class=3D"">https://bugs.launchpad.net=
/qemu/</a>&gt;.<br class=3D""></blockquote><br style=3D"caret-color: rgb(0,=
 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-v=
ariant-caps: normal; font-weight: normal; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" clas=
s=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none; float: none; display: inline !important=
;" class=3D"">Or even just reporting whether the above helps you, we can</s=
pan><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-si=
ze: 12px; font-style: normal; font-variant-caps: normal; font-weight: norma=
l; letter-spacing: normal; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-widt=
h: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(=
0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; font=
-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; flo=
at: none; display: inline !important;" class=3D"">take it from there.</span=
><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:=
 12px; font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: =
0px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 12px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size:=
 12px; font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; widows: auto; word-spacing: 0px=
; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-deco=
ration: none;" class=3D"">(Note: I didn't even compile the above change.)<b=
r class=3D""><br class=3D"">Thanks<br class=3D"">Laszlo</blockquote></div><=
/blockquote></div><br class=3D""></div></blockquote><div><br></div><div><br=
></div></div>



--732d27ff1e3b3cbc6c95a22b922a6039db2a5e51--

-----------------------d79141e4cfab7771263c551880342dd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBmBAEBCAAQBQJfGESxCRBPsoxt7Hy0xQAKCRBPsoxt7Hy0xb1BB/4qwG4t
sx6V1Td9wwgr5N2BzIucQS8yX+hNryfE/cfm78XezezCx3yvlEpbM6w/wB2X
NfmD6ZUKMrTP9+hej0A5jjxde0lK3AsGJ4CwtFuqggLsKnAlGp3+x0BWG0GY
b/aCQ1Et9Qja00Zg7JxZhr7XgqRG5eqn7Z3yy+4IQmOl37D6sBzCnQKD7YuD
itRlG2yVT/dFX3AsxoUKooNprsUMEojgItOI/3uAdjxTHHuKRGpetzGFGHd0
HoBimgoC3SsQ95kdwjoTZxvOGbxmS4pQpqBm+Xk8Sh6/Ii159hqECDbVRAZH
JDHZ36Zbv6xmtgZyQ+0fMf1Hr7mPVl3QSwUC
=hEfY
-----END PGP SIGNATURE-----


-----------------------d79141e4cfab7771263c551880342dd4--


