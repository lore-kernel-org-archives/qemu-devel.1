Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A088C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5145F20657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5145F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTqo-0002m7-7a
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 14:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hfToy-00025b-QD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 14:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hfTox-0002eA-Fx
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 14:36:04 -0400
Resent-Date: Mon, 24 Jun 2019 14:36:04 -0400
Resent-Message-Id: <E1hfTox-0002eA-Fx@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hfTou-0002aT-Gu; Mon, 24 Jun 2019 14:36:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561401335; cv=none; d=zoho.com; s=zohoarc; 
 b=HZ3wq/DBwtsuwo2x2i+iYq86VrnrQNjoCTENbR8nkbmz435bORM4LLfIjfKDm9OsgpOD60x20t0GkNE4pdrknd1d6I/ESAZTbxBwx8fx8Nd2MQhbfvR7u8PZcPdMxPH6tr5StrQdadywXFO0EmSUwaSNMXjMjdKJx08Je3zBGq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561401335;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=gdW1+zA7U9nQbKoEF1GLVSCxvDA9hAJgi1fiKLQH+yY=; 
 b=fC4UZVOVFhGdu8BOmbnbbXmnmjrx5tkXk4tI2NjC7CjniIme8OQn2dQTiqLHHRF9BGOgWQdD8m8kvn1UUXlmGP5NgkrFbEk4zEEEzmrSo7AQPsAneowd5W8lnNapYNvYD1BvSIb8AHaQ5+kJVVO5dSv1b5x+3JJ/H+nUSeRUIDA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561401333485467.54896003538715;
 Mon, 24 Jun 2019 11:35:33 -0700 (PDT)
Message-ID: <156140133234.24.13306518272551026541@c4a48874b076>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Mon, 24 Jun 2019 11:35:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed
 json:{} filenames
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
Cc: kwolf@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNDE3MzkzNS4yNTc0
Ny0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDYyNDE3MzkzNS4yNTc0Ny0xLW1yZWl0ekByZWRo
YXQuY29tClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0IDAwLzE0
XSBibG9jazogVHJ5IHRvIGNyZWF0ZSB3ZWxsLXR5cGVkIGpzb246e30gZmlsZW5hbWVzCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0JwpkZGQ2NjlhIGJsb2NrOiBNYWtlIHVzZSBvZiBRQVBJIGRlZmF1bHRzCjNiY2Y5MjIg
aW90ZXN0czogcWNvdzIncyBlbmNyeXB0LmZvcm1hdCBpcyBub3cgb3B0aW9uYWwKMTU1YzFkYiBp
b3Rlc3RzOiBUZXN0IGludGVybmFsIG9wdGlvbiB0eXBpbmcKMzY0ZWFjMSBibG9jazogVHJ5IHRv
IGNyZWF0ZSB3ZWxsIHR5cGVkIGpzb246e30gZmlsZW5hbWVzCjExNzI2ZDIgcWFwaTogRm9ybWFs
aXplIHFjb3cgZW5jcnlwdGlvbiBwcm9iaW5nCjU2NzY0NGYgcWFwaTogRm9ybWFsaXplIHFjb3cy
IGVuY3J5cHRpb24gcHJvYmluZwo0ZWIzY2E0IHRlc3RzOiBBZGQgUUFQSSBvcHRpb25hbCBkaXNj
cmltaW5hdG9yIHRlc3RzCmYzZDlmNTMgdGVzdHM6IFRlc3QgUUFQSSBkZWZhdWx0IHZhbHVlcyBm
b3Igc3RydWN0IG1lbWJlcnMKMjg2MjgyNCB0ZXN0LXFhcGk6IFByaW50IHN0cnVjdCBtZW1iZXJz
JyBkZWZhdWx0IHZhbHVlcwpmZjdhN2M1IHFhcGk6IERvY3VtZW50IGRlZmF1bHQgdmFsdWVzIGZv
ciBzdHJ1Y3QgbWVtYmVycwpmYWVmMzdmIHFhcGk6IEFsbG93IG9wdGlvbmFsIGRpc2NyaW1pbmF0
b3JzCjY0YWU3M2MgcWFwaTogSW50cm9kdWNlIGRlZmF1bHQgdmFsdWVzIGZvciBzdHJ1Y3QgbWVt
YmVycwpmNDg1OTUwIHFhcGk6IE1vdmUgdG9fY19zdHJpbmcoKSB0byBjb21tb24ucHkKODcxMWJi
NCBxYXBpOiBQYXJzZSBudW1lcmljIHZhbHVlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNCBD
aGVja2luZyBjb21taXQgODcxMWJiNGMzMGYzIChxYXBpOiBQYXJzZSBudW1lcmljIHZhbHVlcykK
Mi8xNCBDaGVja2luZyBjb21taXQgZjQ4NTk1MGM0NTk1IChxYXBpOiBNb3ZlIHRvX2Nfc3RyaW5n
KCkgdG8gY29tbW9uLnB5KQozLzE0IENoZWNraW5nIGNvbW1pdCA2NGFlNzNjZmVkZDYgKHFhcGk6
IEludHJvZHVjZSBkZWZhdWx0IHZhbHVlcyBmb3Igc3RydWN0IG1lbWJlcnMpCjQvMTQgQ2hlY2tp
bmcgY29tbWl0IGZhZWYzN2Y2Y2Q0NSAocWFwaTogQWxsb3cgb3B0aW9uYWwgZGlzY3JpbWluYXRv
cnMpCjUvMTQgQ2hlY2tpbmcgY29tbWl0IGZmN2E3YzViNjAyNCAocWFwaTogRG9jdW1lbnQgZGVm
YXVsdCB2YWx1ZXMgZm9yIHN0cnVjdCBtZW1iZXJzKQo2LzE0IENoZWNraW5nIGNvbW1pdCAyODYy
ODI0OWRjZjEgKHRlc3QtcWFwaTogUHJpbnQgc3RydWN0IG1lbWJlcnMnIGRlZmF1bHQgdmFsdWVz
KQo3LzE0IENoZWNraW5nIGNvbW1pdCBmM2Q5ZjUzNDNhOTkgKHRlc3RzOiBUZXN0IFFBUEkgZGVm
YXVsdCB2YWx1ZXMgZm9yIHN0cnVjdCBtZW1iZXJzKQpFUlJPUjogSW52YWxpZCBVVEYtOCwgcGF0
Y2ggYW5kIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBiZSBlbmNvZGVkIGluIFVURi04CiMxMDY6IEZJ
TEU6IHRlc3RzL3FhcGktc2NoZW1hL3FhcGktc2NoZW1hLXRlc3Qub3V0OjQyMDoKKyAgICBtZW1i
ZXIgc3RyOiBzdHIgb3B0aW9uYWw9VHJ1ZSBkZWZhdWx0PWZvbyBc6bm/IiInCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpXQVJOSU5HOiBhZGRl
ZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRp
bmc/CiMxMTE6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5p
bmdzLCAxNjIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNy8xNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKOC8xNCBDaGVja2luZyBjb21taXQgNGViM2NhNDU3Y2EzICh0ZXN0czogQWRkIFFBUEkg
b3B0aW9uYWwgZGlzY3JpbWluYXRvciB0ZXN0cykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRl
bGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzM6IApuZXcg
ZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA2NyBsaW5lcyBj
aGVja2VkCgpQYXRjaCA4LzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjkvMTQgQ2hlY2tp
bmcgY29tbWl0IDU2NzY0NGY2YWFhOCAocWFwaTogRm9ybWFsaXplIHFjb3cyIGVuY3J5cHRpb24g
cHJvYmluZykKMTAvMTQgQ2hlY2tpbmcgY29tbWl0IDExNzI2ZDI1YzM2NyAocWFwaTogRm9ybWFs
aXplIHFjb3cgZW5jcnlwdGlvbiBwcm9iaW5nKQoxMS8xNCBDaGVja2luZyBjb21taXQgMzY0ZWFj
MWYzMWZjIChibG9jazogVHJ5IHRvIGNyZWF0ZSB3ZWxsIHR5cGVkIGpzb246e30gZmlsZW5hbWVz
KQoxMi8xNCBDaGVja2luZyBjb21taXQgMTU1YzFkYmRmM2YwIChpb3Rlc3RzOiBUZXN0IGludGVy
bmFsIG9wdGlvbiB0eXBpbmcpCjEzLzE0IENoZWNraW5nIGNvbW1pdCAzYmNmOTIyNzBlODYgKGlv
dGVzdHM6IHFjb3cyJ3MgZW5jcnlwdC5mb3JtYXQgaXMgbm93IG9wdGlvbmFsKQoxNC8xNCBDaGVj
a2luZyBjb21taXQgZGRkNjY5YWQ5NmEwIChibG9jazogTWFrZSB1c2Ugb2YgUUFQSSBkZWZhdWx0
cykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA2MjQxNzM5MzUuMjU3NDctMS1tcmVpdHpAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


