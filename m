Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 19:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7812075A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 19:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7812075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jotom-0000vE-FO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 15:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joto1-0000SE-AU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 15:14:34 -0400
Resent-Date: Fri, 26 Jun 2020 15:14:33 -0400
Resent-Message-Id: <E1joto1-0000SE-AU@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jotnx-0005iL-Hi
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 15:14:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593198838; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eBD0Lzhc4U9rMY9X2pSMJZEagXZpmF8juCuMPtSZVyp5GZ1RIZ+TBtDi2UOYn8WnlD1/je0DqKUKOQZ+7KiwMxcJECRXE7rGqtPfl4vOAKh/GG/0PrgIPRwDlh1IC0tmhda1OLsErQExeS+HJyQq2Kjn1ytFQ0eSdWc4oKlY9sw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593198838;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=nem0K2itPNnPY12KGf5opPwUWW1RJ00DgJ7rjLFn5Ow=; 
 b=QfJH3w3JZPdc2Kz/FaGnix7zIbFyj4duWhpMCWFkdfPkEYngPnL9ZM8O7iP+E5Y5XdIqcBaJ5jHN+KQlI5vZgsTpF7+Vrqr00EljaHJ38tquLbwYmJ9v6kFn6KaMleWpHH6vz0cDYc1pu/ikGkCt0Tle3naV9oRO0Ps+24hZXBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593198835418800.5478032522572;
 Fri, 26 Jun 2020 12:13:55 -0700 (PDT)
Message-ID: <159319883401.31217.926668851218134648@d1fd068a5071>
Subject: Re: [PATCH  v3 00/30] testing/next (gitlab, vm, docker)
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 26 Jun 2020 12:13:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 15:14:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, alex.bennee@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNjE4MTM1Ny4yNjIx
MS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXNpbmcgZGVm
YXVsdCB0YWc6IGxhdGVzdApUcnlpbmcgdG8gcHVsbCByZXBvc2l0b3J5IHJlZ2lzdHJ5LmdpdGxh
Yi5jb20vc3RzcXVhZC9xZW11L3FlbXUvZmVkb3JhIC4uLiAKUHVsbGluZyByZXBvc2l0b3J5IHJl
Z2lzdHJ5LmdpdGxhYi5jb20vc3RzcXVhZC9xZW11L3FlbXUvZmVkb3JhCkVycm9yOiBpbWFnZSBz
dHNxdWFkL3FlbXUvcWVtdS9mZWRvcmE6bGF0ZXN0IG5vdCBmb3VuZApTZW5kaW5nIGJ1aWxkIGNv
bnRleHQgdG8gRG9ja2VyIGRhZW1vbiA0LjA5NiBrQgpTdGVwIDEvOSA6IEZST00gZmVkb3JhOjMy
CiAtLS0+IDJhOGQzMTVlNjIwOAotLS0KIHBlcmwtRW5jb2RlLWRldmVsICAgICAgICAgICAgICAg
ICAgICAgICB4ODZfNjQgIDQ6My4wNi00NDUuZmMzMiAgICAgICAgICAgICAgICAgIHVwZGF0ZXMg
ICA0MiBrCiBwZXJsLUVudiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9hcmNoICAx
LjA0LTQ0MC5mYzMyICAgICAgICAgICAgICAgICAgICBmZWRvcmEgICAgMTkgawogcGVybC1FcnJu
byAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHg4Nl82NCAgMS4zMC00NTMuZmMzMiAgICAg
ICAgICAgICAgICAgICAgdXBkYXRlcyAgIDI0IGsKIHBlcmwtRXJyb3IgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBub2FyY2ggIDE6MC4xNzAyOS0xLmZjMzIgICAgICAgICAgICAgICAgIGZl
ZG9yYSAgICA0MiBrCiBwZXJsLUV4cG9ydGVyICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9h
cmNoICA1Ljc0LTIuZmMzMiAgICAgICAgICAgICAgICAgICAgICBmZWRvcmEgICAgMzIgawogcGVy
bC1FeHBvcnRlci1UaW55ICAgICAgICAgICAgICAgICAgICAgIG5vYXJjaCAgMS4wMDIwMDEtNS5m
YzMyICAgICAgICAgICAgICAgICAgZmVkb3JhICAgIDUxIGsKIHBlcmwtRXh0VXRpbHMtQ0J1aWxk
ZXIgICAgICAgICAgICAgICAgICBub2FyY2ggIDE6MC4yODAyMzQtMi5mYzMyICAgICAgICAgICAg
ICAgIGZlZG9yYSAgICA0NyBrCi0tLQooNjMzLzg0Mik6IHBlcmwtRW5jb2RlLUxvY2FsZS0xLjA1
LTE1LmZjMzIubm9hciAxNTkga0IvcyB8ICAxOSBrQiAgICAgMDA6MDAgICAgCig2MzQvODQyKTog
cGVybC1FbnYtMS4wNC00NDAuZmMzMi5ub2FyY2gucnBtICAgIDE2MCBrQi9zIHwgIDE5IGtCICAg
ICAwMDowMCAgICAKKDYzNS84NDIpOiBwZXJsLURpZ2VzdC1TSEEtNi4wMi00NDIuZmMzMi54ODZf
NjQgMTQ5IGtCL3MgfCAgNjQga0IgICAgIDAwOjAwICAgIAooNjM2Lzg0Mik6IHBlcmwtRXJyb3It
MC4xNzAyOS0xLmZjMzIubm9hcmNoLnJwbSAyMDEga0IvcyB8ICA0MiBrQiAgICAgMDA6MDAgICAg
Cig2MzcvODQyKTogcGVybC1FeHBvcnRlci01Ljc0LTIuZmMzMi5ub2FyY2gucnBtIDE1MiBrQi9z
IHwgIDMyIGtCICAgICAwMDowMCAgICAKKDYzOC84NDIpOiBwZXJsLUV4cG9ydGVyLVRpbnktMS4w
MDIwMDEtNS5mYzMyLm4gMTgyIGtCL3MgfCAgNTEga0IgICAgIDAwOjAwICAgIAooNjM5Lzg0Mik6
IHBlcmwtRXh0VXRpbHMtQ0J1aWxkZXItMC4yODAyMzQtMi5mYyAxNDkga0IvcyB8ICA0NyBrQiAg
ICAgMDA6MDAgICAgCi0tLQogIEluc3RhbGxpbmcgICAgICAgOiBwZXJsLURCX0ZpbGUtMS44NTMt
Mi5mYzMyLng4Nl82NCAgICAgICAgICAgICAgICAgICAyMzMvODU2IAogIEluc3RhbGxpbmcgICAg
ICAgOiBwZXJsLURldmVsLVNpemUtMC44My01LmZjMzIueDg2XzY0ICAgICAgICAgICAgICAgICAy
MzQvODU2IAogIEluc3RhbGxpbmcgICAgICAgOiBwZXJsLUVudi0xLjA0LTQ0MC5mYzMyLm5vYXJj
aCAgICAgICAgICAgICAgICAgICAgICAyMzUvODU2IAogIEluc3RhbGxpbmcgICAgICAgOiBwZXJs
LUVycm9yLTE6MC4xNzAyOS0xLmZjMzIubm9hcmNoICAgICAgICAgICAgICAgICAyMzYvODU2IAog
IEluc3RhbGxpbmcgICAgICAgOiBwZXJsLUlQQy1TeXNWLTIuMDctNDQyLmZjMzIueDg2XzY0ICAg
ICAgICAgICAgICAgICAyMzcvODU2IAogIEluc3RhbGxpbmcgICAgICAgOiBwZXJsLUlQQy1TeXN0
ZW0tU2ltcGxlLTEuMzAtMS5mYzMyLm5vYXJjaCAgICAgICAgICAyMzgvODU2IAogIEluc3RhbGxp
bmcgICAgICAgOiBwZXJsLWF1dG9kaWUtMi4zMi0yLmZjMzIubm9hcmNoICAgICAgICAgICAgICAg
ICAgICAyMzkvODU2IAotLS0KICBWZXJpZnlpbmcgICAgICAgIDogcGVybC1EaWdlc3QtU0hBLTE6
Ni4wMi00NDIuZmMzMi54ODZfNjQgICAgICAgICAgICAgNjM0Lzg1NiAKICBWZXJpZnlpbmcgICAg
ICAgIDogcGVybC1FbmNvZGUtTG9jYWxlLTEuMDUtMTUuZmMzMi5ub2FyY2ggICAgICAgICAgICAg
NjM1Lzg1NiAKICBWZXJpZnlpbmcgICAgICAgIDogcGVybC1FbnYtMS4wNC00NDAuZmMzMi5ub2Fy
Y2ggICAgICAgICAgICAgICAgICAgICAgNjM2Lzg1NiAKICBWZXJpZnlpbmcgICAgICAgIDogcGVy
bC1FcnJvci0xOjAuMTcwMjktMS5mYzMyLm5vYXJjaCAgICAgICAgICAgICAgICAgNjM3Lzg1NiAK
ICBWZXJpZnlpbmcgICAgICAgIDogcGVybC1FeHBvcnRlci01Ljc0LTIuZmMzMi5ub2FyY2ggICAg
ICAgICAgICAgICAgICAgNjM4Lzg1NiAKICBWZXJpZnlpbmcgICAgICAgIDogcGVybC1FeHBvcnRl
ci1UaW55LTEuMDAyMDAxLTUuZmMzMi5ub2FyY2ggICAgICAgICAgNjM5Lzg1NiAKICBWZXJpZnlp
bmcgICAgICAgIDogcGVybC1FeHRVdGlscy1DQnVpbGRlci0xOjAuMjgwMjM0LTIuZmMzMi5ub2Fy
Y2ggICAgNjQwLzg1NiAKLS0tCiAgcGVybC1FbmNvZGUtZGV2ZWwtNDozLjA2LTQ0NS5mYzMyLng4
Nl82NCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgcGVybC1FbnYtMS4w
NC00NDAuZmMzMi5ub2FyY2ggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgcGVybC1FcnJuby0xLjMwLTQ1My5mYzMyLng4Nl82NCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgcGVybC1FcnJvci0xOjAuMTcwMjkt
MS5mYzMyLm5vYXJjaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgcGVybC1FeHBvcnRlci01Ljc0LTIuZmMzMi5ub2FyY2ggICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgcGVybC1FeHBvcnRlci1UaW55LTEuMDAyMDAxLTUu
ZmMzMi5ub2FyY2ggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgcGVybC1F
eHRVdGlscy1DQnVpbGRlci0xOjAuMjgwMjM0LTIuZmMzMi5ub2FyY2ggICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUs
IGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICct
bicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1k
NjMwZWMzZjhjMjQ0YjBhOTYyYmFjZDU0ZGIzZjI0ZScsICctdScsICcxMDAxJywgJy0tc2VjdXJp
dHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNU
PScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0x
NCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9
L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2Vy
LWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtZGFsdGxkM2Yvc3JjL2RvY2tlci1zcmMuMjAyMC0wNi0yNi0xNS4wNC4yMC4yNTI3Njov
dmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9mZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAn
dGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1m
aWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1kNjMwZWMzZjhjMjQ0YjBhOTYyYmFj
ZDU0ZGIzZjI0ZQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVh
dmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1kYWx0bGQzZi9zcmMn
Cm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAg
ICA5bTQ4LjYzNXMKdXNlciAgICAwbTEwLjI5OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjI2MTgxMzU3LjI2MjExLTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

