Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76144C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B52206B7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B52206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahuT-0005TD-Sz
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kahsc-0003pO-Hn
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:12:54 -0500
Resent-Date: Thu, 05 Nov 2020 11:12:54 -0500
Resent-Message-Id: <E1kahsc-0003pO-Hn@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kahsZ-0007Rm-Sk
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:12:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604592763; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L7tXCIN3mnmG4bkif0TeXgP9Os9jiIwKWj5uswdgq2b76e6cimeqw5JnlcZ9ju0si8B5e/ZOXoAK7gSXd4X9A3Jd68CL98VxHk4Fhhk0z0pP3fOYFeKJk+aj+8ctqY9C4+AIRC0BuRpkn68CP9b1d1JFJAFPD4YmGhs+4CN1CoU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604592763;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lOZKEZClxF1Rx9WCTqnkaH+gIi9P8rhu/G2nmImWzoU=; 
 b=WLCIqXUPf7yEXzIS2eMr/szNV1y70+c++aKNAjJXG7l1zAP4hX/uPkP/Ak2LARKrKg3+fgJFNoMVT4mkiek2yZCtE9P0TcF4Ls1XRn3XJsUYcbEAI5TvbuvI8OfrQNWWNkJIl4CSkMesrWsnVjWW83/Ap8SywidZ8QjUqdQ42Uk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604592762240557.3805860979619;
 Thu, 5 Nov 2020 08:12:42 -0800 (PST)
Subject: Re: [PATCH] RFC: sphinx: adopt kernel readthedoc theme
Message-ID: <160459276116.17446.17273971722304454331@66eaa9a8a123>
In-Reply-To: <20201105160335.1222062-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Thu, 5 Nov 2020 08:12:42 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 09:36:51
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwNTE2MDMzNS4xMjIy
MDYyLTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDExMDUx
NjAzMzUuMTIyMjA2Mi0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFU
Q0hdIFJGQzogc3BoaW54OiBhZG9wdCBrZXJuZWwgcmVhZHRoZWRvYyB0aGVtZQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9q
ZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTEwNTE2MDMzNS4xMjIy
MDYyLTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDExMDUxNjAz
MzUuMTIyMjA2Mi0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbQogLSBbdGFnIHVwZGF0ZV0g
ICAgICBwYXRjaGV3LzVGQTQxNDQ4LjQwNDA0MDRAaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzVGQTQx
NDQ4LjQwNDA0MDRAaHVhd2VpLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjZj
OTEyNzYgUkZDOiBzcGhpbng6IGFkb3B0IGtlcm5lbCByZWFkdGhlZG9jIHRoZW1lCgo9PT0gT1VU
UFVUIEJFR0lOID09PQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzM4OiBGSUxFOiBk
b2NzL2NvbmYucHk6MTU3OgorICAgIHN5cy5zdGRlcnIud3JpdGUoJ1dhcm5pbmc6IFRoZSBTcGhp
bnggXCdzcGhpbnhfcnRkX3RoZW1lXCcgSFRNTCB0aGVtZSB3YXMgbm90IGZvdW5kLiBNYWtlIHN1
cmUgeW91IGhhdmUgdGhlIHRoZW1lIGluc3RhbGxlZCB0byBwcm9kdWNlIHByZXR0eSBIVE1MIG91
dHB1dC4gRmFsbGluZyBiYWNrIHRvIHRoZSBkZWZhdWx0IHRoZW1lLlxuJykKCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzEyNjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDIzMiBsaW5lcyBjaGVja2VkCgpDb21taXQgNmM5MTI3NjNkNzE3IChSRkM6IHNwaGlu
eDogYWRvcHQga2VybmVsIHJlYWR0aGVkb2MgdGhlbWUpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAxMTA1MTYwMzM1LjEyMjIwNjItMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

