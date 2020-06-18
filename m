Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A087C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4D3208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4D3208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm02i-0005Dm-6v
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jm01n-0004GJ-QW
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:16:47 -0400
Resent-Date: Thu, 18 Jun 2020 15:16:47 -0400
Resent-Message-Id: <E1jm01n-0004GJ-QW@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jm01l-0000WM-3B
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592507766; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=R9oTIGKxo7E3RCmW6Rpwi2xBq65TybTJq5o7AEz0eS1RZv/jIVOCzCUDeWN8XgAGRhbccICBsVv0QHeh7//reOg2TDeJIr3PB0sGHxhkhZja0BCt6bboyCnp5rxrqBSlHBM5Nl3UqZtGHiKEZlnbCtcEokl6yK7L+PgCaJt4nlE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592507766;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xjsdSUPbx1XsBBQtNboU9DIQwy5PrL9zT/cRXe9MCuM=; 
 b=QFEMvYQeEtGMPmCzXkLJ2d/oaKGSbLFTcYYThPF9wGgwKgBzi5+iyvQ/+ZKFlug6LJ8PcQS4NOHITNjGMYo8gn+c5RMUN2iYamDcjKDYEM08jC5deuQfFbxp6RFaQwLZqVu/XvuXV1K9mOQJfPhLyZKLWqGQF4B/d8u45M/jTlM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592507763018990.8603663158017;
 Thu, 18 Jun 2020 12:16:03 -0700 (PDT)
Message-ID: <159250776071.26237.5385423157011529910@d1fd068a5071>
Subject: Re: [RFC v6 0/4] QEMU cpus.c refactoring
In-Reply-To: <20200618190401.4895-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cfontana@suse.de
Date: Thu, 18 Jun 2020 12:16:03 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 12:45:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, r.bolshakov@yadro.com,
 haxm-team@intel.com, colin.xu@intel.com, pbonzini@redhat.com,
 sunilmut@microsoft.com, rth@twiddle.net, philmd@redhat.com, cfontana@suse.de,
 wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxODE5MDQwMS40ODk1
LTEtY2ZvbnRhbmFAc3VzZS5kZS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYmFja2Vu
ZHMvcm5nLWJ1aWx0aW4ubwogIENDICAgICAgYmFja2VuZHMvaG9zdG1lbS5vCi90bXAvcWVtdS10
ZXN0L3NyYy9kbWEtaGVscGVycy5jOiBJbiBmdW5jdGlvbiAnZG1hX2Jsa19jYic6Ci90bXAvcWVt
dS10ZXN0L3NyYy9kbWEtaGVscGVycy5jOjE1NDoyMDogZXJyb3I6ICd1c2VfaWNvdW50JyB1bmRl
Y2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAxNTQgfCAgICAgICAgIGlmICht
ZW0gJiYgdXNlX2ljb3VudCAmJiBkYnMtPmRpciA9PSBETUFfRElSRUNUSU9OX0ZST01fREVWSUNF
KSB7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qv
c3JjL2RtYS1oZWxwZXJzLmM6MTU0OjIwOiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmll
ciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgpt
YWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGRtYS1oZWxwZXJzLm9d
IEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tl
ci5weSIsIGxpbmUgNjY5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NF
cnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5k
ICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9NTUyMTYxOTc5ZmEyNDYxMjkzODE0OGY3OTU4ZmI0YTgnLCAnLXUnLCAnMTAw
MycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScs
ICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9
JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2Fj
aGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC00Njl5Z3Q0bi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA2LTE4LTE1
LjEyLjQxLjE3NTM1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTU1MjE2MTk3
OWZhMjQ2MTI5MzgxNDhmNzk1OGZiNGE4Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LTQ2OXlndDRuL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBF
cnJvciAyCgpyZWFsICAgIDNtMTguNDYzcwp1c2VyICAgIDBtOC4xNTNzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYxODE5MDQwMS40
ODk1LTEtY2ZvbnRhbmFAc3VzZS5kZS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

