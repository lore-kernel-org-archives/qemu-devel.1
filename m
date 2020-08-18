Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC57C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F7E207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QKcsCRc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F7E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k844u-0002o3-CI
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83tF-0006WT-Jt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:09 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12947)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1k83t9-0005sa-3E
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1597765863; x=1629301863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dk2BRG/prIYuGB8K5FkKnVkcRMds1VjUxwW5ZfJWxxE=;
 b=QKcsCRc05KyHYLDGwst1nbC0R2/4ZBRwSKCnNu3/Lbyl6QubX/PJUN2R
 oQLT9nxRATAa0gWblCu8ur56EUMFDNDvxTBvFUkfLBpsvCsWkeiYHranq
 g7vYihmxi29UMQojkV164Xc9MNoVpVwFkVpVVxb/NKBaOuDssTK3jBrc+ E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Aug 2020 08:50:57 -0700
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 18 Aug 2020 08:50:56 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 9EBDC16D3; Tue, 18 Aug 2020 10:50:55 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 05/34] Hexagon (target/hexagon) register names
Date: Tue, 18 Aug 2020 10:50:18 -0500
Message-Id: <1597765847-16637-6-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.39;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 11:50:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, tsimpson@quicinc.com, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPgotLS0K
IHRhcmdldC9oZXhhZ29uL2hleF9yZWdzLmggfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDgzIGluc2VydGlvbnMoKykK
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uM2I0MjQ5YQotLS0gL2Rldi9udWxs
CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTAsMCArMSw4MyBAQAorLyoKKyAq
ICBDb3B5cmlnaHQoYykgMjAxOS0yMDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMu
IEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIg
dGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQg
YnkKKyAqICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9m
IHRoZSBMaWNlbnNlLCBvcgorICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0
IHdpbGwgYmUgdXNlZnVsLAorICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSBy
ZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxv
bmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGlj
ZW5zZXMvPi4KKyAqLworCisjaWZuZGVmIEhFWEFHT05fUkVHU19ICisjZGVmaW5lIEhFWEFHT05f
UkVHU19ICisKK2VudW0geworICAgIEhFWF9SRUdfUjAwICAgICAgICAgICAgICA9IDAsCisgICAg
SEVYX1JFR19SMDEgICAgICAgICAgICAgID0gMSwKKyAgICBIRVhfUkVHX1IwMiAgICAgICAgICAg
ICAgPSAyLAorICAgIEhFWF9SRUdfUjAzICAgICAgICAgICAgICA9IDMsCisgICAgSEVYX1JFR19S
MDQgICAgICAgICAgICAgID0gNCwKKyAgICBIRVhfUkVHX1IwNSAgICAgICAgICAgICAgPSA1LAor
ICAgIEhFWF9SRUdfUjA2ICAgICAgICAgICAgICA9IDYsCisgICAgSEVYX1JFR19SMDcgICAgICAg
ICAgICAgID0gNywKKyAgICBIRVhfUkVHX1IwOCAgICAgICAgICAgICAgPSA4LAorICAgIEhFWF9S
RUdfUjA5ICAgICAgICAgICAgICA9IDksCisgICAgSEVYX1JFR19SMTAgICAgICAgICAgICAgID0g
MTAsCisgICAgSEVYX1JFR19SMTEgICAgICAgICAgICAgID0gMTEsCisgICAgSEVYX1JFR19SMTIg
ICAgICAgICAgICAgID0gMTIsCisgICAgSEVYX1JFR19SMTMgICAgICAgICAgICAgID0gMTMsCisg
ICAgSEVYX1JFR19SMTQgICAgICAgICAgICAgID0gMTQsCisgICAgSEVYX1JFR19SMTUgICAgICAg
ICAgICAgID0gMTUsCisgICAgSEVYX1JFR19SMTYgICAgICAgICAgICAgID0gMTYsCisgICAgSEVY
X1JFR19SMTcgICAgICAgICAgICAgID0gMTcsCisgICAgSEVYX1JFR19SMTggICAgICAgICAgICAg
ID0gMTgsCisgICAgSEVYX1JFR19SMTkgICAgICAgICAgICAgID0gMTksCisgICAgSEVYX1JFR19S
MjAgICAgICAgICAgICAgID0gMjAsCisgICAgSEVYX1JFR19SMjEgICAgICAgICAgICAgID0gMjEs
CisgICAgSEVYX1JFR19SMjIgICAgICAgICAgICAgID0gMjIsCisgICAgSEVYX1JFR19SMjMgICAg
ICAgICAgICAgID0gMjMsCisgICAgSEVYX1JFR19SMjQgICAgICAgICAgICAgID0gMjQsCisgICAg
SEVYX1JFR19SMjUgICAgICAgICAgICAgID0gMjUsCisgICAgSEVYX1JFR19SMjYgICAgICAgICAg
ICAgID0gMjYsCisgICAgSEVYX1JFR19SMjcgICAgICAgICAgICAgID0gMjcsCisgICAgSEVYX1JF
R19SMjggICAgICAgICAgICAgID0gMjgsCisgICAgSEVYX1JFR19SMjkgICAgICAgICAgICAgID0g
MjksCisgICAgSEVYX1JFR19TUCAgICAgICAgICAgICAgID0gMjksCisgICAgSEVYX1JFR19GUCAg
ICAgICAgICAgICAgID0gMzAsCisgICAgSEVYX1JFR19SMzAgICAgICAgICAgICAgID0gMzAsCisg
ICAgSEVYX1JFR19MUiAgICAgICAgICAgICAgID0gMzEsCisgICAgSEVYX1JFR19SMzEgICAgICAg
ICAgICAgID0gMzEsCisgICAgSEVYX1JFR19TQTAgICAgICAgICAgICAgID0gMzIsCisgICAgSEVY
X1JFR19MQzAgICAgICAgICAgICAgID0gMzMsCisgICAgSEVYX1JFR19TQTEgICAgICAgICAgICAg
ID0gMzQsCisgICAgSEVYX1JFR19MQzEgICAgICAgICAgICAgID0gMzUsCisgICAgSEVYX1JFR19Q
M18wICAgICAgICAgICAgID0gMzYsCisgICAgSEVYX1JFR19NMCAgICAgICAgICAgICAgID0gMzgs
CisgICAgSEVYX1JFR19NMSAgICAgICAgICAgICAgID0gMzksCisgICAgSEVYX1JFR19VU1IgICAg
ICAgICAgICAgID0gNDAsCisgICAgSEVYX1JFR19QQyAgICAgICAgICAgICAgID0gNDEsCisgICAg
SEVYX1JFR19VR1AgICAgICAgICAgICAgID0gNDIsCisgICAgSEVYX1JFR19HUCAgICAgICAgICAg
ICAgID0gNDMsCisgICAgSEVYX1JFR19DUzAgICAgICAgICAgICAgID0gNDQsCisgICAgSEVYX1JF
R19DUzEgICAgICAgICAgICAgID0gNDUsCisgICAgSEVYX1JFR19VUENZQ0xFTE8gICAgICAgID0g
NDYsCisgICAgSEVYX1JFR19VUENZQ0xFSEkgICAgICAgID0gNDcsCisgICAgSEVYX1JFR19GUkFN
RUxJTUlUICAgICAgID0gNDgsCisgICAgSEVYX1JFR19GUkFNRUtFWSAgICAgICAgID0gNDksCisg
ICAgSEVYX1JFR19QS1RDTlRMTyAgICAgICAgID0gNTAsCisgICAgSEVYX1JFR19QS1RDTlRISSAg
ICAgICAgID0gNTEsCisgICAgLyogVXNlIHJlc2VydmVkIGNvbnRyb2wgcmVnaXN0ZXJzIGZvciBx
ZW11IGV4ZWN1dGlvbiBjb3VudHMgKi8KKyAgICBIRVhfUkVHX1FFTVVfUEtUX0NOVCAgICAgID0g
NTIsCisgICAgSEVYX1JFR19RRU1VX0lOU05fQ05UICAgICA9IDUzLAorICAgIEhFWF9SRUdfVVRJ
TUVSTE8gICAgICAgICAgPSA2MiwKKyAgICBIRVhfUkVHX1VUSU1FUkhJICAgICAgICAgID0gNjMs
Cit9OworCisjZW5kaWYKLS0gCjIuNy40Cgo=

