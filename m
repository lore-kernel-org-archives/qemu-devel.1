Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622E5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C6123D1F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C6123D1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsRE-0007Jr-HN
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpsQa-0006tH-9G
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:58:24 -0400
Resent-Date: Mon, 29 Jun 2020 07:58:24 -0400
Resent-Message-Id: <E1jpsQa-0006tH-9G@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpsQW-0007uB-26
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:58:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593431886; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Y5ySpi0Z/vhzePPVC3+rIDMXEobHiJIdLDzjKrIGbes6yF9KsTCMSuL3/RNow2bWNKxu9o31QEkIchmmNlU/S5R30j9JsOoZ7ZQguz3K8fC4JwdcD1Ny1bUbAIuuQ5rnxmJokqb4YciD3VXwuqnM5CHNWLRaKoYFd6FnAbkhaY0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593431886;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TS+UOK3XNhiGK4K+eDT0Bf6tFUUubQG5vsOw66N1FKE=; 
 b=cKKB7R8pTyohZMxAufctG262urzoIZSp94OBERjg44lqNEW1NxF41BrWgKf8YneXrKKZbAI/sPr475Fxo1LUo5R8CWPInlKwG3v+2Z8rEGPe6dxU8c5M6LWoxprDO+iTxOrZcJzQBmjTOdSZ2qHpIbzkuhl5a5kb6z4dY4Vsdec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593431884692653.9063710308493;
 Mon, 29 Jun 2020 04:58:04 -0700 (PDT)
Message-ID: <159343188314.14426.1750235337419962269@d1fd068a5071>
Subject: Re: [PATCH v4 0/3] Avoid abort on QMP attempt to add an object with
 duplicate id
In-Reply-To: <20200629112329.27611-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Mon, 29 Jun 2020 04:58:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 07:58:16
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyOTExMjMyOS4yNzYx
MS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpxZW11LXN5c3RlbS14ODZf
NjQ6IGZhbGxpbmcgYmFjayB0byB0Y2cKICBURVNUICAgIGlvdGVzdC1xY293MjogMTU0CioqCkVS
Uk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9xbXAtY21kLXRlc3QuYzoyMzE6dGVz
dF9vYmplY3RfYWRkX2ZhaWx1cmVfbW9kZXM6IGFzc2VydGlvbiBmYWlsZWQ6IChxZGljdF9oYXNr
ZXkocmVzcCwgInJldHVybiIpKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVz
dC9zcmMvdGVzdHMvcXRlc3QvcW1wLWNtZC10ZXN0LmM6MjMxOnRlc3Rfb2JqZWN0X2FkZF9mYWls
dXJlX21vZGVzOiBhc3NlcnRpb24gZmFpbGVkOiAocWRpY3RfaGFza2V5KHJlc3AsICJyZXR1cm4i
KSkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE1Ngog
IFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxNTgKLS0tCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE3
NwogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxNzkKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3Jj
L3Rlc3RzL3F0ZXN0L3FtcC1jbWQtdGVzdC5jOjIzMTp0ZXN0X29iamVjdF9hZGRfZmFpbHVyZV9t
b2RlczogYXNzZXJ0aW9uIGZhaWxlZDogKHFkaWN0X2hhc2tleShyZXNwLCAicmV0dXJuIikpCkVS
Uk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9xbXAt
Y21kLXRlc3QuYzoyMzE6dGVzdF9vYmplY3RfYWRkX2ZhaWx1cmVfbW9kZXM6IGFzc2VydGlvbiBm
YWlsZWQ6IChxZGljdF9oYXNrZXkocmVzcCwgInJldHVybiIpKQptYWtlOiAqKiogW2NoZWNrLXF0
ZXN0LXg4Nl82NF0gRXJyb3IgMQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxODEKICBURVNUICAg
IGlvdGVzdC1xY293MjogMTg0CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE4NgotLS0KICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxh
YmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OGQ5YzY0M2FmYWZiNGJhYThlZTI2YzIyNjNm
MTRlNzQnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmlu
ZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJF
X09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywg
J1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1hbmdfXzZ1Zi9zcmMvZG9ja2Vy
LXNyYy4yMDIwLTA2LTI5LTA3LjQwLjU3LjI4MTY2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11
OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD04ZDljNjQzYWZhZmI0YmFhOGVlMjZjMjI2M2YxNGU3NAptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1hbmdfXzZ1Zi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTdtNi4xODNzCnVzZXIgICAgMG05
LjQxMXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMjAwNjI5MTEyMzI5LjI3NjExLTEtZXJpYy5hdWdlckByZWRoYXQuY29tL3Rlc3Rpbmcu
ZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

