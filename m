Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB87AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9265C20868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9265C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKiQ-0005cY-5o
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hZJwq-00042V-Vl
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hZJwp-0006Ow-Gw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:50:44 -0400
Resent-Date: Fri, 07 Jun 2019 14:50:44 -0400
Resent-Message-Id: <E1hZJwp-0006Ow-Gw@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hZJwp-0006Mw-87
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559862206; cv=none; d=zoho.com; s=zohoarc; 
 b=ACnV09N4Y3fRctfj/pZqadtXAmhjjRVizKkOoEH4eoAr13dFxblkq4Q5+eMgk931YMIz29jXEQwtVicVG36ep1hgtBc4bG4KYV3ForM48i96WSYRAZRQ8KrzT9Rk+uWomWz/4wxg6DiLBXebYvehUhjTollJ87gUVygmM/KlYhI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1559862206;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=gi1+WhWYxX2Tmza/lvLNhXg8pYZU2p9OjWa/SzcxnfA=; 
 b=lPY7jwCFkl1lPdA50MG3Snkj+zdXKKI2iFQ3YMH1sFzCVZXHZV0IcfkbRlmo4IZxlhH3Lm6kv1Kjmgzx9FvwKJ5fCGS8lRl5XKW6271210tDvsmgvChXVx1zIoxi0CLPYwnmtcKUxDOVrnZkdQ7RcBk50/zoJZCts6GV81dgZMI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1559862203865426.08427601184496;
 Thu, 6 Jun 2019 16:03:23 -0700 (PDT)
In-Reply-To: <20190606211414.8681-1-crosa@redhat.com>
Message-ID: <155986220241.32260.14102034332620275193@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: crosa@redhat.com
Date: Thu, 6 Jun 2019 16:03:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Add "boot_linux" acceptance test
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 cohuck@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 crosa@redhat.com, philmd@redhat.com, sameo@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYwNjIxMTQxNC44Njgx
LTEtY3Jvc2FAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2NiAwLzddIEFkZCAiYm9vdF9s
aW51eCIgYWNjZXB0YW5jZSB0ZXN0ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDYwNjIx
MTQxNC44NjgxLTEtY3Jvc2FAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA2MDYyMTE0MTQuODY4MS0xLWNy
b3NhQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDYwNjIxMTQxNC44NjgxLTEtY3Jvc2FAcmVk
aGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjczNjJkNjdiZWQgdXNlIEF2
b2NhZG8gZGF0YSBkcmFpbmVyIGZvciBjb25zb2xlIGxvZ2dpbmcKMWM2YWM3MWUwNyBBZGQgImJv
b3RfbGludXgiIHRlc3QgZm9yIGFhcmNoNjQgYW5kIHZpcnQgbWFjaGluZSB0eXBlCjc2ZGZjNmUy
OGUgQWRkICJib290X2xpbnV4IiB0ZXN0IGZvciB4ODZfNjQgYW5kIHBjIGFuZCBxMzUgbWFjaGlu
ZSB0eXBlcwowMWE2OTgwNGMyIEFjY2VwdGFuY2UgdGVzdHM6IGRlcGVuZCBvbiBxZW11LWltZwpi
N2RjOTY5ZDMxIEFjY2VwdGFuY2UgdGVzdHM6IGFkZCB0aGUgYnVpbGQgZGlyZWN0b3J5IHRvIHRo
ZSBzeXN0ZW0gUEFUSAo1ZjNiODRjM2I2IEFjY2VwdGFuY2UgdGVzdHM6IGtlZXAgYSBzdGFibGUg
cmVmZXJlbmNlIHRvIHRoZSBRRU1VIGJ1aWxkIGRpcgo4ZDA4OTkwYzdjIEFjY2VwdGFuY2UgdGVz
dHM6IHVzZSByZWxhdGl2ZSBsb2NhdGlvbiBmb3IgdGVzdHMKCj09PSBPVVRQVVQgQkVHSU4gPT09
CjEvNyBDaGVja2luZyBjb21taXQgOGQwODk5MGM3Yzc4IChBY2NlcHRhbmNlIHRlc3RzOiB1c2Ug
cmVsYXRpdmUgbG9jYXRpb24gZm9yIHRlc3RzKQoyLzcgQ2hlY2tpbmcgY29tbWl0IDVmM2I4NGMz
YjZmNyAoQWNjZXB0YW5jZSB0ZXN0czoga2VlcCBhIHN0YWJsZSByZWZlcmVuY2UgdG8gdGhlIFFF
TVUgYnVpbGQgZGlyKQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzQ4OiBGSUxFOiB0
ZXN0cy9hY2NlcHRhbmNlL2F2b2NhZG9fcWVtdS9fX2luaXRfXy5weToxNzoKK1NSQ19ST09UX0RJ
UiA9IG9zLnBhdGguZGlybmFtZShvcy5wYXRoLmRpcm5hbWUob3MucGF0aC5kaXJuYW1lKG9zLnBh
dGguZGlybmFtZShfX2ZpbGVfXykpKSkKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBs
aW5lcyBjaGVja2VkCgpQYXRjaCAyLzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvNyBD
aGVja2luZyBjb21taXQgYjdkYzk2OWQzMTFhIChBY2NlcHRhbmNlIHRlc3RzOiBhZGQgdGhlIGJ1
aWxkIGRpcmVjdG9yeSB0byB0aGUgc3lzdGVtIFBBVEgpCjQvNyBDaGVja2luZyBjb21taXQgMDFh
Njk4MDRjMmIyIChBY2NlcHRhbmNlIHRlc3RzOiBkZXBlbmQgb24gcWVtdS1pbWcpCjUvNyBDaGVj
a2luZyBjb21taXQgNzZkZmM2ZTI4ZTIxIChBZGQgImJvb3RfbGludXgiIHRlc3QgZm9yIHg4Nl82
NCBhbmQgcGMgYW5kIHEzNSBtYWNoaW5lIHR5cGVzKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3Ig
ZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM0MzogCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTA3
OiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL2Jvb3RfbGludXgucHk6NjA6CisgICAgICAgIGNsb3Vk
aW5pdC53YWl0X2Zvcl9waG9uZV9ob21lKCgnMC4wLjAuMCcsIHNlbGYucGhvbmVfaG9tZV9wb3J0
KSwgc2VsZi5uYW1lKQoKdG90YWw6IDAgZXJyb3JzLCAyIHdhcm5pbmdzLCA5NiBsaW5lcyBjaGVj
a2VkCgpQYXRjaCA1LzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNi83IENoZWNraW5nIGNv
bW1pdCAxYzZhYzcxZTA3ZjIgKEFkZCAiYm9vdF9saW51eCIgdGVzdCBmb3IgYWFyY2g2NCBhbmQg
dmlydCBtYWNoaW5lIHR5cGUpCjcvNyBDaGVja2luZyBjb21taXQgNzM2MmQ2N2JlZDM3ICh1c2Ug
QXZvY2FkbyBkYXRhIGRyYWluZXIgZm9yIGNvbnNvbGUgbG9nZ2luZykKV0FSTklORzogbGluZSBv
dmVyIDgwIGNoYXJhY3RlcnMKIzM4OiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL2Jvb3RfbGludXgu
cHk6NjI6CisgICAgICAgIGNvbnNvbGVfZHJhaW5lciA9IGRhdGFkcmFpbmVyLkxpbmVMb2dnZXIo
c2VsZi52bS5jb25zb2xlX3NvY2tldC5maWxlbm8oKSwKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBj
aGFyYWN0ZXJzCiMzOTogRklMRTogdGVzdHMvYWNjZXB0YW5jZS9ib290X2xpbnV4LnB5OjYzOgor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvZ2dlcj1z
ZWxmLmxvZy5nZXRDaGlsZCgnY29uc29sZScpKQoKdG90YWw6IDAgZXJyb3JzLCAyIHdhcm5pbmdz
LCA1MCBsaW5lcyBjaGVja2VkCgpQYXRjaCA3LzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA2
MDYyMTE0MTQuODY4MS0xLWNyb3NhQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


