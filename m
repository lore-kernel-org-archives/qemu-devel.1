Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF5DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5E020656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5E020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJW4-00049w-GK
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtJVV-0003ik-O6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:29:41 -0400
Resent-Date: Wed, 08 Jul 2020 19:29:41 -0400
Resent-Message-Id: <E1jtJVV-0003ik-O6@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtJVT-0001UF-5v
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:29:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594250971; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ne/445VNrvB2z1PuXzPyw1ltYBb3hCf3t9uko1dh2Ly19aYhzAxBHUAy8PFBYSZh795wI7wdJjVwR0KHWRovnXsKkET+XL0BMqjTDAwQDijyk26eOqF15FOIInzCCEBviRU9MkpqhivUnARPHdL9vWXdbvDTLowFb4EiBLUSp18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594250971;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=w88cSucSp6PBtRMTNk4lt+o3GmTG1KUF0nN0JH0ZMlo=; 
 b=bI12ht06fd0Ow+KWuO10TVxJtAP2Dfau+NdX3AIkjXCkHH0Wn6NoDmyi0V0hIdGpx3S/4SYhzm5Zu7QSDfLm0wRM/ECBcgWqqp9Mjf2zEQQqfuGOnu9Y8gE6k7TECTknK1SmRq5CBmGx7ycfvP1gdPx4CRdErV4g6xsN5Gq4dMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594250967962232.4471542345333;
 Wed, 8 Jul 2020 16:29:27 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] Use ACPI PCI hot-plug for q35
Message-ID: <159425096672.14243.10361764063550366178@07a7f0d89f7d>
In-Reply-To: <20200708224615.114077-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jusual@redhat.com
Date: Wed, 8 Jul 2020 16:29:27 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 19:29:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, jusual@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwODIyNDYxNS4xMTQw
NzctMS1qdXN1YWxAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcvYWNwaS90
cG0ubwogIENDICAgICAgaHcvYWNwaS9pcG1pLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkv
aWNoOS5jOiBJbiBmdW5jdGlvbiAnaWNoOV9wbV9pbml0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2FjcGkvaWNoOS5jOjMxNTozNDogZXJyb3I6IHRvbyBtYW55IGFyZ3VtZW50cyB0byBmdW5jdGlv
biAncWJ1c19zZXRfaG90cGx1Z19oYW5kbGVyJwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJmVycm9yX2Fib3J0KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2h3L2lzYS9p
c2EuaDo4OjAsCi0tLQogdm9pZCBxYnVzX3NldF9ob3RwbHVnX2hhbmRsZXIoQnVzU3RhdGUgKmJ1
cywgT2JqZWN0ICpoYW5kbGVyKTsKICAgICAgXgogIENDICAgICAgaHcvYWNwaS9hY3BpLXN0dWIu
bwptYWtlOiAqKiogW2h3L2FjcGkvaWNoOS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBody9hY3BpL2FtbC1idWlsZC1zdHViLm8K
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFBy
b2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBD
b21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9ZThkYWQzYWYwN2YwNDZlNmFjYzA3ZDVhYWIxODU0YjknLCAnLXUn
LCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScs
ICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEn
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1fajNrOHNmaS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3
LTA4LTE5LjI3LjAyLjExMjUyOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1l
OGRhZDNhZjA3ZjA0NmU2YWNjMDdkNWFhYjE4NTRiOQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1fajNrOHNmaS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgMm0yNS4zNTBzCnVzZXIgICAgMG04LjY4NnMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzA4
MjI0NjE1LjExNDA3Ny0xLWp1c3VhbEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNl
bnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

