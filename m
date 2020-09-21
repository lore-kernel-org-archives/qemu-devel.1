Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20984C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A444207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A444207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCkr-0004tB-RU
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKCkG-0004T0-Du
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 23:44:04 -0400
Resent-Date: Sun, 20 Sep 2020 23:44:04 -0400
Resent-Message-Id: <E1kKCkG-0004T0-Du@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKCk9-0001TA-Re
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 23:44:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600659828; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OMZoBwUZsFnplbBtsG0mS6vs8p+V7TopuavjQ8RNaeXQSLsk+tOYY0c0RqaqXmRSFcpXJRSCLxQCiSj73gVPoXLejWozJdn1ZD9ZXTDF2DjFZLVjxQy5NCtR00p7sgbxDr90vVmRGj+TDWXMSzUgeEVD7DuBwoNHNXBz898NTxg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600659828;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=eyZ2SrmkBiPjX3FscCawiQkwi8Q2Q8GWI3fenLu11no=; 
 b=iCGAipT8gAtjIvweMgMLLt4gf3q4DBogQ6g9tGdZGwzGoOBkVFB5aFxMftPxHh20NN1+fDQbwzMVaAJh2npPMQppNS9jn4DDQoTSXh3kmEIuycqDkxxh9x8Mg5jQDUC+TPfYA8TQUbZ52oWqZsTQlJqldxok/YrXef2eLG9Qft8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600659828037438.1567865302759;
 Sun, 20 Sep 2020 20:43:48 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] Add a General Virtual Device Fuzzer
Message-ID: <160065982646.23907.6281645894304199010@66eaa9a8a123>
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Sun, 20 Sep 2020 20:43:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:46:02
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
Cc: alxndr@bu.edu, qemu-devel@nongnu.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMTAyMjUwNi44NzMz
MDMtMS1hbHhuZHJAYnUuZWR1LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdl
LWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkhvc3QgbWFjaGluZSBjcHU6
IHg4Nl82NApUYXJnZXQgbWFjaGluZSBjcHUgZmFtaWx5OiB4ODYKVGFyZ2V0IG1hY2hpbmUgY3B1
OiB4ODZfNjQKLi4vc3JjL21lc29uLmJ1aWxkOjEwOiBXQVJOSU5HOiBNb2R1bGUgdW5zdGFibGUt
a2V5dmFsIGhhcyBubyBiYWNrd2FyZHMgb3IgZm9yd2FyZHMgY29tcGF0aWJpbGl0eSBhbmQgbWln
aHQgbm90IGV4aXN0IGluIGZ1dHVyZSByZWxlYXNlcy4KUHJvZ3JhbSBzaCBmb3VuZDogWUVTClBy
b2dyYW0gcHl0aG9uMyBmb3VuZDogWUVTICgvdXNyL2Jpbi9weXRob24zKQpDb25maWd1cmluZyBu
aW5qYXRvb2wgdXNpbmcgY29uZmlndXJhdGlvbgotLS0KbWFrZVsxXTogTm90aGluZyB0byBiZSBk
b25lIGZvciAnYWxsJy4KbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgJy90bXAvcWVtdS10ZXN0
L3NyYy9zbGlycCcKR2VuZXJhdGluZyBuc2lzIHdpdGggYSBjdXN0b20gY29tbWFuZAptYWtlWzFd
OiB3YXJuaW5nOiBqb2JzZXJ2ZXIgdW5hdmFpbGFibGU6IHVzaW5nIC1qMS4gIEFkZCAnKycgdG8g
cGFyZW50IG1ha2UgcnVsZS4KbWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvdG1wL3FlbXUt
dGVzdC9idWlsZCcKbWFrZVsyXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvdG1wL3FlbXUtdGVzdC9z
cmMvc2xpcnAnCm1ha2VbMl06IE5vdGhpbmcgdG8gYmUgZG9uZSBmb3IgJ2FsbCcuCi0tLQpIb3N0
IG1hY2hpbmUgY3B1OiBpMzg2ClRhcmdldCBtYWNoaW5lIGNwdSBmYW1pbHk6IHg4NgpUYXJnZXQg
bWFjaGluZSBjcHU6IGkzODYKLi4vc3JjL21lc29uLmJ1aWxkOjEwOiBXQVJOSU5HOiBNb2R1bGUg
dW5zdGFibGUta2V5dmFsIGhhcyBubyBiYWNrd2FyZHMgb3IgZm9yd2FyZHMgY29tcGF0aWJpbGl0
eSBhbmQgbWlnaHQgbm90IGV4aXN0IGluIGZ1dHVyZSByZWxlYXNlcy4KUHJvZ3JhbSBzaCBmb3Vu
ZDogWUVTClByb2dyYW0gcHl0aG9uMyBmb3VuZDogWUVTICgvdXNyL2Jpbi9weXRob24zKQpDb25m
aWd1cmluZyBuaW5qYXRvb2wgdXNpbmcgY29uZmlndXJhdGlvbgotLS0KQ29tcGlsaW5nIEMgb2Jq
ZWN0IG1pZ3JhdGlvbi9saWJtaWdyYXRpb24uZmEucC9xZW11LWZpbGUtY2hhbm5lbC5jLm9iagpD
b21waWxpbmcgQyBvYmplY3QgbWlncmF0aW9uL2xpYm1pZ3JhdGlvbi5mYS5wL3FlbXUtZmlsZS5j
Lm9iagouLi9zcmMvc29mdG1tdS9tZW1vcnkuYzogSW4gZnVuY3Rpb24gJ2ZsYXR2aWV3X2Zvcl9l
YWNoX3JhbmdlJzoKLi4vc3JjL3NvZnRtbXUvbWVtb3J5LmM6NjYyOjI0OiBlcnJvcjogaW5jb21w
YXRpYmxlIHR5cGUgZm9yIGFyZ3VtZW50IDEgb2YgJ2NiJwogIDY2MiB8ICAgICAgICAgaWYgKGNi
KGZyLT5hZGRyLnN0YXJ0LCBmci0+YWRkci5zaXplLCBmci0+bXIsIG9wYXF1ZSkpCiAgICAgIHwg
ICAgICAgICAgICAgICAgfn5+fn5+fn5efn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgIHwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIEludDEyOCB7YWthIHN0cnVjdCBJ
bnQxMjh9Ci4uL3NyYy9zb2Z0bW11L21lbW9yeS5jOjY2MjoyNDogbm90ZTogZXhwZWN0ZWQgJ3Jh
bV9hZGRyX3QnIHtha2EgJ3Vuc2lnbmVkIGludCd9IGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlICdJ
bnQxMjgnIHtha2EgJ3N0cnVjdCBJbnQxMjgnfQouLi9zcmMvc29mdG1tdS9tZW1vcnkuYzo2NjI6
NDA6IGVycm9yOiBpbmNvbXBhdGlibGUgdHlwZSBmb3IgYXJndW1lbnQgMiBvZiAnY2InCiAgNjYy
IHwgICAgICAgICBpZiAoY2IoZnItPmFkZHIuc3RhcnQsIGZyLT5hZGRyLnNpemUsIGZyLT5tciwg
b3BhcXVlKSkKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5e
fn5+fgogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJbnQxMjgge2FrYSBz
dHJ1Y3QgSW50MTI4fQouLi9zcmMvc29mdG1tdS9tZW1vcnkuYzo2NjI6NDA6IG5vdGU6IGV4cGVj
dGVkICdyYW1fYWRkcl90JyB7YWthICd1bnNpZ25lZCBpbnQnfSBidXQgYXJndW1lbnQgaXMgb2Yg
dHlwZSAnSW50MTI4JyB7YWthICdzdHJ1Y3QgSW50MTI4J30KbWFrZTogKioqIFtNYWtlZmlsZS5u
aW5qYToxNjQwOiBsaWJxZW11LXg4Nl82NC1zb2Z0bW11LmZhLnAvc29mdG1tdV9tZW1vcnkuYy5v
YmpdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJh
Y2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2Rv
Y2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLXJtJywgJy0tbGFiZWwnLCAn
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD03MmFmZTg1MGI0NTI0OWNiOTA2ODJkODBlMWZlMjRkZScs
ICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICct
ZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1seTQ4OHlrNy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA5LTIw
LTIzLjMxLjEyLjI0NDQ0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2ZlZG9yYScsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTcyYWZl
ODUwYjQ1MjQ5Y2I5MDY4MmQ4MGUxZmUyNGRlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLWx5NDg4eWs3L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3Jh
XSBFcnJvciAyCgpyZWFsICAgIDEybTMzLjQxM3MKdXNlciAgICAwbTIyLjc2M3MKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTIxMDIy
NTA2Ljg3MzMwMy0xLWFseG5kckBidS5lZHUvdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

