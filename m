Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B24C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 05:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AA62063A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 05:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="odSZDbr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AA62063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKEiQ-0001tf-AT
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 01:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1jKEhY-0001I6-F7
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Aijaz.Baig@protonmail.com>) id 1jKEhW-0002o3-H1
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:17:07 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:57931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Aijaz.Baig@protonmail.com>)
 id 1jKEhV-0002lr-Sn
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 01:17:06 -0400
Date: Fri, 03 Apr 2020 05:16:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=default; t=1585891022;
 bh=yjQW6jlR6NIowKgPB38LI36ubmbRrOFXaUlTRha2rF8=;
 h=Date:To:From:Reply-To:Subject:From;
 b=odSZDbr2tBsCou+oaIit1wUjccTuhD0Y65o9zFQ4QZfQy0UxGF11qPGDf1Ho1YZFb
 AjlOrX6HNg1xsHCTEqR6vfElHGKRumZrXjN1ccdrIlcgnu+RMVNISSEj2CWbuIeN/P
 H6O9yXvWs/+dbF+tLwYHDFJWT2WeuaURP/X8xEdw=
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: "Aijaz.Baig" <Aijaz.Baig@protonmail.com>
Subject: Qemu doesn't detect hard drive
Message-ID: <XSF-9CLAGYMG1ivdwoihQBZm3XT2vWdKVqHtMLExgA1LJwkSeISDoKKVEJ3E3qhZaNvki44j2CdXdQ81ljytvtS0MGmXL3gFhO2kQmWA2Kk=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1_0a6e74d445d619ee118d2c4da3278270"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.70.40.22
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
Reply-To: "Aijaz.Baig" <Aijaz.Baig@protonmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.

--b1_0a6e74d445d619ee118d2c4da3278270
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkKCkkgaGF2ZSBhIHdvcmtpbmcgUUVNVSBpbWFnZSBlbXVsYXRpbmcgYW4gQVJNIHZleHByZXNz
LWE5IGFuZCBJIHJ1biBpdCBsaWtlIHNvOgoKYHN1ZG8gcWVtdS1zeXN0ZW0tYXJtIC1tIDUxMk0g
LU0gdmV4cHJlc3MtYTkgLUQgcWVtdS5sb2cgLWQgdW5pbXAgLWtlcm5lbCBidWlsZHJvb3QtMjAx
OS4wMi41L291dHB1dC9pbWFnZXMvekltYWdlIC1kdGIgYnVpbGRyb290LTIwMTkuMDIuNS9vdXRw
dXQvaW1hZ2VzL3ZleHByZXNzLXYycC1jYTkuZHRiIC1hcHBlbmQgImNvbnNvbGU9dHR5QU1BMCwx
MTUyMDAga2dkYm9jPWtiZCx0dHlBTUEwLDExNTIwMCBpcD1kaGNwIG5va2FzbHIiIC1pbml0cmQg
YnVpbGRyb290LTIwMTkuMDIuNS9vdXRwdXQvaW1hZ2VzL3Jvb3Rmcy5jcGlvIC1ub2dyYXBoaWMg
LW5ldCBuaWMgLW5ldCBicmlkZ2UsYnI9bXlicmlkZ2UgLXNgCgpJIHdvdWxkIG5vdyBsaWtlIHRv
IGFkZCBhIGhhcmQgZGlzayBmb3IgcGVyc2lzdGVudCBzdG9yYWdlIGFuZCB0aGVuIHRyYW5zZmVy
IGNvbnRyb2wgZnJvbSBidXN5Ym94IGluaXRyZCBiYXNlZCByb290ZnMgb3ZlciB0byB0aGUgZnVs
bCBmbGVkZ2VkIHZlcnNpb24gb2ZmZXJlZCB3aXRoIExpbnV4LiBTbyBJIGFkZCBpdCB0byB0aGUg
Y29tbWFuZCBsaW5lCgpgc3VkbyBxZW11LXN5c3RlbS1hcm0gLW0gMTAyNE0gLU0gdmV4cHJlc3Mt
YTkgLUQgcWVtdS5sb2cgLWRyaXZlIGlmPW5vbmUsZm9ybWF0PXJhdyxmaWxlPWRpc2suaW1nIC1r
ZXJuZWwgYnVpbGRyb290LTIwMTkuMDIuNS9vdXRwdXQvaW1hZ2VzL3pJbWFnZSAtZHRiIGJ1aWxk
cm9vdC0yMDE5LjAyLjUvb3V0cHV0L2ltYWdlcy92ZXhwcmVzcy12MnAtY2E5LmR0YiAtYXBwZW5k
ICJjb25zb2xlPXR0eUFNQTAsMTE1MjAwIGtnZGJvYz1rYmQsdHR5QU1BMCwxMTUyMDAgaXA9ZGhj
cCBub2thc2xyIiAtaW5pdHJkIGJ1aWxkcm9vdC0yMDE5LjAyLjUvb3V0cHV0L2ltYWdlcy9yb290
ZnMuY3BpbyAtbm9ncmFwaGljIC1uZXQgbmljIC1uZXQgYnJpZGdlLGJyPW15YnJpZGdlIC1zCmAK
Cm9mIGNvdXJzZSBJIGZpcnN0IGNyZWF0ZSBhIGRpc2sgaW1hZ2UgYW5kIGZvcm1hdCBpdCBhcyBl
eHQyOgpgcWVtdS1pbWcgY3JlYXRlIGRpc2suaW1nIDEwRyAmJiBta2ZzLmV4dDIgLUYgZGlzay5p
bWdgCgpGcm9tIHRoZSBsb2cgbWVzc2FnZXMgSSBzZWUgdGhhdCBpdCBoYXMgbm90IGJlZW4gYWJs
ZSB0byBkZXRlY3QgdGhpcyBhdCBhbGwuIENhbiBzb21lb25lIHBsZWFzZSBzdW1tYXJpemUgaG93
IGJsb2NrIGRldmljZXMgd29yayB3aXRoIFFlbXUuIEkga25vdyB0aGUgb2xkZXIgYC1oZGFgIGhh
cyBiZWVuIGNoYW5nZWQgdG8gYSBuZXdlciBgLWRyaXZlYCBvcHRpb24gY2FuIGNvbWJpbmVzIHRo
ZSBjdW1iZXJzb21lIHNwZWNpZmljYXRpb24gb2YgdGhlIGZyb250IGFuZCBiYWNrIGVuZHMgc2Vw
YXJhdGVseS4gQnV0IEkgZG9uJ3Qga25vdyB0aGUgYmFzaWNzIGFuZCB3aHkgSSBhbSBnZXR0aW5n
IHRoaXMgcHJvYmxlbS4KCkkgYW0gYmFzaWNhbGx5IGxvb2tpbmcgdG8gYHN3aXRjaF9yb290YCBm
cm9tIGluaXRyZCB0byB0aGUgZnVsbCBmbGVkZ2VkIExpbnV4IHJvb3RmcyBidXQgdGhpcyBpcyBv
bmx5IHRoZSBmaXJzdCBzdGVwLgoKU2VudCB3aXRoIFtQcm90b25NYWlsXShodHRwczovL3Byb3Rv
bm1haWwuY29tKSBTZWN1cmUgRW1haWwu


--b1_0a6e74d445d619ee118d2c4da3278270
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdj5IaTxicj48YnI+SSBoYXZlIGEgd29ya2luZyBRRU1VIGltYWdlIGVtdWxhdGluZyBhbiBB
Uk0gdmV4cHJlc3MtYTkgYW5kIEkgcnVuIGl0IGxpa2Ugc286PGJyPjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+YHN1ZG8gcWVtdS1zeXN0ZW0tYXJtIC1tIDUxMk0gLU0gdmV4cHJlc3MtYTkgLUQg
cWVtdS5sb2cgLWQgdW5pbXAgLWtlcm5lbCBidWlsZHJvb3QtMjAxOS4wMi41L291dHB1dC9pbWFn
ZXMvekltYWdlIC1kdGIgYnVpbGRyb290LTIwMTkuMDIuNS9vdXRwdXQvaW1hZ2VzL3ZleHByZXNz
LXYycC1jYTkuZHRiIC1hcHBlbmQgImNvbnNvbGU9dHR5QU1BMCwxMTUyMDAga2dkYm9jPWtiZCx0
dHlBTUEwLDExNTIwMCBpcD1kaGNwIG5va2FzbHIiIC1pbml0cmQgYnVpbGRyb290LTIwMTkuMDIu
NS9vdXRwdXQvaW1hZ2VzL3Jvb3Rmcy5jcGlvIC1ub2dyYXBoaWMgLW5ldCBuaWMgLW5ldCBicmlk
Z2UsYnI9bXlicmlkZ2UgLXNgPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3b3VsZCBu
b3cgbGlrZSB0byBhZGQgYSBoYXJkIGRpc2sgZm9yIHBlcnNpc3RlbnQgc3RvcmFnZSBhbmQgdGhl
biB0cmFuc2ZlciBjb250cm9sIGZyb20gYnVzeWJveCBpbml0cmQgYmFzZWQgcm9vdGZzIG92ZXIg
dG8gdGhlIGZ1bGwgZmxlZGdlZCB2ZXJzaW9uIG9mZmVyZWQgd2l0aCBMaW51eC4gU28gSSBhZGQg
aXQgdG8gdGhlIGNvbW1hbmQgbGluZTxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmBzdWRv
IHFlbXUtc3lzdGVtLWFybSAtbSAxMDI0TSAtTSB2ZXhwcmVzcy1hOSAtRCBxZW11LmxvZyAtZHJp
dmUgaWY9bm9uZSxmb3JtYXQ9cmF3LGZpbGU9ZGlzay5pbWcgLWtlcm5lbCBidWlsZHJvb3QtMjAx
OS4wMi41L291dHB1dC9pbWFnZXMvekltYWdlIC1kdGIgYnVpbGRyb290LTIwMTkuMDIuNS9vdXRw
dXQvaW1hZ2VzL3ZleHByZXNzLXYycC1jYTkuZHRiIC1hcHBlbmQgImNvbnNvbGU9dHR5QU1BMCwx
MTUyMDAga2dkYm9jPWtiZCx0dHlBTUEwLDExNTIwMCBpcD1kaGNwIG5va2FzbHIiIC1pbml0cmQg
YnVpbGRyb290LTIwMTkuMDIuNS9vdXRwdXQvaW1hZ2VzL3Jvb3Rmcy5jcGlvIC1ub2dyYXBoaWMg
LW5ldCBuaWMgLW5ldCBicmlkZ2UsYnI9bXlicmlkZ2UgLXM8YnI+PC9kaXY+PGRpdj5gPGJyPjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+b2YgY291cnNlIEkgZmlyc3QgY3JlYXRlIGEgZGlzayBp
bWFnZSBhbmQgZm9ybWF0IGl0IGFzIGV4dDI6PGJyPjwvZGl2PjxkaXY+YHFlbXUtaW1nIGNyZWF0
ZSBkaXNrLmltZyAxMEcgJmFtcDsmYW1wOyBta2ZzLmV4dDIgLUYgZGlzay5pbWdgPGJyPjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+RnJvbSB0aGUgbG9nIG1lc3NhZ2VzIEkgc2VlIHRoYXQgaXQg
aGFzIG5vdCBiZWVuIGFibGUgdG8gZGV0ZWN0IHRoaXMgYXQgYWxsLiBDYW4gc29tZW9uZSBwbGVh
c2Ugc3VtbWFyaXplIGhvdyBibG9jayBkZXZpY2VzIHdvcmsgd2l0aCBRZW11LiBJIGtub3cgdGhl
IG9sZGVyIGAtaGRhYCBoYXMgYmVlbiBjaGFuZ2VkIHRvIGEgbmV3ZXIgYC1kcml2ZWAgb3B0aW9u
IGNhbiBjb21iaW5lcyB0aGUgY3VtYmVyc29tZSBzcGVjaWZpY2F0aW9uIG9mIHRoZSBmcm9udCBh
bmQgYmFjayBlbmRzIHNlcGFyYXRlbHkuIEJ1dCBJIGRvbid0IGtub3cgdGhlIGJhc2ljcyBhbmQg
d2h5IEkgYW0gZ2V0dGluZyB0aGlzIHByb2JsZW0uPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+SSBhbSBiYXNpY2FsbHkgbG9va2luZyB0byBgc3dpdGNoX3Jvb3RgIGZyb20gaW5pdHJkIHRv
IHRoZSBmdWxsIGZsZWRnZWQgTGludXggcm9vdGZzIGJ1dCB0aGlzIGlzIG9ubHkgdGhlIGZpcnN0
IHN0ZXAuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2ln
bmF0dXJlX2Jsb2NrIj48ZGl2IGNsYXNzPSJwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay11c2Vy
IHByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVtcHR5Ij48YnI+PC9kaXY+PGRpdiBjbGFzcz0i
cHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stcHJvdG9uIj5TZW50IHdpdGggPGEgaHJlZj0iaHR0
cHM6Ly9wcm90b25tYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPlByb3Rvbk1haWw8L2E+IFNlY3Vy
ZSBFbWFpbC48YnI+PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+



--b1_0a6e74d445d619ee118d2c4da3278270--


