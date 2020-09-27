Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C686CC4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A0521775
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A0521775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMWoT-0004A7-6C
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 09:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMWnH-0002y5-HX
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:32:47 -0400
Resent-Date: Sun, 27 Sep 2020 09:32:47 -0400
Resent-Message-Id: <E1kMWnH-0002y5-HX@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMWnE-0006It-Vc
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:32:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601213550; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gbnSxqjZEmVlpD99uukAiVmt01tz2/9cbleJG9KWX4rbFhwR/e8Stdb/gmOLmrlFbfZ+Glul8TBWkC7WkkM2klJIBM4X6sTAvAdCnPvXzEOeJRvCeETQg2qZEqfBWxD2qbyQSoDjOO84KQgaX5RCzmHeMyQv5XB3bzKI8jwiTSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601213550;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=BmA12o1UMk0IDyEQiJsYfLN4QOUSDMaLXI30YQxntOs=; 
 b=lAWnaRZSHgm7anRi4UxNNyKhww6Cc1kob+47iMBetnxRTr0xnIqrddVS3n0bdazXi2EM3UiRa7Ynl1oBj1CZJ9Q48pqcREtZ1TSbPzlIOl+On74cpx+OBPveeI2EjVlrZYu6Pzaj1tBiMXjo6r0T9QRcp/d4QjHKybnsx08kIiM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601213548938579.4451964662943;
 Sun, 27 Sep 2020 06:32:28 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] block-backend: Introduce I/O hang
Message-ID: <160121354753.10465.12860399163784947908@66eaa9a8a123>
In-Reply-To: <20200927130420.1095-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fangying1@huawei.com
Date: Sun, 27 Sep 2020 06:32:28 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 09:27:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fangying1@huawei.com, mreitz@redhat.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNzEzMDQyMC4xMDk1
LTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQyBsaW5rZXIgZm9yIHRoZSBo
b3N0IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhvc3QgbWFjaGluZSBjcHUgZmFtaWx5OiB4
ODZfNjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWlsZDoxMDogV0FS
TklORzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRz
IGNvbXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClBy
b2dyYW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4v
cHl0aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tCkNv
bXBpbGluZyBDIG9iamVjdCBsaWJibG9jay5mYS5wL2Jsb2NrX2NvbW1pdC5jLm8KQ29tcGlsaW5n
IEMgb2JqZWN0IGxpYmJsb2NrLmZhLnAvYmxvY2tfdmhkeC1lbmRpYW4uYy5vCi4uL3NyYy9ibG9j
ay9ibG9jay1iYWNrZW5kLmM6IEluIGZ1bmN0aW9uICdibGtfbmV3JzoKLi4vc3JjL2Jsb2NrL2Js
b2NrLWJhY2tlbmQuYzozODY6NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0
aW9uICdhdG9taWNfc2V0JyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0K
ICAgICBhdG9taWNfc2V0KCZibGstPnJlaW5mby5pbl9mbGlnaHQsIDApOwogICAgIF4KLi4vc3Jj
L2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzozODY6NTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFy
YXRpb24gb2YgJ2F0b21pY19zZXQnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQouLi9zcmMvYmxv
Y2svYmxvY2stYmFja2VuZC5jOiBJbiBmdW5jdGlvbiAnYmxrX2RlbGV0ZSc6Ci4uL3NyYy9ibG9j
ay9ibG9jay1iYWNrZW5kLmM6NDc5OjU6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiAnYXRvbWljX3JlYWQnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0
aW9uXQogICAgIGFzc2VydChhdG9taWNfcmVhZCgmYmxrLT5yZWluZm8uaW5fZmxpZ2h0KSA9PSAw
KTsKICAgICBeCi4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6NDc5OjU6IGVycm9yOiBuZXN0
ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdhdG9taWNfcmVhZCcgWy1XZXJyb3I9bmVzdGVkLWV4
dGVybnNdCi4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6IEluIGZ1bmN0aW9uICdibGtfcmVo
YW5kbGVfaW5zZXJ0X2Fpb2NiJzoKLi4vc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoyNDU5OjU6
IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYXRvbWljX2luYycgWy1X
ZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgYXRvbWljX2luYygmYmxr
LT5yZWluZm8uaW5fZmxpZ2h0KTsKICAgICBeCi4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6
MjQ1OTo1OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYXRvbWljX2luYycg
Wy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6IElu
IGZ1bmN0aW9uICdibGtfcmVoYW5kbGVfcmVtb3ZlX2Fpb2NiJzoKLi4vc3JjL2Jsb2NrL2Jsb2Nr
LWJhY2tlbmQuYzoyNDY4OjU6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biAnYXRvbWljX2RlYycgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAg
ICAgYXRvbWljX2RlYygmYmxrLT5yZWluZm8uaW5fZmxpZ2h0KTsKICAgICBeCi4uL3NyYy9ibG9j
ay9ibG9jay1iYWNrZW5kLmM6MjQ2ODo1OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlv
biBvZiAnYXRvbWljX2RlYycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbbGliYmxvY2suZmEucC9ibG9j
a19ibG9jay1iYWNrZW5kLmMub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5p
c2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAi
Li90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA3MDksIGluIDxtb2R1bGU+Ci0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
cm0nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTM5OTUxZTA0YmYzYjQ4MDlh
NGFmZTU3NTVjYTc3MWY1JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29t
cD11bmNvbmZpbmVkJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTVxa2lrc3kxL3NyYy9kb2Nr
ZXItc3JjLjIwMjAtMDktMjctMDkuMjguMjAuNjk4NzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQg
bm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9Mzk5NTFlMDRiZjNiNDgwOWE0YWZlNTc1NWNhNzcxZjUKbWFrZVsxXTogKioq
IFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtNXFraWtzeTEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4t
dGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDRtNi43NTVzCnVzZXIgICAgMG0y
My4xMzlzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDkyNzEzMDQyMC4xMDk1LTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vdGVzdGluZy5k
b2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

