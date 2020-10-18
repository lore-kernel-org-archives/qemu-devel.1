Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233DAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 05:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF02A20829
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 05:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF02A20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU1U3-0005PC-Ks
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 01:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kU1TF-0004uh-IN; Sun, 18 Oct 2020 01:43:06 -0400
Resent-Date: Sun, 18 Oct 2020 01:43:05 -0400
Resent-Message-Id: <E1kU1TF-0004uh-IN@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kU1TD-0006Qc-32; Sun, 18 Oct 2020 01:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602999766; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cbSQDbPd1SyKVtLd9rFgBi543Da/YWQYSIEW6+3k1sdwBqGMmxU/Ya7TzrXbyq8Ghpwk3U5OfpnMZuDTg7qGvSLjX2W4O2Bsyp3sEu69gWe6Nl5u/v51nApB5+BJzHG0u2JoTup0jwEmYAUN/wILBwPs0xu2PtXaztDZp21TDTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602999766;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zkMqd2PoGsRETKfrObokfyzGKfE/Ipqr5yjk2Bz5JkE=; 
 b=QE+UEtDbUjTvmfkMhScitI2fE8KK/0sT6CMvmOC2xAnxMpPnNho8iHeLZJEXDhj6ENTO3ySifxjmIA2jp+wRzharKF0mwXl8Hb4mV/nHLBswzetc3SE8+CYmardsqMp9RdirToaiD3j5lwxGqdSW65MTB0csMo+4vTivDULtsgI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602999764107697.9273458087587;
 Sat, 17 Oct 2020 22:42:44 -0700 (PDT)
Subject: Re: [PATCH] qemu-img: add support for rate limit in qemu-img convert
Message-ID: <160299976266.17996.16077375266149312335@66eaa9a8a123>
In-Reply-To: <1602999390-21324-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Sat, 17 Oct 2020 22:42:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 01:36:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, xieyingtai@huawei.com, lizhengui@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAyOTk5MzkwLTIxMzI0LTEt
Z2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNjAyOTk5
MzkwLTIxMzI0LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20KU3ViamVjdDog
W1BBVENIXSBxZW11LWltZzogYWRkIHN1cHBvcnQgZm9yIHJhdGUgbGltaXQgaW4gcWVtdS1pbWcg
Y29udmVydAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1
Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8x
NjAyOTk5MzkwLTIxMzI0LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20gLT4g
cGF0Y2hldy8xNjAyOTk5MzkwLTIxMzI0LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdl
aS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpjMzk2NzJjIHFlbXUtaW1nOiBh
ZGQgc3VwcG9ydCBmb3IgcmF0ZSBsaW1pdCBpbiBxZW11LWltZyBjb252ZXJ0Cgo9PT0gT1VUUFVU
IEJFR0lOID09PQpFUlJPUjogY29uc2lkZXIgdXNpbmcgcWVtdV9zdHJ0b3VsbCBpbiBwcmVmZXJl
bmNlIHRvIHN0cnRvdWxsCiM5NDogRklMRTogcWVtdS1pbWcuYzoyMzM2OgorICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBsb25nIHN2YWwgPSBzdHJ0b3VsbChvcHRhcmcsICZlbmQsIDEwKTsKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOTQgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGMzOTY3
MmMyM2U1ZCAocWVtdS1pbWc6IGFkZCBzdXBwb3J0IGZvciByYXRlIGxpbWl0IGluIHFlbXUtaW1n
IGNvbnZlcnQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE2MDI5OTkzOTAtMjEzMjQtMS1naXQtc2Vu
ZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

