Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE9FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B692065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B692065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviT9-0003eF-Iy
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jviRI-0001aJ-VC; Wed, 15 Jul 2020 10:31:16 -0400
Resent-Date: Wed, 15 Jul 2020 10:31:16 -0400
Resent-Message-Id: <E1jviRI-0001aJ-VC@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jviRE-0004HL-9M; Wed, 15 Jul 2020 10:31:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594823444; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Qa5DlLoKcRvp7DDL1cvewIrg8Mb75mOFh2QJ6gg8Pij5mu79bjaglLcXNv9dRxBfzlvC1t9HTEqxRzuWCSX6z/pPwssqczjNg4ldarAtzGmWeiHdLo5pleL7irHZu8lT8t4v513g86tf32Mzj18nlN6P/JpwHRSFhTDqA7fqryM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594823444;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=42ypsgi6i5DCJBTN7oA8BzLiWtoxrZe0g0l7zXEch5A=; 
 b=Qz2gvIk7cTJV0VbAFukS6fB9K354Gmsb5OIK1z0BBsWbLZX2rdLdoFv+itozjTBaiqH01UN/JZv1mFv9WPmvu495B0GEXpDYgxchUMSPKRuuSvBnVuDzH9/KNUPyiMlE04Er6+GkBtcqfTpWvOxWrTwFqUXcQfZf4eh/O5NesSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594823432139854.7881832995865;
 Wed, 15 Jul 2020 07:30:32 -0700 (PDT)
Subject: Re: [PATCH for-5.1 0/2] Unbreak make check SPEED=slow
Message-ID: <159482343003.11884.10971114831473825396@07a7f0d89f7d>
In-Reply-To: <20200715140440.3540942-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Wed, 15 Jul 2020 07:30:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 10:31:06
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 alistair@alistair23.me, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 sundeep.lkml@gmail.com, b.galvani@gmail.com, nieklinnenbank@gmail.com,
 qemu-arm@nongnu.org, palmer@dabbelt.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNTE0MDQ0MC4zNTQw
OTQyLTEtYXJtYnJ1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKcWVtdS1zeXN0ZW0tYWFyY2g2
NDogZmFsbGluZyBiYWNrIHRvIHRjZwogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1j
aGFyCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWNoYXIuYzoxMjA0OmNo
YXJfc2VyaWFsX3Rlc3Q6ICdjaHInIHNob3VsZCBub3QgYmUgTlVMTApFUlJPUiB0ZXN0LWNoYXIg
LSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtY2hhci5jOjEy
MDQ6Y2hhcl9zZXJpYWxfdGVzdDogJ2Nocicgc2hvdWxkIG5vdCBiZSBOVUxMCm1ha2U6ICoqKiBb
Y2hlY2stdW5pdF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMjUKICBURVNUICAgIGlvdGVzdC1xY293Mjog
MDI3Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJv
Y2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXIn
LCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1hYTI4MzE0NDU0MGE0
ZDcwYmYzMDNmYjk1ZWUwNTYxOScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3Nl
Y2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdF
WFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdE
RUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2Nj
YWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1zbjZ2
X3RyMS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTE1LTEwLjE1LjM4LjE3Mjc3Oi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWlj
ayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFi
ZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hYTI4MzE0NDU0MGE0ZDcwYmYzMDNmYjk1ZWUwNTYx
OQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJl
Y3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1zbjZ2X3RyMS9zcmMnCm1ha2U6ICoq
KiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTRtNTIu
Nzg3cwp1c2VyICAgIDBtOC42NTBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcxNTE0MDQ0MC4zNTQwOTQyLTEtYXJtYnJ1QHJlZGhh
dC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

