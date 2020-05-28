Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F5DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B67207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B67207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jePii-0007pn-6Z
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jePhJ-0006Bm-Vt
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:04:17 -0400
Resent-Date: Thu, 28 May 2020 17:04:17 -0400
Resent-Message-Id: <E1jePhJ-0006Bm-Vt@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jePhI-00066f-85
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:04:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590699845; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gbQyYkWJZ0JFK4a/dS/TI95ARma9r/Ge+FHGVoQD7T8poeoWO/vkoR+QrlcqLmfc8xrm8NtcqoF7G1hFo2OqNrNm6ESsKHWqHZRtcLh+JiXllunzapoJ7m/Is27lbBR/slAb4l/JcxlMdCBX7Tmieahg+oPuutJrDxq570BwqYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590699845;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1OfLNcXvPrdXSntETgw7F5ngZB2S9xTuEOUly6xH4JY=; 
 b=AvkaZ9fysH4yuwgcTebxkRoO/MaC0CPZj009yK9byqvGsLKyKQ8YsPEBeR8Et2IxwqK3A1l/buhY44r2o7fJQ3jONJjfjpPIgq5JhwDZhCuES0FLpZ7iz65CXCyMesgEQWlioYfpObs/+hb+1U/sYHpZlFT/XOWwD5qggxvOlcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590699843323920.4741299438057;
 Thu, 28 May 2020 14:04:03 -0700 (PDT)
Message-ID: <159069984173.20666.5623166936384525125@45ef0f9c86ae>
In-Reply-To: <20200528134035.32025-1-kraxel@redhat.com>
Subject: Re: [PATCH v2 0/4] microvm: memory config tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 28 May 2020 14:04:03 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:26:02
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
Cc: ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyODEzNDAzNS4zMjAy
NS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIHg4Nl82NC1zb2Z0bW11L3NvZnRtbXUvbWFpbi5vCiAgQ0MgICAgICB4ODZfNjQtc29m
dG1tdS9nZGJzdHViLXhtbC5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS90cmFjZS9nZW5lcmF0
ZWQtaGVscGVycy5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9pMzg2L3hlbi94ZW4taHZtLmM6MjA2
OjM0OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnWDg2X01BQ0hJTkVfTUFY
X1JBTV9CRUxPV180RycKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWDg2X01BQ0hJ
TkVfTUFYX1JBTV9CRUxPV180RywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgox
IGVycm9yIGdlbmVyYXRlZC4KbWFrZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMu
bWFrOjY5OiBody9pMzg2L3hlbi94ZW4taHZtLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IHg4Nl82
NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+
CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD0wYmFjNDkxODUxMzE0OWYyYTQ3MTdkMGFiOWQzMzFlZScsICctdScsICcxMDAzJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0n
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtc2R3b2Rpbngvc3JjL2RvY2tlci1zcmMuMjAyMC0w
NS0yOC0xNi41OS40Ni4xNDQ0NDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0w
YmFjNDkxODUxMzE0OWYyYTQ3MTdkMGFiOWQzMzFlZQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1zZHdvZGlueC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZl
ZG9yYV0gRXJyb3IgMgoKcmVhbCAgICA0bTE1LjU5NnMKdXNlciAgICAwbTcuMjQ5cwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1Mjgx
MzQwMzUuMzIwMjUtMS1rcmF4ZWxAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

