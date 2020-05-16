Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAADC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 12:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E6020671
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 12:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E6020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZwJ3-000056-RB
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 08:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZwI4-0007k2-AW; Sat, 16 May 2020 08:51:44 -0400
Resent-Date: Sat, 16 May 2020 08:51:44 -0400
Resent-Message-Id: <E1jZwI4-0007k2-AW@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZwI2-0004e0-JZ; Sat, 16 May 2020 08:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589633489; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SamtjRV3tPsY9QtyER3Lb0HMKt/ao+bSuXqjZtMLQNrOfsEbWamPknplZcMvqu1HGbpYXGCqgNgYd80wJ9dOVs/Ut9dwBRzMxXT2Owcja2fKgqyTwKDMRYQYWh6NONeYKd/Iuh77dkJ4e8nR77ZLZahITuNl4xh85hxE4/DaqxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589633489;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=UA7jCdAdM9fsssXLmW13B1unNTexzTCFnXGrB4ADL+M=; 
 b=bZqY6UYYozvATAiAhKa/At5uJSC/WJpENvmxmViaf2j/DNpWhRJ0kLhbLtqxnjlzAyISfAVQZH7XRiNMwCDOP7ILtx2o6d8DI7dSreHZxTbRWN770guZfs2aPn1TJWF4UFpOONfygxZsFPD297sFn1qiRSZuWlcS6IIvjmVlZdQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589633486691482.6198632074811;
 Sat, 16 May 2020 05:51:26 -0700 (PDT)
Message-ID: <158963348462.15373.17975661021707545167@45ef0f9c86ae>
In-Reply-To: <20200515150421.25479-1-kraxel@redhat.com>
Subject: Re: [PATCH v6 00/16] acpi: i386 tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Sat, 16 May 2020 05:51:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 06:59:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: lvivier@redhat.com, kwolf@redhat.com, thuth@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, marcandre.lureau@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, jsnow@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNTE1MDQyMS4yNTQ3
OS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUxNTE1MDQyMS4yNTQ3OS0xLWtyYXhlbEByZWRo
YXQuY29tClN1YmplY3Q6IFtQQVRDSCB2NiAwMC8xNl0gYWNwaTogaTM4NiB0d2Vha3MKVHlwZTog
c2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCjlhZGIyOGQgYWNwaTogcTM1OiBkcm9wIF9TQi5QQ0kwLklTQS5MUENEIG9w
cmVnaW9uLgo2NDZhMTA4IGFjcGk6IGRyb3AgYnVpbGRfcGlpeDRfcG0oKQo2MzI0YmJhIGFjcGk6
IGRyb3Agc2VyaWFsL3BhcmFsbGVsIGVuYWJsZSBiaXRzIGZyb20gZHNkdAo0YThjZWI4IGFjcGk6
IHNpbXBsaWZ5IGJ1aWxkX2lzYV9kZXZpY2VzX2FtbCgpCmQ4Y2NjNmYgYWNwaTogZmFjdG9yIG91
dCBmd19jZmdfYWRkX2FjcGlfZHNkdCgpCmUwYzVmYzQgYWNwaTogbW92ZSBhbWwgYnVpbGRlciBj
b2RlIGZvciBpODA0MiAoa2JkK21vdXNlKSBkZXZpY2UKNGViMGNjMCBmbG9wcHk6IG1vdmUgY21v
c19nZXRfZmRfZHJpdmVfdHlwZSgpIGZyb20gcGMKNzFkNTZmYSBmbG9wcHk6IG1ha2UgaXNhX2Zk
Y19nZXRfZHJpdmVfbWF4X2NocyBzdGF0aWMKYzg5NWExNiBhY3BpOiBtb3ZlIGFtbCBidWlsZGVy
IGNvZGUgZm9yIGZsb3BweSBkZXZpY2UKNDFlMzJkNCBhY3BpOiBtb3ZlIGFtbCBidWlsZGVyIGNv
ZGUgZm9yIHBhcmFsbGVsIGRldmljZQpmZTQxODgxIGFjcGk6IHBhcmFsbGVsOiBkb24ndCB1c2Ug
X1NUQSBtZXRob2QKYmNiNWFlNCBhY3BpOiBtb3ZlIGFtbCBidWlsZGVyIGNvZGUgZm9yIHNlcmlh
bCBkZXZpY2UKNDllMTFmOSBhY3BpOiBzZXJpYWw6IGRvbid0IHVzZSBfU1RBIG1ldGhvZAo2ZTdh
ZTVkIGFjcGk6IHJ0YzogdXNlIGEgc2luZ2xlIGNycyByYW5nZQplMWIxMjk0IGFjcGk6IG1vdmUg
YW1sIGJ1aWxkZXIgY29kZSBmb3IgcnRjIGRldmljZQoxMGZjMmQ0IHF0ZXN0OiBhbGxvdyBEU0RU
IGFjcGkgdGFibGUgY2hhbmdlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNiBDaGVja2luZyBj
b21taXQgMTBmYzJkNDVhNmZhIChxdGVzdDogYWxsb3cgRFNEVCBhY3BpIHRhYmxlIGNoYW5nZXMp
CjIvMTYgQ2hlY2tpbmcgY29tbWl0IGUxYjEyOTRkYTkzNyAoYWNwaTogbW92ZSBhbWwgYnVpbGRl
ciBjb2RlIGZvciBydGMgZGV2aWNlKQozLzE2IENoZWNraW5nIGNvbW1pdCA2ZTdhZTVkMDEzOGIg
KGFjcGk6IHJ0YzogdXNlIGEgc2luZ2xlIGNycyByYW5nZSkKNC8xNiBDaGVja2luZyBjb21taXQg
NDllMTFmOWU5MWY0IChhY3BpOiBzZXJpYWw6IGRvbid0IHVzZSBfU1RBIG1ldGhvZCkKNS8xNiBD
aGVja2luZyBjb21taXQgYmNiNWFlNGRkOGIxIChhY3BpOiBtb3ZlIGFtbCBidWlsZGVyIGNvZGUg
Zm9yIHNlcmlhbCBkZXZpY2UpCjYvMTYgQ2hlY2tpbmcgY29tbWl0IGZlNDE4ODE1NWFjZiAoYWNw
aTogcGFyYWxsZWw6IGRvbid0IHVzZSBfU1RBIG1ldGhvZCkKNy8xNiBDaGVja2luZyBjb21taXQg
NDFlMzJkNGIzNWMzIChhY3BpOiBtb3ZlIGFtbCBidWlsZGVyIGNvZGUgZm9yIHBhcmFsbGVsIGRl
dmljZSkKOC8xNiBDaGVja2luZyBjb21taXQgYzg5NWExNjE0ODQ5IChhY3BpOiBtb3ZlIGFtbCBi
dWlsZGVyIGNvZGUgZm9yIGZsb3BweSBkZXZpY2UpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI0NTogCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDIyMSBsaW5l
cyBjaGVja2VkCgpQYXRjaCA4LzE2IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjkvMTYgQ2hl
Y2tpbmcgY29tbWl0IDcxZDU2ZmE4YjE0NiAoZmxvcHB5OiBtYWtlIGlzYV9mZGNfZ2V0X2RyaXZl
X21heF9jaHMgc3RhdGljKQoxMC8xNiBDaGVja2luZyBjb21taXQgNGViMGNjMDUxODUyIChmbG9w
cHk6IG1vdmUgY21vc19nZXRfZmRfZHJpdmVfdHlwZSgpIGZyb20gcGMpCkVSUk9SOiBNaXNzaW5n
IFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgODIg
bGluZXMgY2hlY2tlZAoKUGF0Y2ggMTAvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjEx
LzE2IENoZWNraW5nIGNvbW1pdCBlMGM1ZmM0NGRlNzYgKGFjcGk6IG1vdmUgYW1sIGJ1aWxkZXIg
Y29kZSBmb3IgaTgwNDIgKGtiZCttb3VzZSkgZGV2aWNlKQoxMi8xNiBDaGVja2luZyBjb21taXQg
ZDhjY2M2ZjA4ZGNkIChhY3BpOiBmYWN0b3Igb3V0IGZ3X2NmZ19hZGRfYWNwaV9kc2R0KCkpCjEz
LzE2IENoZWNraW5nIGNvbW1pdCA0YThjZWI4ZDlkZDkgKGFjcGk6IHNpbXBsaWZ5IGJ1aWxkX2lz
YV9kZXZpY2VzX2FtbCgpKQoxNC8xNiBDaGVja2luZyBjb21taXQgNjMyNGJiYWMyOTg0IChhY3Bp
OiBkcm9wIHNlcmlhbC9wYXJhbGxlbCBlbmFibGUgYml0cyBmcm9tIGRzZHQpCjE1LzE2IENoZWNr
aW5nIGNvbW1pdCA2NDZhMTA4ZjVlY2UgKGFjcGk6IGRyb3AgYnVpbGRfcGlpeDRfcG0oKSkKMTYv
MTYgQ2hlY2tpbmcgY29tbWl0IDlhZGIyOGQ0MGFkMyAoYWNwaTogcTM1OiBkcm9wIF9TQi5QQ0kw
LklTQS5MUENEIG9wcmVnaW9uLikKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDA1MTUxNTA0MjEuMjU0NzktMS1rcmF4ZWxAcmVkaGF0LmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

