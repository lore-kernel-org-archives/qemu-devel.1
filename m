Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE3C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695162071C
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695162071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctb9-00045Y-Jr
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jctaS-00039R-CF; Sun, 24 May 2020 12:34:56 -0400
Resent-Date: Sun, 24 May 2020 12:34:56 -0400
Resent-Message-Id: <E1jctaS-00039R-CF@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jctaO-0004YH-Vp; Sun, 24 May 2020 12:34:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590338059; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WxYYsGe0EK9ORHTkR0y756+wrXbhFYpwDGhnJ0vy8QmcUU696u8lkx48P2uSpKSKndEvAJU8w51UchRALe4n3Li5qsZ6MAbTCEPKH3AvIXBlmkmFfSrbH+HxoFNsBxCkyouTi3tKZAhusmjctpAo93ozscY7hfPrfyGjDD5Yhts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590338059;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Fiq7lZ8BYSIzCxFh8iiv0pNoTnCWC9ZMBOa2r97REjc=; 
 b=Dli3pWeZ8cfQM4hn1GP3jVRYfwd3tKb3DMZlmiY25htd4vbPvt4HmD6HT5zo7nccx28DU5FohqOIe7GfmVR6KjU8Caa5xBZm0LdpU043KFrkQeF+WzMBTRDpVPmoIg/GWKkLsR7LePNBlcbyeCYGzKvMVtap5gTm0WJ87QGMCHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590338057313117.41850999901362;
 Sun, 24 May 2020 09:34:17 -0700 (PDT)
Message-ID: <159033805582.25024.9998111829771601365@45ef0f9c86ae>
In-Reply-To: <cover.1590331741.git.berto@igalia.com>
Subject: Re: [PATCH v6 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Sun, 24 May 2020 09:34:17 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 12:30:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwMzMxNzQxLmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBi
dWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0
cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5
IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14ODZf
NjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIGJsb2NrL3FlZC10YWJsZS5vCiAgQ0MgICAgICBibG9jay9xZWQtY2x1c3Rlci5vCiAgQ0Mg
ICAgICBibG9jay9xZWQtY2hlY2subwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1
c3Rlci5jOjE5MTI6NTQ6IGVycm9yOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20gZW51bWVyYXRp
b24gdHlwZSAnUUNvdzJDbHVzdGVyVHlwZScgKGFrYSAnZW51bSBRQ293MkNsdXN0ZXJUeXBlJykg
dG8gZGlmZmVyZW50IGVudW1lcmF0aW9uIHR5cGUgJ2VudW0gcWNvdzJfZGlzY2FyZF90eXBlJyBb
LVdlcnJvciwtV2VudW0tY29udmVyc2lvbl0KICAgICAgICBxY293Ml9mcmVlX2FueV9jbHVzdGVy
cyhicywgb2xkX2wyX2VudHJ5LCAxLCB0eXBlKTsKICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fiAgICAgICAgICAgICAgICAgICAgICBefn5+CjEgZXJyb3IgZ2VuZXJhdGVkLgptYWtlOiAq
KiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrL3Fjb3cyLWNsdXN0ZXIu
b10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFj
ZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9j
a2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vz
c0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1h
bmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUu
aW5zdGFuY2UudXVpZD0yNDc5MzViZjExNDA0NDk5OTFiNDgxNjk3MDUyOGMwMycsICctdScsICcx
MDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1l
JywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hv
bWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNTlpdWx4ejAvc3JjL2RvY2tlci1z
cmMuMjAyMC0wNS0yNC0xMi4zMC40NS4zMTU4MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpm
ZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFu
Y2UudXVpZD0yNDc5MzViZjExNDA0NDk5OTFiNDgxNjk3MDUyOGMwMwptYWtlWzFdOiAqKiogW2Rv
Y2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC01OWl1bHh6MC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0
LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTMxLjY3NHMKdXNlciAgICAwbTguNTIx
cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
Y292ZXIuMTU5MDMzMTc0MS5naXQuYmVydG9AaWdhbGlhLmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

