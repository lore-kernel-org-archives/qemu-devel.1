Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA98C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E6324182
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 09:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E6324182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVt9C-000661-Ss
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 05:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVt85-0004Xv-3G; Fri, 23 Oct 2020 05:12:57 -0400
Resent-Date: Fri, 23 Oct 2020 05:12:57 -0400
Resent-Message-Id: <E1kVt85-0004Xv-3G@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVt82-0004jK-Hb; Fri, 23 Oct 2020 05:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603444363; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QLxUH0ZvgKCmUDJ5SsybGVpw8r6fDSXEhANRw5UUfJ8BJUEqdYq5EfoSTiyeVPs1QTa0dcX3KE0FauFv6pTrMxPn/KXl9QLS9SMwFcziv9aBxJJfjMBePHD161xMwkYJJkdTlLPCfdcXPX50RdYL0X+w+bAd4AIWonnJRpSDqII=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603444363;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=g8zbOrwzOMrjh5uTA9EO0lQKHF5O6PEBteRMpROlEfI=; 
 b=mc1WAJ1Pa2prP1xnfkCIlZF0EM7WdRUIIl1zpVmg4kLdYoSUiVGs2iI52hLH5iOa4pPa0EsgK9sg6SKziodhtsbRdCqPnTAcTbGC9ByRPriHbkAYkn8DP7h74ewIu56695m2dCT6V4TwZ+U+M8CeFehEqxj0XKuCLxZ4Wk7B30c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603444360964852.0995928118759;
 Fri, 23 Oct 2020 02:12:40 -0700 (PDT)
Subject: Re: [PATCH] virtio-net: Add check for mac address while peer is vdpa
Message-ID: <160344435949.26284.12794378379370899524@66eaa9a8a123>
In-Reply-To: <20201023090743.3023-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lulu@redhat.com
Date: Fri, 23 Oct 2020 02:12:40 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 05:12:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: jasowang@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 lulu@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAyMzA5MDc0My4zMDIz
LTEtbHVsdUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMjMwOTA3NDMuMzAyMy0xLWx1
bHVAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0hdIHZpcnRpby1uZXQ6IEFkZCBjaGVjayBmb3Ig
bWFjIGFkZHJlc3Mgd2hpbGUgcGVlciBpcyB2ZHBhCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFn
IHVwZGF0ZV0gICAgICBwYXRjaGV3LzE2MDM0Mzg1NDkxMi44NDYwLjE3OTE1MjM4NTE3Nzk5MTMy
MzcxLnN0Z2l0QHBhc2hhLVRoaW5rUGFkLVgyODAgLT4gcGF0Y2hldy8xNjAzNDM4NTQ5MTIuODQ2
MC4xNzkxNTIzODUxNzc5OTEzMjM3MS5zdGdpdEBwYXNoYS1UaGlua1BhZC1YMjgwCiAtIFt0YWcg
dXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDEwMjMwNjQ2MTguMjE0MDktMS1rcmF4ZWxAcmVkaGF0
LmNvbSAtPiBwYXRjaGV3LzIwMjAxMDIzMDY0NjE4LjIxNDA5LTEta3JheGVsQHJlZGhhdC5jb20K
IC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMTAyMzA3MzM1MS4yNTEzMzItMS10aHV0
aEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDEwMjMwNzMzNTEuMjUxMzMyLTEtdGh1dGhAcmVk
aGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMDIzMDkwNzQzLjMwMjMt
MS1sdWx1QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMTAyMzA5MDc0My4zMDIzLTEtbHVsdUBy
ZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZTFjYzEzYiB2aXJ0aW8t
bmV0OiBBZGQgY2hlY2sgZm9yIG1hYyBhZGRyZXNzIHdoaWxlIHBlZXIgaXMgdmRwYQoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KRVJST1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90
YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxOSBsaW5lcyBjaGVja2VkCgpDb21taXQgZTFjYzEz
YjhiYzc3ICh2aXJ0aW8tbmV0OiBBZGQgY2hlY2sgZm9yIG1hYyBhZGRyZXNzIHdoaWxlIHBlZXIg
aXMgdmRwYSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDEwMjMwOTA3NDMuMzAyMy0xLWx1bHVA
cmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

