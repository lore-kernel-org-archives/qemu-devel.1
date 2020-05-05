Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A53C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A947F20661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A947F20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVt2z-0005rP-PW
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVszm-0002zT-GZ; Tue, 05 May 2020 04:32:06 -0400
Resent-Date: Tue, 05 May 2020 04:32:06 -0400
Resent-Message-Id: <E1jVszm-0002zT-GZ@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVszl-0000fc-Cv; Tue, 05 May 2020 04:32:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588667513; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HyUPWPaYc/RQo/8o8FACXcyE9f8gG9hyxP5UemXF3L8kFInaXVzLYLXlC9uSSdOGeYLOzYIp5wdvrCG9BGRhaCnYC5fGlnuGyIoixfkjGVKEYNVpCuxxssteuKUMqzwnXaIEHKQN3nyKY6q0vqURAt8TVAyTSeEkwh1uUuEGH4E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588667513;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JE1E6Ap7hOcgvUlTGRB/1/59EtLCvjSuyYFZT+wsxPY=; 
 b=a1Tkg/V3rBhn/ft2nclY3RTbNvFz4MPZ5V6pOermkt/K2MRDl4hVSD47z3F9MMkO+oFskxU6uEPWldWAKn1rXxlQGbAp4ZL0dPk29cqci1lLm06T7eiAR6YDnSZntIwV/3U/7I6P+LFP8cAKg6rZzJyNBucZePQG+e4AV8026K0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588667511309493.55612064867614;
 Tue, 5 May 2020 01:31:51 -0700 (PDT)
Message-ID: <158866750954.24779.2101560508069499232@45ef0f9c86ae>
In-Reply-To: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 00/10] Cadence GEM Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sai.pavan.boddu@xilinx.com
Date: Tue, 5 May 2020 01:31:51 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 04:16:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jasowang@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Alistair.Francis@wdc.com,
 edgar.iglesias@gmail.com, tong.ho@xilinx.com, philmd@redhat.com,
 rfried.dev@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg4NjAxMTY4LTI3NTc2LTEt
Z2l0LXNlbmQtZW1haWwtc2FpLnBhdmFuLmJvZGR1QHhpbGlueC5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1
dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDE1ODg2MDExNjgtMjc1
NzYtMS1naXQtc2VuZC1lbWFpbC1zYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbQpTdWJqZWN0OiBb
UEFUQ0ggdjIgMDAvMTBdIENhZGVuY2UgR0VNIEZpeGVzClR5cGU6IHNlcmllcwoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKZmF0YWw6IHVuYWJsZSB0byB3cml0ZSBuZXcgaW5kZXggZmls
ZQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAicGF0Y2hldy10ZXN0
ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA1MjEsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVf
cmVwbyhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YsIFRydWUpCiAgRmlsZSAicGF0
Y2hldy10ZXN0ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA1NywgaW4gZ2l0X2Nsb25lX3JlcG8K
ICAgIGN3ZD1jbG9uZSkKICBGaWxlICIvb3B0L3JoL3JoLXB5dGhvbjM2L3Jvb3QvdXNyL2xpYjY0
L3B5dGhvbjMuNi9zdWJwcm9jZXNzLnB5IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdjaGVja291dCcsICdyZWZzL3RhZ3MvcGF0Y2hl
dy8xNTg4NjAxMTY4LTI3NTc2LTEtZ2l0LXNlbmQtZW1haWwtc2FpLnBhdmFuLmJvZGR1QHhpbGlu
eC5jb20nLCAnLWInLCAndGVzdCddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxMjgu
CgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MTU4ODYwMTE2OC0yNzU3Ni0xLWdpdC1zZW5kLWVtYWlsLXNhaS5wYXZhbi5ib2RkdUB4aWxpbngu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

