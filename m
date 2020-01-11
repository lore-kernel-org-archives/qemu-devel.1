Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F97AC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 16:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14C22082E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14C22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqJPL-0000n5-0S
	for qemu-devel@archiver.kernel.org; Sat, 11 Jan 2020 11:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iqJOk-0008RA-Uv
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 11:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iqJOg-0005kG-P2
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 11:14:01 -0500
Resent-Date: Sat, 11 Jan 2020 11:14:01 -0500
Resent-Message-Id: <E1iqJOg-0005kG-P2@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iqJOg-0005ad-GK
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 11:13:58 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578759216485824.2767146461133;
 Sat, 11 Jan 2020 08:13:36 -0800 (PST)
In-Reply-To: <1578757241-29583-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v4 00/19] linux-user: Misc patches for 5.0 
Message-ID: <157875921523.17824.17057951578856474214@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Sat, 11 Jan 2020 08:13:36 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc4NzU3MjQxLTI5NTgzLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2NCAwMC8x
OV0gbGludXgtdXNlcjogTWlzYyBwYXRjaGVzIGZvciA1LjAgClR5cGU6IHNlcmllcwpNZXNzYWdl
LWlkOiAxNTc4NzU3MjQxLTI5NTgzLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3Zp
Y0BydC1yay5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEg
bmV3IGJyYW5jaCAndGVzdCcKNDAwZjk5MyBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgS0NP
Vl9JTklUX1RSQUNFIGlvY3RsCjg5Mjk2NzcgbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEtD
T1ZfPEVOQUJMRXxESVNBQkxFPiBpb2N0bHMKYjIwZDVjMCBjb25maWd1cmU6IERldGVjdCBrY292
IHN1cHBvcnQgYW5kIGludHJvZHVjZSBDT05GSUdfS0NPVgo1NjY0NjJkIGxpbnV4LXVzZXI6IEFk
ZCBzdXBwb3J0IGZvciBGREdFVEZEQ1NUQVQgaW9jdGwKMTUxOWI5NCBsaW51eC11c2VyOiBBZGQg
c3VwcG9ydCBmb3IgRkRGTVQ8QkVHfFRSS3xFTkQ+IGlvY3RscwplMDIxMGMxIGxpbnV4LXVzZXI6
IEFkZCBzdXBwb3J0IGZvciBGRDxTRVRFTVNHVFJFU0h8U0VUTUFYRVJSU3xHRVRNQVhFUlJTPiBp
b2N0bHMKNTIxN2Q2NyBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRklGUkVFWkUgYW5kIEZJ
VEhBVyBpb2N0bHMKNWQwOTFjNyBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRklUUklNIGlv
Y3RsCmIzOTc0OWUgbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEZTX0lPQ19GUzxHRVR8U0VU
PlhBVFRSIGlvY3RscwowMDE0ZWJiIGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBGU19JT0Mz
Ml88R0VUfFNFVD5WRVJTSU9OIGlvY3RscwpmNDAwMGZkIGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0
IGZvciBGU19JT0MzMl88R0VUfFNFVD5GTEFHUyBpb2N0bHMKNGY2YjI1YiBsaW51eC11c2VyOiBB
ZGQgc3VwcG9ydCBmb3IgRlNfSU9DXzxHRVR8U0VUPlZFUlNJT04gaW9jdGxzCmUyNzNhZjQgbGlu
dXgtdXNlcjogeHRlbnNhOiBSZW1vdmUgdW51c2VkIGNvbnN0YW50IFRBUkdFVF9OUl9zeXNjYWxs
X2NvdW50CjQ1NTgzYTIgbGludXgtdXNlcjogeHRlbnNhOiBVcGRhdGUgc3lzY2FsbCBudW1iZXJz
IHRvIGtlcm5lbCA1LjUgcmMzIGxldmVsCmNiM2VjMzkgbGludXgtdXNlcjogeDg2XzY0OiBVcGRh
dGUgc3lzY2FsbCBudW1iZXJzIHRvIGtlcm5lbCA1LjUgcmMzIGxldmVsCmQyZjExYzEgbGludXgt
dXNlcjogbWlwczogVXBkYXRlIHN5c2NhbGwgbnVtYmVycyB0byBrZXJuZWwgNS41IHJjMyBsZXZl
bAo3NjcwMjMwIGxpbnV4LXVzZXI6IG1pY3JvYmxhemU6IFVwZGF0ZSBzeXNjYWxsIG51bWJlcnMg
dG8ga2VybmVsIDUuNSByYzMgbGV2ZWwKZWNiZjQ1ZiBsaW51eC11c2VyOiBtNjhrOiBVcGRhdGUg
c3lzY2FsbCBudW1iZXJzIHRvIGtlcm5lbCA1LjUgcmMzIGxldmVsCmNjYTkzNjcgbGludXgtdXNl
cjogRml4IHNvbWUgY29uc3RhbnRzIGluIHRlcm1iaXRzLmgKCj09PSBPVVRQVVQgQkVHSU4gPT09
CjEvMTkgQ2hlY2tpbmcgY29tbWl0IGNjYTkzNjc3MDE2OCAobGludXgtdXNlcjogRml4IHNvbWUg
Y29uc3RhbnRzIGluIHRlcm1iaXRzLmgpCjIvMTkgQ2hlY2tpbmcgY29tbWl0IGVjYmY0NWZkMjFh
OSAobGludXgtdXNlcjogbTY4azogVXBkYXRlIHN5c2NhbGwgbnVtYmVycyB0byBrZXJuZWwgNS41
IHJjMyBsZXZlbCkKMy8xOSBDaGVja2luZyBjb21taXQgNzY3MDIzMGQxZGRiIChsaW51eC11c2Vy
OiBtaWNyb2JsYXplOiBVcGRhdGUgc3lzY2FsbCBudW1iZXJzIHRvIGtlcm5lbCA1LjUgcmMzIGxl
dmVsKQo0LzE5IENoZWNraW5nIGNvbW1pdCBkMmYxMWMxMjI5NjMgKGxpbnV4LXVzZXI6IG1pcHM6
IFVwZGF0ZSBzeXNjYWxsIG51bWJlcnMgdG8ga2VybmVsIDUuNSByYzMgbGV2ZWwpCjUvMTkgQ2hl
Y2tpbmcgY29tbWl0IGNiM2VjMzkzNzdlOCAobGludXgtdXNlcjogeDg2XzY0OiBVcGRhdGUgc3lz
Y2FsbCBudW1iZXJzIHRvIGtlcm5lbCA1LjUgcmMzIGxldmVsKQo2LzE5IENoZWNraW5nIGNvbW1p
dCA0NTU4M2EyOWQwOTIgKGxpbnV4LXVzZXI6IHh0ZW5zYTogVXBkYXRlIHN5c2NhbGwgbnVtYmVy
cyB0byBrZXJuZWwgNS41IHJjMyBsZXZlbCkKNy8xOSBDaGVja2luZyBjb21taXQgZTI3M2FmNGY0
ZTA4IChsaW51eC11c2VyOiB4dGVuc2E6IFJlbW92ZSB1bnVzZWQgY29uc3RhbnQgVEFSR0VUX05S
X3N5c2NhbGxfY291bnQpCkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNiBsaW5lcyBjaGVja2VkCgpQYXRjaCA3LzE5IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo4LzE5IENoZWNraW5nIGNvbW1pdCA0ZjZiMjViMzZm
NTkgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBGU19JT0NfPEdFVHxTRVQ+VkVSU0lPTiBp
b2N0bHMpCjkvMTkgQ2hlY2tpbmcgY29tbWl0IGY0MDAwZmQxYTAxOSAobGludXgtdXNlcjogQWRk
IHN1cHBvcnQgZm9yIEZTX0lPQzMyXzxHRVR8U0VUPkZMQUdTIGlvY3RscykKMTAvMTkgQ2hlY2tp
bmcgY29tbWl0IDAwMTRlYmIwMTMzOSAobGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEZTX0lP
QzMyXzxHRVR8U0VUPlZFUlNJT04gaW9jdGxzKQoxMS8xOSBDaGVja2luZyBjb21taXQgYjM5NzQ5
ZWFjMGQ0IChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRlNfSU9DX0ZTPEdFVHxTRVQ+WEFU
VFIgaW9jdGxzKQoxMi8xOSBDaGVja2luZyBjb21taXQgNWQwOTFjN2E0ZDhlIChsaW51eC11c2Vy
OiBBZGQgc3VwcG9ydCBmb3IgRklUUklNIGlvY3RsKQoxMy8xOSBDaGVja2luZyBjb21taXQgNTIx
N2Q2N2I0MDhlIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRklGUkVFWkUgYW5kIEZJVEhB
VyBpb2N0bHMpCjE0LzE5IENoZWNraW5nIGNvbW1pdCBlMDIxMGMxMDY1YjggKGxpbnV4LXVzZXI6
IEFkZCBzdXBwb3J0IGZvciBGRDxTRVRFTVNHVFJFU0h8U0VUTUFYRVJSU3xHRVRNQVhFUlJTPiBp
b2N0bHMpCjE1LzE5IENoZWNraW5nIGNvbW1pdCAxNTE5Yjk0ZWZhZTQgKGxpbnV4LXVzZXI6IEFk
ZCBzdXBwb3J0IGZvciBGREZNVDxCRUd8VFJLfEVORD4gaW9jdGxzKQoxNi8xOSBDaGVja2luZyBj
b21taXQgNTY2NDYyZDUzNzFiIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRkRHRVRGRENT
VEFUIGlvY3RsKQoxNy8xOSBDaGVja2luZyBjb21taXQgYjIwZDVjMDNlNzZmIChjb25maWd1cmU6
IERldGVjdCBrY292IHN1cHBvcnQgYW5kIGludHJvZHVjZSBDT05GSUdfS0NPVikKMTgvMTkgQ2hl
Y2tpbmcgY29tbWl0IDg5Mjk2NzdhNjI3NyAobGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEtD
T1ZfPEVOQUJMRXxESVNBQkxFPiBpb2N0bHMpCjE5LzE5IENoZWNraW5nIGNvbW1pdCA0MDBmOTkz
YWU4ZWQgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBLQ09WX0lOSVRfVFJBQ0UgaW9jdGwp
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1Nzg3
NTcyNDEtMjk1ODMtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


