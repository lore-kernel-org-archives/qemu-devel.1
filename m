Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60412C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B8E23101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B8E23101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xnM-0005fP-Ea
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6xj0-0007Zn-1h
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:04:02 -0400
Resent-Date: Sat, 15 Aug 2020 11:04:02 -0400
Resent-Message-Id: <E1k6xj0-0007Zn-1h@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6xix-0006kl-Ah
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597503823; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WABeNNztFdJEK9P/l3B+7PAs6gz09ZF/BB8oFzLqj7Ia9L9BO5cros4lwzrqkdQczjzXWK64yPFbWhX4FJ9+xASP0CVSGGs9q4yVjiLpWInjsCsmQTAb8c8nRU5kfUIci7xR52jvjhOFEVSF6fsg9i4eokmQlZXog1hoSadRZ9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597503823;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Xb5G8OluQ+eo3yP3hmMtLLK8nYR2f0NjHEc3vKNU9jg=; 
 b=Mb7SpYMgEyPfBjtczI/bfKgHDY7AAAt9ubTtM3xCgQTTa0Ta/mvgzMOzxxlo/y9qcgax5lH0MbY1zynxjc+S2DjqWaCLSOgEc+lkDptS8F1Qc7PDUawpv22ma8YbzFVzUYHRWsRWEKqGMf/1so36wsbOYA26MuWPWQmarlNu9AY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597503819461550.3223398469286;
 Sat, 15 Aug 2020 08:03:39 -0700 (PDT)
Subject: Re: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
Message-ID: <159750381841.7155.8719372713269184992@66eaa9a8a123>
In-Reply-To: <20200815130046.5344-1-rohit.shinde12194@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rohit.shinde12194@gmail.com
Date: Sat, 15 Aug 2020 08:03:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 11:03:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, rohit.shinde12194@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNTEzMDA0Ni41MzQ0
LTEtcm9oaXQuc2hpbmRlMTIxOTRAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA4MTUxMzAw
NDYuNTM0NC0xLXJvaGl0LnNoaW5kZTEyMTk0QGdtYWlsLmNvbQpTdWJqZWN0OiBbUEFUQ0hdIEZp
eGVzOiBGYWxsdGhyb3VnaCB3YXJuaW5nIG9uIGxpbmUgMjcwIG9mIHFlbXUvcWFwaS9vcHRzLXZp
c2l0b3IuYwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMjAyMDA4MTUxMzAwNDYuNTM0NC0xLXJvaGl0LnNoaW5kZTEyMTk0QGdtYWlsLmNvbSAt
PiBwYXRjaGV3LzIwMjAwODE1MTMwMDQ2LjUzNDQtMS1yb2hpdC5zaGluZGUxMjE5NEBnbWFpbC5j
b20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplZTEzYWQwIEZpeGVzOiBGYWxsdGhy
b3VnaCB3YXJuaW5nIG9uIGxpbmUgMjcwIG9mIHFlbXUvcWFwaS9vcHRzLXZpc2l0b3IuYwoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA3IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBlZTEz
YWQwM2E5ODEgKEZpeGVzOiBGYWxsdGhyb3VnaCB3YXJuaW5nIG9uIGxpbmUgMjcwIG9mIHFlbXUv
cWFwaS9vcHRzLXZpc2l0b3IuYykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTUxMzAwNDYu
NTM0NC0xLXJvaGl0LnNoaW5kZTEyMTk0QGdtYWlsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=

