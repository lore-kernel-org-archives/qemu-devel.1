Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D6E20709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBQVGA13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D6E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxHL-0003Pk-Jj
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBz-0004Go-OZ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBz-0001a5-1e
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNIXapfmc2kvQpMpHBzj75KGg4H4voRcObmUpxsjrMs=;
 b=GBQVGA13I4eNr8/GLgOKw/wClRKLWSdVfNHTF+NvJsC+b/AQ1RF59/edD9NsIIo7NX/Syg
 TIxtCWOzuKxSnSiivJ3Iz15E/MPEuX9b6nXgftQL/qbXETuYI/f4F73PbBmY74fV3EjyfG
 ZmhiczhfSxTF6WwNQ57NiAUay0P3Yug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-ZKil5r5YPpaAEdeBONwDAA-1; Tue, 19 May 2020 04:01:34 -0400
X-MC-Unique: ZKil5r5YPpaAEdeBONwDAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F06318005AA;
 Tue, 19 May 2020 08:01:32 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C083A1944E;
 Tue, 19 May 2020 08:01:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] tests/fuzz: Remove unuseful/unused typedefs
Date: Tue, 19 May 2020 09:00:50 +0100
Message-Id: <20200519080054.146495-5-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
References: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVGhlc2Ug
dHlwZWRlZnMgYXJlIG5vdCB1c2VkLiBVc2UgYSBzaW1wbGUgc3RydWN0dXJlLApyZW1vdGUgdGhl
IHR5cGVkZWZzLgoKU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMDUxNDE0MzQzMy4xODU2OS01LXBoaWxtZEBy
ZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMgfCAxMCArKysrLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3Rlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYyBiL3Rlc3RzL3F0ZXN0L2Z1enov
aTQ0MGZ4X2Z1enouYwppbmRleCA5NmZlZDlmZjEyLi5jMTk3YjAyNmRiIDEwMDY0NAotLS0gYS90
ZXN0cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMKKysrIGIvdGVzdHMvcXRlc3QvZnV6ei9pNDQw
ZnhfZnV6ei5jCkBAIC00NSwxMiArNDUsMTEgQEAgc3RhdGljIHZvaWQgaTQ0MGZ4X2Z1enpfcXRl
c3QoUVRlc3RTdGF0ZSAqcywKICAgICAgKiBsb29wIG92ZXIgdGhlIERhdGEsIGJyZWFraW5nIGl0
IHVwIGludG8gYWN0aW9ucy4gZWFjaCBhY3Rpb24gaGFzIGFuCiAgICAgICogb3Bjb2RlLCBhZGRy
ZXNzIG9mZnNldCBhbmQgdmFsdWUKICAgICAgKi8KLSAgICB0eXBlZGVmIHN0cnVjdCBRVGVzdEZ1
enpBY3Rpb24geworICAgIHN0cnVjdCB7CiAgICAgICAgIHVpbnQ4X3Qgb3Bjb2RlOwogICAgICAg
ICB1aW50OF90IGFkZHI7CiAgICAgICAgIHVpbnQzMl90IHZhbHVlOwotICAgIH0gUVRlc3RGdXp6
QWN0aW9uOwotICAgIFFUZXN0RnV6ekFjdGlvbiBhOworICAgIH0gYTsKIAogICAgIHdoaWxlIChT
aXplID49IHNpemVvZihhKSkgewogICAgICAgICAvKiBtYWtlIGEgY29weSBvZiB0aGUgYWN0aW9u
IHNvIHdlIGNhbiBub3JtYWxpemUgdGhlIHZhbHVlcyBpbi1wbGFjZSAqLwpAQCAtOTEsMTkgKzkw
LDE4IEBAIHN0YXRpYyB2b2lkIGk0NDBmeF9mdXp6X3FvcyhRVGVzdFN0YXRlICpzLAogICAgICAq
IFNhbWUgYXMgaTQ0MGZ4X2Z1enpfcXRlc3QsIGJ1dCB1c2luZyBRT1MuIGRldmZuIGlzIGluY29y
cG9yYXRlZCBpbnRvIHRoZQogICAgICAqIHZhbHVlIHdyaXR0ZW4gb3ZlciBQb3J0IElPCiAgICAg
ICovCi0gICAgdHlwZWRlZiBzdHJ1Y3QgUU9TRnV6ekFjdGlvbiB7CisgICAgc3RydWN0IHsKICAg
ICAgICAgdWludDhfdCBvcGNvZGU7CiAgICAgICAgIHVpbnQ4X3Qgb2Zmc2V0OwogICAgICAgICBp
bnQgZGV2Zm47CiAgICAgICAgIHVpbnQzMl90IHZhbHVlOwotICAgIH0gUU9TRnV6ekFjdGlvbjsK
KyAgICB9IGE7CiAKICAgICBzdGF0aWMgUVBDSUJ1cyAqYnVzOwogICAgIGlmICghYnVzKSB7CiAg
ICAgICAgIGJ1cyA9IHFwY2lfbmV3X3BjKHMsIGZ1enpfcW9zX2FsbG9jKTsKICAgICB9CiAKLSAg
ICBRT1NGdXp6QWN0aW9uIGE7CiAgICAgd2hpbGUgKFNpemUgPj0gc2l6ZW9mKGEpKSB7CiAgICAg
ICAgIG1lbWNweSgmYSwgRGF0YSwgc2l6ZW9mKGEpKTsKICAgICAgICAgc3dpdGNoIChhLm9wY29k
ZSAlIEFDVElPTl9NQVgpIHsKLS0gCjIuMjUuMwoK


