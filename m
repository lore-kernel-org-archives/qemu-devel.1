Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB5C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1A923A60
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1A923A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKToc-0004gV-Jo
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 17:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKTnQ-0004AB-40; Mon, 21 Sep 2020 17:56:28 -0400
Resent-Date: Mon, 21 Sep 2020 17:56:28 -0400
Resent-Message-Id: <E1kKTnQ-0004AB-40@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKTnN-0008Gb-Tr; Mon, 21 Sep 2020 17:56:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600725372; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DiJs3fZDHOuwrZDHy8rRYk7+P+CAhyvVYk4JSx8iWENylxEMQGgWtlhOf5gn7BEgJMZv1CGPPMp3j1bquqNqJN2TNalIMW9VBfevwJvigtK0vom8UBL9O0shVnV4UkKbn/nkIRu/EbfOU/JluLalDIj9o4OlsDjKfAr0rSn9dRc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600725372;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GtLPZVLd5rYjOh41ajbRqNJ94K/sxc7Zhe/camXD7AQ=; 
 b=bVt/t+xA1ljrLCzK1VbqywE/s44u3n0R8sDYpAZT1zFvdSHQV00Shg5L7seY1lJhdZQBypNbuJt7R5rGCSATZncnMxFmj/48whYWTWvH0wWpWDSC/95pKk2mTex6n5OyJvP9SM0JADvbJ3qnqwlBnANaNn4KixECvQ9jDnLU2lQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600725369690255.71140865232894;
 Mon, 21 Sep 2020 14:56:09 -0700 (PDT)
Subject: Re: [PATCH 0/6] block/nvme: Map doorbells pages write-only,
 remove magic from nvme_init
Message-ID: <160072536812.23987.6447220487166170351@66eaa9a8a123>
In-Reply-To: <20200921162949.553863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Mon, 21 Sep 2020 14:56:09 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 16:58:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMTE2Mjk0OS41NTM4
NjMtMS1waGlsbWRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpDIGxpbmtlciBmb3IgdGhlIGhv
c3QgbWFjaGluZTogY2MgbGQuYmZkIDIuMjctNDMKSG9zdCBtYWNoaW5lIGNwdSBmYW1pbHk6IHg4
Nl82NApIb3N0IG1hY2hpbmUgY3B1OiB4ODZfNjQKLi4vc3JjL21lc29uLmJ1aWxkOjEwOiBXQVJO
SU5HOiBNb2R1bGUgdW5zdGFibGUta2V5dmFsIGhhcyBubyBiYWNrd2FyZHMgb3IgZm9yd2FyZHMg
Y29tcGF0aWJpbGl0eSBhbmQgbWlnaHQgbm90IGV4aXN0IGluIGZ1dHVyZSByZWxlYXNlcy4KUHJv
Z3JhbSBzaCBmb3VuZDogWUVTClByb2dyYW0gcHl0aG9uMyBmb3VuZDogWUVTICgvdXNyL2Jpbi9w
eXRob24zKQpDb25maWd1cmluZyBuaW5qYXRvb2wgdXNpbmcgY29uZmlndXJhdGlvbgotLS0KQ29t
cGlsaW5nIEMgb2JqZWN0IGF1dGh6L2xpYmF1dGh6LmZhLnAvbGlzdGZpbGUuYy5vCkNvbXBpbGlu
ZyBDIG9iamVjdCBhdXRoei9saWJhdXRoei5mYS5wL2xpc3QuYy5vCi4uL3NyYy9ibG9jay9udm1l
LmM6IEluIGZ1bmN0aW9uICdudm1lX2ZpbGVfb3Blbic6Ci4uL3NyYy9ibG9jay9udm1lLmM6ODA3
Ojg6IGVycm9yOiAncmVncycgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0
aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgaWYgKHJlZ3MpIHsKICAgICAg
ICBeCi4uL3NyYy9ibG9jay9udm1lLmM6NjkyOjIzOiBub3RlOiAncmVncycgd2FzIGRlY2xhcmVk
IGhlcmUKICAgICB2b2xhdGlsZSBOdm1lQmFyICpyZWdzOwogICAgICAgICAgICAgICAgICAgICAg
IF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFts
aWJibG9jay5mYS5wL2Jsb2NrX252bWUuYy5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToK
ICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDcwOSwgaW4gPG1vZHVsZT4K
LS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNz
LkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdy
dW4nLCAnLS1ybScsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OTkyMzM4MTFk
ODZhNDJiMWIyN2FhMzc2YmI4NTk3OWQnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJB
X0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVH
PScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hl
JywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3Rt
cC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtd3U2ODZsd2wv
c3JjL2RvY2tlci1zcmMuMjAyMC0wOS0yMS0xNy41Mi4yMS4yMTc0MDovdmFyL3RtcC9xZW11Onos
cm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScg
cmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9OTkyMzM4MTFkODZhNDJiMWIyN2FhMzc2YmI4NTk3OWQKbWFr
ZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5
IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtd3U2ODZsd2wvc3JjJwptYWtlOiAqKiogW2Rv
Y2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDNtNDYuMzUwcwp1
c2VyICAgIDBtMTUuOTQwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDA5MjExNjI5NDkuNTUzODYzLTEtcGhpbG1kQHJlZGhhdC5jb20v
dGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

