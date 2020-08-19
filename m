Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFFDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B775A207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 06:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTLGmqXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B775A207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8HkN-0001Wg-2d
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 02:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8Hii-0008Pi-SA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k8Hig-0004ry-ID
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 02:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597819029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=GbmIzITO1PVm9UVc3+myQJotcqpbx6QwmMWimLZR4MQ=;
 b=hTLGmqXMT3myFXGUfjzgYHX33JNYixEhPeR21kO9Ho+nnmm+m90tSR+7rMJuhuR6PjTY6V
 NiFqMUOdBFUpt5pEkC7FfyaRGdMoD8iu1U/U2ex1NdDDOHolVmKmY5XZZkYd8w7lSS+Qzg
 TbD5xxSxWTr2DRnIxxWYIZQhNwivVBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-FYUOJg8_M8yngxNFfx1loA-1; Wed, 19 Aug 2020 02:37:04 -0400
X-MC-Unique: FYUOJg8_M8yngxNFfx1loA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3C7985B683
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 06:37:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6E31014182;
 Wed, 19 Aug 2020 06:37:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C58109D8F; Wed, 19 Aug 2020 08:36:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] seabios: update to 1.14-final
Date: Wed, 19 Aug 2020 08:36:59 +0200
Message-Id: <20200819063659.16082-2-kraxel@redhat.com>
In-Reply-To: <20200819063659.16082-1-kraxel@redhat.com>
References: <20200819063659.16082-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to 1.14 release being delayed it missed qemu 5.1.
The last snapshot has all code changes though, so this
changes only the version string in the binaries.

shortlog
========

Kevin O'Connor (1):
      docs: Note v1.14.0 release

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
 roms/seabios                      |   2 +-
 12 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/bios-256k.bin b/pc-bios/bios-256k.bin
index 8fd42903cdb950228613e06c228b7f8004a1381a..96bdeaa487daef197cee02655116518baba34f67 100644
GIT binary patch
delta 68
zcmZo@5NH6R7RDB)EzHb;swR2{x(2%GhNh+#Muv%omX-!dx&=k4Nu`-NC3=Oaxutsf
WMd{NU;+ZdQ6i{K@E*s4Jcntu%G8O~?

delta 65
zcmZo@5NH6R7RDB)EzHb;YQ}m7x+WI7=_!`U7KTPCDT$_rmbwK+sY#`oIVF09skx<k
T`9<l|4V@Xqw>tzfA6N$fhddO@

diff --git a/pc-bios/bios.bin b/pc-bios/bios.bin
index 528b8ab412b6cd143305bb3dc7173d2d6fc166c0..3ecaf4a7094b556f821e08901df19b280b8bf4c1 100644
GIT binary patch
delta 51
zcmZo@;AjA%EsW7=!X|nKx(2%GhNh+#Muv%omX-!d)AQ39MW+|%FrM2eu$OT=Unb+H
FX#k8H5M}@X

delta 63
zcmZo@;AjA%EsW7=n#Ottx+WI7=_!`U7KTPCDT$_rmbwK+sY#`oIVF09skx<k`9<jr
RX%jXwb}?<|%VhjC4FG=l6)XS%

diff --git a/pc-bios/vgabios-ati.bin b/pc-bios/vgabios-ati.bin
index 3dbfe53e5c88c9e62534ee54cea648e829b66c4e..118caacde6af3f4b0e06851fb3ab85aa14c7c687 100644
GIT binary patch
delta 64
zcmZqJ!ql*Zi9K|c@5|qz9vj(xW@?(~8R#15rW=}?S{NB78d_Q!B<U6ur6!eT=9K6a
UrskIF<rk$hFfg%94rFWr0MHK<wEzGB

delta 64
zcmZqJ!ql*Zi9K|c@5|qzWgFRjW@;Mi8R(i==%%MwCR-R9rKBX98d~ZW6s0DWX6BUW
U6{hBv>g5-uGcd7C4rFWr0PMIGwEzGB

diff --git a/pc-bios/vgabios-bochs-display.bin b/pc-bios/vgabios-bochs-display.bin
index ca4c3db2db79d1cbc6deeec7835c34be02966975..d79124b76010580a220fc6a92df7c83350ac5a58 100644
GIT binary patch
delta 64
zcmZp8z}WDBkv(*k#mnzD92?nR<Y}7d8R#15rW=}?S{NB78d_Q!B<U6ur6!eT=9K6a
UrskIF<rk$hFfg%94s?G30OQ&fv;Y7A

delta 64
zcmZp8z}WDBkv(*k#mnzDW*gaG<Y^k~8R(i==%%MwCR-R9rKBX98d~ZW6s0DWX6BUW
U6{hBv>g5-uGcd7C4s?G3005E}v;Y7A

diff --git a/pc-bios/vgabios-cirrus.bin b/pc-bios/vgabios-cirrus.bin
index b8ee1fe0ff050f34b3565c15e3fd569a4a804609..37bf5e7fe72d5e9f4ecc2747cd5eb9d1eb8d9f41 100644
GIT binary patch
delta 65
zcmZqJz|^pTi9K|c&&xM~-#4;1Ow%;cGtf2AO*b?(wJ<VFG_<rdNYX7RN=+)w%qh_;
VOwBFT%P&f2U|?d|>=+xs2mlPG6|w*T

delta 65
zcmZqJz|^pTi9K|c&&xM~svFrGrfC}M8R(i==%%MwCR-R9rKBX98d~ZW6s0DWX6BUW
V6{hBv>g5-uGcd7ic8m>R1OWCx6|w*T

diff --git a/pc-bios/vgabios-qxl.bin b/pc-bios/vgabios-qxl.bin
index 9829cd1dec0d92e902a391c3c3d41c0a4642cb66..0ff8ff21f00582e1738b052e0bf959be3aeafcae 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tY@f+D^%+NH^Gtf2AO*b?(wJ<VFG_<rdNYX7RN=+)w%qh_;
VOwBFT%P&f2U|?d|oEUGx2mtsY6;%KL

delta 65
zcmZqJ!ql*Zi9K|c@5^tYy&KtQ%+NH}Gtf1$&`nRVOtvsIN=ZpHHMG<%C`wH#&CDs$
VD@@HT)ypqRXJBI4oEUGx2mlq?7F7TM

diff --git a/pc-bios/vgabios-ramfb.bin b/pc-bios/vgabios-ramfb.bin
index 12dcb8e82305948dd3fb4cead4211f4978fbf514..df5e9d615a2b2f706bcc4a7be1cc4050d6b4ceeb 100644
GIT binary patch
delta 64
zcmZp8z}WDBkv(*k#mhsscP2Bsh;NkJnXhT0XP|4Kn{H@oYGGuUXlQ9^kfd8sl$unU
UnNy-yn3`LvmtU05z`(=;0P?OC82|tP

delta 64
zcmZp8z}WDBkv(*k#mhssT$34H#5c<A%-1y5Gtf1$&`nRVOtvsIN=ZpHHMG<%C`wH#
U&CDs$D@@HT)ypqRXJBFh0ND=}82|tP

diff --git a/pc-bios/vgabios-stdvga.bin b/pc-bios/vgabios-stdvga.bin
index 68fe2fe820d3e4782f2455e39de7b324f32e63cf..70f60941533d7e8567a0d107f6e671c8b5635ca8 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tYo*UU`%+NH^Gtf2AO*b?(wJ<VFG_<rdNYX7RN=+)w%qh_;
VOwBFT%P&f2U|?d|oEUGx2mte`6+Zv~

delta 65
zcmZqJ!ql*Zi9K|c@5^tY<r~>&%+NH}Gtf1$&`nRVOtvsIN=ZpHHMG<%C`wH#&CDs$
VD@@HT)ypqRXJBI4oEUGx2mldb7C!(0

diff --git a/pc-bios/vgabios-virtio.bin b/pc-bios/vgabios-virtio.bin
index 60ce81d37c3a6b0fb8d368f2d4c738db0378f427..65af5be59d17c764c3ae5d7527a824b153765312 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tY&Kuch%+NH^Gtf2AO*b?(wJ<VFG_<rdNYX7RN=+)w%qh_;
VOwBFT%P&f2U|?d|oEUGx2mtbN6*&L^

delta 65
zcmZqJ!ql*Zi9K|c@5^tYg&Wyt%+NH}Gtf1$&`nRVOtvsIN=ZpHHMG<%C`wH#&CDs$
VD@@HT)ypqRXJBI4oEUGx2mlZ%7C8U_

diff --git a/pc-bios/vgabios-vmware.bin b/pc-bios/vgabios-vmware.bin
index b75a3517d11a731276087f1d57cd9fbd9e6cd6e8..89d42b32c1f3dda0a489f1e2f8d5246b8f6342cb 100644
GIT binary patch
delta 65
zcmZqJ!ql*Zi9K|c@5^tY&o;8pn4xK+XP|4Kn{H@oYGGuUXlQ9^kfd8sl$unUnNy-y
Vn3`LvmtU05z`(?^IWgXX5dagM72E&-

delta 65
zcmZqJ!ql*Zi9K|c@5^tYA{*If%+NH}Gtf1$&`nRVOtvsIN=ZpHHMG<%C`wH#&CDs$
VD@@HT)ypqRXJBI4oEUGx2mt*y72E&-

diff --git a/pc-bios/vgabios.bin b/pc-bios/vgabios.bin
index 410436fbdf9093badab3b01c8478d40f9278349b..320471e18d34b9398b503af0df932a55e39eed4c 100644
GIT binary patch
delta 65
zcmZqJz|^pTi9K|c&&z`$Hj^3S#5c<EPFFM0Gtf2AO*b?(wJ<VFG_<rdNYX7RN=+)w
V%qh_;OwBFT%P&f2m>f8LJpjvU75o4I

delta 65
zcmZqJz|^pTi9K|c&&z`$S(6###5c<EPFFM5Gtf1$&`nRVOtvsIN=ZpHHMG<%C`wH#
V&CDs$D@@HT)ypqRpBy-SJpkp)7W@DJ

diff --git a/roms/seabios b/roms/seabios
index d9c812dda519..155821a1990b 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit d9c812dda519a1a73e8370e1b81ddf46eb22ed16
+Subproject commit 155821a1990b6de78dde5f98fa5ab90e802021e0
-- 
2.18.4


