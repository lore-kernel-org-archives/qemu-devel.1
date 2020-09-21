Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF924C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E592078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E592078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKC46-0007ty-S7
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKC2t-0007TV-C3
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:59:15 -0400
Resent-Date: Sun, 20 Sep 2020 22:59:15 -0400
Resent-Message-Id: <E1kKC2t-0007TV-C3@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKC2r-00050h-1w
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:59:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600657140; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fW55j3PD9VHL83AinPAzYkrhRH/ssX/T/UfLkQDI0Z3NtsyB3tARqMlheIvt80mbLRiZFxaQYZzCUH/Edf/5PRVafrD39g9WJ3ZN5xTAcGB4mu7pA338S5oTtGfkyg7sCVpXJfEk/E57YfuzvR2Ho5BIkX2/5Iqji85911abBdM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600657140;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Z4C90pV61nnfrb4dLE4/7rKR6OPf3Ui5A7Ehca78+AE=; 
 b=m2y2BL/sDmAdnz+tOeSU1rxcvIWk9yoqFioDT641HMDCkPgcJbwoMjXaa+q6tRiDwZnihInXfKMWQwmEP2JLwzUwltes5m3x6YovH7ocPnr2gRPuJBvHiaD9wyqSzPoS9Dh90LYOEPwPwhCdf2EXLlAl/eswb/4syXYIyAOPnTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600657139021275.1542251099187;
 Sun, 20 Sep 2020 19:58:59 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] Add a General Virtual Device Fuzzer
Message-ID: <160065713758.23907.1081744016534744472@66eaa9a8a123>
In-Reply-To: <20200921022506.873303-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Sun, 20 Sep 2020 19:58:59 -0700 (PDT)
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
ZWN0IGxpYnFlbXUteDg2XzY0LXNvZnRtbXUuZmEucC9tZXNvbi1nZW5lcmF0ZWRfLi5fcWFwaV9x
YXBpLWludHJvc3BlY3QuYy5vYmoKQ29tcGlsaW5nIEMgb2JqZWN0IGxpYnFlbXUteDg2XzY0LXNv
ZnRtbXUuZmEucC9tZXNvbi1nZW5lcmF0ZWRfLi5fcWFwaV9xYXBpLXR5cGVzLW1pc2MtdGFyZ2V0
LmMub2JqCi4uL3NyYy9zb2Z0bW11L21lbW9yeS5jOiBJbiBmdW5jdGlvbiAnZmxhdHZpZXdfZm9y
X2VhY2hfcmFuZ2UnOgouLi9zcmMvc29mdG1tdS9tZW1vcnkuYzo2NjI6MjQ6IGVycm9yOiBpbmNv
bXBhdGlibGUgdHlwZSBmb3IgYXJndW1lbnQgMSBvZiAnY2InCiAgNjYyIHwgICAgICAgICBpZiAo
Y2IoZnItPmFkZHIuc3RhcnQsIGZyLT5hZGRyLnNpemUsIGZyLT5tciwgb3BhcXVlKSkKICAgICAg
fCAgICAgICAgICAgICAgICB+fn5+fn5+fl5+fn5+fgogICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgfAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgSW50MTI4IHtha2Egc3RydWN0
IEludDEyOH0KLi4vc3JjL3NvZnRtbXUvbWVtb3J5LmM6NjYyOjI0OiBub3RlOiBleHBlY3RlZCAn
cmFtX2FkZHJfdCcge2FrYSAndW5zaWduZWQgaW50J30gYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUg
J0ludDEyOCcge2FrYSAnc3RydWN0IEludDEyOCd9Ci4uL3NyYy9zb2Z0bW11L21lbW9yeS5jOjY2
Mjo0MDogZXJyb3I6IGluY29tcGF0aWJsZSB0eXBlIGZvciBhcmd1bWVudCAyIG9mICdjYicKICA2
NjIgfCAgICAgICAgIGlmIChjYihmci0+YWRkci5zdGFydCwgZnItPmFkZHIuc2l6ZSwgZnItPm1y
LCBvcGFxdWUpKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+
fl5+fn5+CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAog
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEludDEyOCB7YWth
IHN0cnVjdCBJbnQxMjh9Ci4uL3NyYy9zb2Z0bW11L21lbW9yeS5jOjY2Mjo0MDogbm90ZTogZXhw
ZWN0ZWQgJ3JhbV9hZGRyX3QnIHtha2EgJ3Vuc2lnbmVkIGludCd9IGJ1dCBhcmd1bWVudCBpcyBv
ZiB0eXBlICdJbnQxMjgnIHtha2EgJ3N0cnVjdCBJbnQxMjgnfQpDb21waWxpbmcgQyBvYmplY3Qg
bGlicWVtdS14ODZfNjQtc29mdG1tdS5mYS5wL21lc29uLWdlbmVyYXRlZF8uLl9xYXBpX3FhcGkt
aW5pdC1jb21tYW5kcy5jLm9iagptYWtlOiAqKiogW01ha2VmaWxlLm5pbmphOjE2NDI6IGxpYnFl
bXUteDg2XzY0LXNvZnRtbXUuZmEucC9zb2Z0bW11X21lbW9yeS5jLm9ial0gRXJyb3IgMQptYWtl
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVj
ZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA3
MDksIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUs
IGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICct
bicsICdkb2NrZXInLCAncnVuJywgJy0tcm0nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5j
ZS51dWlkPWEwYWIzNGY0Y2VhZTQ4MjI4YzVmNzk5MDE4OTkyZGRmJywgJy11JywgJzEwMDEnLCAn
LS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy1lJywgJ1RBUkdFVF9MSVNU
PScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0x
NCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9
L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2Vy
LWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtNXk1Z3BuNDkvc3JjL2RvY2tlci1zcmMuMjAyMC0wOS0yMC0yMi40Ni4yNi40MDcxOi92
YXIvdG1wL3FlbXU6eixybycsICdxZW11L2ZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWEwYWIzNGY0Y2VhZTQ4MjI4YzVmNzk5
MDE4OTkyZGRmCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTV5NWdwbjQ5L3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAg
IDEybTMwLjI4OXMKdXNlciAgICAwbTIwLjM4M3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTIxMDIyNTA2Ljg3MzMwMy0xLWFseG5k
ckBidS5lZHUvdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

