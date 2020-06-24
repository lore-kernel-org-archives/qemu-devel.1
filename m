Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A0D2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A0D2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joC3q-0000r5-H6
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joBwU-0007RD-4o
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:24:22 -0400
Resent-Date: Wed, 24 Jun 2020 16:24:22 -0400
Resent-Message-Id: <E1joBwU-0007RD-4o@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joBwP-00036p-7r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:24:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593030244; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AFLlpgq4VVGiF1EOSxib1Xp7ZBTLiVFonUBgvtyueDSW/UOvGh7GfPRIY8uhaEOUIVKMsoJTjvWnUFFqnkNS/efiGUXNxPh3sFkl16CBG0+RgaGGFYEpdMiz5xENAVkd6m3fzQvrzJJMo7R88z5If2Dfu/4DBHIHLMcOKPFH13o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593030244;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/FjwDoMFG89h6Idf0GnW9e9o7QVAk2LdSm4PeTeYWTo=; 
 b=eVA4+VRfNgHdd3sXlYf3OkNWlysXFiGHv+67laFRyvMiWBzb3TwOXrgwTZK+TZCalBetZ79rUW3MxXXdNEAPx+GHQETAEgoBYHjp7GHY1hGkgqv6NZfvUxMSMKeG0URXixOgqfJfaBraXQRYxylAvcwK97iFaYTYA2BhxD6d4Q4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593030242886503.7088571534464;
 Wed, 24 Jun 2020 13:24:02 -0700 (PDT)
Message-ID: <159303024149.15627.16518504633519334059@d1fd068a5071>
Subject: Re: [PATCH v3 0/2] Avoid abort on QMP attempt to add an object with
 duplicate id
In-Reply-To: <20200624194809.26600-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Wed, 24 Jun 2020 13:24:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 16:24:13
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNDE5NDgwOS4yNjYw
MC0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2st
cXRlc3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvcW1wLWNtZC10ZXN0CiAgVEVTVCAgICBpb3Rlc3Qt
cWNvdzI6IDE3NgoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvcW1wLWNt
ZC10ZXN0LmM6MjI1OnRlc3Rfb2JqZWN0X2FkZF93aXRoX2R1cGxpY2F0ZV9pZDogYXNzZXJ0aW9u
IGZhaWxlZDogKHFkaWN0X2hhc2tleShyZXNwLCAicmV0dXJuIikpCkVSUk9SIC0gQmFpbCBvdXQh
IEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9xbXAtY21kLXRlc3QuYzoyMjU6
dGVzdF9vYmplY3RfYWRkX3dpdGhfZHVwbGljYXRlX2lkOiBhc3NlcnRpb24gZmFpbGVkOiAocWRp
Y3RfaGFza2V5KHJlc3AsICJyZXR1cm4iKSkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCkNvdWxk
IG5vdCBhY2Nlc3MgS1ZNIGtlcm5lbCBtb2R1bGU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkK
cWVtdS1zeXN0ZW0teDg2XzY0OiAtYWNjZWwga3ZtOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBrdm06
IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKLS0tCiAgVEVTVCAgICBjaGVjay1xdGVzdC14ODZf
NjQ6IHRlc3RzL3F0ZXN0L3FtcC10ZXN0CiAgVEVTVCAgICBjaGVjay1xdGVzdC14ODZfNjQ6IHRl
c3RzL3F0ZXN0L3FtcC1jbWQtdGVzdAoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMv
cXRlc3QvcW1wLWNtZC10ZXN0LmM6MjI1OnRlc3Rfb2JqZWN0X2FkZF93aXRoX2R1cGxpY2F0ZV9p
ZDogYXNzZXJ0aW9uIGZhaWxlZDogKHFkaWN0X2hhc2tleShyZXNwLCAicmV0dXJuIikpCkVSUk9S
IC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9xbXAtY21k
LXRlc3QuYzoyMjU6dGVzdF9vYmplY3RfYWRkX3dpdGhfZHVwbGljYXRlX2lkOiBhc3NlcnRpb24g
ZmFpbGVkOiAocWRpY3RfaGFza2V5KHJlc3AsICJyZXR1cm4iKSkKbWFrZTogKioqIFtjaGVjay1x
dGVzdC14ODZfNjRdIEVycm9yIDEKICBURVNUICAgIGlvdGVzdC1xY293MjogMjIwCiAgVEVTVCAg
ICBpb3Rlc3QtcWNvdzI6IDIyNgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAyMjkKLS0tCiAgICBy
YWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFBy
b2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1s
YWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTYwY2UyNmFiNjBlMzQ0M2Q5ODQ2MjNiNzc3
NWMzY2FlJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZp
bmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12Jywg
Jy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZ4ZGV0MXRjL3NyYy9kb2Nr
ZXItc3JjLjIwMjAtMDYtMjQtMTYuMTEuMzIuMTI1NzA6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPTYwY2UyNmFiNjBlMzQ0M2Q5ODQ2MjNiNzc3NWMzY2FlCm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZ4ZGV0MXRjL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxMm0yOC44MTVzCnVzZXIgICAg
MG04LjQ5MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwNjI0MTk0ODA5LjI2NjAwLTEtZXJpYy5hdWdlckByZWRoYXQuY29tL3Rlc3Rp
bmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

