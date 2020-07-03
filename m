Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26027C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED94C206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED94C206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIzP-0007G2-9e
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrIy1-0006VH-TR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:30:49 -0400
Resent-Date: Fri, 03 Jul 2020 06:30:49 -0400
Resent-Message-Id: <E1jrIy1-0006VH-TR@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrIxx-00032B-Um
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:30:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593772235; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dmHme+/PijkdHvqkzs5Xd7OtsE3WNUjQIsW/CNoMM0ZYs9l6pY8IgSWCQD8wnF9zNJAPzxJyZKH5dfi53tlqXR/ET9GFa5KhDiiSuhKZT3pDecFl+MJwSdywdB82l4X1C0dtAUOfyryXR6o8KQk7t3CfujCOHmJKHOXywuT4eCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593772235;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qidXyIJ5C+fd+WZRdyx0+Xq8lthTAAHF4F35Zepvt8g=; 
 b=aHeotXCiiBdqU3hhnPuG/YXb2qFbleLSGi5l47dluPA5SDB/EpQZ1+oAHO2gsJRpjnGxjXg0IeK8YBtaKM3qGLnwUV9lz2nxYUvzpcPNXSCoJiZIakIWDQEbcE35I8XdZaU0fo/dg+CBQkI1bDDGVtvqWwDo03NznXUXwqaUVSU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159377223258780.96234657849675;
 Fri, 3 Jul 2020 03:30:32 -0700 (PDT)
Message-ID: <159377223165.11379.6742950760725888081@d1fd068a5071>
Subject: Re: [PATCH] ram: add support for dirty page tracking
In-Reply-To: <20200703092853.1448582-1-owen.si@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: owen.si@ucloud.cn
Date: Fri, 3 Jul 2020 03:30:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:31:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMzA5Mjg1My4xNDQ4
NTgyLTEtb3dlbi5zaUB1Y2xvdWQuY24vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHVp
L3ZuYy1wYWxldHRlLm8KICBDQyAgICAgIHVpL3ZuYy1lbmMtenJsZS5vCiAgQ0MgICAgICB1aS92
bmMtYXV0aC12ZW5jcnlwdC5vCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vc2F2ZXZtLmM6
MTgxOjg6IGVycm9yOiAnUWVtdVRocmVhZCcge2FrYSAnc3RydWN0IFFlbXVUaHJlYWQnfSBoYXMg
bm8gbWVtYmVyIG5hbWVkICd0aHJlYWQnCiAgMTgxIHwgICAgIHsgLnRocmVhZCA9IDAgfSwKICAg
ICAgfCAgICAgICAgXn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vc2F2ZXZtLmM6
IEluIGZ1bmN0aW9uICdkaXJ0eV90cmFja19pc19ydW5uaW5nJzoKL3RtcC9xZW11LXRlc3Qvc3Jj
L21pZ3JhdGlvbi9zYXZldm0uYzoyNzg3OjQ2OiBlcnJvcjogJ1FlbXVUaHJlYWQnIHtha2EgJ3N0
cnVjdCBRZW11VGhyZWFkJ30gaGFzIG5vIG1lbWJlciBuYW1lZCAndGhyZWFkJwogMjc4NyB8ICAg
ICByZXR1cm4gISFjdXJyZW50X2RpcnR5X3RyYWNrX3N0YXRlLnRocmVhZC50aHJlYWQ7CiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3Fl
bXUtdGVzdC9zcmMvbWlncmF0aW9uL3NhdmV2bS5jOiBJbiBmdW5jdGlvbiAnaG1wX2RpcnR5X3Ry
YWNrX3N0b3AnOgovdG1wL3FlbXUtdGVzdC9zcmMvbWlncmF0aW9uL3NhdmV2bS5jOjI4MTc6NDE6
IGVycm9yOiAnUWVtdVRocmVhZCcge2FrYSAnc3RydWN0IFFlbXVUaHJlYWQnfSBoYXMgbm8gbWVt
YmVyIG5hbWVkICd0aHJlYWQnCiAyODE3IHwgICAgIGlmIChjdXJyZW50X2RpcnR5X3RyYWNrX3N0
YXRlLnRocmVhZC50aHJlYWQgPT0gMCkgewogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vc2F2ZXZtLmM6
MjgyODozNzogZXJyb3I6ICdRZW11VGhyZWFkJyB7YWthICdzdHJ1Y3QgUWVtdVRocmVhZCd9IGhh
cyBubyBtZW1iZXIgbmFtZWQgJ3RocmVhZCcKIDI4MjggfCAgICAgY3VycmVudF9kaXJ0eV90cmFj
a19zdGF0ZS50aHJlYWQudGhyZWFkID0gMDsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vc2F2ZXZtLmM6IElu
IGZ1bmN0aW9uICdkaXJ0eV90cmFja19pc19ydW5uaW5nJzoKL3RtcC9xZW11LXRlc3Qvc3JjL21p
Z3JhdGlvbi9zYXZldm0uYzoyNzg4OjE6IGVycm9yOiBjb250cm9sIHJlYWNoZXMgZW5kIG9mIG5v
bi12b2lkIGZ1bmN0aW9uIFstV2Vycm9yPXJldHVybi10eXBlXQogMjc4OCB8IH0KICAgICAgfCBe
CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCiAgQ0MgICAgICB1aS92
bmMtd3MubwogIENDICAgICAgdWkvdm5jLWpvYnMubwogIENDICAgICAgdWkvd2luMzIta2JkLWhv
b2subwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IG1pZ3JhdGlv
bi9zYXZldm0ub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9k
b2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjksIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2Fs
bGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJy
b3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAn
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01YzMwYjQ5ZDU2NWM0N2I5YTcxODA3MmIwM2Q0ZDg3OCcs
ICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICct
LXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0n
LCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19F
TlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdics
ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZzBqem9tdG8vc3JjL2RvY2tlci1zcmMuMjAy
MC0wNy0wMy0wNi4yNy40NC4yOTk4OTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEn
LCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBl
eGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVp
ZD01YzMwYjQ5ZDU2NWM0N2I5YTcxODA3MmIwM2Q0ZDg3OAptYWtlWzFdOiAqKiogW2RvY2tlci1y
dW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC1nMGp6b210by9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3
QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTQ4LjM5MnMKdXNlciAgICAwbTguMDczcwoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3
MDMwOTI4NTMuMTQ0ODU4Mi0xLW93ZW4uc2lAdWNsb3VkLmNuL3Rlc3RpbmcuZG9ja2VyLW1pbmd3
QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

