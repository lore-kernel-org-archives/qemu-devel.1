Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65A3C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABAC205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 20:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABAC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq0q2-0003Da-Mv
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 15:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iq0pT-0002mt-Pp
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iq0pS-0004wa-5b
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 15:24:23 -0500
Resent-Date: Fri, 10 Jan 2020 15:24:23 -0500
Resent-Message-Id: <E1iq0pS-0004wa-5b@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iq0pR-0004nc-TU; Fri, 10 Jan 2020 15:24:22 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578687751055446.33831207363085;
 Fri, 10 Jan 2020 12:22:31 -0800 (PST)
In-Reply-To: <20200110194158.14190-1-vsementsov@virtuozzo.com>
Subject: Re: [Xen-devel] [PATCH v6 00/11] error: auto propagated local_err
 part I
Message-ID: <157868774947.15422.14658847667190512659@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 10 Jan 2020 12:22:31 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mdroth@linux.vnet.ibm.com,
 qemu-block@nongnu.org, paul@xen.org, philmd@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, groug@kaod.org, sstabellini@kernel.org,
 kraxel@redhat.com, stefanha@redhat.com, anthony.perard@citrix.com,
 xen-devel@lists.xenproject.org, mreitz@redhat.com, lersek@redhat.com,
 armbru@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExMDE5NDE1OC4xNDE5
MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1hlbi1kZXZlbF0gW1BBVENIIHY2IDAwLzExXSBl
cnJvcjogYXV0byBwcm9wYWdhdGVkIGxvY2FsX2VyciBwYXJ0IEkKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMjAwMTEwMTk0MTU4LjE0MTkwLTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwpmZWUwZGQyIHhlbjogaW50cm9kdWNlIEVSUlBfQVVUT19QUk9QQUdBVEUKOTA3
NGI0NSBuYmQ6IGludHJvZHVjZSBFUlJQX0FVVE9fUFJPUEFHQVRFCjA1NjMyY2IgVFBNOiBpbnRy
b2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURQoyYTAxOWNkIHZpcnRpby05cDogaW50cm9kdWNlIEVS
UlBfQVVUT19QUk9QQUdBVEUKYjRlMDUyNSBmd19jZmc6IGludHJvZHVjZSBFUlJQX0FVVE9fUFJP
UEFHQVRFCjNhNjk4MDAgcGZsYXNoOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURQpmNGFj
ODcwIFNEIChTZWN1cmUgQ2FyZCk6IGludHJvZHVjZSBFUlJQX0FVVE9fUFJPUEFHQVRFCjI5ZmJj
MWQgaHcvc2Qvc3NpLXNkOiBmaXggZXJyb3IgaGFuZGxpbmcgaW4gc3NpX3NkX3JlYWxpemUKNmVi
YzU3YSBzY3JpcHRzOiBhZGQgY29jY2luZWxsZSBzY3JpcHQgdG8gdXNlIGF1dG8gcHJvcGFnYXRl
ZCBlcnJwCjQ3N2I5ZWMgZXJyb3I6IGF1dG8gcHJvcGFnYXRlZCBsb2NhbF9lcnIKMGMzODkxNCBx
YXBpL2Vycm9yOiBhZGQgKEVycm9yICoqZXJycCkgY2xlYW5pbmcgQVBJcwoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KMS8xMSBDaGVja2luZyBjb21taXQgMGMzODkxNDc1OTFhIChxYXBpL2Vycm9yOiBh
ZGQgKEVycm9yICoqZXJycCkgY2xlYW5pbmcgQVBJcykKMi8xMSBDaGVja2luZyBjb21taXQgNDc3
YjllYzAzODk4IChlcnJvcjogYXV0byBwcm9wYWdhdGVkIGxvY2FsX2VycikKRVJST1I6IE1hY3Jv
cyB3aXRoIG11bHRpcGxlIHN0YXRlbWVudHMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIGEgZG8gLSB3
aGlsZSBsb29wCiMxMzg6IEZJTEU6IGluY2x1ZGUvcWFwaS9lcnJvci5oOjQyODoKKyNkZWZpbmUg
RVJSUF9BVVRPX1BST1BBR0FURSgpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
KyAgICBnX2F1dG8oRXJyb3JQcm9wYWdhdG9yKSBfYXV0b19lcnJwX3Byb3AgPSB7LmVycnAgPSBl
cnJwfTsgIFwKKyAgICBlcnJwID0gKChlcnJwID09IE5VTEwgfHwgKmVycnAgPT0gZXJyb3JfZmF0
YWwpICAgICAgICAgICAgIFwKKyAgICAgICAgICAgID8gJl9hdXRvX2VycnBfcHJvcC5sb2NhbF9l
cnIgOiBlcnJwKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDIgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8xMSBDaGVja2luZyBj
b21taXQgNmViYzU3YTk0Y2YwIChzY3JpcHRzOiBhZGQgY29jY2luZWxsZSBzY3JpcHQgdG8gdXNl
IGF1dG8gcHJvcGFnYXRlZCBlcnJwKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBm
aWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyNTogCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDE0OCBsaW5lcyBjaGVja2Vk
CgpQYXRjaCAzLzExIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjQvMTEgQ2hlY2tpbmcgY29t
bWl0IDI5ZmJjMWQ2MWViMSAoaHcvc2Qvc3NpLXNkOiBmaXggZXJyb3IgaGFuZGxpbmcgaW4gc3Np
X3NkX3JlYWxpemUpCjUvMTEgQ2hlY2tpbmcgY29tbWl0IGY0YWM4NzA2NWYyYyAoU0QgKFNlY3Vy
ZSBDYXJkKTogaW50cm9kdWNlIEVSUlBfQVVUT19QUk9QQUdBVEUpCjYvMTEgQ2hlY2tpbmcgY29t
bWl0IDNhNjk4MDAzMzFhNCAocGZsYXNoOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURSkK
Ny8xMSBDaGVja2luZyBjb21taXQgYjRlMDUyNWQzZGNmIChmd19jZmc6IGludHJvZHVjZSBFUlJQ
X0FVVE9fUFJPUEFHQVRFKQo4LzExIENoZWNraW5nIGNvbW1pdCAyYTAxOWNkMWY5OTIgKHZpcnRp
by05cDogaW50cm9kdWNlIEVSUlBfQVVUT19QUk9QQUdBVEUpCjkvMTEgQ2hlY2tpbmcgY29tbWl0
IDA1NjMyY2JlMmQzOSAoVFBNOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURSkKMTAvMTEg
Q2hlY2tpbmcgY29tbWl0IDkwNzRiNDUwY2IzNCAobmJkOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BS
T1BBR0FURSkKMTEvMTEgQ2hlY2tpbmcgY29tbWl0IGZlZTBkZDI2ZWEwYiAoeGVuOiBpbnRyb2R1
Y2UgRVJSUF9BVVRPX1BST1BBR0FURSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAxMTAxOTQxNTguMTQxOTAtMS12c2VtZW50c292QHZpcnR1
b3p6by5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


