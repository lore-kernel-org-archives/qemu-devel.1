Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C9522314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C9522314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itbzk-0003Wi-3A
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 13:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1itbz2-00036Q-IF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1itbyy-0002av-HJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:41:08 -0500
Resent-Date: Mon, 20 Jan 2020 13:41:08 -0500
Resent-Message-Id: <E1itbyy-0002av-HJ@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1itbyy-0002ab-9v
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 13:41:04 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579545650210341.65792329254384;
 Mon, 20 Jan 2020 10:40:50 -0800 (PST)
In-Reply-To: <1579544504-3616-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] target/i386: early MSR initialization + pass down
 host microcode revision for "-cpu host"
Message-ID: <157954564910.492.5136672157542857962@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Mon, 20 Jan 2020 10:40:50 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: vkuznets@redhat.com, liran.alon@oracle.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc5NTQ0NTA0LTM2MTYtMS1n
aXQtc2VuZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTU3OTU0NDUw
NC0zNjE2LTEtZ2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFU
Q0ggMC8zXSB0YXJnZXQvaTM4NjogZWFybHkgTVNSIGluaXRpYWxpemF0aW9uICsgcGFzcyBkb3du
IGhvc3QgbWljcm9jb2RlIHJldmlzaW9uIGZvciAiLWNwdSBob3N0IgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwg
ZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRo
bSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMjlh
Yzk0YiB0YXJnZXQvaTM4Njoga3ZtOiBpbml0aWFsaXplIG1pY3JvY29kZSByZXZpc2lvbiBmcm9t
IEtWTQo1NDUwMmIzIHRhcmdldC9pMzg2OiBhZGQgYSB1Y29kZS1yZXYgcHJvcGVydHkKN2Q2NmEw
YSB0YXJnZXQvaTM4Njoga3ZtOiBpbml0aWFsaXplIGZlYXR1cmUgTVNScyB2ZXJ5IGVhcmx5Cgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IDdkNjZhMGFkNDRlMCAodGFy
Z2V0L2kzODY6IGt2bTogaW5pdGlhbGl6ZSBmZWF0dXJlIE1TUnMgdmVyeSBlYXJseSkKMi8zIENo
ZWNraW5nIGNvbW1pdCA1NDUwMmIzNDQ5MWQgKHRhcmdldC9pMzg2OiBhZGQgYSB1Y29kZS1yZXYg
cHJvcGVydHkpCjMvMyBDaGVja2luZyBjb21taXQgMjlhYzk0YmVjMTUxICh0YXJnZXQvaTM4Njog
a3ZtOiBpbml0aWFsaXplIG1pY3JvY29kZSByZXZpc2lvbiBmcm9tIEtWTSkKV0FSTklORzogbGlu
ZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzIzOiBGSUxFOiB0YXJnZXQvaTM4Ni9jcHUuYzo2NDIxOgor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1TUl9JQTMyX1VDT0RFX1JFVik7CgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMzNzogRklMRTogdGFyZ2V0L2kzODYva3ZtLmM6MjcwMDoKK15JXkleSV5J
XkkgICBNU1JfSUEzMl9VQ09ERV9SRVYpKSB7JAoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdz
LCAyMSBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1Nzk1
NDQ1MDQtMzYxNi0xLWdpdC1zZW5kLWVtYWlsLXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


