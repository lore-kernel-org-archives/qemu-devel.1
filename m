Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A1C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B4A20658
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B4A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixW7m-00042p-KP
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ixW70-0003XL-8k
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ixW6x-0003f9-8g
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:13:29 -0500
Resent-Date: Fri, 31 Jan 2020 08:13:29 -0500
Resent-Message-Id: <E1ixW6x-0003f9-8g@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ixW6x-0003d4-3f; Fri, 31 Jan 2020 08:13:27 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580476362147788.3715978295951;
 Fri, 31 Jan 2020 05:12:42 -0800 (PST)
In-Reply-To: <20200131130118.1716-1-vsementsov@virtuozzo.com>
Subject: Re: [Xen-devel] [PATCH v7 00/11] error: auto propagated local_err
 part I
Message-ID: <158047636035.17955.5913248840185467774@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 31 Jan 2020 05:12:42 -0800 (PST)
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mdroth@linux.vnet.ibm.com,
 qemu-block@nongnu.org, paul@xen.org, philmd@redhat.com, qemu-devel@nongnu.org,
 groug@kaod.org, sstabellini@kernel.org, kraxel@redhat.com, stefanha@redhat.com,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, mreitz@redhat.com,
 lersek@redhat.com, armbru@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEzMTEzMDExOC4xNzE2
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbWGVuLWRldmVsXSBbUEFUQ0ggdjcgMDAvMTFdIGVy
cm9yOiBhdXRvIHByb3BhZ2F0ZWQgbG9jYWxfZXJyIHBhcnQgSQpNZXNzYWdlLWlkOiAyMDIwMDEz
MTEzMDExOC4xNzE2LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tClR5cGU6IHNlcmllcwoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11CiAgIDkyODE3MzYuLmFkY2Q2ZTkgIG1hc3RlciAgICAgLT4g
bWFzdGVyCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtu
ZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDAxMzExMzAxMTguMTcxNi0xLXZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbSAtPiBwYXRjaGV3LzIwMjAwMTMxMTMwMTE4LjE3MTYtMS12c2VtZW50c292
QHZpcnR1b3p6by5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiMGY0ODM0IHhl
bjogaW50cm9kdWNlIEVSUlBfQVVUT19QUk9QQUdBVEUKYzcwNDU2MSBuYmQ6IGludHJvZHVjZSBF
UlJQX0FVVE9fUFJPUEFHQVRFCjIzOGI0ZDIgVFBNOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BB
R0FURQo1NmFmNjM0IHZpcnRpby05cDogaW50cm9kdWNlIEVSUlBfQVVUT19QUk9QQUdBVEUKOGRk
NDk3YSBmd19jZmc6IGludHJvZHVjZSBFUlJQX0FVVE9fUFJPUEFHQVRFCmNkNTQ3NTAgcGZsYXNo
OiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURQowMzFkN2VkIFNEIChTZWN1cmUgQ2FyZCk6
IGludHJvZHVjZSBFUlJQX0FVVE9fUFJPUEFHQVRFCjdkYzkxYzUgaHcvc2Qvc3NpLXNkOiBmaXgg
ZXJyb3IgaGFuZGxpbmcgaW4gc3NpX3NkX3JlYWxpemUKNTc0MzVjNCBzY3JpcHRzOiBhZGQgY29j
Y2luZWxsZSBzY3JpcHQgdG8gdXNlIGF1dG8gcHJvcGFnYXRlZCBlcnJwCjA4ODNmMjkgZXJyb3I6
IGF1dG8gcHJvcGFnYXRlZCBsb2NhbF9lcnIKZGYwZGI4MyBxYXBpL2Vycm9yOiBhZGQgKEVycm9y
ICoqZXJycCkgY2xlYW5pbmcgQVBJcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMSBDaGVja2lu
ZyBjb21taXQgZGYwZGI4M2NkMThhIChxYXBpL2Vycm9yOiBhZGQgKEVycm9yICoqZXJycCkgY2xl
YW5pbmcgQVBJcykKMi8xMSBDaGVja2luZyBjb21taXQgMDg4M2YyOTZlZDhmIChlcnJvcjogYXV0
byBwcm9wYWdhdGVkIGxvY2FsX2VycikKRVJST1I6IE1hY3JvcyB3aXRoIG11bHRpcGxlIHN0YXRl
bWVudHMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIGEgZG8gLSB3aGlsZSBsb29wCiMxMzk6IEZJTEU6
IGluY2x1ZGUvcWFwaS9lcnJvci5oOjQyNzoKKyNkZWZpbmUgRVJSUF9BVVRPX1BST1BBR0FURSgp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICBnX2F1dG8oRXJyb3JQcm9w
YWdhdG9yKSBfYXV0b19lcnJwX3Byb3AgPSB7LmVycnAgPSBlcnJwfTsgIFwKKyAgICBlcnJwID0g
KChlcnJwID09IE5VTEwgfHwgKmVycnAgPT0gZXJyb3JfZmF0YWwpICAgICAgICAgICAgIFwKKyAg
ICAgICAgICAgID8gJl9hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnIgOiBlcnJwKQoKdG90YWw6IDEg
ZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xMSBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKMy8xMSBDaGVja2luZyBjb21taXQgNTc0MzVjNDczYmYxIChz
Y3JpcHRzOiBhZGQgY29jY2luZWxsZSBzY3JpcHQgdG8gdXNlIGF1dG8gcHJvcGFnYXRlZCBlcnJw
KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlO
RVJTIG5lZWQgdXBkYXRpbmc/CiMzNDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBl
cnJvcnMsIDEgd2FybmluZ3MsIDE2NyBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzExIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCjQvMTEgQ2hlY2tpbmcgY29tbWl0IDdkYzkxYzU2MDI2MyAoaHcv
c2Qvc3NpLXNkOiBmaXggZXJyb3IgaGFuZGxpbmcgaW4gc3NpX3NkX3JlYWxpemUpCjUvMTEgQ2hl
Y2tpbmcgY29tbWl0IDAzMWQ3ZWRhNGJiYiAoU0QgKFNlY3VyZSBDYXJkKTogaW50cm9kdWNlIEVS
UlBfQVVUT19QUk9QQUdBVEUpCjYvMTEgQ2hlY2tpbmcgY29tbWl0IGNkNTQ3NTA3NDhmNCAocGZs
YXNoOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURSkKNy8xMSBDaGVja2luZyBjb21taXQg
OGRkNDk3YTUwNmJjIChmd19jZmc6IGludHJvZHVjZSBFUlJQX0FVVE9fUFJPUEFHQVRFKQo4LzEx
IENoZWNraW5nIGNvbW1pdCA1NmFmNjM0OTQxZDIgKHZpcnRpby05cDogaW50cm9kdWNlIEVSUlBf
QVVUT19QUk9QQUdBVEUpCjkvMTEgQ2hlY2tpbmcgY29tbWl0IDIzOGI0ZDJjODg2ZiAoVFBNOiBp
bnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURSkKMTAvMTEgQ2hlY2tpbmcgY29tbWl0IGM3MDQ1
NjEwZDI4ZCAobmJkOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FURSkKMTEvMTEgQ2hlY2tp
bmcgY29tbWl0IGIwZjQ4MzQ2MDUzNCAoeGVuOiBpbnRyb2R1Y2UgRVJSUF9BVVRPX1BST1BBR0FU
RSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDAxMzExMzAxMTguMTcxNi0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmNoZWNr
cGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

