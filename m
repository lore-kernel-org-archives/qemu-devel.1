Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7525C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34BB20656
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTlssigd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34BB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Qa0-0005n0-Qk
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QYG-0002Ao-1O
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QYE-0001l2-Ci
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QYB-0001aU-4u
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6n2o0LSHov0aMAxHz23Ks8nTcqE/EL9ARTrF1h5BpSY=;
 b=TTlssigd9r7zrSoYtJBL+h0WDCj+II5iJ6C9H6DhP2GRvCuk4+czQ5NyhSbDR3HdaCqyL0
 x0u5xDVUR29HsdxEnUSxrHlWJ0rSfXmmP+m3v3lxm272Sdl7emdUf93tgdgy3v8ypyBgbF
 NXZG/c8POVYn4MTk/cx3HPIW2EoOfgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-5xJcy3bDMQKIDx4y4n_OKg-1; Sat, 22 Feb 2020 03:54:12 -0500
X-MC-Unique: 5xJcy3bDMQKIDx4y4n_OKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 060811005510;
 Sat, 22 Feb 2020 08:54:11 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7B990F71;
 Sat, 22 Feb 2020 08:53:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/31] libqos: split qos-test and libqos makefile vars
Date: Sat, 22 Feb 2020 08:50:18 +0000
Message-Id: <20200222085030.1760640-20-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Darren Kenny <darren.kenny@oracle.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpNb3N0IHFvcy1yZWxhdGVk
IG9iamVjdHMgd2VyZSBzcGVjaWZpZWQgaW4gdGhlIHFvcy10ZXN0LW9iai15IHZhcmlhYmxlLgpx
b3MtdGVzdC1vYmoteSBhbHNvIGluY2x1ZGVkIHFvcy10ZXN0Lm8gd2hpY2ggZGVmaW5lcyBhIG1h
aW4oKS4KVGhpcyBtYWRlIGl0IGRpZmZpY3VsdCB0byByZXB1cnBvc2UgcW9zLXRlc3Qtb2JqLXkg
dG8gbGluayBhbnl0aGluZwpiZXNpZGUgdGVzdHMvcW9zLXRlc3QgYWdhaW5zdCBsaWJxb3MuIFRo
aXMgY2hhbmdlIHNlcGFyYXRlcyBvYmplY3RzIHRoYXQKYXJlIGxpYnFvcy1zcGVjaWZpYyBhbmQg
b25lcyB0aGF0IGFyZSBxb3MtdGVzdCBzcGVjaWZpYyBpbnRvIGRpZmZlcmVudAp2YXJpYWJsZXMu
CgpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3
ZWQtYnk6IERhcnJlbiBLZW5ueSA8ZGFycmVuLmtlbm55QG9yYWNsZS5jb20+ClJldmlld2VkLWJ5
OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAw
MjIwMDQxMTE4LjIzMjY0LTExLWFseG5kckBidS5lZHUKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhh
am5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHRlc3RzL3F0ZXN0L01ha2VmaWxlLmlu
Y2x1ZGUgfCA3MSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
ZXN0cy9xdGVzdC9NYWtlZmlsZS5pbmNsdWRlIGIvdGVzdHMvcXRlc3QvTWFrZWZpbGUuaW5jbHVk
ZQppbmRleCBlYjBmMjNiMTA4Li44Mzg2MThlNmY5IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9N
YWtlZmlsZS5pbmNsdWRlCisrKyBiL3Rlc3RzL3F0ZXN0L01ha2VmaWxlLmluY2x1ZGUKQEAgLTE1
Nyw1MiArMTU3LDUzIEBAIGNoZWNrLXF0ZXN0LXMzOTB4LXkgKz0gbWlncmF0aW9uLXRlc3QKICMg
bGlicW9zIC8gcWdyYXBoIDoKIGxpYnFncmFwaC1vYmoteSA9IHRlc3RzL3F0ZXN0L2xpYnFvcy9x
Z3JhcGgubwogCi1saWJxb3Mtb2JqLXkgPSAkKGxpYnFncmFwaC1vYmoteSkgdGVzdHMvcXRlc3Qv
bGlicW9zL3BjaS5vIHRlc3RzL3F0ZXN0L2xpYnFvcy9md19jZmcubwotbGlicW9zLW9iai15ICs9
IHRlc3RzL3F0ZXN0L2xpYnFvcy9tYWxsb2MubwotbGlicW9zLW9iai15ICs9IHRlc3RzL3F0ZXN0
L2xpYnFvcy9saWJxb3MubwotbGlicW9zLXNwYXByLW9iai15ID0gJChsaWJxb3Mtb2JqLXkpIHRl
c3RzL3F0ZXN0L2xpYnFvcy9tYWxsb2Mtc3BhcHIubworbGlicW9zLWNvcmUtb2JqLXkgPSAkKGxp
YnFncmFwaC1vYmoteSkgdGVzdHMvcXRlc3QvbGlicW9zL3BjaS5vIHRlc3RzL3F0ZXN0L2xpYnFv
cy9md19jZmcubworbGlicW9zLWNvcmUtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL21hbGxv
Yy5vCitsaWJxb3MtY29yZS1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvbGlicW9zLm8KK2xp
YnFvcy1zcGFwci1vYmoteSA9ICQobGlicW9zLWNvcmUtb2JqLXkpIHRlc3RzL3F0ZXN0L2xpYnFv
cy9tYWxsb2Mtc3BhcHIubwogbGlicW9zLXNwYXByLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFv
cy9saWJxb3Mtc3BhcHIubwogbGlicW9zLXNwYXByLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFv
cy9ydGFzLm8KIGxpYnFvcy1zcGFwci1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvcGNpLXNw
YXByLm8KLWxpYnFvcy1wYy1vYmoteSA9ICQobGlicW9zLW9iai15KSB0ZXN0cy9xdGVzdC9saWJx
b3MvcGNpLXBjLm8KK2xpYnFvcy1wYy1vYmoteSA9ICQobGlicW9zLWNvcmUtb2JqLXkpIHRlc3Rz
L3F0ZXN0L2xpYnFvcy9wY2ktcGMubwogbGlicW9zLXBjLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xp
YnFvcy9tYWxsb2MtcGMubyB0ZXN0cy9xdGVzdC9saWJxb3MvbGlicW9zLXBjLm8KIGxpYnFvcy1w
Yy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvYWhjaS5vCiBsaWJxb3MtdXNiLW9iai15ID0g
JChsaWJxb3Mtc3BhcHItb2JqLXkpICQobGlicW9zLXBjLW9iai15KSB0ZXN0cy9xdGVzdC9saWJx
b3MvdXNiLm8KIAogIyBxb3MgZGV2aWNlczoKLXFvcy10ZXN0LW9iai15ID0gdGVzdHMvcXRlc3Qv
cW9zLXRlc3QubyAkKGxpYnFncmFwaC1vYmoteSkKLXFvcy10ZXN0LW9iai15ICs9ICQobGlicW9z
LXBjLW9iai15KSAkKGxpYnFvcy1zcGFwci1vYmoteSkKLXFvcy10ZXN0LW9iai15ICs9IHRlc3Rz
L3F0ZXN0L2xpYnFvcy9lMTAwMGUubwotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGli
cW9zL2kyYy5vCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvaTJjLWlteC5v
Ci1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvaTJjLW9tYXAubwotcW9zLXRl
c3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3NkaGNpLm8KLXFvcy10ZXN0LW9iai15ICs9
IHRlc3RzL3F0ZXN0L2xpYnFvcy90cGNpMjAwLm8KLXFvcy10ZXN0LW9iai15ICs9IHRlc3RzL3F0
ZXN0L2xpYnFvcy92aXJ0aW8ubwotcW9zLXRlc3Qtb2JqLSQoQ09ORklHX1ZJUlRGUykgKz0gdGVz
dHMvcXRlc3QvbGlicW9zL3ZpcnRpby05cC5vCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVz
dC9saWJxb3MvdmlydGlvLWJhbGxvb24ubwotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3Qv
bGlicW9zL3ZpcnRpby1ibGsubwotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9z
L3ZpcnRpby1tbWlvLm8KLXFvcy10ZXN0LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0
aW8tbmV0Lm8KLXFvcy10ZXN0LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tcGNp
Lm8KLXFvcy10ZXN0LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tcGNpLW1vZGVy
bi5vCi1xb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLXJuZy5vCi1x
b3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLXNjc2kubwotcW9zLXRl
c3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3ZpcnRpby1zZXJpYWwubworbGlicW9zLW9i
ai15ID0gICQobGlicWdyYXBoLW9iai15KQorbGlicW9zLW9iai15ICs9ICQobGlicW9zLXBjLW9i
ai15KSAkKGxpYnFvcy1zcGFwci1vYmoteSkKK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9s
aWJxb3MvZTEwMDBlLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvaTJjLm8K
K2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvaTJjLWlteC5vCitsaWJxb3Mtb2Jq
LXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2kyYy1vbWFwLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0
cy9xdGVzdC9saWJxb3Mvc2RoY2kubworbGlicW9zLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFv
cy90cGNpMjAwLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLm8K
K2xpYnFvcy1vYmotJChDT05GSUdfVklSVEZTKSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlv
LTlwLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLWJhbGxvb24u
bworbGlicW9zLW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tYmxrLm8KK2xpYnFv
cy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLW1taW8ubworbGlicW9zLW9iai15
ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tbmV0Lm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0
cy9xdGVzdC9saWJxb3MvdmlydGlvLXBjaS5vCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3Qv
bGlicW9zL3ZpcnRpby1wY2ktbW9kZXJuLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9s
aWJxb3MvdmlydGlvLXJuZy5vCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3Zp
cnRpby1zY3NpLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvdmlydGlvLXNl
cmlhbC5vCiAKICMgcW9zIG1hY2hpbmVzOgotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3Qv
bGlicW9zL2FhcmNoNjQteGxueC16Y3UxMDItbWFjaGluZS5vCi1xb3MtdGVzdC1vYmoteSArPSB0
ZXN0cy9xdGVzdC9saWJxb3MvYXJtLWlteDI1LXBkay1tYWNoaW5lLm8KLXFvcy10ZXN0LW9iai15
ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9hcm0tbjgwMC1tYWNoaW5lLm8KLXFvcy10ZXN0LW9iai15
ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9hcm0tcmFzcGkyLW1hY2hpbmUubwotcW9zLXRlc3Qtb2Jq
LXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2FybS1zYWJyZWxpdGUtbWFjaGluZS5vCi1xb3MtdGVz
dC1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvYXJtLXNtZGtjMjEwLW1hY2hpbmUubwotcW9z
LXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2FybS12aXJ0LW1hY2hpbmUubwotcW9z
LXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL2FybS14aWxpbngtenlucS1hOS1tYWNo
aW5lLm8KLXFvcy10ZXN0LW9iai15ICs9IHRlc3RzL3F0ZXN0L2xpYnFvcy9wcGM2NF9wc2VyaWVz
LW1hY2hpbmUubwotcW9zLXRlc3Qtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9zL3g4Nl82NF9w
Yy1tYWNoaW5lLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3MvYWFyY2g2NC14
bG54LXpjdTEwMi1tYWNoaW5lLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJxb3Mv
YXJtLWlteDI1LXBkay1tYWNoaW5lLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9saWJx
b3MvYXJtLW44MDAtbWFjaGluZS5vCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9z
L2FybS1yYXNwaTItbWFjaGluZS5vCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGlicW9z
L2FybS1zYWJyZWxpdGUtbWFjaGluZS5vCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGli
cW9zL2FybS1zbWRrYzIxMC1tYWNoaW5lLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9xdGVzdC9s
aWJxb3MvYXJtLXZpcnQtbWFjaGluZS5vCitsaWJxb3Mtb2JqLXkgKz0gdGVzdHMvcXRlc3QvbGli
cW9zL2FybS14aWxpbngtenlucS1hOS1tYWNoaW5lLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0cy9x
dGVzdC9saWJxb3MvcHBjNjRfcHNlcmllcy1tYWNoaW5lLm8KK2xpYnFvcy1vYmoteSArPSB0ZXN0
cy9xdGVzdC9saWJxb3MveDg2XzY0X3BjLW1hY2hpbmUubwogCiAjIHFvcyB0ZXN0czoKK3Fvcy10
ZXN0LW9iai15ICs9IHRlc3RzL3F0ZXN0L3Fvcy10ZXN0Lm8KIHFvcy10ZXN0LW9iai15ICs9IHRl
c3RzL3F0ZXN0L2FjOTctdGVzdC5vCiBxb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9kczEz
MzgtdGVzdC5vCiBxb3MtdGVzdC1vYmoteSArPSB0ZXN0cy9xdGVzdC9lMTAwMC10ZXN0Lm8KQEAg
LTIzNCw3ICsyMzUsNyBAQCBjaGVjay11bml0LXkgKz0gdGVzdHMvdGVzdC1xZ3JhcGgkKEVYRVNV
RikKIHRlc3RzL3Rlc3QtcWdyYXBoJChFWEVTVUYpOiB0ZXN0cy90ZXN0LXFncmFwaC5vICQobGli
cWdyYXBoLW9iai15KQogCiBjaGVjay1xdGVzdC1nZW5lcmljLXkgKz0gcW9zLXRlc3QKLXRlc3Rz
L3F0ZXN0L3Fvcy10ZXN0JChFWEVTVUYpOiAkKHFvcy10ZXN0LW9iai15KQordGVzdHMvcXRlc3Qv
cW9zLXRlc3QkKEVYRVNVRik6ICQocW9zLXRlc3Qtb2JqLXkpICQobGlicW9zLW9iai15KQogCiAj
IFFUZXN0IGRlcGVuZGVuY2llczoKIHRlc3RzL3F0ZXN0L3FtcC10ZXN0JChFWEVTVUYpOiB0ZXN0
cy9xdGVzdC9xbXAtdGVzdC5vCi0tIAoyLjI0LjEKCg==


