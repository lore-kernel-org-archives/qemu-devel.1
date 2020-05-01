Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7055EC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 07:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB2020787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 07:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB2020787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUPh1-0001xP-7R
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 03:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUPfn-0000Vj-Je
 for qemu-devel@nongnu.org; Fri, 01 May 2020 03:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUPfl-0008Nz-7D
 for qemu-devel@nongnu.org; Fri, 01 May 2020 03:01:23 -0400
Resent-Date: Fri, 01 May 2020 03:01:23 -0400
Resent-Message-Id: <E1jUPfl-0008Nz-7D@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUPfk-0008GQ-LQ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 03:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588316475; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U2xlpRw2dAHno61hmDxz8Nhu6kN6pJ/vX7S1fKg1cN34xGOMDH25Qp0hxoOnX+PotlNlHN9d3L38shjdBJhZpnC6DdRaSgkVL6YFdMULl6gB6WJN2IMwmMCnqjLPbzbAeaoc1bAVjlGFNvPtDvfrwtloZBeQPgU2/s7+505hNv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588316475;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IH38GOTP+RGXh84C8MdnWy2KnJhK7yjW2o/LMvwGiGM=; 
 b=hO0s6Ls3mNMHCM107erqpxCfAUpCv9pEqwCIv9LHuUIV0In92OVBkFqt14MMEQHJyJBgXwqQejRNiCxBRnPOoBFndCdYVvfW3NgTACQ7hLaNvfvsdV8ek7DcBr2JwyEakA0szEbVrIu9ExYDgmoP071ApkdDE05u7UVD8LwVFUk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158831647327383.35725997228269;
 Fri, 1 May 2020 00:01:13 -0700 (PDT)
Message-ID: <158831647220.4471.4518162164537347990@45ef0f9c86ae>
In-Reply-To: <20200430190122.4592-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/9] gdbstub/next
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 1 May 2020 00:01:13 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 02:18:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQzMDE5MDEyMi40NTky
LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA0MzAxOTAxMjIuNDU5Mi0xLWFsZXguYmVu
bmVlQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIICB2MSAwLzldIGdkYnN0dWIvbmV4dApUeXBl
OiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1w
YXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNo
LnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBz
Oi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBw
YXRjaGV3LzIwMjAwNDMwMTkwMTIyLjQ1OTItMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnIC0+IHBh
dGNoZXcvMjAyMDA0MzAxOTAxMjIuNDU5Mi0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcKU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpjYmVhYTAxIHRhcmdldC9tNjhrOiBmaXggZ2RiIGZv
ciBtNjh4eHgKMGVmOWZjNCB0ZXN0cy90Y2c6IGFkZCBhIG11bHRpYXJjaCBsaW51eC11c2VyIGdk
YiB0ZXN0CjJlYWVmNTkgdGVzdHMvZ3Vlc3QtZGVidWc6IHVzZSB0aGUgdW5peCBzb2NrZXQgZm9y
IGxpbnV4LXVzZXIgdGVzdHMKYzA2MzViYyBnZGJzdHViL2xpbnV4LXVzZXI6IHN1cHBvcnQgZGVi
dWdnaW5nIG92ZXIgYSB1bml4IHNvY2tldApiYzdmYmRhIGdkYnN0dWI6IGVsaW1pbmF0ZSBnZGJz
ZXJ2ZXJfZmQgZ2xvYmFsCjlmYzViMWYgdGVzdHMvdGNnOiBkcm9wIGluZmVyaW9yLndhc19hdHRh
Y2hlZCgpIHRlc3QKZDVhYmMxYSB0ZXN0cy90Y2c6IGJldHRlciB0cmFwIGdkYiBmYWlsdXJlcwo0
M2FiMTAxIGdkYnN0dWI6IEludHJvZHVjZSBnZGJfZ2V0X2Zsb2F0NjQoKSB0byBnZXQgNjQtYml0
IGZsb2F0IHJlZ2lzdGVycwpiMjA4NWIzIGNvbmZpZ3VyZTogZmF2b3VyIGdkYi1tdWx0aWFyY2gg
aWYgd2UgaGF2ZSBpdAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCBi
MjA4NWIzMzYzNzIgKGNvbmZpZ3VyZTogZmF2b3VyIGdkYi1tdWx0aWFyY2ggaWYgd2UgaGF2ZSBp
dCkKMi85IENoZWNraW5nIGNvbW1pdCA0M2FiMTAxYWUwNTcgKGdkYnN0dWI6IEludHJvZHVjZSBn
ZGJfZ2V0X2Zsb2F0NjQoKSB0byBnZXQgNjQtYml0IGZsb2F0IHJlZ2lzdGVycykKMy85IENoZWNr
aW5nIGNvbW1pdCBkNWFiYzFhMTAyMTEgKHRlc3RzL3RjZzogYmV0dGVyIHRyYXAgZ2RiIGZhaWx1
cmVzKQo0LzkgQ2hlY2tpbmcgY29tbWl0IDlmYzViMWY1NmZiZCAodGVzdHMvdGNnOiBkcm9wIGlu
ZmVyaW9yLndhc19hdHRhY2hlZCgpIHRlc3QpCjUvOSBDaGVja2luZyBjb21taXQgYmM3ZmJkYTlm
N2U0IChnZGJzdHViOiBlbGltaW5hdGUgZ2Ric2VydmVyX2ZkIGdsb2JhbCkKRVJST1I6IHN1c3Bl
Y3QgY29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDIsIDYpCiMzNDogRklM
RTogZ2Ric3R1Yi5jOjI5NjU6CisgIGlmIChnZGJzZXJ2ZXJfc3RhdGUuZmQgPCAwKSB7CiAgICAg
ICByZXR1cm47Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDc0IGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDUvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi85IENoZWNraW5nIGNvbW1p
dCBjMDYzNWJjM2IwZTAgKGdkYnN0dWIvbGludXgtdXNlcjogc3VwcG9ydCBkZWJ1Z2dpbmcgb3Zl
ciBhIHVuaXggc29ja2V0KQpFUlJPUjogc3VzcGVjdCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9u
YWwgc3RhdGVtZW50cyAoMiwgNikKIzY3OiBGSUxFOiBnZGJzdHViLmM6Mjk2NjoKKyAgaWYgKGdk
YnNlcnZlcl9zdGF0ZS5zb2NrZXRfcGF0aCkgeworICAgICAgdW5saW5rKGdkYnNlcnZlcl9zdGF0
ZS5zb2NrZXRfcGF0aCk7CgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBh
cmVudGhlc2lzICcoJwojOTM6IEZJTEU6IGdkYnN0dWIuYzozMDg4OgorICAgIGZvcig7OykgewoK
dG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMjAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi85
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo3LzkgQ2hlY2tpbmcgY29tbWl0IDJlYWVmNTk0
M2NhNiAodGVzdHMvZ3Vlc3QtZGVidWc6IHVzZSB0aGUgdW5peCBzb2NrZXQgZm9yIGxpbnV4LXVz
ZXIgdGVzdHMpCjgvOSBDaGVja2luZyBjb21taXQgMGVmOWZjNGU0N2E5ICh0ZXN0cy90Y2c6IGFk
ZCBhIG11bHRpYXJjaCBsaW51eC11c2VyIGdkYiB0ZXN0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQg
b3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM3NTog
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDEyNCBs
aW5lcyBjaGVja2VkCgpQYXRjaCA4LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOS85IENo
ZWNraW5nIGNvbW1pdCBjYmVhYTAxNDUyMGIgKHRhcmdldC9tNjhrOiBmaXggZ2RiIGZvciBtNjh4
eHgpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRB
SU5FUlMgbmVlZCB1cGRhdGluZz8KIzUxOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAw
IGVycm9ycywgMSB3YXJuaW5ncywgMTA1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDkvOSBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDIwMDQzMDE5MDEyMi40NTkyLTEtYWxleC5iZW5uZWVAbGluYXJvLm9y
Zy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

