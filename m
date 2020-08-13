Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45039C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B709206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B709206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AYH-0001eZ-US
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6AX6-0008RM-A9; Thu, 13 Aug 2020 06:32:28 -0400
Resent-Date: Thu, 13 Aug 2020 06:32:28 -0400
Resent-Message-Id: <E1k6AX6-0008RM-A9@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6AX3-0006o9-5R; Thu, 13 Aug 2020 06:32:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597314689; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jLN3zi8M+Ku50kwPLms9jwLhQtdyER6bsMurq9/thmse9s9532BO+X2rH0vejaBpxNrd/jso/YEo7TzkRvkJq0m6WkSewOHjRpQ/K21yjSoTsmOkYYCuHNHilIsNKNqUDbvXDQ2Ym/it+Zc7zEoLNk8svxnnh5L7VaCKGe1VVec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597314689;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=uCFSmA9YXN3XC9TerVKBDpwk6HXqxk26+iluOIYB3KQ=; 
 b=Kx8xx6s59XT9JF6931H25THwt9J4lmcl3rbFvYR+pVKwAgG4jWps/YhGWswHnK5rZ+VV2w8VG1Zvf8YuohNXvv3PUaHI2GhJ8skfkwRJj8Jhf629VRO61YW2Vu+ZwGbSmTBMfSGcBAoM9+lNdByTFWS7esYlU48t1Yo+WUshkSA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597314683703715.8650426971684;
 Thu, 13 Aug 2020 03:31:23 -0700 (PDT)
Subject: Re: [PULL 0/9] Tracing patches
Message-ID: <159731468176.15736.6746841650533502356@66eaa9a8a123>
In-Reply-To: <20200813052257.226142-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Thu, 13 Aug 2020 03:31:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:32:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, lizhijian@cn.fujitsu.com, mst@redhat.com,
 jasowang@redhat.com, qemu-devel@nongnu.org, Alistair.Francis@wdc.com,
 kraxel@redhat.com, sagark@eecs.berkeley.edu, qemu-block@nongnu.org,
 quintela@redhat.com, david@redhat.com, aleksandar.qemu.devel@gmail.com,
 marcandre.lureau@redhat.com, aleksandar.rikalo@syrmia.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, stefanha@redhat.com, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au, kwolf@redhat.com, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, mreitz@redhat.com, chen.zhang@intel.com,
 palmer@dabbelt.com, pbonzini@redhat.com, aurelien@aurel32.net,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMzA1MjI1Ny4yMjYx
NDItMS1zdGVmYW5oYUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA4MTMwNTIyNTcuMjI2
MTQyLTEtc3RlZmFuaGFAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUFVMTCAwLzldIFRyYWNpbmcgcGF0
Y2hlcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwphYjFlMGUwIHRyYWNlLWV2ZW50czogRml4IGF0dHJpYnV0aW9uIG9mIHRyYWNl
IHBvaW50cyB0byBzb3VyY2UKYjRlNmM5NCB0cmFjZS1ldmVudHM6IERlbGV0ZSB1bnVzZWQgdHJh
Y2UgcG9pbnRzCjk2N2IxMDAgc2NyaXB0cy9jbGVhbnVwLXRyYWNlLWV2ZW50czogRW1pdCBmaWxl
cyBpbiBhbHBoYWJldGljYWwgb3JkZXIKYTNiNTQ4MyBzY3JpcHRzL2NsZWFudXAtdHJhY2UtZXZl
bnRzOiBGaXggZm9yIHZjcHUgcHJvcGVydHkKYzg0NmJmNyBzb2Z0bW11OiBBZGQgbWlzc2luZyB0
cmFjZS1ldmVudHMgZmlsZQo2M2Q1OTgyIG5ldC9jb2xvOiBNYXRjaCBpcy1lbmFibGVkIHByb2Jl
IHRvIHRyYWNlcG9pbnQKNzVlYWI0MiBidWlsZDogRG9uJ3QgbWFrZSBvYmplY3QgZmlsZXMgZm9y
IGR0cmFjZSBvbiBtYWNPUwoyOGIyOTUxIHNjcmlwdHMvdHJhY2V0b29sOiBVc2Ugdm9pZCBwb2lu
dGVyIGZvciB2Y3B1CmRjNDRmOWYgc2NyaXB0cy90cmFjZXRvb2w6IEZpeCBkdHJhY2UgZ2VuZXJh
dGlvbiBmb3IgbWFjT1MKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOSBDaGVja2luZyBjb21taXQg
ZGM0NGY5ZjM5NWZmIChzY3JpcHRzL3RyYWNldG9vbDogRml4IGR0cmFjZSBnZW5lcmF0aW9uIGZv
ciBtYWNPUykKMi85IENoZWNraW5nIGNvbW1pdCAyOGIyOTUxNTU1Y2QgKHNjcmlwdHMvdHJhY2V0
b29sOiBVc2Ugdm9pZCBwb2ludGVyIGZvciB2Y3B1KQozLzkgQ2hlY2tpbmcgY29tbWl0IDc1ZWFi
NDJkZTE4YyAoYnVpbGQ6IERvbid0IG1ha2Ugb2JqZWN0IGZpbGVzIGZvciBkdHJhY2Ugb24gbWFj
T1MpCjQvOSBDaGVja2luZyBjb21taXQgNjNkNTk4MjEzMDU4IChuZXQvY29sbzogTWF0Y2ggaXMt
ZW5hYmxlZCBwcm9iZSB0byB0cmFjZXBvaW50KQo1LzkgQ2hlY2tpbmcgY29tbWl0IGM4NDZiZjdh
ZmVmNCAoc29mdG1tdTogQWRkIG1pc3NpbmcgdHJhY2UtZXZlbnRzIGZpbGUpCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzc2OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJu
aW5ncywgMTExIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgo2LzkgQ2hlY2tpbmcgY29tbWl0IGEzYjU0ODNkNDI4MyAoc2NyaXB0cy9jbGVhbnVwLXRy
YWNlLWV2ZW50czogRml4IGZvciB2Y3B1IHByb3BlcnR5KQpFUlJPUjogY29kZSBpbmRlbnQgc2hv
dWxkIG5ldmVyIHVzZSB0YWJzCiMzMzogRklMRTogc2NyaXB0cy9jbGVhbnVwLXRyYWNlLWV2ZW50
cy5wbDozODoKK15JICAgIGRlZmluZWQgJDMgPyAoKSA6ICgnLS1tYXgtZGVwdGgnLCAnMScpLCQK
CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzM0OiBGSUxFOiBzY3Jp
cHRzL2NsZWFudXAtdHJhY2UtZXZlbnRzLnBsOjM5OgorXkkgICAgJHBhdCQKCnRvdGFsOiAyIGVy
cm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi85IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo3LzkgQ2hlY2tpbmcgY29tbWl0IDk2N2IxMDBmODUyMCAoc2NyaXB0
cy9jbGVhbnVwLXRyYWNlLWV2ZW50czogRW1pdCBmaWxlcyBpbiBhbHBoYWJldGljYWwgb3JkZXIp
CjgvOSBDaGVja2luZyBjb21taXQgYjRlNmM5NGRhZDY0ICh0cmFjZS1ldmVudHM6IERlbGV0ZSB1
bnVzZWQgdHJhY2UgcG9pbnRzKQo5LzkgQ2hlY2tpbmcgY29tbWl0IGFiMWUwZTBmZjQzZCAodHJh
Y2UtZXZlbnRzOiBGaXggYXR0cmlidXRpb24gb2YgdHJhY2UgcG9pbnRzIHRvIHNvdXJjZSkKPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTMw
NTIyNTcuMjI2MTQyLTEtc3RlZmFuaGFAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=

