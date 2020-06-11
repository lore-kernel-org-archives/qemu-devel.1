Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 23:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C225520842
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 23:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C225520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjWr5-00067C-1y
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 19:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjWqK-0005ZU-HJ; Thu, 11 Jun 2020 19:42:46 -0400
Resent-Date: Thu, 11 Jun 2020 19:42:44 -0400
Resent-Message-Id: <E1jjWqK-0005ZU-HJ@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjWqH-00027T-R3; Thu, 11 Jun 2020 19:42:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591918952; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OgKc9yucQ+jkw7Rj6qyRZRSS+Tn2R1LqYSR1UwLXca2vBb9yQIQfY3KQ29f8h1h26ro+SEGXxg0Iusni72veezLZW9Ip0yXdsUoq8XksGSsvG4Sak1hzlQYCJd9Mt+tluIHfczZYO0xibMKO0EGa4JE6p8lkTQy25gzku/2V3Rs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591918952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=u78j+K4GTAbT5wfUVcL6FfLeUABnhpsk7YqZbMqopDI=; 
 b=FyxyTW3D323YLiFp1mfqbMUTSKkIrp7Mn0MFBcd5XqKKjG2wFFkRUrOCBNC1qr/e0zrgN0HWlssdbyZ2oca/8YPkTgTbVt3fLElnHNgkmeNCB19Ziez8qxwXyStV2oD1CZAJIF6PpH5s8D/cMlNcWLtIU/D6wkRSOIhQXb/Lo88=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591918950734690.2872725876653;
 Thu, 11 Jun 2020 16:42:30 -0700 (PDT)
Message-ID: <159191894950.1247.1566107495715577757@45ef0f9c86ae>
In-Reply-To: <20200611144529.8873-1-peter.maydell@linaro.org>
Subject: Re: [PATCH 00/10] target/arm: Convert 2-reg-scalar to decodetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Thu, 11 Jun 2020 16:42:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 19:16:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMTE0NDUyOS44ODcz
LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9j
a2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICBhYXJjaDY0LXNvZnRtbXUvdGFyZ2V0L2FybS9wc2NpLm8KICBDQyAgICAgIGFhcmNoNjQtc29m
dG1tdS90YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11
L3RhcmdldC9hcm0vaGVscGVyLWE2NC5vCi90bXAvcWVtdS10ZXN0L3NyYy90YXJnZXQvYXJtL25l
b24tZHAuZGVjb2RlOjQxNjogZXJyb3I6ICgnZGVmaW5pdGlvbiBoYXMgMCBiaXRzJywpCm1ha2Vb
MV06ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3RhcmdldC9hcm0vTWFrZWZpbGUub2JqczoyNzog
dGFyZ2V0L2FybS9kZWNvZGUtbmVvbi1kcC5pbmMuY10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIEdFTiAgICAgYWFyY2g2NC1zb2Z0bW11L3Rh
cmdldC9hcm0vZGVjb2RlLXN2ZS5pbmMuYwogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvcWVtdS1z
eXN0ZW0teDg2XzY0LmV4ZQptYWtlOiAqKiogW01ha2VmaWxlOjUyNzogYWFyY2g2NC1zb2Z0bW11
L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAi
Li90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjUsIGluIDxtb2R1bGU+CiAgICBzeXMu
ZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1hMDkz
ODQwY2Y3YzA0ZWU0YmY4ZGZjYTYwNzNiMmFlYScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zh
ci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNj
YWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtYXNhaTV3NGQvc3JjL2RvY2tlci1zcmMuMjAyMC0wNi0xMS0xOS4zOS4wNy4yNDkwODovdmFy
L3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVz
dC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0
ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hMDkzODQwY2Y3YzA0ZWU0YmY4ZGZjYTYw
NzNiMmFlYQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmlu
ZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1hc2FpNXc0ZC9zcmMnCm1h
a2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAz
bTIyLjQ4NHMKdXNlciAgICAwbTguNzU4cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MTExNDQ1MjkuODg3My0xLXBldGVyLm1heWRl
bGxAbGluYXJvLm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

