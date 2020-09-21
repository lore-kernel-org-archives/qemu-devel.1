Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03FC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DFF20739
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 06:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DFF20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKFI5-0005o8-Hj
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 02:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKFHE-000540-7T
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 02:26:16 -0400
Resent-Date: Mon, 21 Sep 2020 02:26:16 -0400
Resent-Message-Id: <E1kKFHE-000540-7T@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKFHB-0002ug-NW
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 02:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600669566; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kViuTDPfoHtAIyPOC1OuTD4m6CeGqgpxxktzlr/hpO0qj1WoyExp6cYqVaUIXqLZd7fc6IOUM/79UG5Q8iSsayxAb4utl3TwXC7N7gO7adFrVrUqGTyHQXzwgRbg3p0Xxca0Vcto9GIfZEiNaOaG7bPc5R2NFFgzcTm7uDwy6GQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600669566;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=leRptd5klYazZgTeO0jq6e5yL1jBDdAJMIbcIzNKaBE=; 
 b=PlaMhbNAIvUXr1ZUI7SqFQAXquJCyDJKVznel1++zp7ad2W8X9YkdoW9ufQDyMQGoQ3vOU/1h8YA1PbhJ/KxX0Z8pLkO9KzbVy9f1eic8NjDyQmfXbuBkHCuqVUoaoAUCNZ9KANbgAlKG7sa/1nk8G0MjFBFGrdxXGPQ3Plnolk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600669563883888.5616046556277;
 Sun, 20 Sep 2020 23:26:03 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] Add a General Virtual Device Fuzzer
Message-ID: <160066956241.23907.16089556899170719204@66eaa9a8a123>
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Sun, 20 Sep 2020 23:26:03 -0700 (PDT)
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
ZWN0IGxpYmJsb2NrLmZhLnAvYmxvY2tfY3J5cHRvLmMub2JqCkNvbXBpbGluZyBDIG9iamVjdCBs
aWJibG9jay5mYS5wL25iZF9jbGllbnQuYy5vYmoKLi4vc3JjL3NvZnRtbXUvbWVtb3J5LmM6IElu
IGZ1bmN0aW9uICdmbGF0dmlld19mb3JfZWFjaF9yYW5nZSc6Ci4uL3NyYy9zb2Z0bW11L21lbW9y
eS5jOjY2MjoyNDogZXJyb3I6IGluY29tcGF0aWJsZSB0eXBlIGZvciBhcmd1bWVudCAxIG9mICdj
YicKICA2NjIgfCAgICAgICAgIGlmIChjYihmci0+YWRkci5zdGFydCwgZnItPmFkZHIuc2l6ZSwg
ZnItPm1yLCBvcGFxdWUpKQogICAgICB8ICAgICAgICAgICAgICAgIH5+fn5+fn5+Xn5+fn5+CiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICB8CiAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICBJbnQxMjgge2FrYSBzdHJ1Y3QgSW50MTI4fQouLi9zcmMvc29mdG1tdS9tZW1vcnkuYzo2
NjI6MjQ6IG5vdGU6IGV4cGVjdGVkICdyYW1fYWRkcl90JyB7YWthICd1bnNpZ25lZCBpbnQnfSBi
dXQgYXJndW1lbnQgaXMgb2YgdHlwZSAnSW50MTI4JyB7YWthICdzdHJ1Y3QgSW50MTI4J30KLi4v
c3JjL3NvZnRtbXUvbWVtb3J5LmM6NjYyOjQwOiBlcnJvcjogaW5jb21wYXRpYmxlIHR5cGUgZm9y
IGFyZ3VtZW50IDIgb2YgJ2NiJwogIDY2MiB8ICAgICAgICAgaWYgKGNiKGZyLT5hZGRyLnN0YXJ0
LCBmci0+YWRkci5zaXplLCBmci0+bXIsIG9wYXF1ZSkpCiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIH5+fn5+fn5+Xn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgSW50MTI4IHtha2Egc3RydWN0IEludDEyOH0KLi4vc3JjL3NvZnRtbXUvbWVt
b3J5LmM6NjYyOjQwOiBub3RlOiBleHBlY3RlZCAncmFtX2FkZHJfdCcge2FrYSAndW5zaWduZWQg
aW50J30gYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUgJ0ludDEyOCcge2FrYSAnc3RydWN0IEludDEy
OCd9CkNvbXBpbGluZyBDIG9iamVjdCBsaWJibG9jay5mYS5wL2Jsb2NrX2Jsa3JlcGxheS5jLm9i
agptYWtlOiAqKiogW01ha2VmaWxlLm5pbmphOjE2MzE6IGxpYnFlbXUteDg2XzY0LXNvZnRtbXUu
ZmEucC9zb2Z0bW11X21lbW9yeS5jLm9ial0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3Ig
dW5maW5pc2hlZCBqb2JzLi4uLgp3cml0aW5nIG91dHB1dC4uLiBbIDkxJV0gdGFyZ2V0LXNwYXJj
NjQKd3JpdGluZyBvdXRwdXQuLi4gWyA5MyVdIHRhcmdldC14dGVuc2EKLS0tCiAgICByYWlzZSBD
YWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NF
cnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1ybScsICct
LWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Y2RjNTA3Y2RkYWFlNDM2YmI5NjFmZjUx
Y2U5MzQxNGEnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29u
ZmluZWQnLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRT
PScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9X
X0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUv
cGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12
JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC03czN4cDRrNi9zcmMvZG9ja2VyLXNyYy4y
MDIwLTA5LTIxLTAyLjE4LjM1LjE3ODY1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2ZlZG9y
YScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJv
IGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51
dWlkPWNkYzUwN2NkZGFhZTQzNmJiOTYxZmY1MWNlOTM0MTRhCm1ha2VbMV06ICoqKiBbZG9ja2Vy
LXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLTdzM3hwNGs2L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWlu
Z3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDdtMjYuOTkycwp1c2VyICAgIDBtMjIuMjMwcwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA5MjEwMjI1MDYuODczMzAzLTEtYWx4bmRyQGJ1LmVkdS90ZXN0aW5nLmRvY2tlci1taW5nd0Bm
ZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

