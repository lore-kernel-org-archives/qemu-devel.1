Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87C5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4C6206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4C6206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7BH-0004d3-RJ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jw7AS-0003Nr-7y
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:55:32 -0400
Resent-Date: Thu, 16 Jul 2020 12:55:32 -0400
Resent-Message-Id: <E1jw7AS-0003Nr-7y@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jw7AP-0003wb-MN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594918506; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FEy+hydaowoyMr2Kvl79TJZokijwKtJYpsT40oATM9GiEQFJHeJmtBY7HpdNV86SxQDesKaRs5PQAuTPqllRnVYYzHqFthkWAFN0R8qFAwtzRLH1mjKzZKA0VBmqYiUN6eAJb2qgOh9pA8BQPsPk0cTsDqLCA2XyVx1N4/7AscI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594918506;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oguoznBU5jYt0K1LGoHKmkW0K+27RiGjwJrIkcVhLeo=; 
 b=JGiHj2tmrFP2ZTmIqB7Wew64InpxXYk4h18uvcnf8i2Ci0aZixIqzmfGs/KE3ly0RKUBFPFToO7gui6cyBbqYYc+xEBbHzugJddjiWKgDkYt08oWFISY1BOuerkKww5vP/2Iz1xgSYKpIl+bzEYGdtLyB5aLhb+MjGnBeP6xRhk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594918501055356.1654493265838;
 Thu, 16 Jul 2020 09:55:01 -0700 (PDT)
Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
Message-ID: <159491849925.9423.8070197069187026249@07a7f0d89f7d>
In-Reply-To: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thanos.makatos@nutanix.com
Date: Thu, 16 Jul 2020 09:55:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 12:55:26
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
Cc: benjamin.walker@intel.com, elena.ufimtseva@oracle.com, felipe@nutanix.com,
 jag.raman@oracle.com, james.r.harris@intel.com, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, yuvalkashtan@gmail.com, konrad.wilk@oracle.com,
 tina.zhang@intel.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 marcandre.lureau@redhat.com, ismael@linux.com, alex.williamson@redhat.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, tomassetti.andrea@gmail.com,
 changpeng.liu@intel.com, raphael.norwitz@nutanix.com,
 Kanth.Ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk0OTEzNTAzLTUyMjcxLTEt
Z2l0LXNlbmQtZW1haWwtdGhhbm9zLm1ha2F0b3NAbnV0YW5peC5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBm
aW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBo
YXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2Fs
bHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14
ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRv
Y2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIGJsb2NrL3FhcGkubwogIENDICAgICAgYmxvY2svZmlsZS13aW4zMi5v
CgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy9kZXZl
bC92ZmlvLW92ZXItc29ja2V0LnJzdDoyODE6TWFsZm9ybWVkIHRhYmxlLgoKKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0rCi0t
LQogIENDICAgICAgY3J5cHRvL2htYWMubwogIENDICAgICAgY3J5cHRvL2htYWMtbmV0dGxlLm8K
ICBDQyAgICAgIGNyeXB0by9kZXNyZmIubwptYWtlOiAqKiogW01ha2VmaWxlOjEwOTA6IGRvY3Mv
ZGV2ZWwvaW5kZXguaHRtbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hl
ZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90
ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA3MDgsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFp
c2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9j
ZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFi
ZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD03MzlhODBmODVlOTE0NmQ1OWUzODI2ZjBkNjNk
YWE2YycsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5l
ZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVf
T1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAn
U0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9o
b21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZ3d0cW0zbHkvc3JjL2RvY2tlci1z
cmMuMjAyMC0wNy0xNi0xMi41MS41NS44MjYzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2Zl
ZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16
ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5j
ZS51dWlkPTczOWE4MGY4NWU5MTQ2ZDU5ZTM4MjZmMGQ2M2RhYTZjCm1ha2VbMV06ICoqKiBbZG9j
a2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLWd3dHFtM2x5L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3Qt
bWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDNtNC45MzlzCnVzZXIgICAgMG04LjcxNnMK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1
OTQ5MTM1MDMtNTIyNzEtMS1naXQtc2VuZC1lbWFpbC10aGFub3MubWFrYXRvc0BudXRhbml4LmNv
bS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

