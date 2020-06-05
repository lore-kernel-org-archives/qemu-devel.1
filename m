Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B11C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC2D206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC2D206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhJH7-0001pz-2Y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 16:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhJFX-0001LJ-5X
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:47:35 -0400
Resent-Date: Fri, 05 Jun 2020 16:47:35 -0400
Resent-Message-Id: <E1jhJFX-0001LJ-5X@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhJFV-00065J-HP
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591390040; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XOG4jN9Rzn/Z13lipTi1fga/CGA9PdP1zkjMzxy2qNFVE5y7lUOrArL0cOKdJDmkOMQYkL5xB4hrRMHHyn7Ujf7IFhcxazPXBd703ROuMFZjpklNXU03F36y+ZIBidglmKHdhk+PkRKnMBVDm5ozi6ABPx8h83T0vaf95rlLBvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591390040;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Fa0eOR7VCl0NYpB3MRLEsEpCchzNGNylRAiCKFPjVNs=; 
 b=XSu+p/olD4oSdcGe57gSV3jYR7MnzOA9lH3XGcNpSzdRwIO26rqDazKTZ0Zz6L92TgTf1xVXDyuFR5k11km9Hpgs27Tmg6zCbRNAXey0KGmd67eZfvNfx1LJlqtnrXqFsV3AmtqRHMRGSLUvJdudRldJlnVCtD+A45qqGOpG8YY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591390038907605.0421016438585;
 Fri, 5 Jun 2020 13:47:18 -0700 (PDT)
Message-ID: <159139003739.19958.12789875905391177536@45ef0f9c86ae>
In-Reply-To: <20200605174036.4527-1-alxndr@bu.edu>
Subject: Re: [PATCH] fuzz: add oss-fuzz build.sh script
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Fri, 5 Jun 2020 13:47:18 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 16:47:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNTE3NDAzNi40NTI3
LTEtYWx4bmRyQGJ1LmVkdS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUg
Y29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0
aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDUxNzQwMzYuNDUyNy0xLWFseG5kckBidS5lZHUKU3Vi
amVjdDogW1BBVENIXSBmdXp6OiBhZGQgb3NzLWZ1enogYnVpbGQuc2ggc2NyaXB0ClR5cGU6IHNl
cmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNo
ZXcvMjAyMDA2MDUxNzQwMzYuNDUyNy0xLWFseG5kckBidS5lZHUgLT4gcGF0Y2hldy8yMDIwMDYw
NTE3NDAzNi40NTI3LTEtYWx4bmRyQGJ1LmVkdQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjgxMDlhODYgZnV6ejogYWRkIG9zcy1mdXp6IGJ1aWxkLnNoIHNjcmlwdAoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTY6IApuZXcgZmlsZSBtb2RlIDEwMDc1NQoK
RVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzQ4OiBGSUxFOiBzY3JpcHRzL29zcy1mdXp6L2J1
aWxkLnNoOjI4OgorZm9yIGkgaW4gJChsZGQgLi9pMzg2LXNvZnRtbXUvcWVtdS1mdXp6LWkzODYg
IHwgY3V0IC1mMyAtZCcgJyk7IGRvICQKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgNDcg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IDgxMDlhODYyN2Q2OCAoZnV6ejogYWRkIG9zcy1mdXp6IGJ1
aWxkLnNoIHNjcmlwdCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MDUxNzQwMzYuNDUyNy0x
LWFseG5kckBidS5lZHUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

