Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD1C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032A0221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032A0221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWyx-0004JH-1O
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLWwr-0002z1-Mq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:30:33 -0400
Resent-Date: Thu, 24 Sep 2020 15:30:33 -0400
Resent-Message-Id: <E1kLWwr-0002z1-Mq@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLWwn-0006t0-PN
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600975807; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EVXRFdyUzAALGaanLDz08r/CkIVfQpesCjoRTqThSooULMu+IcKdwubmvE4aP0hugKvZk/Ndj2cck1wMb2Jii6Fzf9dApMzcw8SJq5gRCWzvqR7hqOohLhD2ODfuxaEkHVw0v2fOaokhJFr/MlWws7JeKspywFhpWj/JmwJ3JH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600975807;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HzmLDHgt/Ax2ZVCJDTa6AVcE3ebWylt33Zxep0mDXE0=; 
 b=JIql0Ez3Z+Yqwev9mtI6m+oCEydVl97Mlwq7LYX1yqVcsD9M/Zq+prMYznn7JeodQUy/88EwVa/vGSDDU5L1Em1/LGZ828lwnnS+GYp8Ih/A3inW4NHQZMgTJCZci3w4PH/dbAK6JiDG6YnXh5Dn+2KFXlalUsqJB6igJz295B8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600975806702713.6866143595105;
 Thu, 24 Sep 2020 12:30:06 -0700 (PDT)
Subject: Re: [PATCH PROTOTYPE 0/6] virtio-mem: vfio support
Message-ID: <160097580453.12744.16397145594883288661@66eaa9a8a123>
In-Reply-To: <20200924160423.106747-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@redhat.com
Date: Thu, 24 Sep 2020 12:30:06 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:30:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: pankaj.gupta.linux@gmail.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com,
 eric.auger@redhat.com, alex.williamson@redhat.com,
 richardw.yang@linux.intel.com, imammedo@redhat.com, pbonzini@redhat.com,
 lcapitulino@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNDE2MDQyMy4xMDY3
NDctMS1kYXZpZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA5MjQxNjA0MjMuMTA2NzQ3
LTEtZGF2aWRAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggUFJPVE9UWVBFIDAvNl0gdmlydGlv
LW1lbTogdmZpbyBzdXBwb3J0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAg
ICBwYXRjaGV3LzIwMjAwOTIyMjEwMTAxLjQwODEwNzMtMS1qc25vd0ByZWRoYXQuY29tIC0+IHBh
dGNoZXcvMjAyMDA5MjIyMTAxMDEuNDA4MTA3My0xLWpzbm93QHJlZGhhdC5jb20KIC0gW3RhZyB1
cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDkyNDE4NTQxNC4yODY0Mi0xLXZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbSAtPiBwYXRjaGV3LzIwMjAwOTI0MTg1NDE0LjI4NjQyLTEtdnNlbWVudHNvdkB2
aXJ0dW96em8uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOGFmZDFkZiB2Zmlv
OiBEaXNhYmxlIG9ubHkgUkFNX0JMT0NLX0RJU0NBUkRfVF9VTkNPT1JESU5BVEVEIGRpc2NhcmRz
CmQ2NzZiMzIgdmlydGlvLW1lbTogUmVxdWlyZSBvbmx5IFJBTV9CTE9DS19ESVNDQVJEX1RfQ09P
UkRJTkFURUQgZGlzY2FyZHMKOTQ5MmY2NyBtZW1vcnk6IEV4dGVuZCByYW1fYmxvY2tfZGlzY2Fy
ZF8ocmVxdWlyZXxkaXNhYmxlKSBieSB0d28gZGlzY2FyZCB0eXBlcwo5ZWVlYzY5IHZmaW86IElt
cGxlbWVudCBzdXBwb3J0IGZvciBzcGFyc2UgUkFNIG1lbW9yeSByZWdpb25zCjNlMjFkM2Ygdmly
dGlvLW1lbTogSW1wZWxlbWVudCBTcGFyc2VSQU1IYW5kbGVyIGludGVyZmFjZQoyY2ZjNDE3IG1l
bW9yeTogSW50cm9kdWNlIHNwYXJzZSBSQU0gaGFuZGxlciBmb3IgbWVtb3J5IHJlZ2lvbnMKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvNiBDaGVja2luZyBjb21taXQgMmNmYzQxNzZmYmY1IChtZW1v
cnk6IEludHJvZHVjZSBzcGFyc2UgUkFNIGhhbmRsZXIgZm9yIG1lbW9yeSByZWdpb25zKQpFUlJP
UjogImZvbyogYmFyIiBzaG91bGQgYmUgImZvbyAqYmFyIgojMTQ5OiBGSUxFOiBpbmNsdWRlL2V4
ZWMvbWVtb3J5Lmg6MTk1MjoKK3N0YXRpYyBpbmxpbmUgU3BhcnNlUkFNSGFuZGxlciogbWVtb3J5
X3JlZ2lvbl9nZXRfc3BhcnNlX3JhbV9oYW5kbGVyKAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5p
bmdzLCAxNjIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgoyLzYgQ2hlY2tpbmcgY29tbWl0IDNlMjFkM2Y1OTI0NCAodmlydGlvLW1lbTogSW1wZWxl
bWVudCBTcGFyc2VSQU1IYW5kbGVyIGludGVyZmFjZSkKMy82IENoZWNraW5nIGNvbW1pdCA5ZWVl
YzY5MDMxYjAgKHZmaW86IEltcGxlbWVudCBzdXBwb3J0IGZvciBzcGFyc2UgUkFNIG1lbW9yeSBy
ZWdpb25zKQo0LzYgQ2hlY2tpbmcgY29tbWl0IDk0OTJmNjcxNTUxMiAobWVtb3J5OiBFeHRlbmQg
cmFtX2Jsb2NrX2Rpc2NhcmRfKHJlcXVpcmV8ZGlzYWJsZSkgYnkgdHdvIGRpc2NhcmQgdHlwZXMp
CjUvNiBDaGVja2luZyBjb21taXQgZDY3NmIzMjMzNmI1ICh2aXJ0aW8tbWVtOiBSZXF1aXJlIG9u
bHkgUkFNX0JMT0NLX0RJU0NBUkRfVF9DT09SRElOQVRFRCBkaXNjYXJkcykKNi82IENoZWNraW5n
IGNvbW1pdCA4YWZkMWRmMjdiOTkgKHZmaW86IERpc2FibGUgb25seSBSQU1fQkxPQ0tfRElTQ0FS
RF9UX1VOQ09PUkRJTkFURUQgZGlzY2FyZHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTI0MTYwNDIzLjEwNjc0Ny0xLWRhdmlkQHJlZGhh
dC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

