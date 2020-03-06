Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81916C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E802084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E802084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAEBT-0000TF-FL
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jAEAt-0008ME-Ka
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jAEAs-00004s-5O
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:42:03 -0500
Resent-Date: Fri, 06 Mar 2020 09:42:03 -0500
Resent-Message-Id: <E1jAEAs-00004s-5O@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jAEAr-0008R8-Tx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:42:02 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583505713; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g0HrhG2LcLVDetJf/qss5oDeR1CxRarTihoXbWrZlreDsXZmg2ZFNojowG93mBXLRBXbUyg9avpMLpygn+vHfnazqNWm7U2BuvTkA1JoYg9D1IpQKJAnJsPLpOPkQh1U7EGmIfQpX7WxZQKWdtqma3SusCa9vxpwyQJR+UDSvC4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583505713;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=tf8ScGqSMNyLTy9M7zkhroZUSaSNoh3Otk7Yu3/wrQc=; 
 b=JsrvHh3sTGYGx200OsNiQfbQEx1Ke/YdvOReUtJD8pWSDbi+F1WCTfkWZMyifdi9Izs70afh05OEydMy95ipyHkt/4l5E5rHXi+75XE6z1Y3fghRmR2VCSna16OwZGpb2145em3Yp+0i4dbcYlI1m1lSCpWqTyvG6SC+CsTocCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583505710707674.502098843719;
 Fri, 6 Mar 2020 06:41:50 -0800 (PST)
In-Reply-To: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
Message-ID: <158350570928.14529.1394498842582357817@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: christian.ehrhardt@canonical.com
Date: Fri, 6 Mar 2020 06:41:50 -0800 (PST)
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 christian.ehrhardt@canonical.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwNjEzMjY0OC4yNzU3
Ny0xLWNocmlzdGlhbi5laHJoYXJkdEBjYW5vbmljYWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0
Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXIt
dGVzdC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CkZpbGU6ICIvdG1wL3FlbXUtbnNpc1xxZW11LWRvYy5odG1sIiAtPiBubyBmaWxlcyBmb3VuZC4K
VXNhZ2U6IEZpbGUgWy9ub25mYXRhbF0gWy9hXSAoWy9yXSBbL3ggZmlsZXNwZWMgWy4uLl1dIGZp
bGVzcGVjIFsuLi5dIHwKICAgL29uYW1lPW91dGZpbGUgb25lX2ZpbGVfb25seSkKRXJyb3IgaW4g
c2NyaXB0ICIvdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS5uc2kiIG9uIGxpbmUgMTgwIC0tIGFib3J0
aW5nIGNyZWF0aW9uIHByb2Nlc3MKbWFrZTogKioqIFtNYWtlZmlsZToxMTYyOiBxZW11LXNldHVw
LTQuMi41MC5leGVdIEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgog
IEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgog
ICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9ZDc4YWUxYmY5NDAyNGY3YzhhMDI1NWViMGQ2M2M4ZjEnLCAnLXUnLCAnMTAwMycsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1k
b2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC16Ymc4MnhyYi9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTA2LTA5LjM4LjQxLjE4
NTI6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZDc4YWUxYmY5NDAyNGY3Yzhh
MDI1NWViMGQ2M2M4ZjEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtemJnODJ4cmIv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJl
YWwgICAgM204LjcxMXMKdXNlciAgICAwbTcuOTY5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMDYxMzI2NDguMjc1NzctMS1jaHJp
c3RpYW4uZWhyaGFyZHRAY2Fub25pY2FsLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

