Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4015C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A285206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A285206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhD7f-0000Qa-RR
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhD6u-0008DQ-9d; Fri, 05 Jun 2020 10:14:16 -0400
Resent-Date: Fri, 05 Jun 2020 10:14:16 -0400
Resent-Message-Id: <E1jhD6u-0008DQ-9d@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhD6s-0006bE-OP; Fri, 05 Jun 2020 10:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591366441; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ByAsovTp0sIXwPVjT8a9VTIKTpxtOMUkHTYqrWr29W6icQCICDGEKnH7cpXHrsdNJUHGOoSGSQLqti/aG7aWafyuRvSh6BMzMOJ+vx7C6+6m7P2yDvEkGx7gHlIsL6HIFM0ijuU3DzM9U1DV2AA2Eh0UvBlfbCj7VrjCSIi335Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591366441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PEcq/qA4lKV8IOXBJ8uL1BgX4pIo7M+Vczsb1aeYqNw=; 
 b=TRFDPfQfO4QpO9hANCpOtXXUUEcCheKJ51Q0tWWfkLoLfjyoRt63XPXUxbCAAfqf98kZDUE3Jq32yYMqdKwnkP2toxSd2JkQ02A0ZViaNWecKKrC/3aBEwfE923V2ESo2NfWcQ6D9RBQcJyvCk7QhYTKm8lvsfP0OEluGHqb6+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591366439029203.00485576784683;
 Fri, 5 Jun 2020 07:13:59 -0700 (PDT)
Message-ID: <159136643739.19958.13985958610010649749@45ef0f9c86ae>
In-Reply-To: <20200605121342.534811-1-imammedo@redhat.com>
Subject: Re: [PATCH v2] numa: forbid '-numa node,
 mem' for 5.1 and newer machine types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Fri, 5 Jun 2020 07:13:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 10:11:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNTEyMTM0Mi41MzQ4
MTEtMS1pbWFtbWVkb0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBo
dy9kaXNwbGF5L2VkaWQtZ2VuZXJhdGUubwogIENDICAgICAgYmxvY2tkZXYubwoKV2FybmluZywg
dHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3Mvc3lzdGVtL2RlcHJlY2F0
ZWQucnN0OjUwNzpUaXRsZSB1bmRlcmxpbmUgdG9vIHNob3J0LgoKYGAtbnVtYSBub2RlLG1lbT1g
YFwgKnNpemUqIChyZW1vdmVkIGluIDUuMSkKLS0tCiAgQ0MgICAgICBqb2ItcW1wLm8KICBDQyAg
ICAgIG9zLXdpbjMyLm8KCldhcm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0
L3NyYy9kb2NzL3N5c3RlbS9kZXByZWNhdGVkLnJzdDo1MDc6VGl0bGUgdW5kZXJsaW5lIHRvbyBz
aG9ydC4KCmBgLW51bWEgbm9kZSxtZW09YGBcICpzaXplKiAocmVtb3ZlZCBpbiA1LjEpCi0tLQog
IENDICAgICAgcWFwaS9xYXBpLWNvbW1hbmRzLWNyeXB0by5vCiAgQ0MgICAgICBxYXBpL3FhcGkt
Y29tbWFuZHMtaW50cm9zcGVjdC5vCiAgQ0MgICAgICBxYXBpL3FhcGktY29tbWFuZHMtam9iLm8K
bWFrZTogKioqIFtNYWtlZmlsZToxMTE0OiAuZG9jc19zeXN0ZW1fcWVtdS4xX2RvY3Nfc3lzdGVt
X3FlbXUtYmxvY2stZHJpdmVycy43X2RvY3Nfc3lzdGVtX3FlbXUtY3B1LW1vZGVscy43LnNlbnRp
bmVsLl0gRXJyb3IgMgptYWtlOiAqKiogRGVsZXRpbmcgZmlsZSAnLmRvY3Nfc3lzdGVtX3FlbXUu
MV9kb2NzX3N5c3RlbV9xZW11LWJsb2NrLWRyaXZlcnMuN19kb2NzX3N5c3RlbV9xZW11LWNwdS1t
b2RlbHMuNy5zZW50aW5lbC4nCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEwMzogZG9jcy9zeXN0ZW0vaW5kZXguaHRtbF0gRXJy
b3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9k
b2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjUsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWlu
KCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJv
Y2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXIn
LCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD03NGVmODVmZDQ5YWY0
NjY5OTlkOGRlMjQzOGNjMDE3NycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3Nl
Y2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdF
WFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdE
RUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2Nh
Y2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zh
ci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW1sazJo
amxlL3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMDUtMTAuMTEuMzUuMjUyNjA6L3Zhci90bXAvcWVt
dTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NzRlZjg1ZmQ0OWFmNDY2OTk5ZDhkZTI0MzhjYzAxNzcK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbWxrMmhqbGUvc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm0yMi45NDBz
CnVzZXIgICAgMG04LjAwMnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjA1MTIxMzQyLjUzNDgxMS0xLWltYW1tZWRvQHJlZGhhdC5j
b20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

