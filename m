Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF15C4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13B920789
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEz/5K66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13B920789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqhF-0005Cb-MM
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqcq-0007s2-DH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMqck-0006Hr-2z
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:43:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601289793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/srhCkt+oYeOsWkXlEUXpf3BTQ+ZmL7BrrTNh7Eod3k=;
 b=UEz/5K662P8mOTwEEwqrcnk+thioBx3QGXvidxkaRn2ub/vN/DSUHmXxVuHfPt9b8hhf32
 IOPCLq2WGG18QDIpNdU7IveLJPDNs4/9Pe+GQuXg5B4R/l0J9RzNC9keMK86cTgJ9FILRN
 6F/7fbP556XFaj+gEo2z6JFFt8h3MXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-RmKfga-2MvibXuv1Q4utgQ-1; Mon, 28 Sep 2020 06:43:09 -0400
X-MC-Unique: RmKfga-2MvibXuv1Q4utgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B1341DDF7;
 Mon, 28 Sep 2020 10:43:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5F8D5D9CD;
 Mon, 28 Sep 2020 10:43:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CB0F940DE5; Mon, 28 Sep 2020 12:42:56 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/12] tests/acpi: update expected data files
Date: Mon, 28 Sep 2020 12:42:56 +0200
Message-Id: <20200928104256.9241-13-kraxel@redhat.com>
In-Reply-To: <20200928104256.9241-1-kraxel@redhat.com>
References: <20200928104256.9241-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   5 -----
 tests/data/acpi/microvm/DSDT.pcie           | Bin 0 -> 3023 bytes
 tests/data/acpi/virt/DSDT                   | Bin 5200 -> 5196 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6561 -> 6557 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 5200 -> 5196 bytes
 5 files changed, 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 53109c22a56f..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,6 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/microvm/DSDT.pcie32",
-"tests/data/acpi/microvm/DSDT.pcie64",
-"tests/data/acpi/virt/DSDT",
-"tests/data/acpi/virt/DSDT.numamem",
-"tests/data/acpi/virt/DSDT.memhp",
diff --git a/tests/data/acpi/microvm/DSDT.pcie b/tests/data/acpi/microvm/DSDT.pcie
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4b765541e372f4ba4e25529c14acf696516c8f61 100644
GIT binary patch
literal 3023
zcmZveJ!~UI6vyA%>v%o>$l7tfKOE>z2(-2p9Su_KwUZdd$)4A_AbirEgg_i=B7u<L
zgcMR7kdCuNZKQ~rmhL1fDz2lT;2IhlO0GKde>>USJmoBTcK$Q(y?MX4yR*{?JHy}e
zM5$ZtLw_&aY`+)y9gJB-#C^WHy<eiR9gWW4+Bx=joM^AtDc<S!k37$7kQ0T&mdZPk
zKM2c3rFJbh<7TYF7c@F=_=o*^Y+q<S%~(!!)a#&Shgt35s^YHoJpDXP&g(9*&;HDA
zw-f0_T7J;;ym}Lhz_W-6^mv_;%6~UQX)A~9;B?j<ba$yhG<l)y(bsvFemCsyZ&uf%
z?%iSTl*RptJAQayrAVb71;>N7IvbrYb4M>090Z>4`FbrR(zfpoyxV$i|6p(k+ATe)
zvdF@3frN8eQHzgqWKrqo7nCAGUY50}^E%)DDe!yV%lIwtZ6*K<uh#OIEJW%~)NUW>
z;5;%Mlxu1&AfI~lA#IX}e+RwK=>dI!E5S%75DbQM`=6?_O5V;-r?eaPJkos&{W?_&
zJg!m@jYOm&np7#;h3OQxSKD1F_JUza&&7T)O(c6FeryX=ZF{BIGcn~7Ytz^hl0A`4
zY@3cflMK?to`@QornM(b6Um;)DE72t&m;po_DoD|?U^JGX>w)+XD0ScOf%XuNgmSV
zoDrP3xyUCmospc7CTCV~W(8+fazdJ%j^K0zrz1HbO-{TJMy2ss>gvVC%t=m2lT!&!
zB{-Gjgfuy^d+3_P_b4wo^O6(N<ir~b&*Xj<1ZP2VLYkaK!C4fXMac<ia+U;VNpO}V
zC#1<aD>!Eb=d9#}G&x<t=?YF)azdJ%Wx-h%oMp)gX>wKsXGL&UBqyZFIVU*h1m~RO
zgfuy;g0m_(tCADa<eV3r^MZ3;azdJ%3xab&a4twrNRtzrwDH_73eH8z32AaJ3C<<K
zxg<FuP0nS(xhy!BB`2iGxgt1M1m}w6gfux<1?Q^ZT$P-VCg+;qToasYk`vP8To;_{
zf^%JRLYkZ#f^$P~Zb(i@ld~o`Yl5>TIUzOY=)7n17WDEH?Rz`dAL8Kps9{;yt8moN
zpL~7%NXDu&Q8);#t5Ev96Mx^YL*b-ghQj7`Ba|My4)rc))p$i#DkWoKJG&7}kI7ig
zSH()pSlHlh#L{C|v8sj0Z@1`@Yw=8%;vl2m|F%de9wM4@V|{}+tH1|G{ymvar+?`#
zZC<=#%;;&fu)x_x{<a}e?(irG$nl4ReX8!{qQlU)FHXqs9M>m%+40BaIpvP}e>VTC
zt!@8s{8{VCJAZt1aiVM(G;norZJx5=INWJ+sE6FB8n+Yo@%VxD6=v$Ob$zn%c%0bj
zVV5UQ*_g*KPkt=vabBc;c~X5d>V$oJ@|w=(>FwYC4!6GSf4}%ofB9FxKgo?hq04gG
zvbe#qvTqN%p?Kc-49y40rt)so=NVT8)%lmN#t&Z<u8-^9gLAkQRkF6i8HfG{XT+o*

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


