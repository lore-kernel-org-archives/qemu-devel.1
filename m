Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A276BC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7420723AFE
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 18:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7420723AFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k713a-00010P-NI
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 14:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7134-0000a6-RD
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:36:58 -0400
Resent-Date: Sat, 15 Aug 2020 14:36:58 -0400
Resent-Message-Id: <E1k7134-0000a6-RD@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7131-0002Jt-Ht
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 14:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597516602; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mPqmKJdUKFKqGRDz13GUuOBesJ3KdNDBvryHJCYCTcWGedln7efbZveIzRDQXJKDYJ3Pog5An+lYOwIFCCqrUdSKbs2qhxZ/UyaQjz4EZe1Pf+UetQBwDVTkJcLDww1gqN2Ajtmw/TOGDk64GWMqiz1pUe8+ihkynC9k8fqup9s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597516602;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HRet3JNbXhL7TBlJv85aZkJI18zH09Nwv97UMW68njw=; 
 b=l2y1kCcOTGTbhZa8ClmIVDD2V2+w3jTgXIc2qlWjCzWOppwxL5M88aHuoR51pDIW+AEEP0+Gvtjjvv7QahJPKAI7bu3zEBnqnyfCcAvZVniFZe7VIlKx7rfV0WDR+xxAzMqybbc6JD7E9kH5k0NOmPiXB6GY5TIjeO+D4nNE0oA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597516599451444.7899027897871;
 Sat, 15 Aug 2020 11:36:39 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] *** A Method for evaluating dirty page rate ***
Message-ID: <159751659871.18357.254378905251414749@66eaa9a8a123>
In-Reply-To: <1597458180-16945-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhengchuan@huawei.com
Date: Sat, 15 Aug 2020 11:36:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 13:12:31
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
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk3NDU4MTgwLTE2OTQ1LTEt
Z2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0
Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXIt
dGVzdC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CiAgQ0MgICAgICBxYXBpL3FhcGktY29tbWFuZHMtdHJhY2UubwogIENDICAgICAgcWFwaS9xYXBp
LWNvbW1hbmRzLXVpLm8KL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9kaXJ0eXJhdGUuYzog
SW4gZnVuY3Rpb24gJ2dldF9yYW1ibG9ja192Zm5faGFzaCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9t
aWdyYXRpb24vZGlydHlyYXRlLmM6MTQ4OjMzOiBlcnJvcjogcGFzc2luZyBhcmd1bWVudCA1IG9m
ICdxY3J5cHRvX2hhc2hfYnl0ZXN2JyBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1X
ZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgMTQ4IHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG1kLCAmcWNyeXB0b19oYXNoX2xlbiwgTlVMTCkgPCAwKSB7CiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fgogICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAotLS0KICAgNzIgfCAgICAgICAgICAg
ICAgICAgICAgICAgICBzaXplX3QgKnJlc3VsdGxlbiwKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICB+fn5+fn5+fl5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVk
IGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IG1p
Z3JhdGlvbi9kaXJ0eXJhdGUub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5p
c2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAi
Li90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA3MDksIGluIDxtb2R1bGU+Ci0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
bGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD04MzI5ZTNmMmYzNjc0YWY0YjA3Y2U0OWIx
ZjYyYmFhNycsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25m
aW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12Jywg
Jy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNXduZTA2dmEvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wOC0xNS0xNC4zMy40NC4yOTA2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11
L2ZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5v
bi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0
YW5jZS51dWlkPTgzMjllM2YyZjM2NzRhZjRiMDdjZTQ5YjFmNjJiYWE3Cm1ha2VbMV06ICoqKiBb
ZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLTV3bmUwNnZhL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRl
c3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDJtNTYuMDM2cwp1c2VyICAgIDBtOS41
MjVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8xNTk3NDU4MTgwLTE2OTQ1LTEtZ2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBodWF3ZWkuY29t
L3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

