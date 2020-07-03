Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E24EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAFB208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAFB208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPL5-0003P4-5i
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrOyp-00085S-CM; Fri, 03 Jul 2020 12:56:03 -0400
Resent-Date: Fri, 03 Jul 2020 12:56:03 -0400
Resent-Message-Id: <E1jrOyp-00085S-CM@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrOym-0006OC-Dj; Fri, 03 Jul 2020 12:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593795330; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AdBQ9mu/G51AWDU2nqZQGhPD2Bf50kCJrPjy3D3qP+H+FuUk7PaQ3enNJXrQ7WGS5GVD0lGvNmXeJ6oYVJtsfk/MLxqeNbpx4IEQggcbTQAJN0J9lkPzR9ByihItFlCUyNFymcEJO1lMwlMcfjRUxvCPxwrxIxY2h0XzxR/X63s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593795330;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=jHLUq4nklKz5CV1SvfvpkTLwdi59eJlIYmIiyx8er3I=; 
 b=Nm+lFkrQeXmnaVFVgPmcnMnovdqXz0qnFUIOb/Rt6IE7QcRUkgHf3tqp5PtkUXn63+rsvRT/UMuzuT0H04GBGwntPenKY7aSjZjL10AYF5cBrf4o8ZDU8RMSujv5uBvDMr58Lt89+3ASfH28iLC4pHgQMp07r14VYnhDHl5qz3g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593795328871558.9702491950661;
 Fri, 3 Jul 2020 09:55:28 -0700 (PDT)
Message-ID: <159379532700.15570.9794737415308742510@d1fd068a5071>
Subject: Re: [PATCH v6 0/7] block: seriously improve savevm/loadvm performance
In-Reply-To: <20200703161130.23772-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: den@openvz.org
Date: Fri, 3 Jul 2020 09:55:28 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 12:55:53
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, dplotnikov@virtuozzo.com, stefanha@redhat.com,
 den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMzE2MTEzMC4yMzc3
Mi0xLWRlbkBvcGVudnoub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAtLSAgICAgICAgc25hcDAgICAgICAg
ICAgICAgICAgICBTSVpFIHl5eXktbW0tZGQgaGg6bW06c3MgICAwMDowMDowMC4wMDAKIChxZW11
KSBsb2Fkdm0gc25hcDAKK05vdCBhIG1pZ3JhdGlvbiBzdHJlYW0KK0Vycm9yOiBFcnJvciAtMjIg
d2hpbGUgbG9hZGluZyBWTSBzdGF0ZQogKHFlbXUpIHF1aXQKIAogRm9ybWF0dGluZyAnVEVTVF9E
SVIvdC5JTUdGTVQnLCBmbXQ9SU1HRk1UIHNpemU9MTM0MjE3NzI4IGJhY2tpbmdfZmlsZT1URVNU
X0RJUi90LklNR0ZNVC5iYXNlCi0tLQpOb3QgcnVuOiAyNTkKRmFpbHVyZXM6IDI2NwpGYWlsZWQg
MSBvZiAxMTkgaW90ZXN0cwptYWtlOiAqKiogW2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBF
cnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAg
ICBjaGVjay1xdGVzdC1hYXJjaDY0OiB0ZXN0cy9xdGVzdC9xb3MtdGVzdApUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD04MzNiNTkzMjM2YzU0OWNmYWZmMDk2NTU2NDY3MTY4YicsICctdScsICcxMDAzJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC15NWlzeG93Zy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTAzLTEyLjM3LjQ5
LjMyNTA2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVt
dS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpm
aWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04MzNiNTkzMjM2YzU0
OWNmYWZmMDk2NTU2NDY3MTY4YgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFr
ZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15NWlz
eG93Zy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9y
IDIKCnJlYWwgICAgMTdtMzguMjQ0cwp1c2VyICAgIDBtOC44MDNzCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcwMzE2MTEzMC4yMzc3
Mi0xLWRlbkBvcGVudnoub3JnL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

