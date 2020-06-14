Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCEAC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 05:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2432068E
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 05:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2432068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkKsa-0007xw-Jq
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 01:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkKrs-0007JK-BS
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 01:07:40 -0400
Resent-Date: Sun, 14 Jun 2020 01:07:40 -0400
Resent-Message-Id: <E1jkKrs-0007JK-BS@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkKrp-0001n6-Ie
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 01:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592111245; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FbzVLzp67SsKDhBDVx09WId4ndksJM5QonLmT6+wo6JjkMLBkawlP+3YaJGkU4C+oGyiOyi3mIcX94R8fChanka6+glATDASK5Jm76CpAPCVzVueOj7kvVB0JriP2kLTf0Hd6of6sm+vgo2+GOgbMJUUUwkg4duz4UH2BmHnS6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592111245;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=usHEldY7kyrvx8NTOnNdUhRD2ST+ThniFgV2hq5JJtA=; 
 b=WIt7ySBf/kGOJf4T01M3XHGcU1uY4vOXF4jRbeLce5Z30G6QpB/pQ9bvXtHoBSLnMZMxWMGwkk875WvDZyKdG5kytx/7wIQnEVNys+fqVJCsnLArLdAyCGjPDCrNFumBh7aHbj/YCAhWqE+zj27ZnfNN6HnEUVc5c0aGPEuSOwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592111243886948.7510833390213;
 Sat, 13 Jun 2020 22:07:23 -0700 (PDT)
Message-ID: <159211124274.19484.12825687467159237622@45ef0f9c86ae>
In-Reply-To: <20200613040518.38172-1-geoff@hostfission.com>
Subject: Re: [PATCH 0/6] audio/jack: fixes to overall jack behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: geoff@hostfission.com
Date: Sat, 13 Jun 2020 22:07:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 23:24:32
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
Cc: geoff@hostfission.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMzA0MDUxOC4zODE3
Mi0xLWdlb2ZmQGhvc3RmaXNzaW9uLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MTMwNDA1MTguMzgxNzItMS1nZW9mZkBo
b3N0Zmlzc2lvbi5jb20KU3ViamVjdDogW1BBVENIIDAvNl0gYXVkaW8vamFjazogZml4ZXMgdG8g
b3ZlcmFsbCBqYWNrIGJlaGF2aW91cgpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYzk2MjM1MiBhdWRpby9q
YWNrOiBzaW1wbGlmeSB0aGUgcmUtaW5pdCBjb2RlIHBhdGgKMWI4MGM2ZSBhdWRpby9qYWNrOiBo
b25vdXIgdGhlIGVuYWJsZSBzdGF0ZSBvZiB0aGUgYXVkaW8gZGV2aWNlCmQ1NDlkNWUwIGF1ZGlv
L2phY2s6IGRvIG5vdCByZW1vdmUgcG9ydHMgd2hlbiBmaW5pc2hpbmcKZDlmM2M4NCBhdWRpby9q
YWNrOiByZW1vdmUgaW52YWxpZCBzZXQgb2YgaW5wdXQgc3VwcG9ydCBib29sCmM2MTI1NTAgYXVk
aW8vamFjazogcmVtb3ZlIHVudXNlZCBzdG9wcGVkIHN0YXRlCjYyZDU3OWUgYXVkaW8vamFjazog
Zml4IGludmFsaWQgbWluaW11bSBidWZmZXIgc2l6ZSBjaGVjawoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KMS82IENoZWNraW5nIGNvbW1pdCA2MmQ1NzllMDBlNTUgKGF1ZGlvL2phY2s6IGZpeCBpbnZh
bGlkIG1pbmltdW0gYnVmZmVyIHNpemUgY2hlY2spCjIvNiBDaGVja2luZyBjb21taXQgYzYxMjU1
MGNiNThlIChhdWRpby9qYWNrOiByZW1vdmUgdW51c2VkIHN0b3BwZWQgc3RhdGUpCjMvNiBDaGVj
a2luZyBjb21taXQgZDlmM2M4NDZlYzJmIChhdWRpby9qYWNrOiByZW1vdmUgaW52YWxpZCBzZXQg
b2YgaW5wdXQgc3VwcG9ydCBib29sKQo0LzYgQ2hlY2tpbmcgY29tbWl0IGQ1NDlkNWUwNWEzMCAo
YXVkaW8vamFjazogZG8gbm90IHJlbW92ZSBwb3J0cyB3aGVuIGZpbmlzaGluZykKNS82IENoZWNr
aW5nIGNvbW1pdCAxYjgwYzZlYjQyZjUgKGF1ZGlvL2phY2s6IGhvbm91ciB0aGUgZW5hYmxlIHN0
YXRlIG9mIHRoZSBhdWRpbyBkZXZpY2UpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhl
IG9wZW4gcGFyZW50aGVzaXMgJygnCiM0MjogRklMRTogYXVkaW8vamFja2F1ZGlvLmM6Mjc3Ogor
ICAgICAgICAgICAgZm9yKGludCBpID0gMDsgaSA8IGMtPm5jaGFubmVsczsgKytpKSB7Cgp0b3Rh
bDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDkxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvNiBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi82IENoZWNraW5nIGNvbW1pdCBjOTYyMzUyMmNmZTAg
KGF1ZGlvL2phY2s6IHNpbXBsaWZ5IHRoZSByZS1pbml0IGNvZGUgcGF0aCkKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MTMwNDA1MTguMzgx
NzItMS1nZW9mZkBob3N0Zmlzc2lvbi5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

