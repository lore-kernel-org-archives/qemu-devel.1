Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C75C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B78C20872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B78C20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD4Hp-0007uP-9v
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 06:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iD4GS-0006f5-HJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iD4GQ-0000VU-9l
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:11:15 -0400
Resent-Date: Wed, 25 Sep 2019 06:11:15 -0400
Resent-Message-Id: <E1iD4GQ-0000VU-9l@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iD4GQ-0000U9-1z; Wed, 25 Sep 2019 06:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569406194; cv=none; d=zoho.com; s=zohoarc; 
 b=IT3lZF+JW9M/99ky/JttLhleMs8ubJCaD92AqNhIpS+HQ666oaYqFWuFSRzohNMwK3DEpxWB/nuqeSiq2Z/H724FCmAjBTXbu7YYccvkiQlRPRSSSdS12AXs4azHxs/uTOk3VOqexD4SWSJtnv1Lhbr7bbv4rjLKvi/CAvUJZwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569406194;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=lrvd1o5KLFKNYpQNffSeSqk6F3jO5f23PqEygIFLiHM=; 
 b=oXyQCEZ+rrIpRcqalRc/jtQ9fihLwq3Ki2LeQBMCNF3wafUdKDxeag+Z4v2x5WxtZE3j8d9LWEZXKDdGZvhkNHzSLrQ87PZArT+ByiGTLjrTu7TiJATyVSHEgdiO6XWAB3BuxuJa+ZeuIB75HGwQ1/stxqGK49h+g3j9Bv+t/Qo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569406192060895.9371691912185;
 Wed, 25 Sep 2019 03:09:52 -0700 (PDT)
Subject: Re: [PATCH v3 00/25] error: auto propagated local_err
In-Reply-To: <20190924200902.4703-1-vsementsov@virtuozzo.com>
Message-ID: <156940618778.4823.16859844052516018660@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 25 Sep 2019 03:09:52 -0700 (PDT)
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
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, kraxel@redhat.com,
 mreitz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 arikalo@wavecomp.com, mst@redhat.com, armbru@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 farman@linux.ibm.com, ehabkost@redhat.com, groug@kaod.org,
 yuval.shaia@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 vsementsov@virtuozzo.com, david@redhat.com, jsnow@redhat.com,
 david@gibson.dropbear.id.au, kwolf@redhat.com, integration@gluster.org,
 berrange@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org,
 sundeep.lkml@gmail.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNDIwMDkwMi40NzAz
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA5MjQyMDA5MDIu
NDcwMy0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjMgMDAvMjVd
IGVycm9yOiBhdXRvIHByb3BhZ2F0ZWQgbG9jYWxfZXJyCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyODIxODI0IFBW
UkRNQTogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCjRmZWQ5YmQgbmJkOiBGaXggZXJyb3Jf
YXBwZW5kX2hpbnQgdXNhZ2UKNGRkNTkzYiBTb2NrZXRzOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQg
dXNhZ2UKNGI1MWU2MCBNaWdyYXRpb246IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZQo4YmFk
ZDFlIFFPTTogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCmNlZTEyZDcgY21kbGluZTogRml4
IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCjllZTAwMGQgY2hhcmRldjogRml4IGVycm9yX2FwcGVu
ZF9oaW50IHVzYWdlCjliODI3NjkgYmxvY2s6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZQoy
NjgwYTljIHZpcnRpby05cDogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCjk1NjNjYzAgdmly
dGlvOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQgdXNhZ2UKZWFmM2M1ZiBWRklPOiBGaXggZXJyb3Jf
YXBwZW5kX2hpbnQgdXNhZ2UKNWE3MGQxMiBVU0I6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2Fn
ZQphNzMwN2EyIFNDU0k6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZQozOGFiMjM2IFBDSTog
Rml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCjFlM2Y5OGUgU21hcnRGdXNpb24yOiBGaXggZXJy
b3JfYXBwZW5kX2hpbnQgdXNhZ2UKNGIwNmJjYyBhcm06IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1
c2FnZQoxZTE5NGI0IFBvd2VyUEMgVENHIENQVXM6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2Fn
ZQoxNmY3YmU4IEFSTSBUQ0cgQ1BVczogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCjM4YmFh
MGEgczM5MDogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCmU1OTZjNzIgcHl0aG9uOiBhZGQg
Y29tbWl0LXBlci1zdWJzeXN0ZW0ucHkKYzgyYjc1OCBzY3JpcHRzOiBhZGQgY29jY2luZWxsZSBz
Y3JpcHQgdG8gZml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlCjRjMzdkNWMgZXJyb3I6IGF1dG8g
cHJvcGFnYXRlZCBsb2NhbF9lcnIKMWY1ZDk4MyBuZXQvbmV0OiBmaXggbG9jYWwgdmFyaWFibGUg
c2hhZG93aW5nIGluIG5ldF9jbGllbnRfaW5pdAoxMThmNjE3IGh3L2NvcmUvbG9hZGVyLWZpdDog
Zml4IGZyZWVpbmcgZXJycCBpbiBmaXRfbG9hZF9mZHQKMjQ5MzA2OSBlcnJwOiByZW5hbWUgZXJy
cCB0byBlcnJwX2luIHdoZXJlIGl0IGlzIElOLWFyZ3VtZW50Cgo9PT0gT1VUUFVUIEJFR0lOID09
PQoxLzI1IENoZWNraW5nIGNvbW1pdCAyNDkzMDY5Yjc2MDMgKGVycnA6IHJlbmFtZSBlcnJwIHRv
IGVycnBfaW4gd2hlcmUgaXQgaXMgSU4tYXJndW1lbnQpCjIvMjUgQ2hlY2tpbmcgY29tbWl0IDEx
OGY2MTc4NzI3OSAoaHcvY29yZS9sb2FkZXItZml0OiBmaXggZnJlZWluZyBlcnJwIGluIGZpdF9s
b2FkX2ZkdCkKMy8yNSBDaGVja2luZyBjb21taXQgMWY1ZDk4MzI4ZDZjIChuZXQvbmV0OiBmaXgg
bG9jYWwgdmFyaWFibGUgc2hhZG93aW5nIGluIG5ldF9jbGllbnRfaW5pdCkKNC8yNSBDaGVja2lu
ZyBjb21taXQgNGMzN2Q1YzZkMjI4IChlcnJvcjogYXV0byBwcm9wYWdhdGVkIGxvY2FsX2VycikK
RVJST1I6IE1hY3JvcyB3aXRoIG11bHRpcGxlIHN0YXRlbWVudHMgc2hvdWxkIGJlIGVuY2xvc2Vk
IGluIGEgZG8gLSB3aGlsZSBsb29wCiM2OTogRklMRTogaW5jbHVkZS9xYXBpL2Vycm9yLmg6MzU1
OgorI2RlZmluZSBFUlJQX0ZVTkNUSU9OX0JFR0lOKCkgXAorZ19hdXRvKEVycm9yUHJvcGFnYXRv
cikgX19hdXRvX2VycnBfcHJvcCA9IHsuZXJycCA9IGVycnB9OyBcCitlcnJwID0gKChlcnJwID09
IE5VTEwgfHwgKmVycnAgPT0gZXJyb3JfZmF0YWwpID8gXAorICAgICZfX2F1dG9fZXJycF9wcm9w
LmxvY2FsX2VyciA6IGVycnApCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDQxIGxpbmVz
IGNoZWNrZWQKClBhdGNoIDQvMjUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvMjUgQ2hl
Y2tpbmcgY29tbWl0IGM4MmI3NThhZjFkYSAoc2NyaXB0czogYWRkIGNvY2NpbmVsbGUgc2NyaXB0
IHRvIGZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9y
IGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTU6IApu
ZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAyNSBsaW5l
cyBjaGVja2VkCgpQYXRjaCA1LzI1IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjYvMjUgQ2hl
Y2tpbmcgY29tbWl0IGU1OTZjNzIwMzkzYyAocHl0aG9uOiBhZGQgY29tbWl0LXBlci1zdWJzeXN0
ZW0ucHkpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJ
TlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzEzOiAKbmV3IGZpbGUgbW9kZSAxMDA3NTUKCnRvdGFs
OiAwIGVycm9ycywgMSB3YXJuaW5ncywgNjkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi8yNSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgo3LzI1IENoZWNraW5nIGNvbW1pdCAzOGJhYTBhMzE4YTAg
KHMzOTA6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZSkKOC8yNSBDaGVja2luZyBjb21taXQg
MTZmN2JlODZlZWIxIChBUk0gVENHIENQVXM6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZSkK
OS8yNSBDaGVja2luZyBjb21taXQgMWUxOTRiNDhlOTdiIChQb3dlclBDIFRDRyBDUFVzOiBGaXgg
ZXJyb3JfYXBwZW5kX2hpbnQgdXNhZ2UpCjEwLzI1IENoZWNraW5nIGNvbW1pdCA0YjA2YmNjZmU5
NDcgKGFybTogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlKQoxMS8yNSBDaGVja2luZyBjb21t
aXQgMWUzZjk4ZWIxMmQwIChTbWFydEZ1c2lvbjI6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2Fn
ZSkKMTIvMjUgQ2hlY2tpbmcgY29tbWl0IDM4YWIyMzY0ZjQ0YiAoUENJOiBGaXggZXJyb3JfYXBw
ZW5kX2hpbnQgdXNhZ2UpCjEzLzI1IENoZWNraW5nIGNvbW1pdCBhNzMwN2EyOTE1OWUgKFNDU0k6
IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZSkKMTQvMjUgQ2hlY2tpbmcgY29tbWl0IDVhNzBk
MTI3YzlmYyAoVVNCOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQgdXNhZ2UpCjE1LzI1IENoZWNraW5n
IGNvbW1pdCBlYWYzYzVmODU1YzggKFZGSU86IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZSkK
MTYvMjUgQ2hlY2tpbmcgY29tbWl0IDk1NjNjYzBiNmUzNyAodmlydGlvOiBGaXggZXJyb3JfYXBw
ZW5kX2hpbnQgdXNhZ2UpCjE3LzI1IENoZWNraW5nIGNvbW1pdCAyNjgwYTljYTg4ZmEgKHZpcnRp
by05cDogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlKQoxOC8yNSBDaGVja2luZyBjb21taXQg
OWI4Mjc2OTYxNTUwIChibG9jazogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlKQoxOS8yNSBD
aGVja2luZyBjb21taXQgOWVlMDAwZGEyNTA4IChjaGFyZGV2OiBGaXggZXJyb3JfYXBwZW5kX2hp
bnQgdXNhZ2UpCjIwLzI1IENoZWNraW5nIGNvbW1pdCBjZWUxMmQ3Yzg2OTcgKGNtZGxpbmU6IEZp
eCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZSkKMjEvMjUgQ2hlY2tpbmcgY29tbWl0IDhiYWRkMWVj
MDRkYSAoUU9NOiBGaXggZXJyb3JfYXBwZW5kX2hpbnQgdXNhZ2UpCjIyLzI1IENoZWNraW5nIGNv
bW1pdCA0YjUxZTYwYTFlODMgKE1pZ3JhdGlvbjogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdl
KQoyMy8yNSBDaGVja2luZyBjb21taXQgNGRkNTkzYjljN2RmIChTb2NrZXRzOiBGaXggZXJyb3Jf
YXBwZW5kX2hpbnQgdXNhZ2UpCjI0LzI1IENoZWNraW5nIGNvbW1pdCA0ZmVkOWJkODNhNzcgKG5i
ZDogRml4IGVycm9yX2FwcGVuZF9oaW50IHVzYWdlKQoyNS8yNSBDaGVja2luZyBjb21taXQgMjgy
MTgyNGQ5OGJmIChQVlJETUE6IEZpeCBlcnJvcl9hcHBlbmRfaGludCB1c2FnZSkKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MjQyMDA5MDIu
NDcwMy0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


