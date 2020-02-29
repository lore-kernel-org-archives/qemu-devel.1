Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73245C3F2CE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 11:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4261B246AE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 11:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+vU59VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4261B246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j808W-0005SU-AR
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 06:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j807t-000510-Jd
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 06:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j807s-0000oA-AC
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 06:17:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48327
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j807s-0000nx-6o
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 06:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582975063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=247h7hyvoUY52dJB/D3gzlpTpYLPfv4dGHUCwLrxR0E=;
 b=D+vU59VAmI/OfLCf6YfW0acUogA3mF2J/MemsEUh8ByLA8m4D4bw2K7U3jwkDf7xigzXVX
 VSJg7iXoMMK4e9F7HcCjPVJZaZgn9LAO1ZD2zjaTJ+/p4Lbi7vDG9uCzc+1mSE1ANjSOCl
 c4tAcc4UPhS2oqkGv8HMXXwRkKqMMDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-de5pL7o5M8aOgm3ZtaaZ7g-1; Sat, 29 Feb 2020 06:17:33 -0500
X-MC-Unique: de5pL7o5M8aOgm3ZtaaZ7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7618800D48;
 Sat, 29 Feb 2020 11:17:32 +0000 (UTC)
Received: from localhost (ovpn-116-42.ams2.redhat.com [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF4733A3;
 Sat, 29 Feb 2020 11:17:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] l2tpv3: fix RFC number typo in qemu-options.hx
Date: Sat, 29 Feb 2020 11:17:27 +0000
Message-Id: <20200229111727.350893-1-stefanha@redhat.com>
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
Cc: sw@weilnetz.de, jasowang@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Henrik Johansson <henrikjohansson@rocketmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIEwyVFB2MyBSRkMgbnVtYmVyIGlzIDM5MzE6Cmh0dHBzOi8vdG9vbHMuaWV0Zi5vcmcvaHRt
bC9yZmMzOTMxCgpSZXBvcnRlZC1ieTogSGVucmlrIEpvaGFuc3NvbiA8aGVucmlram9oYW5zc29u
QHJvY2tldG1haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+Ci0tLQogcWVtdS1vcHRpb25zLmh4IHwgNCArKy0tCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3FlbXUtb3B0
aW9ucy5oeCBiL3FlbXUtb3B0aW9ucy5oeAppbmRleCBhYzMxNWMxYWM0Li41NWE1MzllMDRmIDEw
MDY0NAotLS0gYS9xZW11LW9wdGlvbnMuaHgKKysrIGIvcWVtdS1vcHRpb25zLmh4CkBAIC0yMzMw
LDcgKzIzMzAsNyBAQCBERUYoIm5ldGRldiIsIEhBU19BUkcsIFFFTVVfT1BUSU9OX25ldGRldiwK
ICAgICAiICAgICAgICAgICAgICAgIExpbnV4IGtlcm5lbCAzLjMrIGFzIHdlbGwgYXMgbW9zdCBy
b3V0ZXJzIGNhbiB0YWxrXG4iCiAgICAgIiAgICAgICAgICAgICAgICBMMlRQdjMuIFRoaXMgdHJh
bnNwb3J0IGFsbG93cyBjb25uZWN0aW5nIGEgVk0gdG8gYSBWTSxcbiIKICAgICAiICAgICAgICAg
ICAgICAgIFZNIHRvIGEgcm91dGVyIGFuZCBldmVuIFZNIHRvIEhvc3QuIEl0IGlzIGEgbmVhcmx5
LXVuaXZlcnNhbFxuIgotICAgICIgICAgICAgICAgICAgICAgc3RhbmRhcmQgKFJGQzMzOTEpLiBO
b3RlIC0gdGhpcyBpbXBsZW1lbnRhdGlvbiB1c2VzIHN0YXRpY1xuIgorICAgICIgICAgICAgICAg
ICAgICAgc3RhbmRhcmQgKFJGQzM5MzEpLiBOb3RlIC0gdGhpcyBpbXBsZW1lbnRhdGlvbiB1c2Vz
IHN0YXRpY1xuIgogICAgICIgICAgICAgICAgICAgICAgcHJlLWNvbmZpZ3VyZWQgdHVubmVscyAo
c2FtZSBhcyB0aGUgTGludXgga2VybmVsKS5cbiIKICAgICAiICAgICAgICAgICAgICAgIHVzZSAn
c3JjPScgdG8gc3BlY2lmeSBzb3VyY2UgYWRkcmVzc1xuIgogICAgICIgICAgICAgICAgICAgICAg
dXNlICdkc3Q9JyB0byBzcGVjaWZ5IGRlc3RpbmF0aW9uIGFkZHJlc3NcbiIKQEAgLTI3MzcsNyAr
MjczNyw3IEBAIEV4YW1wbGUgKHNlbmQgcGFja2V0cyBmcm9tIGhvc3QncyAxLjIuMy40KToKIEBl
bmQgZXhhbXBsZQogCiBAaXRlbSAtbmV0ZGV2IGwydHB2MyxpZD1AdmFye2lkfSxzcmM9QHZhcntz
cmNhZGRyfSxkc3Q9QHZhcntkc3RhZGRyfVssc3JjcG9ydD1AdmFye3NyY3BvcnR9XVssZHN0cG9y
dD1AdmFye2RzdHBvcnR9XSx0eHNlc3Npb249QHZhcnt0eHNlc3Npb259WyxyeHNlc3Npb249QHZh
cntyeHNlc3Npb259XVssaXB2Nl1bLHVkcF1bLGNvb2tpZTY0XVssY291bnRlcl1bLHBpbmNvdW50
ZXJdWyx0eGNvb2tpZT1AdmFye3R4Y29va2llfV1bLHJ4Y29va2llPUB2YXJ7cnhjb29raWV9XVss
b2Zmc2V0PUB2YXJ7b2Zmc2V0fV0KLUNvbmZpZ3VyZSBhIEwyVFB2MyBwc2V1ZG93aXJlIGhvc3Qg
bmV0d29yayBiYWNrZW5kLiBMMlRQdjMgKFJGQzMzOTEpIGlzIGEKK0NvbmZpZ3VyZSBhIEwyVFB2
MyBwc2V1ZG93aXJlIGhvc3QgbmV0d29yayBiYWNrZW5kLiBMMlRQdjMgKFJGQzM5MzEpIGlzIGEK
IHBvcHVsYXIgcHJvdG9jb2wgdG8gdHJhbnNwb3J0IEV0aGVybmV0IChhbmQgb3RoZXIgTGF5ZXIg
MikgZGF0YSBmcmFtZXMgYmV0d2VlbgogdHdvIHN5c3RlbXMuIEl0IGlzIHByZXNlbnQgaW4gcm91
dGVycywgZmlyZXdhbGxzIGFuZCB0aGUgTGludXgga2VybmVsCiAoZnJvbSB2ZXJzaW9uIDMuMyBv
bndhcmRzKS4KLS0gCjIuMjQuMQoK


