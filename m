Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1336DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C44205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 03:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C44205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ4Ma-0004Zh-0y
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 23:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZ4Lv-0003zg-53; Wed, 13 May 2020 23:16:07 -0400
Resent-Date: Wed, 13 May 2020 23:16:07 -0400
Resent-Message-Id: <E1jZ4Lv-0003zg-53@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZ4Lt-0001Ay-4E; Wed, 13 May 2020 23:16:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589426157; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m6F7ykJPUzNAjAOjgjGeuBFCx/vAY5RT9WMjRvVpU1i6RhX2jPx/6CqCdy3cQD82LckSMEEtHOvQyOubFHV82+jCX6Y4fXKjh1G0ZyirBubhxm0Jwp1HC91ynOoOe07qfw9Lf3m5LuD2ZbJmreONG5LiqfbXWyvWrLKgVDMD+u4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589426157;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7CPP4Tnz4aCyNCyF9gkIXdHMqtGAFglxYCVrSuUnazg=; 
 b=NgNWAXOw6Q+Ven5UMGqPsjyzDgXgA5mAODjb+/h/mCDTfQOJ1yIDVX5ryTeSJfBJzgLmZeKvVPsdYqPGsPGN9z/BNNGJ2ZJSkvicWiFkhg/amltO00+/PaF+/rXf20rIiIGKW9nAnlvOl1E/sD077IVqSpM7uiDZN4FWjwkyEwE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589426155109113.05932443140523;
 Wed, 13 May 2020 20:15:55 -0700 (PDT)
Message-ID: <158942615362.13639.13165785285862563463@45ef0f9c86ae>
In-Reply-To: <20200513214130.15375-1-jsnow@redhat.com>
Subject: Re: [PATCH RFC WIP 0/6] iotests: delinting work-in-progress
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Wed, 13 May 2020 20:15:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 23:16:01
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMzIxNDEzMC4xNTM3
NS0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKTm90IHJ1bjogMjU5CkZhaWx1cmVz
OiAwMzEgMDM2IDA1NCAwNjEgMTE0CkZhaWxlZCA1IG9mIDExOCBpb3Rlc3RzCm1ha2U6ICoqKiBb
Y2hlY2stdGVzdHMvY2hlY2stYmxvY2suc2hdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9y
IHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGNoZWNrLXF0ZXN0LWFhcmNoNjQ6IHRlc3Rz
L3F0ZXN0L3Fvcy10ZXN0ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWEzNjRhMzkxNmIzMDQ4NTQ4ODdlNGI3
NDc1MTc1MzgzJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW43M2loeHU2L3NyYy9k
b2NrZXItc3JjLjIwMjAtMDUtMTMtMjMuMDAuMDYuMzE2NzM6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPWEzNjRhMzkxNmIzMDQ4NTQ4ODdlNGI3NDc1MTc1MzgzCm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW43M2loeHU2L3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxNW00Ny4yMTNzCnVzZXIg
ICAgMG01LjM2MXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwNTEzMjE0MTMwLjE1Mzc1LTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5n
LmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

