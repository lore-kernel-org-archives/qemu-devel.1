Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F86C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 04:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F65206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 04:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F65206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtOSC-0000yd-2o
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 00:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtORW-0000Z7-Bd
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 00:45:54 -0400
Resent-Date: Thu, 09 Jul 2020 00:45:54 -0400
Resent-Message-Id: <E1jtORW-0000Z7-Bd@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtORS-0005Eh-S5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 00:45:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594269932; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g1Z9HifJtOKNxR6e72VS3JicTyVGrGBeblVCswnZHNyBOvLvUWXp57AQ9Y4e/lSkd6b+QfgRli8sl4e2vwLhYIgaZj/Q0449dAjUh+AnIBUrYlHjcSvUea05dJCrkwJGZD4hEHBdu3qR+eb69yUSXY8q4+Gh7Zm8C4Ec4GvSFOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594269932;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=D1sDjZFaHXBVnIJ7cxShwJTUjCTF+0loGHrQsUZpcUU=; 
 b=RfFO/YEv3MpTBo2R8ZM8erkEro5bwO9nTkvRcCFg7QRU02mchGdF8kfnZpsMhxrxcASw6vhiXwbORJb4XBNMiZu/0kxI99URaQpbz+m1rPcneTtDJCbHBZI5FHP+y79Pljx9fFUWTV5fDuZo5YNeWNn3TCc+zm154OX0xjdOdB8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159426993050695.23847390444712;
 Wed, 8 Jul 2020 21:45:30 -0700 (PDT)
Subject: Re: [PATCH] migration: fix memory leak in qmp_migrate_set_parameters
Message-ID: <159426992891.14765.11343134500859415610@07a7f0d89f7d>
In-Reply-To: <1594266433-21621-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhengchuan@huawei.com
Date: Wed, 8 Jul 2020 21:45:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 00:45:48
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 fangying1@huawei.com, zhukeqian1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk0MjY2NDMzLTIxNjIxLTEt
Z2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQg
dGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUg
RG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2Ut
Y2VudG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3
IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVT
VCAgICBjaGVjay1xdGVzdC1hYXJjaDY0OiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0CiAg
VEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWlvdgogIFRFU1QgICAgY2hlY2stcXRlc3Qt
YWFyY2g2NDogdGVzdHMvcXRlc3QvbWlncmF0aW9uLXRlc3QKKioqIEVycm9yIGluIGBhYXJjaDY0
LXNvZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2NCc6IG1hbGxvYygpOiBzbWFsbGJpbiBkb3VibGUg
bGlua2VkIGxpc3QgY29ycnVwdGVkOiAweDAwMDA1NTU3MzA5NGJhNTAgKioqCj09PT09PT0gQmFj
a3RyYWNlOiA9PT09PT09PT0KL2xpYjY0L2xpYmMuc28uNigrMHg3ZjNlNClbMHg3ZjkxZmZhMjAz
ZTRdCi9saWI2NC9saWJjLnNvLjYoKzB4ODJiMjApWzB4N2Y5MWZmYTIzYjIwXQotLS0KZmZmZmZm
ZmZmZjYwMDAwMC1mZmZmZmZmZmZmNjAxMDAwIHIteHAgMDAwMDAwMDAgMDA6MDAgMCAgICAgICAg
ICAgICAgICAgIFt2c3lzY2FsbF0KQnJva2VuIHBpcGUKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3Rz
L3F0ZXN0L2xpYnF0ZXN0LmM6MTc1OiBraWxsX3FlbXUoKSBkZXRlY3RlZCBRRU1VIGRlYXRoIGZy
b20gc2lnbmFsIDYgKEFib3J0ZWQpIChjb3JlIGR1bXBlZCkKRVJST1IgLSB0b28gZmV3IHRlc3Rz
IHJ1biAoZXhwZWN0ZWQgMTcsIGdvdCAwKQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LWFhcmNoNjRd
IEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNU
ICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtYml0bWFwCiAgVEVTVCAgICBjaGVjay11bml0OiB0
ZXN0cy90ZXN0LWFpbwotLS0KICBURVNUICAgIGNoZWNrLXF0ZXN0LXg4Nl82NDogdGVzdHMvcXRl
c3QvdGVzdC1maWx0ZXItbWlycm9yCiAgVEVTVCAgICBjaGVjay1xdGVzdC14ODZfNjQ6IHRlc3Rz
L3F0ZXN0L3Rlc3QtZmlsdGVyLXJlZGlyZWN0b3IKICBURVNUICAgIGNoZWNrLXF0ZXN0LXg4Nl82
NDogdGVzdHMvcXRlc3QvbWlncmF0aW9uLXRlc3QKKioqIEVycm9yIGluIGB4ODZfNjQtc29mdG1t
dS9xZW11LXN5c3RlbS14ODZfNjQnOiBtYWxsb2MoKTogc21hbGxiaW4gZG91YmxlIGxpbmtlZCBs
aXN0IGNvcnJ1cHRlZDogMHgwMDAwNTVhY2I0MzZmYzIwICoqKgo9PT09PT09IEJhY2t0cmFjZTog
PT09PT09PT09Ci9saWI2NC9saWJjLnNvLjYoKzB4N2YzZTQpWzB4N2ZlNzQwODgwM2U0XQovbGli
NjQvbGliYy5zby42KCsweDgyYjIwKVsweDdmZTc0MDg4M2IyMF0KLS0tCmZmZmZmZmZmZmY2MDAw
MDAtZmZmZmZmZmZmZjYwMTAwMCByLXhwIDAwMDAwMDAwIDAwOjAwIDAgICAgICAgICAgICAgICAg
ICBbdnN5c2NhbGxdCkJyb2tlbiBwaXBlCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9s
aWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0ZWN0ZWQgUUVNVSBkZWF0aCBmcm9tIHNpZ25h
bCA2IChBYm9ydGVkKSAoY29yZSBkdW1wZWQpCkVSUk9SIC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4
cGVjdGVkIDE3LCBnb3QgMCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEK
ICBURVNUICAgIGlvdGVzdC1xY293MjogMDQwCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0MQog
IFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwNDIKLS0tCk5vdCBydW46IDI1OQpGYWlsdXJlczogMTgx
CkZhaWxlZCAxIG9mIDExOSBpb3Rlc3RzCm1ha2U6ICoqKiBbY2hlY2stdGVzdHMvY2hlY2stYmxv
Y2suc2hdIEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUg
Ii4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY5LCBpbiA8bW9kdWxlPgogICAgc3lz
LmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBj
bWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4n
LCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9M2Fj
YmRhYTllY2VkNGI3YzhlN2NjYTgxNTk0MjJkNzgnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5
LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0n
LCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQn
LCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0v
dmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC1yZTNfOG4zNS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTA5LTAwLjI4LjQyLjE3NDI6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTNhY2JkYWE5ZWNlZDRiN2M4ZTdjY2E4
MTU5NDIyZDc4Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJlM184bjM1L3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAxNm00Ny41OTNzCnVzZXIgICAgMG05LjE1MnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1OTQyNjY0MzMtMjE2MjEtMS1naXQtc2VuZC1l
bWFpbC16aGVuZ2NodWFuQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

