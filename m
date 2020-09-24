Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717F4C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3E52311A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 06:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELdwJSWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3E52311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLKrU-0000To-VA
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 02:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKjY-0000Ev-C6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kLKjQ-0001g7-Gg
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 02:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600928871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhmU3pe9/lU0THQyQ4P0B/pDgq5xDQM6ETgJNB2cgTg=;
 b=ELdwJSWOzO1WznYIRPyMxlDoPvux9fVnRrQBBZCJxeCs+ElDUcXNCA/K9lmN12Rr9POqgd
 NlmIQB8as7PWwsJV2HKHgRuqkvs2F3Y+9eKy4Cit87kAk/C6WmMKx/Jo9GxXmLZcHr3D9P
 g95K5b8sip/4vaV1//w8KLBUearrx4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-69errbeGPTmyKIHp0SXRDA-1; Thu, 24 Sep 2020 02:27:48 -0400
X-MC-Unique: 69errbeGPTmyKIHp0SXRDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D06151007469;
 Thu, 24 Sep 2020 06:27:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 600EB5C1C7;
 Thu, 24 Sep 2020 06:27:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 53E2231F93; Thu, 24 Sep 2020 08:27:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/11] tests/acpi: update expected data files
Date: Thu, 24 Sep 2020 08:27:34 +0200
Message-Id: <20200924062734.22978-12-kraxel@redhat.com>
In-Reply-To: <20200924062734.22978-1-kraxel@redhat.com>
References: <20200924062734.22978-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also clear allowed changes.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   4 ----
 tests/data/acpi/microvm/DSDT.pcie           | Bin 0 -> 3023 bytes
 tests/data/acpi/virt/DSDT                   | Bin 5200 -> 5196 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6561 -> 6557 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 5200 -> 5196 bytes
 5 files changed, 4 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 1ee19a1bcdf8..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/microvm/DSDT.pcie",
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/DSDT.numamem",
-"tests/data/acpi/virt/DSDT.memhp",
diff --git a/tests/data/acpi/microvm/DSDT.pcie b/tests/data/acpi/microvm/DSDT.pcie
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b5dcef1ac79c32fa7bb6fe4cb3589b9984c09776 100644
GIT binary patch
literal 3023
zcmZveJ!~UI6vyA%YkNKZ$oeDS9}aXU1X{<6jt1%MwUZdd$>Mb`=!~?H5Qrm9BoGpu
z5Fy0@>9|PLMvACu=}w}e;yMZnuA!l!<f=3Ox0B7yQ_hli=0Ee^oA-OWJ3HO5JNmsq
zl)BZ~_jkhe&bxu%#h67z+~?Nq{}P3rXngj@)}g=UL_7U%>7Cx-!1KHfa-wk5Rs|>W
zhhe3p)VAej+>BNHoW^Gx{{EmD+ZWqUGL{n^^t-sS!;E%tRcYILmVTBd=T(>3XE(du
z>qdH!wjcC8ui3&P@GM~hJzl4*3g2ZZZRL?2oKAbg-ZmA9CeM{U{<^@@?}feH_4;bm
zyF1FCusE8y7Y~k9id5=ha5(I!)A89Ncl2VxUf}tjuh&8%9sBOkyRGMT_lEnR-PDsR
zhb;UyNH~`zHUBVA7L|W~PAMYfWm)q&ud_Qp1%BUq5x?!d$pm2G)!H7Dg-G3rI-NZo
zoJU5(N<*y#<WrwMpmp-_@1pk^-KY1_5{z^L!EjXD{Y0Hs3wB{TrR}iqk?vdQH>q0W
zag~DDNJJW<Mb(mBoKA6jwcV9sFBq2fT<izaM6xI1$F@M#wpWTh6H_j+HjO<Y*%R5s
zw&~b2$skSaiKww@T6@AYk?e_#Voy8vOfs-z&&1T$o=NhMCTB))W@698G^0I}<RMMY
ztl-4WMLvmXR&qj`oH@an6P!8832AaVg3}S4j^u<iIq^ammBwSKs}~nDFF7GiP9->%
z;8c<m(&WVMp=%P~qk`ZpNKQzT6K^a$llxf|oJGkAX>yhXXGw6DBqyZFSr(jS!C97^
zkS6Dh;G7YhGm;b1<a7n6D>z-r32Aax1ZPEXRwO5+$ypVgRl!-6oRB7GO>ou(XH9ZK
znw)jPSr?pj$q8w4&I-<1!8t2AAx+LX!8s>5=Oibj$%#$ccy8wf=e*>EG&vUp=Yrr|
zkerYv=c3?T6r78a6Vl{d5}Zqdb4hYSnw-mmb6IdMOHN3Wb475j2+kGB32Ab!3eHu*
zxhgp!P0lsJxh6Q*BqyZF*$|u!!P$_UkeYLR*0*^Jdhv<&y{+pHad3Uquq^CVIBMum
zzCL~=WA$tl4nylIls@mo-}mcKI4PK+uzB4GrN^#Az0Fx|yd*1?lCiLz-H4^fWUSW9
zVx?s)Y;ZSX>9MO=^<w0A+H}dac&baWmr?h=Em4Yxh^Bn8zQLPS<bxys9#5y!zjT+@
z&tEfU;=v<aVKM#c$|Pyl(LuSxgCHQs9}Rb@zLk&mL*G6>Cck^wob2Q-KC0A|J0ASm
z`meEa=ZC{j+mGM+<HPe~Wy4?tt%J68!h+*)r^TTj@I^KFI&mLe+_%2OOf$A_PUaq6
zBzAh(<;fE^=JCtpAIo~27inG|*I$pi;lQ4}qO*B&`?tTt%`XPu&;K)6{M8>!@)sY|
zWhHG{e8I7DU=Mqtc;5I7%?HVr@@~}UDc1w#`IlSchc61($93O>bGR8*bGE`6hyDj2
CwWA*Z

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index 9b002836f35fd03afeab9e827fdde3134d26ed2e..bc519abff9cadc1552e4e586b0a3f5f0db498f4a 100644
GIT binary patch
delta 43
zcmcbhaYlp7CD<jzM}&ca>BB@WX~y=AYLc8xe#<vIa^B-$<%o9<3f`<Cq`?FL7G(?c

delta 47
zcmX@3aY2L2CD<h-K!kyT>DNRqX~yo2YLc8xPAfJ$a^B<M6mjH;cMb|>Sh86~NP`Ig
DNc#-*

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index 545a18c3657781d350a006adfa5e58fa63e63922..54728e2b4b8b959f3f829386f6a388ef2600e747 100644
GIT binary patch
delta 43
zcmZ2zJlB}ZCD<iot|S8kli)-yX~vF?YLc8xe#<vIa^B-$<%o9<3f`<CRLKqi{Zk8i

delta 47
zcmbPhywI4-CD<iop(FzXlk`L`X~v$7YLc8xPAfJ$a^B<M6mjH;cMb|>Sh86~sFEE3
DEVvAM

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.numamem
index 9b002836f35fd03afeab9e827fdde3134d26ed2e..bc519abff9cadc1552e4e586b0a3f5f0db498f4a 100644
GIT binary patch
delta 43
zcmcbhaYlp7CD<jzM}&ca>BB@WX~y=AYLc8xe#<vIa^B-$<%o9<3f`<Cq`?FL7G(?c

delta 47
zcmX@3aY2L2CD<h-K!kyT>DNRqX~yo2YLc8xPAfJ$a^B<M6mjH;cMb|>Sh86~NP`Ig
DNc#-*

-- 
2.27.0


