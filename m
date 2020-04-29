Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F59C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 23:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA332072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 23:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA332072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTwLg-0006js-Bc
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 19:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTwKv-0006Fe-MQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 19:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTwKv-0005Wp-7Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 19:41:53 -0400
Resent-Date: Wed, 29 Apr 2020 19:41:53 -0400
Resent-Message-Id: <E1jTwKv-0005Wp-7Q@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTwKq-0005WN-A8; Wed, 29 Apr 2020 19:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588203701; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=allN+gRpT9uiJ+KvylKw/lq/lOx7n2K0ggw5/mlCuAOpuywFfYcacfEdHoCuYaky/3TwtVhFrma/Tu1HT9Ol/qIfspgizmq1s/Xxn0YXA5Fe03RvGZaA2Jz7/llaEOYewiV7/piiDFNrc/rlqydr5laiTvRyEo+8k6rTTZVcdQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588203701;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oyFlTthy4NhVins/CIbeVN7jXnEUVSBA2MF2IXZ4M1U=; 
 b=nn6xw8Xj47LvLD5r9wP8A+VgmpFHK15yWnnaXgXFjvborwwqmQ2vvj3U9I7zuVjLN1G7/wy3ZWl0O6UJPpwHLukXHTIiFCfeuhaT3k+cUceC20T5Rw195p01cTpDaw8L642Pt2o6qFHBGOjwqg0AM87O5nh/d2wnJnr3MyCqxnE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588203699307779.9078130320851;
 Wed, 29 Apr 2020 16:41:39 -0700 (PDT)
Message-ID: <158820369810.4471.18342264613010125476@45ef0f9c86ae>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
Subject: Re: [PATCH v2 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Wed, 29 Apr 2020 16:41:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 19:37:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyOTE0MTEyNi44NTE1
OS0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBM
SU5LICAgIHFlbXUtbmJkCiAgTElOSyAgICBxZW11LXN0b3JhZ2UtZGFlbW9uCiAgTElOSyAgICBx
ZW11LWlvCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6Mjc6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYmxrX25ld193aXRoX2JzJyBpcyBpbnZhbGlk
IGluIEM5OSBbLVdlcnJvciwtV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAg
IG9sZF9iYWNraW5nX2JsayA9IGJsa19uZXdfd2l0aF9icyhicywgQkxLX1BFUk1fV1JJVEUsIEJM
S19QRVJNX0FMTCwKICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3Ny
Yy9xZW11LWltZy5jOjEwNzE6Mjc6IGVycm9yOiB0aGlzIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGlz
IG5vdCBhIHByb3RvdHlwZSBbLVdlcnJvciwtV3N0cmljdC1wcm90b3R5cGVzXQovdG1wL3FlbXUt
dGVzdC9zcmMvcWVtdS1pbWcuYzoxMDcxOjI1OiBlcnJvcjogaW5jb21wYXRpYmxlIGludGVnZXIg
dG8gcG9pbnRlciBjb252ZXJzaW9uIGFzc2lnbmluZyB0byAnQmxvY2tCYWNrZW5kIConIChha2Eg
J3N0cnVjdCBCbG9ja0JhY2tlbmQgKicpIGZyb20gJ2ludCcgWy1XZXJyb3IsLVdpbnQtY29udmVy
c2lvbl0KICAgICAgICBvbGRfYmFja2luZ19ibGsgPSBibGtfbmV3X3dpdGhfYnMoYnMsIEJMS19Q
RVJNX1dSSVRFLCBCTEtfUEVSTV9BTEwsCiAgICAgICAgICAgICAgICAgICAgICAgIF4gfn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgozIGVycm9ycyBnZW5l
cmF0ZWQuCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogcWVtdS1p
bWcub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD0wYzMxN2JjMDM3MmU0NmJhYTVlNTMwY2I1YmZmYWQwNScsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbWh6a2p1eDQvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wNC0yOS0xOS4zOC4xOC4xNDI5ODovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD0wYzMxN2JjMDM3MmU0NmJhYTVlNTMwY2I1YmZmYWQwNQptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1taHpranV4NC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTE5LjkyN3MKdXNlciAgICAwbTgu
MTIycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDA0MjkxNDExMjYuODUxNTktMS1tcmVpdHpAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4v
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

