Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E674FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FD5206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FD5206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8q4r-0007He-2n
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 15:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8q3j-0006ZG-Di; Thu, 20 Aug 2020 15:17:11 -0400
Resent-Date: Thu, 20 Aug 2020 15:17:11 -0400
Resent-Message-Id: <E1k8q3j-0006ZG-Di@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8q3h-00080P-6l; Thu, 20 Aug 2020 15:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597951009; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FkJSNa9JEUV3taZopNDndq7coNCYhIr9zAxNVcWyquiyCGBoNkUAMjIuNxUfrP7e4llySMhkSlXS3Rk8xSTff9F5a8KDmu06A2H7ALUmHBDfNpf3bfv1UIykk9iWfe0R+Y4TO2ky+2s7jjlbdo+03IvhZ0cCBI7m3KZFCKo8QYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597951009;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=r490VO639iSmS+QAe9aj/gqEqjCo345x4pUUdaQu1kg=; 
 b=ilp72mJe50p8twdJ1Bq4xkvIVMSmhkSssCBnGFs2gkJrkIailN6TsPK1FPsDVH8hyrUDMp/e6ZFWBP9GORTQUDYiAeiIPOcK1Bj3qjSESAbAjpS+c1YLMf3ENfP0jXVImXlDjFl2ZiIHIUS+OCNzsqitpxUEdYvma3EXQh0xaZ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597951005859399.26201885069224;
 Thu, 20 Aug 2020 12:16:45 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] preallocate filter
Message-ID: <159795100412.10087.13324527849844486009@66eaa9a8a123>
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Thu, 20 Aug 2020 12:16:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 15:17:05
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgyMDE4Mzk1MC4xMzEw
OS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hl
Y2stdW5pdDogdGVzdHMvdGVzdC1jaGFyClVuZXhwZWN0ZWQgZXJyb3IgaW4gb2JqZWN0X3Byb3Bl
cnR5X3RyeV9hZGQoKSBhdCAvdG1wL3FlbXUtdGVzdC9zcmMvcW9tL29iamVjdC5jOjExODE6CmF0
dGVtcHQgdG8gYWRkIGR1cGxpY2F0ZSBwcm9wZXJ0eSAnc2VyaWFsLWlkJyB0byBvYmplY3QgKHR5
cGUgJ2NvbnRhaW5lcicpCkVSUk9SIHRlc3QtY2hhciAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBl
Y3RlZCAzOCwgZ290IDkpCm1ha2U6ICoqKiBbY2hlY2stdW5pdF0gRXJyb3IgMQptYWtlOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAw
MTgKICBURVNUICAgIGlvdGVzdC1xY293MjogMDE5Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vz
c0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1h
bmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUu
aW5zdGFuY2UudXVpZD1hODBmMDUxNjM5NGU0ZDgzYjE5YTE5ZTMyOTg5OWMxNycsICctdScsICcx
MDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1l
JywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAn
Vj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICct
ZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1uX2EydjViai9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4LTIw
LTE1LjAwLjMxLjEyOTg3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zh
ci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0
YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hODBm
MDUxNjM5NGU0ZDgzYjE5YTE5ZTMyOTg5OWMxNwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVy
cm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC1uX2EydjViai9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRv
czddIEVycm9yIDIKCnJlYWwgICAgMTZtMTMuMTA1cwp1c2VyICAgIDBtOC44ODZzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgyMDE4
Mzk1MC4xMzEwOS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlj
a0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

