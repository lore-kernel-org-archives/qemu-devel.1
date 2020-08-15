Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6153CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366E623B18
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 16:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366E623B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yoS-0006cN-EB
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6ynb-0005sK-1C
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:12:51 -0400
Resent-Date: Sat, 15 Aug 2020 12:12:51 -0400
Resent-Message-Id: <E1k6ynb-0005sK-1C@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6ynY-0002zT-O1
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 12:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597507961; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WPzMIOIqFqoeAqwZvtLWYwZ0v4zaOYRiBeUmAQqv/5lJUjZZCbOAWg6xS+1nZDeXHKKqO0urr+WUMmMO6F12tuaE4IAbTetGGP0dx48h9o1mneKhkLHdgi7WXhVDWxC0VOumvqXNMV7Qer+aDo6NvkhNao1GbDO3UuyWZVs7nnE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597507961;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=o1hhBVGyw+mcD9ciLCYu3znqkNHCmihSuRAkD9UCbZo=; 
 b=bFbvCPMwrBZZezbFFItH3MNQtYW4Dkf+xcWEakti2EJNgFkxtz7RQUuoeK5BxFH/qo/uSIb6xx0nQwXv46JHXrZ+IKjsTou1iRsaiaUYVDqrNMzMNPwqRa336TKKyH6Psn4fX0K86CrJhIcodHq4iqRyzFuVZXNTW5eNOjWwgqA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597507959525169.8270167022025;
 Sat, 15 Aug 2020 09:12:39 -0700 (PDT)
Subject: Re: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
Message-ID: <159750795847.7155.1670749874930682593@66eaa9a8a123>
In-Reply-To: <20200815151148.10571-1-rohit.shinde12194@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rohit.shinde12194@gmail.com
Date: Sat, 15 Aug 2020 09:12:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 11:03:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: rohit.shinde12194@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNTE1MTE0OC4xMDU3
MS0xLXJvaGl0LnNoaW5kZTEyMTk0QGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
cWFwaS9xYXBpLXR5cGVzLXRyYW5zYWN0aW9uLm8KICBDQyAgICAgIHFhcGkvcWFwaS1idWlsdGlu
LXZpc2l0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3FhcGkvb3B0cy12aXNpdG9yLmM6IEluIGZ1bmN0
aW9uICdvcHRzX25leHRfbGlzdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9xYXBpL29wdHMtdmlzaXRv
ci5jOjI2OTo5OiBlcnJvcjogZW1wdHkgZGVjbGFyYXRpb24gWy1XZXJyb3JdCiAgICAgICAgIF9f
YXR0cmlidXRlX18oKGZhbGx0aHJvdWdoKSk7CiAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFtxYXBpL29wdHMtdmlzaXRvci5vXSBF
cnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIu
cHkiLCBsaW5lIDcwOSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPWNiYWVkOWUwYmFmOTRiYTlhZGZkMDY3ZmM4OWQ3ZGYyJywgJy11JywgJzEwMDEn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtYjB6eGo3eWcvc3JjL2RvY2tlci1zcmMuMjAyMC0wOC0xNS0xMi4x
MC40MS40MzE0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90bXAv
cWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAy
LgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1jYmFlZDllMGJh
Zjk0YmE5YWRmZDA2N2ZjODlkN2RmMgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEK
bWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1i
MHp4ajd5Zy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVy
cm9yIDIKCnJlYWwgICAgMW01Ny44ODVzCnVzZXIgICAgMG02LjUyOHMKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwODE1MTUxMTQ4LjEw
NTcxLTEtcm9oaXQuc2hpbmRlMTIxOTRAZ21haWwuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNl
bnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

