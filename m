Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160D0C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5653206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5653206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMAVr-0003PO-18
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 09:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jMAVH-0002wH-D3
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 09:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jMAVF-0001iK-OI
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 09:12:27 -0400
Resent-Date: Wed, 08 Apr 2020 09:12:27 -0400
Resent-Message-Id: <E1jMAVF-0001iK-OI@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jMAVF-0001hV-Gg
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 09:12:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586351516; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ef1ZvdzaI++Cfh1l1YjeZJVb488rjX21g6XOJIDyd9EjSv3y3gT1u3GkoDpy3Qfs5MEuO426JwBfXF2kM2yGbRu7dgpEXGDXzgMU2LgdDGNQxm0FqOSHPW8wS7nDkAuY9X78YaWo/UsrBGDTEN5t3kIEzCzaHuIDYM5F1Wt2Z2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586351516;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9C+Jt2sIKTAIglTBOCGiHQUXFRfnW0Tw6Zv08QGe2rc=; 
 b=EQYXPTxPFlr738iNV7PpXSYCnh2rbcxKibfb6YhTCYonj5pXyry4gYYpmYQuF3jXT77KelgMT9C/4rv408hRp5ru92sghBx+YdpOzzdzQ4AHo69GPthZ8kgwIZleXOa1IApjOKwPzEDdvjQ83K70+q9mm8yXiLOAXxcjfVf+l74=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586351514553576.3659715286441;
 Wed, 8 Apr 2020 06:11:54 -0700 (PDT)
In-Reply-To: <20200408125816.955-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v6 0/8] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Message-ID: <158635151289.18042.161177889541346614@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Wed, 8 Apr 2020 06:11:54 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODEyNTgxNi45NTUt
MS1taWFveXVib0BodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjYgMC84XSBwY2lfZXhwYW5kZXJfYnJkaWdlOmFj
cGk6U3VwcG9ydCBweGItcGNpZSBmb3IgQVJNCk1lc3NhZ2UtaWQ6IDIwMjAwNDA4MTI1ODE2Ljk1
NS0xLW1pYW95dWJvQGh1YXdlaS5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2YTJkZmVh
IHVuaXQtdGVzdDogQWRkIHRoZSBiaW5hcnkgZmlsZSBhbmQgY2xlYXIgZGlmZi5oCjNiNmExNjYg
dW5pdC10ZXN0OiBBZGQgdGVzdGNhc2UgZm9yIHB4YgpjNWQxNTljIHVuaXQtdGVzdDogVGhlIGZp
bGVzIGNoYW5nZWQuCmUzZGQ4OWUgYWNwaTogQWxpZ24gdGhlIHNpemUgdG8gMTI4awowNDNmNWZk
IGFjcGk6IFJlZmFjdG9yIHRoZSBzb3VyY2Ugb2YgaG9zdCBicmlkZ2UgYW5kIGJ1aWxkIHRhYmxl
cyBmb3IgcHhiCjIyZjRkNWMgYWNwaTogRXh0cmFjdCBjcnMgYnVpbGQgZm9ybSBhY3BpX2J1aWxk
LmMKM2MxNjdiZSBmd19jZmc6IFdyaXRlIHRoZSBleHRyYSByb290cyBpbnRvIHRoZSBmd19jZmcK
ZTI3Nzc4NiBhY3BpOiBFeHRyYWN0IHR3byBBUElzIGZyb20gYWNwaV9kc2R0X2FkZF9wY2kKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgZTI3Nzc4NjUyNDczIChhY3Bp
OiBFeHRyYWN0IHR3byBBUElzIGZyb20gYWNwaV9kc2R0X2FkZF9wY2kpCjIvOCBDaGVja2luZyBj
b21taXQgM2MxNjdiZTdlYTUxIChmd19jZmc6IFdyaXRlIHRoZSBleHRyYSByb290cyBpbnRvIHRo
ZSBmd19jZmcpCjMvOCBDaGVja2luZyBjb21taXQgMjJmNGQ1YzNlYjFkIChhY3BpOiBFeHRyYWN0
IGNycyBidWlsZCBmb3JtIGFjcGlfYnVpbGQuYykKNC84IENoZWNraW5nIGNvbW1pdCAwNDNmNWZk
MzA4OTQgKGFjcGk6IFJlZmFjdG9yIHRoZSBzb3VyY2Ugb2YgaG9zdCBicmlkZ2UgYW5kIGJ1aWxk
IHRhYmxlcyBmb3IgcHhiKQo1LzggQ2hlY2tpbmcgY29tbWl0IGUzZGQ4OWUyMTNkYyAoYWNwaTog
QWxpZ24gdGhlIHNpemUgdG8gMTI4aykKNi84IENoZWNraW5nIGNvbW1pdCBjNWQxNTljOGE2YjEg
KHVuaXQtdGVzdDogVGhlIGZpbGVzIGNoYW5nZWQuKQpFUlJPUjogRG8gbm90IGFkZCBleHBlY3Rl
ZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cgaW5zdHJ1Y3Rpb25zIGluIHRlc3Rz
L3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10
ZXN0LWFsbG93ZWQtZGlmZi5oIGFuZCBody9hcm0vdmlydC1hY3BpLWJ1aWxkLmMgZm91bmQKCkVS
Uk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0aGVyIHdpdGggdGVzdHMsIGZvbGxv
dyBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOiBib3RoIHRl
c3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggYW5kIGh3L2FybS92aXJ0
LWFjcGktYnVpbGQuYyBmb3VuZAoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyIGxpbmVz
IGNoZWNrZWQKClBhdGNoIDYvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNy84IENoZWNr
aW5nIGNvbW1pdCAzYjZhMTY2ZTdlY2UgKHVuaXQtdGVzdDogQWRkIHRlc3RjYXNlIGZvciBweGIp
CkVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0aGVyIHdpdGggdGVzdHMsIGZv
bGxvdyBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOiBib3Ro
IHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggYW5kIHRlc3RzL3F0
ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYyBmb3VuZAoKRVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQg
ZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9x
dGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVz
dC1hbGxvd2VkLWRpZmYuaCBhbmQgdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jIGZvdW5k
Cgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDc2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDcv
OCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOC84IENoZWNraW5nIGNvbW1pdCA2YTJkZmVh
MTNiYTMgKHVuaXQtdGVzdDogQWRkIHRoZSBiaW5hcnkgZmlsZSBhbmQgY2xlYXIgZGlmZi5oKQpF
UlJPUjogRG8gbm90IGFkZCBleHBlY3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xs
b3cgaW5zdHJ1Y3Rpb25zIGluIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0
ZXN0cy9kYXRhL2FjcGkvdmlydC9EU0RULnB4YiBhbmQgdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMt
dGVzdC5jIGZvdW5kCgpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxMzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CgpFUlJPUjogRG8gbm90IGFkZCBleHBlY3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBm
b2xsb3cgaW5zdHJ1Y3Rpb25zIGluIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90
aCB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oIGFuZCB0ZXN0cy9x
dGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMgZm91bmQKCkVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVk
IGZpbGVzIHRvZ2V0aGVyIHdpdGggdGVzdHMsIGZvbGxvdyBpbnN0cnVjdGlvbnMgaW4gdGVzdHMv
cXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOiBib3RoIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRl
c3QtYWxsb3dlZC1kaWZmLmggYW5kIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYyBmb3Vu
ZAoKdG90YWw6IDMgZXJyb3JzLCAxIHdhcm5pbmdzLCAxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDgv
OCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDgxMjU4MTYuOTU1LTEtbWlhb3l1Ym9AaHVh
d2VpLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

