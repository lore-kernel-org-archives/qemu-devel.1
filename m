Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAE4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A462071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e967mHyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A462071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIc9-00042z-8w
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHyR-0003tf-Vf
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:08:56 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:14578)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHyM-0005Pf-2s
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604016530; x=1635552530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3oQkrRpo7U0k1j06uRl+Ko8wJbT7hHLbi+yTj6D9sHY=;
 b=e967mHyH3hjwOCj46O7qwrkpmm2ba4FOZcBabmDAy0/fWFngSZCzZ6F9
 JAv8W3+k5Mc1sGGrl+HM8G1cG17AdmDpwf6PpqiMX3EvYZM8ad2rUTH35
 C2ZxbB9RcKCw7jjvtTvBhyprzCs7QW3x1f+FMF3rW1zHE/gVonSvMJQtB E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Oct 2020 17:08:44 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 29 Oct 2020 17:08:44 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 745E3411D; Thu, 29 Oct 2020 19:08:43 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 06/33] Hexagon (target/hexagon) register names
Date: Thu, 29 Oct 2020 19:08:12 -0500
Message-Id: <1604016519-28065-7-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604016519-28065-1-git-send-email-tsimpson@quicinc.com>
References: <1604016519-28065-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.39;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 19:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, bcain@quicinc.com, richard.henderson@linaro.org,
 at.org@qualcomm.com, laurent@vivier.eu, tsimpson@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgpSZXZp
ZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+
Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCB8IDgzICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgODMgaW5zZXJ0aW9u
cygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oIGIvdGFyZ2V0L2hleGFnb24vaGV4X3Jl
Z3MuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4zYjQyNDlhCi0tLSAvZGV2
L251bGwKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaApAQCAtMCwwICsxLDgzIEBACisv
KgorICogIENvcHlyaWdodChjKSAyMDE5LTIwMjAgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIs
IEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieQorICogIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9u
IDIgb2YgdGhlIExpY2Vuc2UsIG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVy
c2lvbi4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRo
YXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAq
ICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9y
Zy9saWNlbnNlcy8+LgorICovCisKKyNpZm5kZWYgSEVYQUdPTl9SRUdTX0gKKyNkZWZpbmUgSEVY
QUdPTl9SRUdTX0gKKworZW51bSB7CisgICAgSEVYX1JFR19SMDAgICAgICAgICAgICAgID0gMCwK
KyAgICBIRVhfUkVHX1IwMSAgICAgICAgICAgICAgPSAxLAorICAgIEhFWF9SRUdfUjAyICAgICAg
ICAgICAgICA9IDIsCisgICAgSEVYX1JFR19SMDMgICAgICAgICAgICAgID0gMywKKyAgICBIRVhf
UkVHX1IwNCAgICAgICAgICAgICAgPSA0LAorICAgIEhFWF9SRUdfUjA1ICAgICAgICAgICAgICA9
IDUsCisgICAgSEVYX1JFR19SMDYgICAgICAgICAgICAgID0gNiwKKyAgICBIRVhfUkVHX1IwNyAg
ICAgICAgICAgICAgPSA3LAorICAgIEhFWF9SRUdfUjA4ICAgICAgICAgICAgICA9IDgsCisgICAg
SEVYX1JFR19SMDkgICAgICAgICAgICAgID0gOSwKKyAgICBIRVhfUkVHX1IxMCAgICAgICAgICAg
ICAgPSAxMCwKKyAgICBIRVhfUkVHX1IxMSAgICAgICAgICAgICAgPSAxMSwKKyAgICBIRVhfUkVH
X1IxMiAgICAgICAgICAgICAgPSAxMiwKKyAgICBIRVhfUkVHX1IxMyAgICAgICAgICAgICAgPSAx
MywKKyAgICBIRVhfUkVHX1IxNCAgICAgICAgICAgICAgPSAxNCwKKyAgICBIRVhfUkVHX1IxNSAg
ICAgICAgICAgICAgPSAxNSwKKyAgICBIRVhfUkVHX1IxNiAgICAgICAgICAgICAgPSAxNiwKKyAg
ICBIRVhfUkVHX1IxNyAgICAgICAgICAgICAgPSAxNywKKyAgICBIRVhfUkVHX1IxOCAgICAgICAg
ICAgICAgPSAxOCwKKyAgICBIRVhfUkVHX1IxOSAgICAgICAgICAgICAgPSAxOSwKKyAgICBIRVhf
UkVHX1IyMCAgICAgICAgICAgICAgPSAyMCwKKyAgICBIRVhfUkVHX1IyMSAgICAgICAgICAgICAg
PSAyMSwKKyAgICBIRVhfUkVHX1IyMiAgICAgICAgICAgICAgPSAyMiwKKyAgICBIRVhfUkVHX1Iy
MyAgICAgICAgICAgICAgPSAyMywKKyAgICBIRVhfUkVHX1IyNCAgICAgICAgICAgICAgPSAyNCwK
KyAgICBIRVhfUkVHX1IyNSAgICAgICAgICAgICAgPSAyNSwKKyAgICBIRVhfUkVHX1IyNiAgICAg
ICAgICAgICAgPSAyNiwKKyAgICBIRVhfUkVHX1IyNyAgICAgICAgICAgICAgPSAyNywKKyAgICBI
RVhfUkVHX1IyOCAgICAgICAgICAgICAgPSAyOCwKKyAgICBIRVhfUkVHX1IyOSAgICAgICAgICAg
ICAgPSAyOSwKKyAgICBIRVhfUkVHX1NQICAgICAgICAgICAgICAgPSAyOSwKKyAgICBIRVhfUkVH
X0ZQICAgICAgICAgICAgICAgPSAzMCwKKyAgICBIRVhfUkVHX1IzMCAgICAgICAgICAgICAgPSAz
MCwKKyAgICBIRVhfUkVHX0xSICAgICAgICAgICAgICAgPSAzMSwKKyAgICBIRVhfUkVHX1IzMSAg
ICAgICAgICAgICAgPSAzMSwKKyAgICBIRVhfUkVHX1NBMCAgICAgICAgICAgICAgPSAzMiwKKyAg
ICBIRVhfUkVHX0xDMCAgICAgICAgICAgICAgPSAzMywKKyAgICBIRVhfUkVHX1NBMSAgICAgICAg
ICAgICAgPSAzNCwKKyAgICBIRVhfUkVHX0xDMSAgICAgICAgICAgICAgPSAzNSwKKyAgICBIRVhf
UkVHX1AzXzAgICAgICAgICAgICAgPSAzNiwKKyAgICBIRVhfUkVHX00wICAgICAgICAgICAgICAg
PSAzOCwKKyAgICBIRVhfUkVHX00xICAgICAgICAgICAgICAgPSAzOSwKKyAgICBIRVhfUkVHX1VT
UiAgICAgICAgICAgICAgPSA0MCwKKyAgICBIRVhfUkVHX1BDICAgICAgICAgICAgICAgPSA0MSwK
KyAgICBIRVhfUkVHX1VHUCAgICAgICAgICAgICAgPSA0MiwKKyAgICBIRVhfUkVHX0dQICAgICAg
ICAgICAgICAgPSA0MywKKyAgICBIRVhfUkVHX0NTMCAgICAgICAgICAgICAgPSA0NCwKKyAgICBI
RVhfUkVHX0NTMSAgICAgICAgICAgICAgPSA0NSwKKyAgICBIRVhfUkVHX1VQQ1lDTEVMTyAgICAg
ICAgPSA0NiwKKyAgICBIRVhfUkVHX1VQQ1lDTEVISSAgICAgICAgPSA0NywKKyAgICBIRVhfUkVH
X0ZSQU1FTElNSVQgICAgICAgPSA0OCwKKyAgICBIRVhfUkVHX0ZSQU1FS0VZICAgICAgICAgPSA0
OSwKKyAgICBIRVhfUkVHX1BLVENOVExPICAgICAgICAgPSA1MCwKKyAgICBIRVhfUkVHX1BLVENO
VEhJICAgICAgICAgPSA1MSwKKyAgICAvKiBVc2UgcmVzZXJ2ZWQgY29udHJvbCByZWdpc3RlcnMg
Zm9yIHFlbXUgZXhlY3V0aW9uIGNvdW50cyAqLworICAgIEhFWF9SRUdfUUVNVV9QS1RfQ05UICAg
ICAgPSA1MiwKKyAgICBIRVhfUkVHX1FFTVVfSU5TTl9DTlQgICAgID0gNTMsCisgICAgSEVYX1JF
R19VVElNRVJMTyAgICAgICAgICA9IDYyLAorICAgIEhFWF9SRUdfVVRJTUVSSEkgICAgICAgICAg
PSA2MywKK307CisKKyNlbmRpZgotLSAKMi43LjQKCg==

