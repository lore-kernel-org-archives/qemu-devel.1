Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B5FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962EC2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962EC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcN9-00014H-7s
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNbLG-0002Cd-C8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNbLE-0001Fo-2N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:31:45 -0400
Resent-Date: Thu, 24 Oct 2019 07:31:45 -0400
Resent-Message-Id: <E1iNbLE-0001Fo-2N@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNbLD-0001FR-OH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571916688; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QUNsxA7DdW2QHOjkykfrpPsddFl1lyn8+zCtBfBLKNa8QuKlpaz9GwOeThVLClnAUfy1cjnbNjGYs5QfIfih/MHpk1mEA4tfNO6D1TWJBbozjcaodik8NuwbzqaQB+WHBRx+Xvhz7P+nJ+2UEe7FCw4wFJm3oX3Vyv4ah5KVh2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571916688;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=o4Mz8YSpkLl5XG00gpjjvxu1Ufd+uVjqQ9Lj1AKkmjk=; 
 b=Zrsq+jPvURhNTSW3Bsb2wbQgqhg2I/zVCq0TcWz+1DQ9+trhCfbRE8u9lWWsUzLsJ973vqJ8iXFtS+ZTyKFvQmWcW9cQLK75il/F8DbW3EuniI0TYEdma73YD7zVTzRML8xcpRdBP7QCI1x0Z1vxTUeSXpF/f1+wro+sq/SWXYA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571916684186864.0019471948476;
 Thu, 24 Oct 2019 04:31:24 -0700 (PDT)
In-Reply-To: <1571824420-24893-1-git-send-email-xiajidong@cmss.chinamobile.com>
Subject: Re: [PATCH] hw/audio: fix a memory leak in OPLCreate()
Message-ID: <157191668273.6043.7806241572219217020@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: xiajidong@cmss.chinamobile.com
Date: Thu, 24 Oct 2019 04:31:24 -0700 (PDT)
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
Cc: xiajidong@cmss.chinamobile.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxODI0NDIwLTI0ODkzLTEt
Z2l0LXNlbmQtZW1haWwteGlhamlkb25nQGNtc3MuY2hpbmFtb2JpbGUuY29tLwoKCgpIaSwKClRo
aXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBv
dXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIGh3L2F1
ZGlvOiBmaXggYSBtZW1vcnkgbGVhayBpbiBPUExDcmVhdGUoKQpUeXBlOiBzZXJpZXMKTWVzc2Fn
ZS1pZDogMTU3MTgyNDQyMC0yNDg5My0xLWdpdC1zZW5kLWVtYWlsLXhpYWppZG9uZ0BjbXNzLmNo
aW5hbW9iaWxlLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczov
L2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0
Y2hldy8yMDE5MTAyMzEwMTk1Ni4xOTEyMC0xLWtyYXhlbEByZWRoYXQuY29tIC0+IHBhdGNoZXcv
MjAxOTEwMjMxMDE5NTYuMTkxMjAtMS1rcmF4ZWxAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAg
ICAgICBwYXRjaGV3LzIwMTkxMDI0MDc0MzA3LjIyODIxLTEtZ2FuZXNoZ3JAbGludXguaWJtLmNv
bSAtPiBwYXRjaGV3LzIwMTkxMDI0MDc0MzA3LjIyODIxLTEtZ2FuZXNoZ3JAbGludXguaWJtLmNv
bQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjhmMDE1NTUgaHcvYXVkaW86IGZpeCBh
IG1lbW9yeSBsZWFrIGluIE9QTENyZWF0ZSgpCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjog
Y29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMyMTogRklMRTogaHcvYXVkaW8vZm1v
cGwuYzoxMTE1OgorXklmcmVlKHB0cik7JAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA3
IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA4ZjAxNTU1YzdiYmEgKGh3L2F1ZGlvOiBmaXggYSBtZW1v
cnkgbGVhayBpbiBPUExDcmVhdGUoKSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3MTgyNDQyMC0y
NDg5My0xLWdpdC1zZW5kLWVtYWlsLXhpYWppZG9uZ0BjbXNzLmNoaW5hbW9iaWxlLmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


