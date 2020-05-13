Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44741C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 00:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F6A206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 00:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F6A206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYf4s-0002aK-B9
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 20:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYf4D-0002Ad-Ni; Tue, 12 May 2020 20:16:09 -0400
Resent-Date: Tue, 12 May 2020 20:16:09 -0400
Resent-Message-Id: <E1jYf4D-0002Ad-Ni@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYf4C-0007rq-Nt; Tue, 12 May 2020 20:16:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589328953; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RPtwe7dQU0XfOldKNj7hWnlqrW/m39H/zVJqlTyz9B0U4aM75CWTkjcSijV+lqkR7OQ9EtisWPsxgPnZzKG7D3FiAZL5Aj5gNO6e0kkR2te7pjOCjatGNhWrAzSs7W87QV/DJ6joFbddfjQtgtAgubltQtKPZSG17cO4sAmHAYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589328953;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=UrPnoAI8hsHLFmhxKabK5wAnXf+QQkvquXbvP3iqz+g=; 
 b=e3myr4tXq/i1TXXNcWaBtecdhIh4r0XiMZOc8RuOonoy9uCm/9vEiD4Jb2fLqEZ84s89CLX8C78wef0Bd1QgGv68+Q1NsGE5VWkyfTXPVnG7Zq3leBk5uomr6KtYwgVQVxbuTgEvVlwUHutCr/UOyM0E+/buu7GtzIX28ahXNcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158932895212610.50313110251534;
 Tue, 12 May 2020 17:15:52 -0700 (PDT)
Message-ID: <158932895046.9905.1233556357517458199@45ef0f9c86ae>
In-Reply-To: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v4 00/15] Apply COR-filter to the block-stream permanently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Tue, 12 May 2020 17:15:52 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 19:44:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5MzAyMjQ1LTg5MzI2OS0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQg
QVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKICBDQyAgICAgIG9zLXdpbjMyLm8KICBDQyAgICAgIG1vbml0b3IvbW9uaXRv
ci5vCiAgQ0MgICAgICBtb25pdG9yL3FtcC5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9jb3B5
LW9uLXJlYWQuYzoyOToxMDogZmF0YWwgZXJyb3I6IGJsb2NrL2NvcHktb24tcmVhZC5oOiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSAiYmxvY2svY29weS1vbi1yZWFkLmgiCiAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCm1h
a2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogYmxvY2svY29weS1vbi1y
ZWFkLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
L3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3N0cmVhbS5jOjIyOjEwOiBmYXRhbCBlcnJvcjogYmxv
Y2svY29weS1vbi1yZWFkLmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRlICJi
bG9jay9jb3B5LW9uLXJlYWQuaCIKICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY29t
cGlsYXRpb24gdGVybWluYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMu
bWFrOjY5OiBibG9jay9zdHJlYW0ub10gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGlu
IDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vz
c0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1h
bmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUu
aW5zdGFuY2UudXVpZD1iMmExOWUwMzZhNTY0OWFkYmRkYmVhMDRkYjhiMTUwOScsICctdScsICcx
MDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1l
JywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAn
Vj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1l
JywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW9zOHRkOGNrL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMTIt
MjAuMTQuMTIuMTgyNTI6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YjJhMTll
MDM2YTU2NDlhZGJkZGJlYTA0ZGI4YjE1MDkKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtb3M4dGQ4Y2svc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFd
IEVycm9yIDIKCnJlYWwgICAgMW0zOC44MjFzCnVzZXIgICAgMG04LjEzOHMKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1ODkzMDIyNDUtODkz
MjY5LTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbS90ZXN0
aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

