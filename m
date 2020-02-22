Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708CCC35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF63D20675
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcKJJzyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF63D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Qkw-0000mR-UN
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QaW-0007JW-RH
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QaU-0004Ws-Rz
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:56:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48331
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QaU-0004Vz-N6
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsx8FhdzgkOZZ87b+oZrvupxPHaVDgVhbgv0pOnoj8M=;
 b=ZcKJJzyCiWijwwg9P3zEGlTUaM6xVWF92wMAWZFzoUSF1vYt63WpMH/OrIEV+TR5KHROaQ
 oqWHzLk/7jlf3fYQpA+OQO1rVWwVjPuqSgmqewnjWhDvTEyy0bqDkAi9BLIzxgMxJwEX3G
 MAb6yFlhBj9Dx5pCqoZydXsY8fe0tfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-R9k5SiD5MDyzJUqgfHpdww-1; Sat, 22 Feb 2020 03:56:36 -0500
X-MC-Unique: R9k5SiD5MDyzJUqgfHpdww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3152A8017CC;
 Sat, 22 Feb 2020 08:56:35 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DABD027094;
 Sat, 22 Feb 2020 08:56:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/31] fuzz: add documentation to docs/devel/
Date: Sat, 22 Feb 2020 08:50:30 +0000
Message-Id: <20200222085030.1760640-32-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Darren Kenny <darren.kenny@oracle.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpu
b2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IERhcnJlbiBLZW5ueSA8ZGFy
cmVuLmtlbm55QG9yYWNsZS5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwMjIwMDQxMTE4LjIzMjY0LTIz
LWFseG5kckBidS5lZHUKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIGRvY3MvZGV2ZWwvZnV6emluZy50eHQgfCAxMTYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMTYgaW5zZXJ0
aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3MvZGV2ZWwvZnV6emluZy50eHQKCmRpZmYg
LS1naXQgYS9kb2NzL2RldmVsL2Z1enppbmcudHh0IGIvZG9jcy9kZXZlbC9mdXp6aW5nLnR4dApu
ZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwLi4zMjRkMmNkOTJiCi0tLSAvZGV2
L251bGwKKysrIGIvZG9jcy9kZXZlbC9mdXp6aW5nLnR4dApAQCAtMCwwICsxLDExNiBAQAorPSBG
dXp6aW5nID0KKworPT0gSW50cm9kdWN0aW9uID09CisKK1RoaXMgZG9jdW1lbnQgZGVzY3JpYmVz
IHRoZSB2aXJ0dWFsLWRldmljZSBmdXp6aW5nIGluZnJhc3RydWN0dXJlIGluIFFFTVUgYW5kCito
b3cgdG8gdXNlIGl0IHRvIGltcGxlbWVudCBhZGRpdGlvbmFsIGZ1enplcnMuCisKKz09IEJhc2lj
cyA9PQorCitGdXp6aW5nIG9wZXJhdGVzIGJ5IHBhc3NpbmcgaW5wdXRzIHRvIGFuIGVudHJ5IHBv
aW50L3RhcmdldCBmdW5jdGlvbi4gVGhlCitmdXp6ZXIgdHJhY2tzIHRoZSBjb2RlIGNvdmVyYWdl
IHRyaWdnZXJlZCBieSB0aGUgaW5wdXQuIEJhc2VkIG9uIHRoZXNlCitmaW5kaW5ncywgdGhlIGZ1
enplciBtdXRhdGVzIHRoZSBpbnB1dCBhbmQgcmVwZWF0cyB0aGUgZnV6emluZy4KKworVG8gZnV6
eiBRRU1VLCB3ZSByZWx5IG9uIGxpYmZ1enplci4gVW5saWtlIG90aGVyIGZ1enplcnMgc3VjaCBh
cyBBRkwsIGxpYmZ1enplcgoraXMgYW4gX2luLXByb2Nlc3NfIGZ1enplci4gRm9yIHRoZSBkZXZl
bG9wZXIsIHRoaXMgbWVhbnMgdGhhdCBpdCBpcyB0aGVpcgorcmVzcG9uc2liaWxpdHkgdG8gZW5z
dXJlIHRoYXQgc3RhdGUgaXMgcmVzZXQgYmV0d2VlbiBmdXp6aW5nLXJ1bnMuCisKKz09IEJ1aWxk
aW5nIHRoZSBmdXp6ZXJzID09CisKK05PVEU6IElmIHBvc3NpYmxlLCBidWlsZCBhIDMyLWJpdCBi
aW5hcnkuIFdoZW4gZm9ya2luZywgdGhlIDMyLWJpdCBmdXp6ZXIgaXMKK211Y2ggZmFzdGVyLCBz
aW5jZSB0aGUgcGFnZS1tYXAgaGFzIGEgc21hbGxlciBzaXplLiBUaGlzIGlzIGR1ZSB0byB0aGUg
ZmFjdCB0aGF0CitBZGRyZXNzU2FuaXRpemVyIG1tYXBzIH4yMFRCIG9mIG1lbW9yeSwgYXMgcGFy
dCBvZiBpdHMgZGV0ZWN0aW9uLiBUaGlzIHJlc3VsdHMKK2luIGEgbGFyZ2UgcGFnZS1tYXAsIGFu
ZCBhIG11Y2ggc2xvd2VyIGZvcmsoKS4KKworVG8gYnVpbGQgdGhlIGZ1enplcnMsIGluc3RhbGwg
YSByZWNlbnQgdmVyc2lvbiBvZiBjbGFuZzoKK0NvbmZpZ3VyZSB3aXRoIChzdWJzdGl0dXRlIHRo
ZSBjbGFuZyBiaW5hcmllcyB3aXRoIHRoZSB2ZXJzaW9uIHlvdSBpbnN0YWxsZWQpOgorCisgICAg
Q0M9Y2xhbmctOCBDWFg9Y2xhbmcrKy04IC9wYXRoL3RvL2NvbmZpZ3VyZSAtLWVuYWJsZS1mdXp6
aW5nCisKK0Z1enogdGFyZ2V0cyBhcmUgYnVpbHQgc2ltaWxhcmx5IHRvIHN5c3RlbS9zb2Z0bW11
OgorCisgICAgbWFrZSBpMzg2LXNvZnRtbXUvZnV6egorCitUaGlzIGJ1aWxkcyAuL2kzODYtc29m
dG1tdS9xZW11LWZ1enotaTM4NgorCitUaGUgZmlyc3Qgb3B0aW9uIHRvIHRoaXMgY29tbWFuZCBp
czogLS1mdXp6X3RhZ2V0PUZVWlpfTkFNRQorVG8gbGlzdCBhbGwgb2YgdGhlIGF2YWlsYWJsZSBm
dXp6ZXJzIHJ1biBxZW11LWZ1enotaTM4NiB3aXRoIG5vIGFyZ3VtZW50cy4KKworZWc6CisgICAg
Li9pMzg2LXNvZnRtbXUvcWVtdS1mdXp6LWkzODYgLS1mdXp6LXRhcmdldD12aXJ0aW8tbmV0LWZv
cmstZnV6egorCitJbnRlcm5hbGx5LCBsaWJmdXp6ZXIgcGFyc2VzIGFsbCBhcmd1bWVudHMgdGhh
dCBkbyBub3QgYmVnaW4gd2l0aCAiLS0iLgorSW5mb3JtYXRpb24gYWJvdXQgdGhlc2UgaXMgYXZh
aWxhYmxlIGJ5IHBhc3NpbmcgLWhlbHA9MQorCitOb3cgdGhlIG9ubHkgdGhpbmcgbGVmdCB0byBk
byBpcyB3YWl0IGZvciB0aGUgZnV6emVyIHRvIHRyaWdnZXIgcG90ZW50aWFsCitjcmFzaGVzLgor
Cis9PSBBZGRpbmcgYSBuZXcgZnV6emVyID09CitDb3ZlcmFnZSBvdmVyIHZpcnR1YWwgZGV2aWNl
cyBjYW4gYmUgaW1wcm92ZWQgYnkgYWRkaW5nIGFkZGl0aW9uYWwgZnV6emVycy4KK0Z1enplcnMg
YXJlIGtlcHQgaW4gdGVzdHMvcXRlc3QvZnV6ei8gYW5kIHNob3VsZCBiZSBhZGRlZCB0bwordGVz
dHMvcXRlc3QvZnV6ei9NYWtlZmlsZS5pbmNsdWRlCisKK0Z1enplcnMgY2FuIHJlbHkgb24gYm90
aCBxdGVzdCBhbmQgbGlicW9zIHRvIGNvbW11bmljYXRlIHdpdGggdmlydHVhbCBkZXZpY2VzLgor
CisxLiBDcmVhdGUgYSBuZXcgc291cmNlIGZpbGUuIEZvciBleGFtcGxlIGBgdGVzdHMvcXRlc3Qv
ZnV6ei9mb28tZGV2aWNlLWZ1enouY2BgLgorCisyLiBXcml0ZSB0aGUgZnV6emluZyBjb2RlIHVz
aW5nIHRoZSBsaWJxdGVzdC9saWJxb3MgQVBJLiBTZWUgZXhpc3RpbmcgZnV6emVycworZm9yIHJl
ZmVyZW5jZS4KKworMy4gUmVnaXN0ZXIgdGhlIGZ1enplciBpbiBgYHRlc3RzL2Z1enovTWFrZWZp
bGUuaW5jbHVkZWBgIGJ5IGFwcGVuZGluZyB0aGUKK2NvcnJlc3BvbmRpbmcgb2JqZWN0IHRvIGZ1
enotb2JqLXkKKworRnV6emVycyBjYW4gYmUgbW9yZS1vci1sZXNzIHRob3VnaHQgb2YgYXMgc3Bl
Y2lhbCBxdGVzdCBwcm9ncmFtcyB3aGljaCBjYW4KK21vZGlmeSB0aGUgcXRlc3QgY29tbWFuZHMg
YW5kL29yIHF0ZXN0IGNvbW1hbmQgYXJndW1lbnRzIGJhc2VkIG9uIGlucHV0cworcHJvdmlkZWQg
YnkgbGliZnV6emVyLiBMaWJmdXp6ZXIgcGFzc2VzIGEgYnl0ZSBhcnJheSBhbmQgbGVuZ3RoLiBD
b21tb25seSB0aGUKK2Z1enplciBsb29wcyBvdmVyIHRoZSBieXRlLWFycmF5IGludGVycHJldGlu
ZyBpdCBhcyBhIGxpc3Qgb2YgcXRlc3QgY29tbWFuZHMsCithZGRyZXNzZXMsIG9yIHZhbHVlcy4K
KworPSBJbXBsZW1lbnRhdGlvbiBEZXRhaWxzID0KKworPT0gVGhlIEZ1enplcidzIExpZmVjeWNs
ZSA9PQorCitUaGUgZnV6emVyIGhhcyB0d28gZW50cnlwb2ludHMgdGhhdCBsaWJmdXp6ZXIgY2Fs
bHMuIGxpYmZ1enplciBwcm92aWRlcyBpdCdzCitvd24gbWFpbigpLCB3aGljaCBwZXJmb3JtcyBz
b21lIHNldHVwLCBhbmQgY2FsbHMgdGhlIGVudHJ5cG9pbnRzOgorCitMTFZNRnV6emVySW5pdGlh
bGl6ZTogY2FsbGVkIHByaW9yIHRvIGZ1enppbmcuIFVzZWQgdG8gaW5pdGlhbGl6ZSBhbGwgb2Yg
dGhlCituZWNlc3Nhcnkgc3RhdGUKKworTExWTUZ1enplclRlc3RPbmVJbnB1dDogY2FsbGVkIGZv
ciBlYWNoIGZ1enppbmcgcnVuLiBQcm9jZXNzZXMgdGhlIGlucHV0IGFuZAorcmVzZXRzIHRoZSBz
dGF0ZSBhdCB0aGUgZW5kIG9mIGVhY2ggcnVuLgorCitJbiBtb3JlIGRldGFpbDoKKworTExWTUZ1
enplckluaXRpYWxpemUgcGFyc2VzIHRoZSBhcmd1bWVudHMgdG8gdGhlIGZ1enplciAobXVzdCBz
dGFydCB3aXRoIHR3bworZGFzaGVzLCBzbyB0aGV5IGFyZSBpZ25vcmVkIGJ5IGxpYmZ1enplciBt
YWluKCkpLiBDdXJyZW50bHksIHRoZSBhcmd1bWVudHMKK3NlbGVjdCB0aGUgZnV6eiB0YXJnZXQu
IFRoZW4sIHRoZSBxdGVzdCBjbGllbnQgaXMgaW5pdGlhbGl6ZWQuIElmIHRoZSB0YXJnZXQKK3Jl
cXVpcmVzIHFvcywgcWdyYXBoIGlzIHNldCB1cCBhbmQgdGhlIFFPTS9MSUJRT1MgbW9kdWxlcyBh
cmUgaW5pdGlhbGl6ZWQuCitUaGVuIHRoZSBRR3JhcGggaXMgd2Fsa2VkIGFuZCB0aGUgUUVNVSBj
bWRfbGluZSBpcyBkZXRlcm1pbmVkIGFuZCBzYXZlZC4KKworQWZ0ZXIgdGhpcywgdGhlIHZsLmM6
cWVtdV9fbWFpbiBpcyBjYWxsZWQgdG8gc2V0IHVwIHRoZSBndWVzdC4gVGhlcmUgYXJlCit0YXJn
ZXQtc3BlY2lmaWMgaG9va3MgdGhhdCBjYW4gYmUgY2FsbGVkIGJlZm9yZSBhbmQgYWZ0ZXIgcWVt
dV9tYWluLCBmb3IKK2FkZGl0aW9uYWwgc2V0dXAoZS5nLiBQQ0kgc2V0dXAsIG9yIFZNIHNuYXBz
aG90dGluZykuCisKK0xMVk1GdXp6ZXJUZXN0T25lSW5wdXQ6IFVzZXMgcXRlc3QvcW9zIGZ1bmN0
aW9ucyB0byBhY3QgYmFzZWQgb24gdGhlIGZ1enoKK2lucHV0LiBJdCBpcyBhbHNvIHJlc3BvbnNp
YmxlIGZvciBtYW51YWxseSBjYWxsaW5nIHRoZSBtYWluIGxvb3AvbWFpbl9sb29wX3dhaXQKK3Rv
IGVuc3VyZSB0aGF0IGJvdHRvbSBoYWx2ZXMgYXJlIGV4ZWN1dGVkIGFuZCBhbnkgY2xlYW51cCBy
ZXF1aXJlZCBiZWZvcmUgdGhlCituZXh0IGlucHV0LgorCitTaW5jZSB0aGUgc2FtZSBwcm9jZXNz
IGlzIHJldXNlZCBmb3IgbWFueSBmdXp6aW5nIHJ1bnMsIFFFTVUgc3RhdGUgbmVlZHMgdG8KK2Jl
IHJlc2V0IGF0IHRoZSBlbmQgb2YgZWFjaCBydW4uIFRoZXJlIGFyZSBjdXJyZW50bHkgdHdvIGlt
cGxlbWVudGVkCitvcHRpb25zIGZvciByZXNldHRpbmcgc3RhdGU6CisxLiBSZWJvb3QgdGhlIGd1
ZXN0IGJldHdlZW4gcnVucy4KKyAgIFByb3M6IFN0cmFpZ2h0Zm9yd2FyZCBhbmQgZmFzdCBmb3Ig
c2ltcGxlIGZ1enogdGFyZ2V0cy4KKyAgIENvbnM6IERlcGVuZGluZyBvbiB0aGUgZGV2aWNlLCBk
b2VzIG5vdCByZXNldCBhbGwgZGV2aWNlIHN0YXRlLiBJZiB0aGUKKyAgIGRldmljZSByZXF1aXJl
cyBzb21lIGluaXRpYWxpemF0aW9uIHByaW9yIHRvIGJlaW5nIHJlYWR5IGZvciBmdXp6aW5nCisg
ICAoY29tbW9uIGZvciBRT1MtYmFzZWQgdGFyZ2V0cyksIHRoaXMgaW5pdGlhbGl6YXRpb24gbmVl
ZHMgdG8gYmUgZG9uZSBhZnRlcgorICAgZWFjaCByZWJvb3QuCisgICBFeGFtcGxlIHRhcmdldDog
aTQ0MGZ4LXF0ZXN0LXJlYm9vdC1mdXp6CisyLiBSdW4gZWFjaCB0ZXN0IGNhc2UgaW4gYSBzZXBh
cmF0ZSBmb3JrZWQgcHJvY2VzcyBhbmQgY29weSB0aGUgY292ZXJhZ2UKKyAgIGluZm9ybWF0aW9u
IGJhY2sgdG8gdGhlIHBhcmVudC4gVGhpcyBpcyBmYWlybHkgc2ltaWxhciB0byBBRkwncyAiZGVm
ZXJyZWQiCisgICBmb3JrLXNlcnZlciBtb2RlIFszXQorICAgUHJvczogUmVsYXRpdmVseSBmYXN0
LiBEZXZpY2VzIG9ubHkgbmVlZCB0byBiZSBpbml0aWFsaXplZCBvbmNlLiBObyBuZWVkCisgICB0
byBkbyBzbG93IHJlYm9vdHMgb3Igdm1sb2Fkcy4KKyAgIENvbnM6IE5vdCBvZmZpY2lhbGx5IHN1
cHBvcnRlZCBieSBsaWJmdXp6ZXIuIERvZXMgbm90IHdvcmsgd2VsbCBmb3IgZGV2aWNlcworICAg
dGhhdCByZWx5IG9uIGRlZGljYXRlZCB0aHJlYWRzLgorICAgRXhhbXBsZSB0YXJnZXQ6IHZpcnRp
by1uZXQtZm9yay1mdXp6Ci0tIAoyLjI0LjEKCg==


