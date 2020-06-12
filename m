Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF22C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 03:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D0B20835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 03:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D0B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjah2-0000ym-DJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 23:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjagW-0000Xc-Ah
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 23:48:52 -0400
Resent-Date: Thu, 11 Jun 2020 23:48:52 -0400
Resent-Message-Id: <E1jjagW-0000Xc-Ah@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjagU-0003Rk-5u
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 23:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591933713; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BFKOghMtxrlnXBIDfDIlCIW4XucdU0Z3jAzdW7DkS65bHBNGjm0jXQa1/3/DfCP8ka7atBgJ95BifZe3twkK21t+c9XoDFhsrzogvyk1BnJ7mh72ttIWZ88U9NayS1IzpDInTsUPmETx2KCsHZGadnrj7p9X+CM2AomBj10Cp8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591933713;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NQjMJjogXxzUDEBmdhq9b988foUs9XjTvfAyayVjXBk=; 
 b=RbkjM44V8bV5PXaoJR1ZprvEr5QcnGMl/mv5rreY4LR5nZH8/X4ml0DIXuzoqcobPYuV85E5OYokQSS4zsuiSBjq7lPD4PvKntMjcRzPxfHBv3sSar+NhePl+sjswc1ZTpQn0tYtgZcXbIRSThwa5XXjcdKA9uxHs1xIgTMJPWU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591933710922107.96924738703615;
 Thu, 11 Jun 2020 20:48:30 -0700 (PDT)
Message-ID: <159193370963.1247.6245078748953185577@45ef0f9c86ae>
In-Reply-To: <20200612014606.147691-1-jkz@google.com>
Subject: Re: [PATCH 0/5] linux-user: Support extended clone(CLONE_VM)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jkz@google.com
Date: Thu, 11 Jun 2020 20:48:30 -0700 (PDT)
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: jkz@google.com, riku.voipio@iki.fi, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMjAxNDYwNi4xNDc2
OTEtMS1qa3pAZ29vZ2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgorKysgL3RtcC9xZW11LXRlc3QvYnVp
bGQvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MS5vdXQuYmFkIDIwMjAtMDYtMTIgMDM6NDE6MTQuMDE1
MDc2ODU5ICswMDAwCkBAIC0xLDUgKzEsMzAgQEAKLS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uCitXQVJOSU5HOnFlbXUubWFjaGluZTpxZW11IHJlY2VpdmVk
IHNpZ25hbCA5OiAvdG1wL3FlbXUtdGVzdC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvLi4vLi4v
eDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0IC1kaXNwbGF5IG5vbmUgLXZnYSBub25l
IC1jaGFyZGV2IHNvY2tldCxpZD1tb24scGF0aD0vdG1wL3RtcC5ZSHNYWGdqenlML3FlbXUtMjI1
MDktbW9uaXRvci5zb2NrIC1tb24gY2hhcmRldj1tb24sbW9kZT1jb250cm9sIC1xdGVzdCB1bml4
OnBhdGg9L3RtcC90bXAuWUhzWFhnanp5TC9xZW11LTIyNTA5LXF0ZXN0LnNvY2sgLWFjY2VsIHF0
ZXN0IC1ub2RlZmF1bHRzIC1kaXNwbGF5IG5vbmUgLWFjY2VsIHF0ZXN0IC1kcml2ZSBpZj12aXJ0
aW8saWQ9ZHJpdmUwLGZpbGU9L3RtcC9xZW11LXRlc3QvdGVzdC5pbWcsZm9ybWF0PXFjb3cyLGNh
Y2hlPXdyaXRlYmFjayxhaW89dGhyZWFkcyxub2RlLW5hbWU9dG9wLGJhY2tpbmcubm9kZS1uYW1l
PWJhc2UgLWRyaXZlIGlmPWlkZSxpZD1kcml2ZTEsbWVkaWE9Y2Ryb20KKy4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uRS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uCis9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CitFUlJPUjog
dGVzdF9wYXVzZSAoX19tYWluX18uVGVzdFNpbmdsZUJsb2NrZGV2KQorLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQor
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgorICBGaWxlICIwNDEiLCBsaW5lIDEw
OCwgaW4gdGVzdF9wYXVzZQotLS0KIFJhbiAxMDQgdGVzdHMKIAotT0sKK0ZBSUxFRCAoZXJyb3Jz
PTEpCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0MgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAw
NDMKICBURVNUICAgIGlvdGVzdC1xY293MjogMDQ2Ci0tLQpOb3QgcnVuOiAyNTkKRmFpbHVyZXM6
IDA0MQpGYWlsZWQgMSBvZiAxMTkgaW90ZXN0cwptYWtlOiAqKiogW2NoZWNrLXRlc3RzL2NoZWNr
LWJsb2NrLnNoXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBG
aWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NSwgaW4gPG1vZHVsZT4KICAg
IHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywg
Jy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlk
PTBiOTUzYmI0YzU1MzRhMmY5ZjU0YmJiMDc3YzRhMDYwJywgJy11JywgJzEwMDMnLCAnLS1zZWN1
cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJ
U1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9E
SVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWZ5MXh3cl96L3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMTEtMjMuMzEuMTQuMjky
MDM6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTBiOTUzYmI0YzU1MzRhMmY5
ZjU0YmJiMDc3YzRhMDYwCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZ5MXh3cl96
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoK
cmVhbCAgICAxN20xNS4zNDRzCnVzZXIgICAgMG04LjU1NHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjEyMDE0NjA2LjE0NzY5MS0x
LWprekBnb29nbGUuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

