Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19B0C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FF1239D4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FF1239D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKYbc-0006Jd-3r
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 23:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKYZk-0005HQ-Rl
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:02:40 -0400
Resent-Date: Mon, 21 Sep 2020 23:02:40 -0400
Resent-Message-Id: <E1kKYZk-0005HQ-Rl@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKYZf-0005tP-9R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600743746; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NpywanoXSg4E1GO4CUfFe9gEjrftqSVkeF4fiVAI7kfiyrjZ9h8/pSyz2PeKHQreMFYZWC4c2BMReCUjcvGNW91peT0c4YNxL8YdsKYFNO1WMjI5eaqMvko89QTlr6X3/Ygwyac0fPYnOyzGIgx8lnTaEt1DRWoeW73YY08eeu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600743746;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9107to9E/IcweaD59MgXDrlOirGWB0U2NKDzUCUsNKU=; 
 b=jSDYGcht/wtuQBL1mG1mcS9k5DO+GqB37AEnxCSL9KY0FdUVNTDsb4yQKbudVmxcFXoA9wL5/z2jPBVGk5MU3CmGKFwi0hClFPoWGod1J2SwVlk7JjxkjhT/a0VVtWmqiQLMCP56TJhUJaH3os2FUeJElnH2HzBMcOKAiEftjbI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600743745264697.9446707519894;
 Mon, 21 Sep 2020 20:02:25 -0700 (PDT)
Subject: Re: [PATCH 00/24] qom: Convert some properties to class properties
Message-ID: <160074374391.23987.9192777371902564218@66eaa9a8a123>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Mon, 21 Sep 2020 20:02:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 23:02:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMTIyMTA0NS42OTk2
OTAtMS1laGFia29zdEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkMgbGlua2VyIGZvciB0aGUg
aG9zdCBtYWNoaW5lOiBjYyBsZC5iZmQgMi4yNy00MwpIb3N0IG1hY2hpbmUgY3B1IGZhbWlseTog
eDg2XzY0Ckhvc3QgbWFjaGluZSBjcHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6MTA6IFdB
Uk5JTkc6IE1vZHVsZSB1bnN0YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJk
cyBjb21wYXRpYmlsaXR5IGFuZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQ
cm9ncmFtIHNoIGZvdW5kOiBZRVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmlu
L3B5dGhvbjMpCkNvbmZpZ3VyaW5nIG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9uCi0tLQpS
dW5uaW5nIHRlc3QgcXRlc3QteDg2XzY0OiBxb3MtdGVzdApCcm9rZW4gcGlwZQouLi9zcmMvdGVz
dHMvcXRlc3QvbGlicXRlc3QuYzoxNzU6IGtpbGxfcWVtdSgpIGRldGVjdGVkIFFFTVUgZGVhdGgg
ZnJvbSBzaWduYWwgNyAoQnVzIGVycm9yKSAoY29yZSBkdW1wZWQpCkVSUk9SIHF0ZXN0LXg4Nl82
NDogZGV2aWNlLWludHJvc3BlY3QtdGVzdCAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCA2
LCBnb3QgNSkKbWFrZTogKioqIFtydW4tdGVzdC0xNTFdIEVycm9yIDEKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KCkxvb2tpbmcgZm9yIGV4cGVjdGVkIGZpbGUgJ3Rl
c3RzL2RhdGEvYWNwaS9taWNyb3ZtL0ZBQ1AnCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tcm0nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPTEwMTJlZTkyMjY0OTQwNjk4YTllY2U0ODMyOWIyMDcyJywgJy11
JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2Fj
aGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1oMmlmYmRjdi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA5LTIxLTIy
LjU1LjAwLjE2NjI1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0xMDEyZWU5
MjI2NDk0MDY5OGE5ZWNlNDgzMjliMjA3MgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1oMmlmYmRjdi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczdd
IEVycm9yIDIKCnJlYWwgICAgN20yMi42NDdzCnVzZXIgICAgMG0yMC4xNDlzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyMTIyMTA0
NS42OTk2OTAtMS1laGFia29zdEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRv
czcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

