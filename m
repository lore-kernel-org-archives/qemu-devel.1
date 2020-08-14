Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8F9C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D3D20708
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D3D20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6XNc-0005t4-EK
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6XMd-00050A-T3
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 06:55:11 -0400
Resent-Date: Fri, 14 Aug 2020 06:55:11 -0400
Resent-Message-Id: <E1k6XMd-00050A-T3@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6XMb-0007Mg-72
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 06:55:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597402504; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NfJojho/DNoL4Vm6elNFRygK7SmBFgE36x9zLKQ30lL2nh4+BoptwZdGDlF7gBBGoAAa8CoxpdqVklPaUfE7K1oQoCUKDJrpPb3tIU+RncJfKRwBCt61nBHrkX04j/uL/WxVGcyFT8t1vt54aA2XvJJjtHQmq2NVgoB5cOoFLfA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597402504;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TaXQFIiDWJbXc1r7paDcEIEqo33y8pHylKBE+WZzTaY=; 
 b=h8BmFawzI9Xck1xhTtIxWdYpWOakXVVoy57blK56GcxQyltEbsuOpW1ZNmyjCD6IzyBNVonXYsCvyqBmUHS9kuoGrQR2MlC004NwnxxHFoPgkyTtySc1L0KMyE590+fOB+VP9QnXNvLwiqhgEik1mINDYI7YX1OoS1APicVyDWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597402500778189.76560311732294;
 Fri, 14 Aug 2020 03:55:00 -0700 (PDT)
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
Message-ID: <159740249960.3448.10223904837988254090@66eaa9a8a123>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Fri, 14 Aug 2020 03:55:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 06:49:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNDA5MTMyNi4xNjE3
My0xLXBib256aW5pQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKSG9zdCBtYWNoaW5l
IGNwdTogeDg2XzY0ClRhcmdldCBtYWNoaW5lIGNwdSBmYW1pbHk6IHg4NgpUYXJnZXQgbWFjaGlu
ZSBjcHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6OTogV0FSTklORzogTW9kdWxlIHVuc3Rh
YmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNvbXBhdGliaWxpdHkgYW5k
IG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dyYW0gc2ggZm91bmQ6IFlF
UwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0aG9uMykKQ29uZmlndXJp
bmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tCiAgICAgICAgICAgICBMaW51eCBr
ZXlyaW5nOiBOTwoKRm91bmQgbmluamF0b29sLTEuOCBhdCAvdG1wL3FlbXUtdGVzdC9idWlsZC9u
aW5qYXRvb2wKV0FSTklORzogY3VzdG9tX3RhcmdldCAnc2hhcmVkIFFBUEkgc291cmNlIGZpbGVz
JyBoYXMgbW9yZSB0aGFuIG9uZSBvdXRwdXQhIFVzaW5nIHRoZSBmaXJzdCBvbmUuCldBUk5JTkc6
IGN1c3RvbV90YXJnZXQgJ1FHQSBRQVBJIGZpbGVzJyBoYXMgbW9yZSB0aGFuIG9uZSBvdXRwdXQh
IFVzaW5nIHRoZSBmaXJzdCBvbmUuCldBUk5JTkc6IGN1c3RvbV90YXJnZXQgJ1FBUEkgZmlsZXMg
Zm9yIHFlbXUtc3RvcmFnZS1kYWVtb24nIGhhcyBtb3JlIHRoYW4gb25lIG91dHB1dCEgVXNpbmcg
dGhlIGZpcnN0IG9uZS4KV0FSTklORzogY3VzdG9tX3RhcmdldCAnUUFQSSBkb2MnIGhhcyBtb3Jl
IHRoYW4gb25lIG91dHB1dCEgVXNpbmcgdGhlIGZpcnN0IG9uZS4KV0FSTklORzogY3VzdG9tX3Rh
cmdldCAnZGV2ZWwgbWFudWFsJyBoYXMgbW9yZSB0aGFuIG9uZSBvdXRwdXQhIFVzaW5nIHRoZSBm
aXJzdCBvbmUuCldBUk5JTkc6IGN1c3RvbV90YXJnZXQgJ2ludGVyb3AgbWFudWFsJyBoYXMgbW9y
ZSB0aGFuIG9uZSBvdXRwdXQhIFVzaW5nIHRoZSBmaXJzdCBvbmUuCldBUk5JTkc6IGN1c3RvbV90
YXJnZXQgJ3Rvb2xzIG1hbnVhbCcgaGFzIG1vcmUgdGhhbiBvbmUgb3V0cHV0ISBVc2luZyB0aGUg
Zmlyc3Qgb25lLgpXQVJOSU5HOiBjdXN0b21fdGFyZ2V0ICd0b29scyBtYW4gcGFnZXMnIGhhcyBt
b3JlIHRoYW4gb25lIG91dHB1dCEgVXNpbmcgdGhlIGZpcnN0IG9uZS4KV0FSTklORzogY3VzdG9t
X3RhcmdldCAnc3BlY3MgbWFudWFsJyBoYXMgbW9yZSB0aGFuIG9uZSBvdXRwdXQhIFVzaW5nIHRo
ZSBmaXJzdCBvbmUuCldBUk5JTkc6IGN1c3RvbV90YXJnZXQgJ3N5c3RlbSBtYW51YWwnIGhhcyBt
b3JlIHRoYW4gb25lIG91dHB1dCEgVXNpbmcgdGhlIGZpcnN0IG9uZS4KV0FSTklORzogY3VzdG9t
X3RhcmdldCAnc3lzdGVtIG1hbiBwYWdlcycgaGFzIG1vcmUgdGhhbiBvbmUgb3V0cHV0ISBVc2lu
ZyB0aGUgZmlyc3Qgb25lLgpXQVJOSU5HOiBjdXN0b21fdGFyZ2V0ICd1c2VyIG1hbnVhbCcgaGFz
IG1vcmUgdGhhbiBvbmUgb3V0cHV0ISBVc2luZyB0aGUgZmlyc3Qgb25lLgpDb21tYW5kIGxpbmUg
Zm9yIGJ1aWxkaW5nIFsnbGliY29tbW9uLmZhJ10gaXMgbG9uZywgdXNpbmcgYSByZXNwb25zZSBm
aWxlCi91c3IvYmluL3B5dGhvbjMgLUIgL3RtcC9xZW11LXRlc3Qvc3JjL21lc29uL21lc29uLnB5
IGludHJvc3BlY3QgLS10ZXN0cyB8IC91c3IvYmluL3B5dGhvbjMgLUIgc2NyaXB0cy9tdGVzdDJt
YWtlLnB5ID4gTWFrZWZpbGUubXRlc3QKLi9uaW5qYXRvb2wgLXQgbmluamEybWFrZSAtLW9taXQg
Y2xlYW4gZGlzdCB1bmluc3RhbGwgPCBidWlsZC5uaW5qYSA+IE1ha2VmaWxlLm5pbmphCi0tLQpD
b21waWxpbmcgQyBvYmplY3QgbGlicWVtdXV0aWwuYS5wL21lc29uLWdlbmVyYXRlZF8uLl9xYXBp
X3FhcGktdmlzaXQtY3J5cHRvLmMub2JqCkNvbXBpbGluZyBDIG9iamVjdCBsaWJxZW11dXRpbC5h
LnAvbWVzb24tZ2VuZXJhdGVkXy4uX3FhcGlfcWFwaS1ldmVudHMtbWlzYy5jLm9iagpDb21waWxp
bmcgQyBvYmplY3QgbGlicWVtdXV0aWwuYS5wL21lc29uLWdlbmVyYXRlZF8uLl9xYXBpX3FhcGkt
Y29tbWFuZHMtbWlzYy5jLm9iagptYWtlOiAqKiogW01ha2VmaWxlLm5pbmphOjE5Mjk6IGRvY3Mv
c3lzdGVtXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tl
ci9kb2NrZXIucHkiLCBsaW5lIDcwOSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPTU3NDk4ZDZlMDIyZjQ1Mjc5OTYwOGNlMzQ0NmM3YzBhJywgJy11
JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0n
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC11bl9vM3A5Yy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4
LTE0LTA2LjUwLjM1Ljk1ODg6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvZmVkb3JhJywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NTc0
OThkNmUwMjJmNDUyNzk5NjA4Y2UzNDQ2YzdjMGEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtdW5fbzNwOWMvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRv
cmFdIEVycm9yIDIKCnJlYWwgICAgNG0yNC4wNTNzCnVzZXIgICAgMG0yMC4xMDdzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgxNDA5
MTMyNi4xNjE3My0xLXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVk
b3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

