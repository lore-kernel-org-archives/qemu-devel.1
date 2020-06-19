Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F42C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24515207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Km51a/FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24515207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDGo-0005n0-9o
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 05:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmDBF-0002yR-Om
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:19:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmDBB-0003fD-2U
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592558360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=X6aSOjEdPLqjMMXrYS67+m/IRIYsIVeI+rzjuhMOa5U=;
 b=Km51a/FFYt7LBeDcCcTWDipPuUY5D0hb6oMYdLenIP+VJybCT/euItTJeWRglJlkdDS4TP
 +FAxhJuRUgUrGN2KxHnsmwKy8689ZIVf8g+PS7aO0s4PtVannvPIpoJqoOonKeNsFjFdXv
 p6JGQWETSzvL3h+DPnwyKP/kYMxA4jM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-b6TyklUfOOWwHjANAYskaA-1; Fri, 19 Jun 2020 05:19:16 -0400
X-MC-Unique: b6TyklUfOOWwHjANAYskaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A32E3107ACCA;
 Fri, 19 Jun 2020 09:19:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D96C710098A3;
 Fri, 19 Jun 2020 09:19:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 74CCA9D7A; Fri, 19 Jun 2020 11:19:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 12/12] tests/acpi: update expected data files
Date: Fri, 19 Jun 2020 11:19:05 +0200
Message-Id: <20200619091905.21676-13-kraxel@redhat.com>
In-Reply-To: <20200619091905.21676-1-kraxel@redhat.com>
References: <20200619091905.21676-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/data/acpi/pc/DSDT           | Bin 5014 -> 4934 bytes
 tests/data/acpi/pc/DSDT.acpihmat  | Bin 6338 -> 6258 bytes
 tests/data/acpi/pc/DSDT.bridge    | Bin 6873 -> 6793 bytes
 tests/data/acpi/pc/DSDT.cphp      | Bin 5477 -> 5397 bytes
 tests/data/acpi/pc/DSDT.dimmpxm   | Bin 6667 -> 6587 bytes
 tests/data/acpi/pc/DSDT.ipmikcs   | Bin 5086 -> 5006 bytes
 tests/data/acpi/pc/DSDT.memhp     | Bin 6373 -> 6293 bytes
 tests/data/acpi/pc/DSDT.numamem   | Bin 5020 -> 4940 bytes
 tests/data/acpi/q35/DSDT          | Bin 7752 -> 7678 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9076 -> 9002 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7769 -> 7695 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8215 -> 8141 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9405 -> 9331 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7827 -> 7753 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9111 -> 9037 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8882 -> 8808 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7758 -> 7684 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8357 -> 8283 bytes
 18 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index 384a82dbb3cb0e9f47db6f4d08945631c2b72b56..6d0aaf729ac7d64cf966621adf276534de5cc555 100644
GIT binary patch
delta 62
zcmbQHeoT$aCD<jzO_+g!asNgxF-A2tz4&0K_yA{5gXktH&tS)Rj(A6xAReGRLv%xc
QiGec{R{|Hy;%SUR0PRW+y#N3J

delta 122
zcmX@6Hcg$&CD<ionlJ+cW7|e9F-B8Wz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
z07GMECI+tm0uHQ5%A8py>oQ7eL^rC%>49{BR537k=rgeU1i1P!GFUJ$J3E3H%+5|g
JYOx!m5C9(`8>;{S

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index 47ddfdb027b06dc2daa46be711c3f4640ce68320..2e5e02400b1bd2842989d395c573fc593f45503b 100644
GIT binary patch
delta 63
zcmX?P_{o6FCD<jTNP>ZZv3Dbv7^9k+UVN}qe1Nm3L3ERpXRu>DN4%p;5D!qEA-W;J
R#K4(}D}jq;^E5^saR3*D4`~1Z

delta 123
zcmexlaLAC$CD<k8kOTt*W5`A>F-B8Wz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
z07GMECI+tm0uHQ5%A8py>oQ7eL^rC%>49{BR537k=rgeU1i1P!GFUJ$J3E3H%+5|g
KYO@=ojyM2sP8?SN

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index d1e2fa9fb8c75160fc1fa46deed6a6a9cb515559..623c4c03585c47d4d28adc611823b7cce8f4a5c7 100644
GIT binary patch
delta 63
zcmca<+G)z=66_MvDaF9R$gz=2j8RQZFFx2QKET=2Ai7D)GuSbnBi_*^hzBUo5Zw@9
RV&KfgmB7Wac^ad$BmnX}4$S}n

delta 123
zcmeA)y=ltj66_LkQ;LCs@%%<EF-B8Wz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
z07GMECI+tm0uHQ5%A8py>oQ7eL^rC%>49{BR537k=rgeU1i1P!GFUJ$J3E3H%+5|g
KYO@=ovm^kEs~o!k

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index 54f481faf1e336c0bbf5e774cd67220fe06e951b..e0a43ccdadae150c0f39599c85e4e21ed8fff2a4 100644
GIT binary patch
delta 63
zcmaE=HC2ntCD<iIRFr{%(PAT)7^9k+UVN}qe1Nm3L3ERpXRu>DN4%p;5D!qEA-W;J
R#K4(}D}jq;^EAfu!T{rs4-5bR

delta 123
zcmbQL^;C<?CD<h-Rg{5&@&86HF-B8Wz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
z07GMECI+tm0uHQ5%A8py>oQ7eL^rC%>49{BR537k=rgeU1i1P!GFUJ$J3E3H%+5|g
KYO@>Td0_x-S{(WS

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 5d98016ae571cde04ff96d58212e0faf9aaf50e6..21eb065a0ee3bd96f1a2e7601aa83fefa833349a 100644
GIT binary patch
delta 63
zcmeA+*=@|_66_MPTatl+QDGyO7^9k+UVN}qe1Nm3L3ERpXRu>DN4%p;5D!qEA-W;J
R#K4(}D}jq;^EAd%2>|(!4=4Zt

delta 123
zcmdmO+-<_;66_MfEycjV_-rGW7^A7GUVN}qe1Nm3L3ER3K!l+&N4%p;5Dzm0BSUmU
zfT6K769d<O0S8tjWzH;<br~f!q8ruX^gud5su&nN^cmQF0$lwV87vr>ogG08W@jfL
Kwb_laR004i*&G%C

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index 57b78358744a5bb13639ccddb887be2721240807..b8f08f266b5735fe6967d4e105ee6b3662dad7e6 100644
GIT binary patch
delta 88
zcmcbo-lxvx66_MvC(OXW7`%~7jL}?8FFx2QKET=2Ai7D)GuSbnBi_*^hzBUo5Zw@9
jV&KfgmB7U!;3lKb3{wbFHMxz+Yw}9Q`<pK?@d*L|$f6e0

delta 148
zcmeBEzo*XS66_LkPndy$QEDTX7^A7GUVN}qe1Nm3L3ER3K!l+&N4%p;5Dzm0BSUmU
zfT6K769d<O0S8tjWzH;<br~fsqZ`%Y^gud5su&nN^cmQF0$lwV87vr>ogG08W@jfL
eCEzBb&kVD~GuSbH@_fdJlOq{DHa9Tw2?794F(Zip

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 8cb90ef14e13be85995c6fe3d3f6d12f4d939504..9a9418f4bde5fb18883c244ea956122e371ff01a 100644
GIT binary patch
delta 63
zcmaEAIMtBLCD<iosssZA<Hn6#VvK5Pdhx+d@d3`B2GLDYp23ds9Py4WK|DZthUkU>
R69Z=^t^_WY&C?kD#Q_+=51Ie~

delta 123
zcmbPg_|%ZgCD<k8sRRQ9W5q@;F-B8Wz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
z07GMECI+tm0uHQ5%A8py>oQ7eL^rC%>49{BR537k=rgeU1i1P!GFUJ$J3E3H%+5|g
KYO@=ozc>JL)EtNa

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index f194bc639482eb839a875d493857526f85f1a9e0..6eec385c2ec00544c6eaa7e19d32b2ccd5a51915 100644
GIT binary patch
delta 63
zcmbQEenySUCD<jzN0@<uF>@oA7^9k+UVN}qe1Nm3L3ERpXRu>DN4%p;5D!qEA-W;J
R#K4(}D}jq;^E5^_Apr0P4vzo;

delta 123
zcmX@3Hb<SyCD<iojxYlQqrpZlF-B8Wz4&0K_yA{5gXkv7fCxilj(A6xARcB0MuzBy
z07GMECI+tm0uHQ5%A8py>oQ7eL^rC%>49{BR537k=rgeU1i1P!GFUJ$J3E3H%+5|g
KYO@<7n-BmV+#7uW

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 6a5e4dd85a7d9a95f7ad0fb95e6a4fa7a8d91adb..e63676d7a63afec714debeb465ee478ea4714337 100644
GIT binary patch
delta 63
zcmX?M^Us>gCD<k8pDY6d<LZrE^BL9D^x}h^;scyL4WgT*JcAwMIpQ5%f_NAh<QbwH
T0z88PnYa?Tcs5Hi>B|5BVXhFs

delta 152
zcmexoeZq#zCD<jzLym!g@ybT7`Hb}r?0WIRPVoWGo(9oP&TO8+j`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-U{$V6TumTV
kqCi!y49<?OevHmeK*A>gNC<fI>odb_^bFp7k5NGe0GZ(>WdHyG

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index c1dd7773f3386a946fcb4a9a3bf9ad3a33ddbbe9..cd97b819824e4140d087e465d179b71775d6a494 100644
GIT binary patch
delta 63
zcmez3w#tpmCD<iIOPPUzv0@|Fd`2}jz4&0K_yA{5gXktH&tS)Rj(A6xARYz=d4}kQ
S0MDR6Cawf7p3Ra>(TV^lo)6ss

delta 152
zcmZ4G_Qj3MCD<jTM45qsanVMu`Hb}r?0WIRPVoWGo(9oP&TO8+j`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-U{$V6TumTV
kqCi!y49<?OevHmeK*A>gNC<fI>odb_^bFp7kI_dF0FK)wf&c&j

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 2ef1e894a35b9e85fe07e2678bd2456f5ec40dc6..8b0fb497dbbaeba18e9d0e1503de4396f1c230b0 100644
GIT binary patch
delta 63
zcmca<({ID&66_MfFUP>Z=(Uk+KBJnNUVN}qe1Nm3L3ERpXRu>DN4%p;5Dx=`JVSIt
SfM-x36ITKk&t^#`2N?hd0uLns

delta 152
zcmeCTxoN}Y66_KZDaXLTShA68K4ZNDyIy>-Q+$B4r$Ka+Gn;3yV?0N^qe~DE1A{z6
zbVGn=P#_am0vAtogHM373lmoZ7gKbjB#6!6?C<Ny%)khwoPd;1K!^(ySd}XiR})B;
kC{UFvgR`TnAEUDqknjlr5(3`*`phsJJ%cyjV>FZj061qP$^ZZW

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 74e86176e5fec46e660c567acf8fbcf08a14bdfb..d9bb414e9bf15d9b9149f38c9bb5d8b993f88650 100644
GIT binary patch
delta 63
zcmbR4aMqs7CD<k8tULn)qsm6E`HX66dhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
T0iHpDOk4?EJewt%{>cIWDYg)R

delta 152
zcmX?WKiz@LCD<iIT!Dds(RU-)e8zeQcD?vur}zM8PlM<tXEx7Z$9Rr-N0%TT1_pVC
z=!O8#pg<<B1TLQF2A=?D7bdO-E~e;4Nf4XC+27ZZnSl{VIRPo3fDjiZuqsz3t|pKw
kQJ^YU24_cCKSpOKAmI}LBm}(q^_gKddIoR4$M{|r00UViB>(^b

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 4bf8e9d64b04f9f805047d6850c2dd0086970445..29f19b22a38f9d8e7dc9870f0c1aa3d4470643ff 100644
GIT binary patch
delta 63
zcmdn%`PqZZCD<jTScQRs@$E*g`HX66dhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
T0iHpDOk4?EJewt%mM8%LR6h{?

delta 152
zcmezDvDcH!CD<iouL=VLqxeRy`Hb}r?0WIRPVoWGo(9oP&TO8+j`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-U{$V6TumTV
kqCi!y49<?OevHmeK*A>gNC<fI>odb_^bFp7k8!FJ0DIsiq5uE@

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 38723daef80421ea528b2ad2d411e7357df43956..e8dea1ea42af765babcb747af998b0d912abdcbd 100644
GIT binary patch
delta 88
zcmbPid(wu>CD<jzQ;vaw@!m$R`Hbdjdhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
k0iHpDOk4?EJOXYa`phteAXSswn0zPeFvV=X%yd8+02eVA?f?J)

delta 163
zcmX?UGuf8QCD<iovK#{gBgaOr`Hb}r?0WIRPVoWGo(9oP&TO8+j`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-U{$V6TumTV
vqCi!y49<?OevHmeK*A>gNC>!z=rhA?^bBTljGwH{6gT-1qxa@crUTLdx=1KU

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 98328d1c4197ab19a71de7f3f18e2985f4910f45..dca76db15b943122efd5c200cb54ce3dbc97a55f 100644
GIT binary patch
delta 63
zcmbR4e%6i4CD<jzSDAr<an44r`HX66dhx+d@d3`B2GLDYp23ds9Py4WK|Bl$@(j@p
S0iHpDOk4?EJewt%>J$Me+z<``

delta 152
zcmX@>Hr<`eCD<iox-tU;<FSog^BL<M*!ALro#F$WJq@CpoY_2s9pgFT9bJNW7#QRk
zq8kD{g94ej61aGx8+-zsU6{BUxR|0FB|&TkXMbNuW(Gze<piXB0zzDvz^YuCxSBw!
kM1iVY8Jrzm{TQ8{fP_x~kPz_Z*Jp;==o!5E9%H^D0F?D5vj6}9

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 5916c0e9ce0a9607c6230f9dfebe2c1be70b2495..6d8facd9e179140682ad5d4302f3dad14dbec342 100644
GIT binary patch
delta 63
zcmdnw`oe|FCD<h-Ly3WbF=8Xvd`2}jz4&0K_yA{5gXktH&tS)Rj(A6xARYz=d4}kQ
S0MDR6Cawf7p3Ra>GZg?Wst_;$

delta 152
zcmaFivdNXpCD<iolM(|1W79^i`Hb}r?0WIRPVoWGo(9oP&TO8+j`1AvjxIqw3=HxN
z(G3BfL4izM30yqU4L$+RE=*hvTujl8k{~vNv%jw+GXo=#aspC50U<6-U{$V6TumTV
kqCi!y49<?OevHmeK*A>gNC<fI>odb_^bFp7kFiSu0Gx{@)c^nh

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index cf3fde3449bc8e9bbe683b936cf9866590b0ef82..737325dc3082fdf06283857811f6f5174e0ff2a9 100644
GIT binary patch
delta 63
zcmX?S(_+Kr66_MfBFDhM7_yOTKBJnNUVN}qe1Nm3L3ERpXRu>DN4%p;5Dx=`JVSIt
SfM-x36ITKk&t^#`QyBmOFb@L&

delta 152
zcmZp%IcLM=66_M<C&$3RShtaDK4ZNDyIy>-Q+$B4r$Ka+Gn;3yV?0N^qe~DE1A{z6
zbVGn=P#_am0vAtogHM373lmoZ7gKbjB#6!6?C<Ny%)khwoPd;1K!^(ySd}XiR})B;
kC{UFvgR`TnAEUDqknjlr5(3`*`phsJJ%cyjV^os?04kOwr~m)}

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 56b6fb0c3298517d080e38fea05a748b9f1dba54..27ee927fc5ac05b89724c154197304c39e653269 100644
GIT binary patch
delta 63
zcmZ4Lc-w)?CD<h-T7iLqv3Vocd`2}jz4&0K_yA{5gXktH&tS)Rj(A6xARYz=d4}kQ
S0MDR6Cawf7p3Ra>J#qjlZ4es(

delta 152
zcmccZu+)*uCD<iosR9E7<Jyf}^BL<M*!ALro#F$WJq@CpoY_2s9pgFT9bJNW7#QRk
zq8kD{g94ej61aGx8+-zsU6{BUxR|0FB|&TkXMbNuW(Gze<piXB0zzDvz^YuCxSBw!
kM1iVY8Jrzm{TQ8{fP_x~kPz_Z*Jp;==o!5E9%HQ>0GBu=zyJUM

-- 
2.18.4


