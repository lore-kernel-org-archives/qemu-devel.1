Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62032C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197A32077C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFRp-0005FX-7c
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1isFRH-0004pS-DS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1isFRG-0002tx-0K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:24:39 -0500
Resent-Date: Thu, 16 Jan 2020 19:24:39 -0500
Resent-Message-Id: <E1isFRG-0002tx-0K@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1isFRF-0002rp-Ny
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:24:37 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579220665463489.7861088231708;
 Thu, 16 Jan 2020 16:24:25 -0800 (PST)
In-Reply-To: <20200116202414.157959-1-dgilbert@redhat.com>
Subject: Re: [PATCH v3 0/2] Fix hyperv synic on vhost
Message-ID: <157922066484.433.7316108748419062411@197193fa8d23>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Thu, 16 Jan 2020 16:24:25 -0800 (PST)
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
Cc: jasowang@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExNjIwMjQxNC4xNTc5
NTktMS1kZ2lsYmVydEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDExNjIwMjQxNC4xNTc5NTktMS1kZ2lsYmVy
dEByZWRoYXQuY29tClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUEFUQ0ggdjMgMC8yXSBGaXggaHlw
ZXJ2IHN5bmljIG9uIHZob3N0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
RnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWdd
ICAgICAgICAgcGF0Y2hldy8yMDIwMDExNjIwMjQxNC4xNTc5NTktMS1kZ2lsYmVydEByZWRoYXQu
Y29tIC0+IHBhdGNoZXcvMjAyMDAxMTYyMDI0MTQuMTU3OTU5LTEtZGdpbGJlcnRAcmVkaGF0LmNv
bQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY3YWVmZjIgdmhvc3Q6IE9ubHkgYWxp
Z24gc2VjdGlvbnMgZm9yIHZob3N0LXVzZXIKNWJiNDY3ZiB2aG9zdDogQWRkIG5hbWVzIHRvIHNl
Y3Rpb24gcm91bmRlZCB3YXJuaW5nCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcg
Y29tbWl0IDViYjQ2N2Y0YWMzYiAodmhvc3Q6IEFkZCBuYW1lcyB0byBzZWN0aW9uIHJvdW5kZWQg
d2FybmluZykKMi8yIENoZWNraW5nIGNvbW1pdCBmN2FlZmYyNGE5OWEgKHZob3N0OiBPbmx5IGFs
aWduIHNlY3Rpb25zIGZvciB2aG9zdC11c2VyKQpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQoj
NDU6IEZJTEU6IGh3L3ZpcnRpby92aG9zdC5jOjU1NDoKKyAgICBpZiAoZGV2LT52aG9zdF9vcHMt
PmJhY2tlbmRfdHlwZSA9PSBWSE9TVF9CQUNLRU5EX1RZUEVfVVNFUikgeyAgICQKCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM2MDogRklMRTogaHcvdmlydGlvL3Zob3N0LmM6NTY5
OgorICAgICAgICB0cmFjZV92aG9zdF9yZWdpb25fYWRkX3NlY3Rpb25fYWxpZ25lZChzZWN0aW9u
LT5tci0+bmFtZSwgbXJzX2dwYSwgbXJzX3NpemUsCgp0b3RhbDogMSBlcnJvcnMsIDEgd2Fybmlu
Z3MsIDQzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDAxMTYyMDI0MTQuMTU3OTU5LTEtZGdpbGJlcnRAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


