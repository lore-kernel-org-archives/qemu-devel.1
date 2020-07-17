Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F6FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382482070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382482070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOsn-00038Q-GA
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jwOs4-0002O7-LG; Fri, 17 Jul 2020 07:49:44 -0400
Resent-Date: Fri, 17 Jul 2020 07:49:44 -0400
Resent-Message-Id: <E1jwOs4-0002O7-LG@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jwOs2-0000wI-C9; Fri, 17 Jul 2020 07:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594986577; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PFmu9hFXff030u23QUTqtCrin75Of3o17A3qe+Ec/7AHv/EPpR24F/tFqDKw8jwQGZwJSOv2PUTUAyWmZ4C+au8JDXcp3qIhkT/SE7eSTOEDnMnmpiRW71oDoVVuVOdx1BBZKh3v7rzk7eGbX5N578KvvubOyZQwQVTX2uW5+Ic=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594986577;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9eG3744AlcOTI3aaMF01+ExUc2KJPwrqBOhZ809N+x4=; 
 b=dL7De26uF/zYX7UNK2EFMwIkirF4o/eeL7dvfGvV5AHDAZ2fADNA746Km9LY6bpURxf+zBQBiCcIVk9nfkB+fn9qXVqwX4FH1IAIhbllI5QRKJAY8qobctS7DXanJosuCiprAgOwrAK7AKX/aYVIezi9yclq55J/YQ80qcgE6Y8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594986573231289.855907786329;
 Fri, 17 Jul 2020 04:49:33 -0700 (PDT)
Subject: Re: [PATCH for-5.1 0/3] file-posix: Fix check_hdev_writable() with
 auto-read-only
Message-ID: <159498657216.17162.3061554083998112738@07a7f0d89f7d>
In-Reply-To: <20200717105426.51134-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwolf@redhat.com
Date: Fri, 17 Jul 2020 04:49:33 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 06:26:56
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNzEwNTQyNi41MTEz
NC0xLWt3b2xmQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNrLXF0ZXN0
LXg4Nl82NDogdGVzdHMvcXRlc3QvcW1wLXRlc3QKICBURVNUICAgIGNoZWNrLXF0ZXN0LXg4Nl82
NDogdGVzdHMvcXRlc3QvcW1wLWNtZC10ZXN0CioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90
ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjk3OmluaXRfc29ja2V0OiBhc3NlcnRpb24gZmFpbGVkIChy
ZXQgIT0gLTEpOiAoLTEgIT0gLTEpCkVSUk9SIHFtcC1jbWQtdGVzdCAtIEJhaWwgb3V0ISBFUlJP
UjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzo5Nzppbml0X3NvY2tl
dDogYXNzZXJ0aW9uIGZhaWxlZCAocmV0ICE9IC0xKTogKC0xICE9IC0xKQptYWtlOiAqKiogW2No
ZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hl
ZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwODAKICBURVNUICAgIGlvdGVzdC1x
Y293MjogMDg2Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkK
c3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdk
b2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1mYzM0NjNh
MTdjZWE0NTRjOWEwZmNkNDcyMzU4ZGI0ZicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0
JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICct
ZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICct
ZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1jM2J6emJ0OC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTE3LTA3LjM0LjQxLjI4MTgyOi92YXIv
dG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVz
dC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0
ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1mYzM0NjNhMTdjZWE0NTRjOWEwZmNkNDcy
MzU4ZGI0ZgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmlu
ZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1jM2J6emJ0OC9zcmMnCm1h
a2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAg
MTRtNTEuMDY1cwp1c2VyICAgIDBtOC45NzhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcxNzEwNTQyNi41MTEzNC0xLWt3b2xmQHJl
ZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

