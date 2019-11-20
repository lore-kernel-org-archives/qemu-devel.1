Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A10C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 06:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A180222A0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 06:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A180222A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXJFS-00032c-2B
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 01:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iXJEL-0001yY-HY
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iXJEJ-0008PW-Ut
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:12:45 -0500
Resent-Date: Wed, 20 Nov 2019 01:12:45 -0500
Resent-Message-Id: <E1iXJEJ-0008PW-Ut@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iXJEJ-0008JJ-NR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 01:12:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574230332; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=THPaZlxu1zktlC4ZtGV6ss/ShoqN0NzemUZXQozCuaMyLRU0qI816dSh7gdSEyjV8GFMY2SASweCrnSj2QnG9322/9pa5Jfoy6kaFU5A/Zr3cqBzhN4NNNgFPQURKy3vA0pixRJ1IbEt4JyL+WzwUWMU4PBHXUps/8B5Gly3J6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574230332;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=A23mRzs35sk+Fvf9PHia0MhvUZRV57jxXhTMLrc0t64=; 
 b=aEG0XFpbmJZJYIE9TR7rPtbxhRPWgQgBYmkfg2CktadnKUHwz4iWyHKJgCpqYGAC/0nEtFidJPAJC/zIdHOetingzJLyarbFJVnJiaES4IWkBKcSOr8V/DIsVF6tapUXs/7Mqrx/QCv1CUC9WfUA6IVLL8go7KUlGtE3bbHzjog=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574230331496174.27800411362568;
 Tue, 19 Nov 2019 22:12:11 -0800 (PST)
In-Reply-To: <20191120005003.27035-1-mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] virtio-pci: disable vring processing when
 bus-mastering is disabled
Message-ID: <157423033042.2797.15950947649776190513@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mdroth@linux.vnet.ibm.com
Date: Tue, 19 Nov 2019 22:12:11 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: aik@ozlabs.ru, david@gibson.dropbear.id.au, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyMDAwNTAwMy4yNzAz
NS0xLW1kcm90aEBsaW51eC52bmV0LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVz
dGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIg
aW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19F
TlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNo
ZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtdGhyZWFkLXBvb2wKd2FpdF9mb3JfbWlncmF0aW9uX2ZhaWw6
IHVuZXhwZWN0ZWQgc3RhdHVzIHN0YXR1cz13YWl0LXVucGx1ZyBhbGxvd19hY3RpdmU9MQoqKgpF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvbWlncmF0aW9uLXRlc3QuYzo5MDg6d2FpdF9m
b3JfbWlncmF0aW9uX2ZhaWw6IGFzc2VydGlvbiBmYWlsZWQ6IChyZXN1bHQpCkVSUk9SIC0gQmFp
bCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9taWdyYXRpb24tdGVzdC5jOjkw
ODp3YWl0X2Zvcl9taWdyYXRpb25fZmFpbDogYXNzZXJ0aW9uIGZhaWxlZDogKHJlc3VsdCkKbWFr
ZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWhi
aXRtYXAKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtYmRydi1kcmFpbgotLS0KICAg
IHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVk
UHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICct
LWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Yzg2M2UxNTg4MmE3NDdhODhjMjkwNTc1
NTA1Y2MxZGUnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29u
ZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklH
VVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1l
JywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYn
LCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNo
ZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13ZzcwcmdwdS9zcmMvZG9j
a2VyLXNyYy4yMDE5LTExLTIwLTAxLjAyLjU3LjEyNDEyOi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5l
ZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUu
aW5zdGFuY2UudXVpZD1jODYzZTE1ODgyYTc0N2E4OGMyOTA1NzU1MDVjYzFkZQptYWtlWzFdOiAq
KiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC13ZzcwcmdwdS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1
bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgOW0xMy4yMzZzCnVzZXIgICAg
MG04LjEzMXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMTkxMTIwMDA1MDAzLjI3MDM1LTEtbWRyb3RoQGxpbnV4LnZuZXQuaWJtLmNvbS90
ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


