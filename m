Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC90C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DF322464
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DF322464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1Kc-0005Vi-LM
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jC1Jr-0004fq-Fh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jC1Jq-0005Bq-9B
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:22:43 -0400
Resent-Date: Wed, 11 Mar 2020 09:22:43 -0400
Resent-Message-Id: <E1jC1Jq-0005Bq-9B@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jC1Jq-0005Be-0x
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583932953; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FKbYQH381xCd70lNJhSeare2nd3poD3HFl777VLeYb77A9zNPWm1T/JCn+wCjtn9IWoPWtsTZSnsYAreOiZlKpkuwXy90zHdlSDYdBm9i+j+X2fWDfc4L61DgM3ZchAHbVAiGG8K0BagJhVWXv38MMgdEzQK6ft2/01BNo7ph1M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583932953;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=OpHkv7MkU4/HUlA2IJ0TnlcNRLj30fzKvPdmWia51us=; 
 b=dIhZhlE+Gk4WUdKd/9C1Q7KJvARFWJ5E/Ab5J4du/e3PamuVxy3a5hs9bu8QPhMM2trOk+o0+dwHQnfy9ETHQqvOM2cbNKNvxwfsv/kCb75TgJSmIsUt2tI7LHSpQdllMcmOwDJa+4xrVCN4kvuEMzMj15R9gdhoQ0j4YYTNWho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15839329511951002.1353014033504;
 Wed, 11 Mar 2020 06:22:31 -0700 (PDT)
In-Reply-To: <20200311123624.277221-1-stefanha@redhat.com>
Subject: Re: [PATCH 0/2] thread: add lock guard macros
Message-ID: <158393294992.5248.13775226604855408879@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Wed, 11 Mar 2020 06:22:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMTEyMzYyNC4yNzcy
MjEtMS1zdGVmYW5oYUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB1
dGlsL3VyaS5vCiAgQ0MgICAgICB1dGlsL25vdGlmeS5vCi90bXAvcWVtdS10ZXN0L3NyYy91dGls
L3FlbXUtdGltZXIuYzogSW4gZnVuY3Rpb24gJ3RpbWVybGlzdF9leHBpcmVkJzoKL3RtcC9xZW11
LXRlc3Qvc3JjL3V0aWwvcWVtdS10aW1lci5jOjE5NjoyNDogZXJyb3I6ICdleHBpcmVfdGltZScg
bWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJl
LXVuaW5pdGlhbGl6ZWRdCiAgICAgcmV0dXJuIGV4cGlyZV90aW1lIDw9IHFlbXVfY2xvY2tfZ2V0
X25zKHRpbWVyX2xpc3QtPmNsb2NrLT50eXBlKTsKICAgICAgICAgICAgfn5+fn5+fn5+fn5+Xn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3Jj
L3J1bGVzLm1hazo2OTogdXRpbC9xZW11LXRpbWVyLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9k
dWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YmJlN2VjMzYxOWUy
NDAxYTk3MDYwZDVkOWFiNTViYWMnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2Nj
YWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1qZHRu
d2tzYS9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTExLTA5LjIwLjU0LjI4NTQ6L3Zhci90bXAvcWVt
dTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YmJlN2VjMzYxOWUyNDAxYTk3MDYwZDVkOWFiNTViYWMK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtamR0bndrc2Evc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMW0zNi42NTRz
CnVzZXIgICAgMG03Ljg1NnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzExMTIzNjI0LjI3NzIyMS0xLXN0ZWZhbmhhQHJlZGhhdC5j
b20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

