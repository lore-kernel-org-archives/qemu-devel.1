Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F3DC2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AB02465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 06:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5m/ZvtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AB02465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiBTZ-00047r-VA
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 01:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iiBSW-0002pT-4p
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iiBSP-0000hG-6W
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:08:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48910
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iiBSO-0000e2-UT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 01:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576822092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ly5NriXaAIerzcWYiGmWZquZ7zLwcmptmx97DSYXNew=;
 b=F5m/ZvtDdS94TfzV9P/nNwduNRk8R9dauQrjZE6AoaDcl7YTY3+9NFcKkuyq2dx/Uy2R2e
 Ua55bCfa7CpPOY71LWq+4gvf3aRC9BngjxkK1zGW0DHP/Lf1qq3o4HaH1SKgcvXp2sIaIN
 aDBRl89XOHB6nYFaM3unxqga1/FoZqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-Yyha0CDEMe2FMIP48DJUpg-1; Fri, 20 Dec 2019 01:08:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF27A801E66
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:08:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C602C5DA2C;
 Fri, 20 Dec 2019 06:08:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 23BE39AFB; Fri, 20 Dec 2019 07:08:05 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] seabios: update to 1.13.0 final
Date: Fri, 20 Dec 2019 07:08:05 +0100
Message-Id: <20191220060805.1741-2-kraxel@redhat.com>
In-Reply-To: <20191220060805.1741-1-kraxel@redhat.com>
References: <20191220060805.1741-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Yyha0CDEMe2FMIP48DJUpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to the final 1.13 release.  No code changes.

git shortlog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Kevin O'Connor (1):
      docs: Note v1.13.0 release

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-ati.bin           | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-qxl.bin           | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 28672 -> 28672 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-virtio.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-vmware.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios.bin               | Bin 38912 -> 38912 bytes
 roms/config.seabios-128k          |   1 +
 roms/seabios                      |   2 +-
 13 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/pc-bios/bios-256k.bin b/pc-bios/bios-256k.bin
index 40e7e67a9bbea0ffd4506b2ff68f867d7c0350d5..4af7f7d5a91bcc19905e1742b07=
06e034e2a655c 100644
GIT binary patch
delta 73
zcmZo@5NH6R7RDB)EzInJs>XT-x(2%GX-0-grimtrsYwP#x&=3Dk4Nu`-NC3=3DOaxutsf
aMd{NU;+ZdQ6i{KDZX3)jvmHnrUIPG0`4|8I

delta 74
zcmZo@5NH6R7RDB)EzInJYDRhnx~7)8>B*K!iKa&8W~s(ThPnkssY#`oIVF09skx<k
b`9<l|FD5XGZxp!8INdgwS!O$sIJ^b`Q^y!Q

diff --git a/pc-bios/bios.bin b/pc-bios/bios.bin
index 97b1e239aa2bc28c4e406264b251b0e446b711e4..67874c31b8b0284eb292deb2c9e=
bc191fa2d73b6 100644
GIT binary patch
delta 27112
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
StL}(T9K}s}vmc2D|NjRExmvXV

delta 28243
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
`
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

diff --git a/pc-bios/vgabios-ati.bin b/pc-bios/vgabios-ati.bin
index b5314fb66c3add81a70a862ec4e5ccbe0338d352..6202cf73e254ccac67b3289230a=
23f3f45f6b41f 100644
GIT binary patch
delta 64
zcmZqJ!ql*Zi9K|c@5|qzEgRW=3DW@;Mi8R#15rl%PhCYdIhB&H@A80i)ir6!eT=3D9K6a
UrskIF<rk$hFfg%94rFWr0Q2@0qW}N^

delta 64
zcmZqJ!ql*Zi9K|c@5|qzGd8mO%+xf}Gtf1))J;#eOiDC0GB-;#HZs&LC`wH#&CDs$
UD@@HT)ypqRXJBHP9LU%L0PX-4qW}N^

diff --git a/pc-bios/vgabios-bochs-display.bin b/pc-bios/vgabios-bochs-disp=
lay.bin
index 5033cc8433c65eeaba548067fb48b66c9675bd82..b675f86bc622b77afd8b24a5094=
8663aeae2c2ce 100644
GIT binary patch
delta 64
zcmZp8z}WDBkv(*k#mnzDE*sfj<Y^k~8R#15rl%PhCYdIhB&H@A80i)ir6!eT=3D9K6a
UrskIF<rk$hFfg%94s?G300+<(q5uE@

delta 64
zcmZp8z}WDBkv(*k#mnzD5gXZG<Y^k|8R(i?>ZT`KCMB90nVY2=3D8yV^r6s0DWX6BUW
U6{hBv>g5-uGcd7C4s?G300G(-q5uE@

diff --git a/pc-bios/vgabios-cirrus.bin b/pc-bios/vgabios-cirrus.bin
index 4a3643903f57ddc2ef0c93a45604f51b104c20a8..63fde14fea4a2d4873b6efc02b0=
437c1802625ea 100644
GIT binary patch
delta 64
zcmZqJz|^pTi9K|c&&$xDog3NTOw%;hGtf2AO;0m2OfpS0NlZ;LFw!k3N=3D+)w%qh_;
UOwBFT%P&f2U|?dIyfO9(0QnOZ-v9sr

delta 64
zcmZqJz|^pTi9K|c&&$xDvm4ppOw%;dGtf1))J;#eOiDC0GB-;#HZs&LC`wH#&CDs$
UD@@HT)ypqRXJBHPyfO9(0P`Id-v9sr

diff --git a/pc-bios/vgabios-qxl.bin b/pc-bios/vgabios-qxl.bin
index f6811bcc8bf81558b7aa5b37704df84560d67896..80168826e2e5cdba8fb6a7805ad=
f061f3cf38685 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tYvp2HOn4xK`XP|4Ko1SK5m}Hu0l9-xgV5D16l$unUnNy-y
Vn3`LvmtU05z`(?^IWgXX5da+p7DE64

delta 65
zcmZqJ!ql*Zi9K|c@5^tY>o>B`n4xK;XP|3pshgf`nUrX1WNwyfY-FfgP?VZfnwe9g
VSD2bxs+V7s&cMX7IWgXX5daqt7DE64

diff --git a/pc-bios/vgabios-ramfb.bin b/pc-bios/vgabios-ramfb.bin
index 79986b26cfe2e77e94d6142eaeb39844a394ce12..1dc413dcd2ab1720a46d0e7ee7a=
bca46469200b5 100644
GIT binary patch
delta 64
zcmZp8z}WDBkv(*k#mhss5|bHS#5c<A%-1y5Gtf2AO;0m2OfpS0NlZ;LFw!k3N=3D+)w
U%qh_;OwBFT%P&f2U|?ba0N~9P2LJ#7

delta 64
zcmZp8z}WDBkv(*k#mhssI+Gb)#5c<A%-1y1Gtf1))J;#eOiDC0GB-;#HZs&LC`wH#
U&CDs$D@@HT)ypqRXJBFh0NW=3DO2LJ#7

diff --git a/pc-bios/vgabios-stdvga.bin b/pc-bios/vgabios-stdvga.bin
index d709ec60a05588259debcb9a86b7b5abb9de7b21..f92b9a664dfbdbf953efddbba22=
50d7556c6b53a 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tYtsB{A%+NH}Gtf2AO;0m2OfpS0NlZ;LFw!k3N=3D+)w%qh_;
VOwBFT%P&f2U|?d|oEUGx2mlz37A*h(

delta 65
zcmZqJ!ql*Zi9K|c@5^tYGdHr&n4xK;XP|3pshgf`nUrX1WNwyfY-FfgP?VZfnwe9g
VSD2bxs+V7s&cMX7IWgXX5dadG7A*h(

diff --git a/pc-bios/vgabios-virtio.bin b/pc-bios/vgabios-virtio.bin
index b99faf4ccc1505db3d0584bede134b39037f1339..b0d2f70670303c9d0daafea45e9=
bbf7473ec127e 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tY^&8n|%+NH}Gtf2AO;0m2OfpS0NlZ;LFw!k3N=3D+)w%qh_;
VOwBFT%P&f2U|?d|oEUGx2mlvV7AF7z

delta 65
zcmZqJ!ql*Zi9K|c@5^tYlQ*)@n4xK;XP|3pshgf`nUrX1WNwyfY-FfgP?VZfnwe9g
VSD2bxs+V7s&cMX7IWgXX5daZi7AF7z

diff --git a/pc-bios/vgabios-vmware.bin b/pc-bios/vgabios-vmware.bin
index 8c92ab76f757e1f577dac7632fb70317a954eff8..1c2776e8cf6b02f4e01a4c4f161=
6cdc190417a34 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tYN*mc{%+NH}Gtf2AO;0m2OfpS0NlZ;LFw!k3N=3D+)w%qh_;
VOwBFT%P&f2U|?d|oEUGx2ml0e70Lhr

delta 65
zcmZqJ!ql*Zi9K|c@5^tYW*gaO%+NH_Gtf1))J;#eOiDC0GB-;#HZs&LC`wH#&CDs$
VD@@HT)ypqRXJBI4oEUGx2mt<U70Lhr

diff --git a/pc-bios/vgabios.bin b/pc-bios/vgabios.bin
index aeae0364ada84845cb9243e54a55c8c2f184e82d..c5aad8f3a99f9be693b008fd921=
f50a601c41be8 100644
GIT binary patch
delta 65
zcmZqJz|^pTi9K|c&&z`$6_Xj`#5c<EPFFM5Gtf2AO;0m2OfpS0NlZ;LFw!k3N=3D+)w
V%qh_;OwBFT%P&f2m>f8LJpk=3D@7U}>1

delta 65
zcmZqJz|^pTi9K|c&&z`$J(C&Z#5c<EPFFM1Gtf1))J;#eOiDC0GB-;#HZs&LC`wH#
V&CDs$D@@HT)ypqRpBy-SJpkv?7U}>1

diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
index a17502ca0f61..c43912bf9de4 100644
--- a/roms/config.seabios-128k
+++ b/roms/config.seabios-128k
@@ -15,3 +15,4 @@ CONFIG_PVSCSI=3Dn
 CONFIG_NVME=3Dn
 CONFIG_USE_SMM=3Dn
 CONFIG_VGAHOOKS=3Dn
+CONFIG_HOST_BIOS_GEOMETRY=3Dn
diff --git a/roms/seabios b/roms/seabios
index c9ba5276e321..f21b5a4aeb02 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit c9ba5276e3217ac6a1ec772dbebf568ba3a8a55d
+Subproject commit f21b5a4aeb020f2a5e2c6503f906a9349dd2f069
--=20
2.18.1


