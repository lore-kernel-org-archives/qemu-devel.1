Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE012070E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjMJe2kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE012070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADtr-0004JT-LT
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jADt5-0003Nq-2m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jADt3-0007VG-Hv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56432
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jADt3-0007IW-Cj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583504616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7mfZ74BwmZdiyyzlqXXN0fK4giEEEuqHqbKDSpCy3U=;
 b=TjMJe2kErqOt3x0AFRGhzYxrBdxxa3Rml6NItWa6ePCfj0cE34MfatTm2ZNCMEJGdhBXPV
 NQ2X40rbswGvGBZWuvvwDunauFT4YIqXWnvEe3fNTapM8GcCBPMhZSdXbPwfwPC3i5p7rK
 J5wVUmC+tHm4JK67d661q5fJnbZhIpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-Tpf-xd8aNaqKbb-TAlmuLw-1; Fri, 06 Mar 2020 09:23:33 -0500
X-MC-Unique: Tpf-xd8aNaqKbb-TAlmuLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B19F218CA24B;
 Fri,  6 Mar 2020 14:23:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8025D73899;
 Fri,  6 Mar 2020 14:23:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] fuzz: fix style/typos in linker-script comments
Date: Fri,  6 Mar 2020 14:23:16 +0000
Message-Id: <20200306142318.1435372-2-stefanha@redhat.com>
In-Reply-To: <20200306142318.1435372-1-stefanha@redhat.com>
References: <20200306142318.1435372-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2Ug
PGVibGFrZUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogRGFycmVuIEtlbm55IDxkYXJyZW4ua2Vu
bnlAb3JhY2xlLmNvbT4KTWVzc2FnZS1pZDogMjAyMDAyMjcwMzE0MzkuMzEzODYtMi1hbHhuZHJA
YnUuZWR1ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4KLS0tCiB0ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5sZCB8IDE2ICsrKysrKysrKystLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkIGIvdGVzdHMvcXRlc3QvZnV6
ei9mb3JrX2Z1enoubGQKaW5kZXggYjIzYTU5ZjE5NC4uZTA4NmJiYTg3MyAxMDA2NDQKLS0tIGEv
dGVzdHMvcXRlc3QvZnV6ei9mb3JrX2Z1enoubGQKKysrIGIvdGVzdHMvcXRlc3QvZnV6ei9mb3Jr
X2Z1enoubGQKQEAgLTEsNyArMSw4IEBACi0vKiBXZSBhZGp1c3QgbGlua2VyIHNjcmlwdCBtb2Rp
ZmljYXRpb24gdG8gcGxhY2UgYWxsIG9mIHRoZSBzdHVmZiB0aGF0IG5lZWRzIHRvCi0gKiBwZXJz
aXN0IGFjcm9zcyBmdXp6aW5nIHJ1bnMgaW50byBhIGNvbnRpZ3VvdXMgc2VjaXRvbiBvZiBtZW1v
cnkuIFRoZW4sIGl0IGlzCisvKgorICogV2UgYWRqdXN0IGxpbmtlciBzY3JpcHQgbW9kaWZpY2F0
aW9uIHRvIHBsYWNlIGFsbCBvZiB0aGUgc3R1ZmYgdGhhdCBuZWVkcyB0bworICogcGVyc2lzdCBh
Y3Jvc3MgZnV6emluZyBydW5zIGludG8gYSBjb250aWd1b3VzIHNlY3Rpb24gb2YgbWVtb3J5LiBU
aGVuLCBpdCBpcwogICogZWFzeSB0byByZS1tYXAgdGhlIGNvdW50ZXItcmVsYXRlZCBtZW1vcnkg
YXMgc2hhcmVkLgotKi8KKyAqLwogCiBTRUNUSU9OUwogewpAQCAtMTcsNyArMTgsOCBAQCBTRUNU
SU9OUwogICB9CiAgIC5kYXRhLmZ1enpfb3JkZXJlZCA6CiAgIHsKLSAgICAgIC8qIENvdmVyYWdl
IGNvdW50ZXJzLiBUaGV5J3JlIG5vdCBuZWNlc3NhcnkgZm9yIGZ1enppbmcsIGJ1dCBhcmUgdXNl
ZnVsCisgICAgICAvKgorICAgICAgICogQ292ZXJhZ2UgY291bnRlcnMuIFRoZXkncmUgbm90IG5l
Y2Vzc2FyeSBmb3IgZnV6emluZywgYnV0IGFyZSB1c2VmdWwKICAgICAgICAqIGZvciBhbmFseXpp
bmcgdGhlIGZ1enppbmcgcGVyZm9ybWFuY2UKICAgICAgICAqLwogICAgICAgX19zdGFydF9fX2xs
dm1fcHJmX2NudHMgPSAuOwpAQCAtMzIsNiArMzQsOCBAQCBTRUNUSU9OUwogICAgICAgX19GVVpa
X0NPVU5URVJTX0VORCA9IC47CiAgIH0KIH0KLS8qIERvbnQgb3ZlcndyaXRlIHRoZSBTRUNUSU9O
UyBpbiB0aGUgZGVmYXVsdCBsaW5rZXIgc2NyaXB0LiBJbnN0ZWFkIGluc2VydCB0aGUKLSAqIGFi
b3ZlIGludG8gdGhlIGRlZmF1bHQgc2NyaXB0ICovCisvKgorICogRG9uJ3Qgb3ZlcndyaXRlIHRo
ZSBTRUNUSU9OUyBpbiB0aGUgZGVmYXVsdCBsaW5rZXIgc2NyaXB0LiBJbnN0ZWFkIGluc2VydCB0
aGUKKyAqIGFib3ZlIGludG8gdGhlIGRlZmF1bHQgc2NyaXB0CisgKi8KIElOU0VSVCBBRlRFUiAu
ZGF0YTsKLS0gCjIuMjQuMQoK


