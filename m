Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8469C83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB33C206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB33C206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTGFB-0002Az-Nz
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTGEQ-0001A7-Mu
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTGEO-0001LM-SG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:44:22 -0400
Resent-Date: Mon, 27 Apr 2020 22:44:22 -0400
Resent-Message-Id: <E1jTGEO-0001LM-SG@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTGEO-0001K2-BR
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588041846; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D5+fzEACtXDIjDppu+XR0lwCkXzoFU53XHRdn0LtNJFe97Q+IKKGeJjALAKfRoBGAYKssijGb9OIfcce31xFxH9ET+Uq8gSlRA6Rt+araSHPGCaOPrlc3Su6hAaQcbp9ZAB2K7jH/+WX7CaWrtOI2X0xcCBHHAjW2pYDcoj9H3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588041846;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=BgdtSM1xUe7TeJeMPUG2X2q7hWY+sIyyDZNOZ+enlG0=; 
 b=fz9sfLIbXzu/auvQPdQKsW7QnFZi30sG1SPH/3QzYnxVUm8i6CrWGgZ9vrrjGktgz8hKd7NK9if0kN2+X6c8/1FFo95cqYiMrtbfu1af9BZCf4LqfjJmd24/exCiteWILoHj68cyua/gSYmp4pEYWsZiHdXADcsUvaMW12O/gpA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588041844030980.3880504533834;
 Mon, 27 Apr 2020 19:44:04 -0700 (PDT)
In-Reply-To: <20200428012810.10877-1-vishal.l.verma@intel.com>
Subject: Re: [PATCH 0/3] account for NVDIMM nodes during SRAT generation
Message-ID: <158804184249.15667.634657454454879088@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vishal.l.verma@intel.com
Date: Mon, 27 Apr 2020 19:44:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 22:44:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: mst@redhat.com, jingqi.liu@intel.com, dave.hansen@linux.intel.com,
 qemu-devel@nongnu.org, vishal.l.verma@intel.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODAxMjgxMC4xMDg3
Ny0xLXZpc2hhbC5sLnZlcm1hQGludGVsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAvM10gYWNjb3VudCBmb3IgTlZESU1N
IG5vZGVzIGR1cmluZyBTUkFUIGdlbmVyYXRpb24KTWVzc2FnZS1pZDogMjAyMDA0MjgwMTI4MTAu
MTA4NzctMS12aXNoYWwubC52ZXJtYUBpbnRlbC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVs
bCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2Uu
Lgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwozNGM1OWQzIHRlc3RzL2FjcGk6IHVwZGF0ZSBleHBlY3RlZCBTUkFUIGZpbGVzCmRjYzk2ZWIg
aHcvYWNwaS1idWlsZDogYWNjb3VudCBmb3IgTlZESU1NIG51bWEgbm9kZXMgaW4gU1JBVAowOGI3
ZWU1IGRpZmZzLWFsbG93ZWQ6IGFkZCB0aGUgU1JBVCBBTUwgdG8gZGlmZnMtYWxsb3dlZAoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KMS8zIENoZWNraW5nIGNvbW1pdCAwOGI3ZWU1ZTdkZGYgKGRpZmZz
LWFsbG93ZWQ6IGFkZCB0aGUgU1JBVCBBTUwgdG8gZGlmZnMtYWxsb3dlZCkKMi8zIENoZWNraW5n
IGNvbW1pdCBkY2M5NmViOTdkNDYgKGh3L2FjcGktYnVpbGQ6IGFjY291bnQgZm9yIE5WRElNTSBu
dW1hIG5vZGVzIGluIFNSQVQpCkVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0
aGVyIHdpdGggdGVzdHMsIGZvbGxvdyBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10
YWJsZXMtdGVzdC5jOiBib3RoIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1k
aWZmLmggYW5kIGh3L2kzODYvYWNwaS1idWlsZC5jIGZvdW5kCgpFUlJPUjogRG8gbm90IGFkZCBl
eHBlY3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cgaW5zdHJ1Y3Rpb25zIGlu
IHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0ZXN0cy9xdGVzdC9iaW9zLXRh
Ymxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oIGFuZCBody9pMzg2L2FjcGktYnVpbGQuYyBmb3VuZAoK
dG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAzMiBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzMg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMyBDaGVja2luZyBjb21taXQgMzRjNTlkM2Ew
MjMyICh0ZXN0cy9hY3BpOiB1cGRhdGUgZXhwZWN0ZWQgU1JBVCBmaWxlcykKRVJST1I6IERvIG5v
dCBhZGQgZXhwZWN0ZWQgZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93IGluc3RydWN0
aW9ucyBpbiB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVzdHMvZGF0YS9h
Y3BpL3BjL1NSQVQuZGltbXB4bSBhbmQgaHcvaTM4Ni9hY3BpLWJ1aWxkLmMgZm91bmQKCkVSUk9S
OiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0aGVyIHdpdGggdGVzdHMsIGZvbGxvdyBp
bnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOiBib3RoIHRlc3Rz
L2RhdGEvYWNwaS9xMzUvU1JBVC5kaW1tcHhtIGFuZCBody9pMzg2L2FjcGktYnVpbGQuYyBmb3Vu
ZAoKRVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQgZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywg
Zm9sbG93IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJv
dGggdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBhbmQgaHcvaTM4
Ni9hY3BpLWJ1aWxkLmMgZm91bmQKCkVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRv
Z2V0aGVyIHdpdGggdGVzdHMsIGZvbGxvdyBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlv
cy10YWJsZXMtdGVzdC5jOiBib3RoIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dl
ZC1kaWZmLmggYW5kIGh3L2kzODYvYWNwaS1idWlsZC5jIGZvdW5kCgp0b3RhbDogNCBlcnJvcnMs
IDAgd2FybmluZ3MsIDEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8zIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDQyODAxMjgxMC4xMDg3Ny0xLXZpc2hhbC5sLnZlcm1hQGludGVsLmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

