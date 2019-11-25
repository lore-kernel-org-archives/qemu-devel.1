Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A41A2075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A41A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDlB-0003BB-4d
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iZDjj-0002Hy-Lw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iZDjh-00062R-IN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:45:02 -0500
Resent-Date: Mon, 25 Nov 2019 07:45:02 -0500
Resent-Message-Id: <E1iZDjh-00062R-IN@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iZDjh-00061o-A6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574685860; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WRYCqHnTM4WCpJZqyJqZctTpfCWx70zQ63xQzTRg6PUeLLYRtC1BKJqFY7yERBLc3AsmC6E8KrWfAhVejFxhwkQ1mImuMKlArdgr0ksNk7vZgmDkuT0T7POt82GFhj9kJAyhDKtC2/bivB5wqDCfA1/n7EbkswUB17G3AMzPHoo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574685860;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=H75dw3T3YO+3WEOyRH04ALoALXvywNd1dgVup+EyNWU=; 
 b=WxbQ6ULfAq9mm3aKM9JYcAwLnYg2U179o85uOGOZ1CJbnx9Y3jukn7Gb2Bw6x11gJ/MpMrOmlcoihWJu/SPGjrcA/gcRPtr76Xbi6X8GHrzYQ6Cpa9WUWXGvE5k2SKEGcWhbPU8eRkMNZz0iHVDfD2jJcqQfpreUM0jAD9kjNGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574685859337629.8189844173243;
 Mon, 25 Nov 2019 04:44:19 -0800 (PST)
In-Reply-To: <20191125120548.13589-1-yury-kotov@yandex-team.ru>
Subject: Re: [PATCH] migration/ram: Yield periodically to the main loop
Message-ID: <157468585803.7001.1149674053320313211@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yury-kotov@yandex-team.ru
Date: Mon, 25 Nov 2019 04:44:19 -0800 (PST)
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyNTEyMDU0OC4xMzU4
OS0xLXl1cnkta290b3ZAeWFuZGV4LXRlYW0ucnUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVz
dGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIg
aW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19F
TlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGlv
dGVzdC1xY293MjogMjY4CkZhaWx1cmVzOiAyNjcKRmFpbGVkIDEgb2YgMTA4IGlvdGVzdHMKbWFr
ZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3IgMQpUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5Iiwg
bGluZSA2NjIsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD00ZDZiMjJlNTJhMjU0NjQ3OTJhY2U5OGI2YWFmM2Ji
MScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BU
Uz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hP
V19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWRwNncyOGs3L3NyYy9kb2NrZXItc3Jj
LjIwMTktMTEtMjUtMDcuMzEuMDkuNzYxNDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50
b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9NGQ2YjIyZTUyYTI1NDY0NzkyYWNlOThiNmFhZjNiYjEKbWFrZVsxXTogKioqIFtkb2Nr
ZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtZHA2dzI4azcvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1x
dWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEzbTguODUycwp1c2VyICAgIDBtOC41MzZz
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDE5MTEyNTEyMDU0OC4xMzU4OS0xLXl1cnkta290b3ZAeWFuZGV4LXRlYW0ucnUvdGVzdGluZy5k
b2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


