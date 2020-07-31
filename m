Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F058DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 03:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2008207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 03:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ZBHmquxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2008207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1LN9-0006nP-1L
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 23:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vit9696@protonmail.com>)
 id 1k1LMM-0006Hg-ME
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 23:05:26 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:61021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vit9696@protonmail.com>)
 id 1k1LMJ-0007j6-Ep
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 23:05:26 -0400
Date: Fri, 31 Jul 2020 02:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1596164151;
 bh=M7CgakWJICw+vYXIedT4t384GXVz0amURND25oq04Rg=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=ZBHmquxRQEJUitRVsX9ZgoyOxB4cvTrg+s4Xrz9atdzF9K3hwKGMMKsV9bF93ZQW6
 /AJUHOizo1ECHVkct1aNB89CIT2cuuMc0AjESOpbuTTHEnrFeLEEVv3Oya95ct5l7U
 uUmxHlIw6doKvJbNSSvh5WdJsb8TsAWNbE3Vj7/Y=
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 1/2] i386/acpi: fix inconsistent QEMU/OVMF device paths
Message-ID: <lE_xyk_1uYzbQKr5tPEMurU_jWzMJ74ZDmC6QZHQx2XTNK1AnZSqw-25RsyO8LMtQRiw_vyFvmjGI7y5SBuJS86yu6ynvDqg8GliBayGYaw=@protonmail.com>
In-Reply-To: <20200730153447-mutt-send-email-mst@kernel.org>
References: <20200730155755.188845-1-mst@redhat.com>
 <e1759ee7-b167-d69e-99f9-e824e9e3e0b8@redhat.com>
 <20200730153447-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="---------------------9256accdabb51ebf06706bfefff4fa69";
 charset=utf-8
Received-SPF: pass client-ip=185.70.40.136;
 envelope-from=vit9696@protonmail.com; helo=mail-40136.protonmail.ch
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 22:55:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLYTO_END_DIGIT=0.25, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
-----------------------9256accdabb51ebf06706bfefff4fa69
Content-Type: multipart/mixed; boundary="0723013a1a8e2a0676ecfd524f4ae4fabcfcab0d"

--0723013a1a8e2a0676ecfd524f4ae4fabcfcab0d
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

  Hi,<div><br></div><div>Thanks a lot! Can confirm the authenticity of both=
 patches. I also do not mind whether my full name or nickname is used, what=
ever is easier.</div><div><br></div>Best regards,<div>Vitaly<caret></caret>=
<br><div><div> <div><br></div><div><br></div>On Thu, Jul 30, 2020 at 22:35,=
 Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" class=3D"">mst@re=
dhat.com</a>&gt; wrote:<blockquote class=3D"protonmail_quote" type=3D"cite"=
>  On Thu, Jul 30, 2020 at 06:11:17PM +0200, Philippe Mathieu-Daud=C3=83=C2=
=A9 wrote:<br>&gt; On 7/30/20 5:58 PM, Michael S. Tsirkin wrote:<br>&gt; &g=
t; macOS uses ACPI UIDs to build the DevicePath for NVRAM boot options,<br>=
&gt; &gt; while OVMF firmware gets them via an internal channel through QEM=
U.<br>&gt; &gt; Due to a bug in QEMU ACPI currently UEFI firmware and ACPI =
have<br>&gt; &gt; different values, and this makes the underlying operating=
 system<br>&gt; &gt; unable to report its boot option.<br>&gt; &gt;<br>&gt;=
 &gt; The particular node in question is the primary PciRoot (PCI0 in ACPI)=
,<br>&gt; &gt; which for some reason gets assigned 1 in ACPI UID and 0 in t=
he<br>&gt; &gt; DevicePath. This is due to the _UID assigned to it by build=
_dsdt in<br>&gt; &gt; hw/i386/acpi-build.c Which does not correspond to the=
 primary PCI<br>&gt; &gt; identifier given by pcibus_num in hw/pci/pci.c<br=
>&gt; &gt;<br>&gt; &gt; Reference with the device paths, OVMF startup logs,=
 and ACPI table<br>&gt; &gt; dumps (SysReport):<br>&gt; &gt; https://github=
.com/acidanthera/bugtracker/issues/1050<br>&gt; &gt;<br>&gt; &gt; In UEFI v=
2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with<br>&gt; &gt; =
the paragraph,<br>&gt; &gt;<br>&gt; &gt;     Root PCI bridges will use the =
plug and play ID of PNP0A03, This will<br>&gt; &gt;     be stored in the AC=
PI Device Path _HID field, or in the Expanded<br>&gt; &gt;     ACPI Device =
Path _CID field to match the ACPI name space. The _UID<br>&gt; &gt;     in =
the ACPI Device Path structure must match the _UID in the ACPI<br>&gt; &gt;=
     name space.<br>&gt; &gt;<br>&gt; &gt; (See especially the last sentenc=
e.)<br>&gt; &gt;<br>&gt; &gt; Considering *extra* root bridges / root buses=
 (with bus number &gt; 0),<br>&gt; &gt; QEMU's ACPI generator actually does=
 the right thing; since QEMU commit<br>&gt; &gt; c96d9286a6d7 ("i386/acpi-b=
uild: more traditional _UID and _HID for PXB<br>&gt; &gt; root buses", 2015=
-06-11).<br>&gt; &gt;<br>&gt; &gt; However, the _UID values for root bridge=
 zero (on both i440fx and q35)<br>&gt; &gt; have always been "wrong" (from =
UEFI perspective), going back in QEMU to<br>&gt; &gt; commit 74523b850189 (=
"i386: add ACPI table files from seabios",<br>&gt; &gt; 2013-10-14).<br>&gt=
; &gt;<br>&gt; &gt; Even in SeaBIOS, these _UID values have always been 1; =
see commit<br>&gt; &gt; a4d357638c57 ("Port rombios32 code from bochs-bios.=
", 2008-03-08) for<br>&gt; &gt; i440fx, and commit ecbe3fd61511 ("seabios: =
q35: add dsdt", 2012-12-01)<br>&gt; &gt; for q35.<br>&gt; &gt;<br>&gt; &gt;=
 Suggested-by: Laszlo Ersek &lt;lersek@redhat.com&gt;<br>&gt; &gt; Tested-b=
y: vit9696 &lt;vit9696@protonmail.com&gt;<br>&gt;<br>&gt; Vitaly uses his f=
ull name on EDK2 mailing list, so I don't think he'll<br>&gt; have a proble=
m to use it in QEMU too:<br>&gt; Tested-by: Vitaly Cheptsov &lt;vit9696@pro=
tonmail.com&gt;<br>&gt;<br>&gt; From:<br>&gt; https://wiki.qemu.org/Contrib=
ute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line<br>&gt; "P=
lease use your real name to sign a patch (not an alias or acronym)."<br><br=
>Right. Tested-by is different though, I don't think we have<br>a problem w=
ith anonymous testing.<br><br>Anyway, updated.<br><br>&gt; &gt; Signed-off-=
by: Michael S. Tsirkin &lt;mst@redhat.com&gt;<br>&gt; &gt; ---<br>&gt; &gt;=
  hw/i386/acpi-build.c | 4 ++--<br>&gt; &gt;  1 file changed, 2 insertions(=
+), 2 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/hw/i386/acpi-buil=
d.c b/hw/i386/acpi-build.c<br>&gt; &gt; index b7bcbbbb2a..7a5a8b3521 100644=
<br>&gt; &gt; --- a/hw/i386/acpi-build.c<br>&gt; &gt; +++ b/hw/i386/acpi-bu=
ild.c<br>&gt; &gt; @@ -1497,7 +1497,7 @@ build_dsdt(GArray *table_data, BIO=
SLinker *linker,<br>&gt; &gt;          dev =3D aml_device("PCI0");<br>&gt; =
&gt;          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")))=
;<br>&gt; &gt;          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));=
<br>&gt; &gt; -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));<=
br>&gt; &gt; +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));<b=
r>&gt; &gt;          aml_append(sb_scope, dev);<br>&gt; &gt;          aml_a=
ppend(dsdt, sb_scope);<br>&gt; &gt;<br>&gt; &gt; @@ -1512,7 +1512,7 @@ buil=
d_dsdt(GArray *table_data, BIOSLinker *linker,<br>&gt; &gt;          aml_ap=
pend(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));<br>&gt; &gt;      =
    aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));<br>&gt; =
&gt;          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));<br>&gt; &=
gt; -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));<br>&gt; &g=
t; +        aml_append(dev, aml_name_decl("_UID", aml_int(0)));<br>&gt; &gt=
;          aml_append(dev, build_q35_osc_method());<br>&gt; &gt;          a=
ml_append(sb_scope, dev);<br>&gt; &gt;          aml_append(dsdt, sb_scope);=
<br>&gt; &gt;<br><br></blockquote><div><br></div><div><br></div></div></div=
></div>



--0723013a1a8e2a0676ecfd524f4ae4fabcfcab0d--

-----------------------9256accdabb51ebf06706bfefff4fa69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBmBAEBCAAQBQJfI4gwCRBPsoxt7Hy0xQAKCRBPsoxt7Hy0xa7PB/wPzXH2
BjzY4gszbZxLdvRVCl2ouUZfw719ZDdC+fWCBnGNJ5ee20vE2OEc//i/lAJH
J8ZWxmApO1X+QttR9ia8Wy3+f3vA3rbKi7kJVWN0dslSxOSsB7MplIA8vAM5
0vVhv+C39GcU3to5W/WZl1Xrsx7jUBukdaSqg5v2irsq470Qnbdkq63D9Yk0
b5hJZ6d1Ty1HR3m3bDlsUMykASm4bQS7DX0qqfuzPVvZ3OX/OYm3wtCMTp6R
z1yOX1IGVUnE9kpRPFPPTOmuNeCG+k6d9VphPr+EcvpYhR69Cz+H0q5iY49L
q8uFuZowC81qKcumEDqgElz8phVxUU655omy
=sM6X
-----END PGP SIGNATURE-----


-----------------------9256accdabb51ebf06706bfefff4fa69--


