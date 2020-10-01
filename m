Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F5FC47420
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EE5206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEeoFrJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EE5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNySd-0008GO-Az
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNyQB-0007Lz-BB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNyQ5-0006qX-KQ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601558087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3XbvsUjeKYcUEIboJ+hyeMcCuCcuXyUv198nBwa3Cc4=;
 b=eEeoFrJGn3fLXaIF6R7LbXsnJRWxLclA5LNZ1Ac/+PkvSNy8uwlPrHBEVvV7DyRU6HwGK2
 VW+eBOQdwwX11DVmBQwYFN/OQP1BElx14+kBL64JNZ/us5gla3Jp0nal8BLOPPtD+KHHNS
 yhxr5mTkFsZWP490Z9d2KX+WpbNJ9+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-njZgZPJ1OOGG_0ECpxlrjw-1; Thu, 01 Oct 2020 09:14:46 -0400
X-MC-Unique: njZgZPJ1OOGG_0ECpxlrjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 342D964093
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2020 13:14:45 +0000 (UTC)
Received: from localhost (ovpn-115-144.ams2.redhat.com [10.36.115.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D51F45C1D0;
 Thu,  1 Oct 2020 13:14:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block/export: fix QAPI doc indentation style violation
Date: Thu,  1 Oct 2020 14:14:39 +0100
Message-Id: <20201001131439.386431-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2luY2UgY29tbWl0IGE2OWE2ZDRiNGQ0ZmFlMmUzZDI1MDYyNDFlMjJhNzhmZjE3MzIyODMKKCJz
Y3JpcHRzL3FhcGkvcGFyc2VyLnB5OiBpbXByb3ZlIGRvYyBjb21tZW50IGluZGVudCBoYW5kbGlu
ZyIpIHRoZSBRQVBJCmdlbmVyYXRvciBlbWl0cyBhbiBlcnJvciB3aGVuIHVuaW5kZW50ZWQgdGV4
dCBmb2xsb3dzICJSZXR1cm5zOiIuCgpGaXggYmxvY2stZXhwb3J0Lmpzb24gYnkgbW92aW5nIHRo
ZSBjb21tZW50IHRvIG1ha2UgdGhlIFFBUEkgZ2VuZXJhdG9yCmhhcHB5LgoKU2lnbmVkLW9mZi1i
eTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KQmFzZWQtb246IGdp
dDovL3JlcG8ub3IuY3ovcWVtdS9rZXZpbi5naXQgYmxvY2sKCiBxYXBpL2Jsb2NrLWV4cG9ydC5q
c29uIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcWFwaS9ibG9jay1leHBv
cnQuanNvbiBiL3FhcGkvYmxvY2stZXhwb3J0Lmpzb24KaW5kZXggODdhYzUxMTdjZC4uYTc5M2Uz
NGFmOSAxMDA2NDQKLS0tIGEvcWFwaS9ibG9jay1leHBvcnQuanNvbgorKysgYi9xYXBpL2Jsb2Nr
LWV4cG9ydC5qc29uCkBAIC0zOSwyMSArMzksMjEgQEAKICMgc2VydmVyIHdpbGwgcHJlc2VudCB0
aGVtIGFzIG5hbWVkIGV4cG9ydHM7IGZvciBleGFtcGxlLCBhbm90aGVyCiAjIFFFTVUgaW5zdGFu
Y2UgY291bGQgcmVmZXIgdG8gdGhlbSBhcyAibmJkOkhPU1Q6UE9SVDpleHBvcnRuYW1lPU5BTUUi
LgogIwotIyBAYWRkcjogQWRkcmVzcyBvbiB3aGljaCB0byBsaXN0ZW4uCi0jIEB0bHMtY3JlZHM6
IElEIG9mIHRoZSBUTFMgY3JlZGVudGlhbHMgb2JqZWN0IChzaW5jZSAyLjYpLgotIyBAdGxzLWF1
dGh6OiBJRCBvZiB0aGUgUUF1dGhaIGF1dGhvcml6YXRpb24gb2JqZWN0IHVzZWQgdG8gdmFsaWRh
dGUKLSMgICAgICAgICAgICAgdGhlIGNsaWVudCdzIHg1MDkgZGlzdGluZ3Vpc2hlZCBuYW1lLiBU
aGlzIG9iamVjdCBpcwotIyAgICAgICAgICAgICBpcyBvbmx5IHJlc29sdmVkIGF0IHRpbWUgb2Yg
dXNlLCBzbyBjYW4gYmUgZGVsZXRlZCBhbmQKLSMgICAgICAgICAgICAgcmVjcmVhdGVkIG9uIHRo
ZSBmbHkgd2hpbGUgdGhlIE5CRCBzZXJ2ZXIgaXMgYWN0aXZlLgotIyAgICAgICAgICAgICBJZiBt
aXNzaW5nLCBpdCB3aWxsIGRlZmF1bHQgdG8gZGVueWluZyBhY2Nlc3MgKHNpbmNlIDQuMCkuCi0j
IEBtYXgtY29ubmVjdGlvbnM6IFRoZSBtYXhpbXVtIG51bWJlciBvZiBjb25uZWN0aW9ucyB0byBh
bGxvdyBhdCB0aGUgc2FtZQotIyAgICAgICAgICAgICAgICAgICB0aW1lLCAwIGZvciB1bmxpbWl0
ZWQuIChzaW5jZSA1LjI7IGRlZmF1bHQ6IDApCi0jCi0jIFJldHVybnM6IGVycm9yIGlmIHRoZSBz
ZXJ2ZXIgaXMgYWxyZWFkeSBydW5uaW5nLgotIwogIyBLZWVwIHRoaXMgdHlwZSBjb25zaXN0ZW50
IHdpdGggdGhlIE5iZFNlcnZlck9wdGlvbnMgdHlwZS4gVGhlIG9ubHkgaW50ZW5kZWQKICMgZGlm
ZmVyZW5jZSBpcyB1c2luZyBTb2NrZXRBZGRyZXNzTGVnYWN5IGluc3RlYWQgb2YgU29ja2V0QWRk
cmVzcy4KICMKKyMgQGFkZHI6IEFkZHJlc3Mgb24gd2hpY2ggdG8gbGlzdGVuLgorIyBAdGxzLWNy
ZWRzOiBJRCBvZiB0aGUgVExTIGNyZWRlbnRpYWxzIG9iamVjdCAoc2luY2UgMi42KS4KKyMgQHRs
cy1hdXRoejogSUQgb2YgdGhlIFFBdXRoWiBhdXRob3JpemF0aW9uIG9iamVjdCB1c2VkIHRvIHZh
bGlkYXRlCisjICAgICAgICAgICAgIHRoZSBjbGllbnQncyB4NTA5IGRpc3Rpbmd1aXNoZWQgbmFt
ZS4gVGhpcyBvYmplY3QgaXMKKyMgICAgICAgICAgICAgaXMgb25seSByZXNvbHZlZCBhdCB0aW1l
IG9mIHVzZSwgc28gY2FuIGJlIGRlbGV0ZWQgYW5kCisjICAgICAgICAgICAgIHJlY3JlYXRlZCBv
biB0aGUgZmx5IHdoaWxlIHRoZSBOQkQgc2VydmVyIGlzIGFjdGl2ZS4KKyMgICAgICAgICAgICAg
SWYgbWlzc2luZywgaXQgd2lsbCBkZWZhdWx0IHRvIGRlbnlpbmcgYWNjZXNzIChzaW5jZSA0LjAp
LgorIyBAbWF4LWNvbm5lY3Rpb25zOiBUaGUgbWF4aW11bSBudW1iZXIgb2YgY29ubmVjdGlvbnMg
dG8gYWxsb3cgYXQgdGhlIHNhbWUKKyMgICAgICAgICAgICAgICAgICAgdGltZSwgMCBmb3IgdW5s
aW1pdGVkLiAoc2luY2UgNS4yOyBkZWZhdWx0OiAwKQorIworIyBSZXR1cm5zOiBlcnJvciBpZiB0
aGUgc2VydmVyIGlzIGFscmVhZHkgcnVubmluZy4KKyMKICMgU2luY2U6IDEuMy4wCiAjIwogeyAn
Y29tbWFuZCc6ICduYmQtc2VydmVyLXN0YXJ0JywKLS0gCjIuMjYuMgoK


