Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52898C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2806820781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2806820781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqg6l-0000eC-Dz
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqg4g-0006BH-96; Wed, 01 Jul 2020 12:59:06 -0400
Resent-Date: Wed, 01 Jul 2020 12:59:06 -0400
Resent-Message-Id: <E1jqg4g-0006BH-96@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqg4d-0006PW-LE; Wed, 01 Jul 2020 12:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593622737; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jX2PM4stYKQoTd6nQ4ayt4ddVF1W7RtVSOqk5JWDFl8A0f6L14DmfSlKNCd/pQTSiMpGsh6bFVOKZSfaGH4ltHSGduJTNeRQ5Yk5UzJRN9xo8rk7sxOH4yCk0pKHNNGp0/0uCL1kqAVmWU0H96zQzUQF1PZVWD1qqdnvpszAfJA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593622737;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6OB8hnU0SOHsQMIeJr+yaGjAlUFfSKBL86MgTTEy6ik=; 
 b=UPLB9PZXgM38jNEykyadjp3jfipuLS23Z7ipB+4Hh6/9Vkh8fJCib3ZNmPPBR5ESESMgBNUbhehhTEojuJ17bOIHVTtcswfD9pRFZiDmi4tetufjxGy8eSC58r94z6Zj1uf/NtW0NHrA9wabG9kfPLvw+Tqhx40VgCXjNarSQg4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159362273512595.85980689869552;
 Wed, 1 Jul 2020 09:58:55 -0700 (PDT)
Message-ID: <159362273389.26405.7163118057791066597@d1fd068a5071>
Subject: Re: [PATCH 0/3] block: improve error reporting for unsupported
 O_DIRECT
In-Reply-To: <20200701160509.1523847-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Wed, 1 Jul 2020 09:58:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:59:01
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMTE2MDUwOS4xNTIz
ODQ3LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgorKysgL3RtcC9xZW11LXRl
c3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLzIyNi5vdXQuYmFkIDIwMjAtMDctMDEgMTY6NTg6
MTEuMzIxMDI5NzE3ICswMDAwCkBAIC02LDcgKzYsNyBAQAogcWVtdS1pbzogY2FuJ3Qgb3Blbjog
QSByZWd1bGFyIGZpbGUgd2FzIGV4cGVjdGVkIGJ5IHRoZSAnZmlsZScgZHJpdmVyLCBidXQgc29t
ZXRoaW5nIGVsc2Ugd2FzIGdpdmVuCiBxZW11LWlvOiB3YXJuaW5nOiBPcGVuaW5nIGEgY2hhcmFj
dGVyIGRldmljZSBhcyBhIGZpbGUgdXNpbmcgdGhlICdmaWxlJyBkcml2ZXIgaXMgZGVwcmVjYXRl
ZAogPT0gVGVzdGluZyBSVyA9PQotcWVtdS1pbzogY2FuJ3Qgb3BlbjogQ291bGQgbm90IG9wZW4g
J1RFU1RfRElSL3QuSU1HRk1UJzogSXMgYSBkaXJlY3RvcnkKK3FlbXUtaW86IGNhbid0IG9wZW46
IFVuYWJsZSB0byBvcGVuICdURVNUX0RJUi90LklNR0ZNVCcgZmxhZ3MgMHgyOiBJcyBhIGRpcmVj
dG9yeQogcWVtdS1pbzogd2FybmluZzogT3BlbmluZyBhIGNoYXJhY3RlciBkZXZpY2UgYXMgYSBm
aWxlIHVzaW5nIHRoZSAnZmlsZScgZHJpdmVyIGlzIGRlcHJlY2F0ZWQKIAogPT09IFRlc3Rpbmcg
d2l0aCBkcml2ZXI6aG9zdF9kZXZpY2UgPT09CkBAIC0xNCwxMyArMTQsMTMgQEAKLS0tCk5vdCBy
dW46IDI1OQpGYWlsdXJlczogMDYxIDA2OSAxMTEgMjI2IDI0NApGYWlsZWQgNSBvZiAxMTkgaW90
ZXN0cwptYWtlOiAqKiogW2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDY2OSwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTY3MjI4YTcwZTc4NDRkNzBiMDdhODY0
ZmVmNWM0NTY5JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXkycXV6cWZiL3NyYy9k
b2NrZXItc3JjLjIwMjAtMDctMDEtMTIuNDEuMTIuMjM1Mzg6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPTY3MjI4YTcwZTc4NDRkNzBiMDdhODY0ZmVmNWM0NTY5Cm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXkycXV6cWZiL3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxN200MS44OTJzCnVzZXIg
ICAgMG01Ljc5MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwNzAxMTYwNTA5LjE1MjM4NDctMS1iZXJyYW5nZUByZWRoYXQuY29tL3Rl
c3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

