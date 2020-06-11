Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9990BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE4120792
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE4120792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ1D-0007DR-Lh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjPt9-0003FJ-3B
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:17:11 -0400
Resent-Date: Thu, 11 Jun 2020 12:17:11 -0400
Resent-Message-Id: <E1jjPt9-0003FJ-3B@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjPt5-0004Id-D7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591892199; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PtBupQt1GSrl2k6h7I7cMwbSlLkVciHfIlwUDcz0Y0bc7VWZ7reYeQEGS9rKppPXxj6FMpb8n4127P1s2erUSXQeYSylAwS4NPdSiiaIC/F6ZDNOWeoXGwrVJ/jicBzpEzqeCB615MCK+DoFUtguSTofZhJQlBySEGQSrP6eIRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591892199;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=iHH1aisMwRNIZG5c0Lx1A0xZG2/4K+uPeZgdUXlN5H4=; 
 b=Ph3lnJD9eiTK6EUZ11oAutoWT+TwcKujJOOJZWvXc+5T/ZX4IYz412bXTwnArS5bYawvUca1A+XeQDSU4BxUDKB9wnI7qHdvyawI0Kf/AIDrvoxCCwUyC6R7TSiFooa2dd9Q2DOTeU0uhfz/MO2G2hx73EQzquNvuxGjnfbT/og=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15918921950411000.9154528554718;
 Thu, 11 Jun 2020 09:16:35 -0700 (PDT)
Message-ID: <159189219293.1247.7275400437936161232@45ef0f9c86ae>
In-Reply-To: <1591880064-30638-1-git-send-email-yi.l.liu@intel.com>
Subject: Re: [RFC v6 00/25] intel_iommu: expose Shared Virtual Addressing to
 VMs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yi.l.liu@intel.com
Date: Thu, 11 Jun 2020 09:16:35 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 12:17:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, yi.l.liu@intel.com,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au,
 yi.y.sun@intel.com, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTkxODgwMDY0LTMwNjM4LTEt
Z2l0LXNlbmQtZW1haWwteWkubC5saXVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1h
a2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVz
dC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
ICAgICAgICAgICAgICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody9wY2kvcGNp
X2J1cy5oOjQsCiAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVk
ZS9ody9wY2ktaG9zdC9pNDQwZnguaDoxNSwKICAgICAgICAgICAgICAgICBmcm9tIC90bXAvcWVt
dS10ZXN0L3NyYy9zdHVicy9wY2ktaG9zdC1waWl4LmM6MjoKL3RtcC9xZW11LXRlc3Qvc3JjL2lu
Y2x1ZGUvaHcvaW9tbXUvaG9zdF9pb21tdV9jb250ZXh0Lmg6Mjg6MTA6IGZhdGFsIGVycm9yOiBs
aW51eC9pb21tdS5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSA8bGludXgv
aW9tbXUuaD4KICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVk
LgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHN0dWJzL3BjaS1o
b3N0LXBpaXgub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9k
b2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjUsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2Fs
bGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJy
b3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAn
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0yMGFiMmU5NmUyMTg0YTM0OTkxYjkyMWNjZjY1MzY5Mics
ICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICct
LXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0n
LCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19F
TlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYn
LCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTd2Y3NfenVoL3NyYy9kb2NrZXItc3JjLjIw
MjAtMDYtMTEtMTIuMTQuMDAuOTE5ODovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEn
LCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBl
eGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVp
ZD0yMGFiMmU5NmUyMTg0YTM0OTkxYjkyMWNjZjY1MzY5MgptYWtlWzFdOiAqKiogW2RvY2tlci1y
dW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC03dmNzX3p1aC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3
QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTMzLjAyN3MKdXNlciAgICAwbTguMzU3cwoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU5MTg4
MDA2NC0zMDYzOC0xLWdpdC1zZW5kLWVtYWlsLXlpLmwubGl1QGludGVsLmNvbS90ZXN0aW5nLmRv
Y2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

