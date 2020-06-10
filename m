Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6381DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD3420656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD3420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5SZ-0000eI-GQ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj5Ow-0004s7-DF; Wed, 10 Jun 2020 14:24:38 -0400
Resent-Date: Wed, 10 Jun 2020 14:24:38 -0400
Resent-Message-Id: <E1jj5Ow-0004s7-DF@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj5Ou-0006TN-Ti; Wed, 10 Jun 2020 14:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591813464; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nERr9RB1PZ5GUVpniahBtzwB9D9yMLnTAt66MY94L8yPWbcm8vEjPeTSL6jl1RYqvqMjbXiWkTtAS1TivSC0O8uCSZeyJYv9gRhvI6qdzTyWxkMz897dMuqOmWeg2jDa52tdhTWEgCZtFS1dX0stTouAUApGM2n1OwNhOa7J9eI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591813464;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vCCNr6hMRhfg2TnLL/ZKhYCx9revIvgL4x/Xn6AJC6c=; 
 b=DvSiT2a9WETFFPAgYCorhxTVVbj0OhrgrJZ1jA1LB+UhV1K4g+penDB0o9IGI6uIKCEHcDHHNCoa3bPwiu1gHJU4Jj+dZZzY3PX8FjjoxkReoHieZ5GWCvRBdev99omKZcmGDx3lKvWzTTeL1teIAq12bUEEBN4x698adE9phgQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591813462365206.32799210555925;
 Wed, 10 Jun 2020 11:24:22 -0700 (PDT)
Message-ID: <159181346094.21115.18138399616727000138@45ef0f9c86ae>
In-Reply-To: <20200610144129.27659-1-den@openvz.org>
Subject: Re: [PATCH 0/2] qcow2: seriously improve savevm performance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: den@openvz.org
Date: Wed, 10 Jun 2020 11:24:22 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:20:12
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, dplotnikov@virtuozzo.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMDE0NDEyOS4yNzY1
OS0xLWRlbkBvcGVudnoub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdl
LWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQlVOWklQMiBwYy1iaW9z
L2VkazItaTM4Ni1jb2RlLmZkLmJ6MgogIEJVTlpJUDIgcGMtYmlvcy9lZGsyLWFybS12YXJzLmZk
LmJ6MgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cy
X2NvX3Ztc3RhdGVfdGFza19lbnRyeSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi5j
OjUxNDc6MTI6IGVycm9yOiAnZXJyJyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMg
ZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICByZXR1cm4gZXJyOwog
ICAgICAgICAgICBefn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMK
bWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBibG9jay9xY293Mi5v
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDY2NSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPWEwMzI3YWUyZWYzYzQxNjNiZGQzMDdiMzBiYzkwYTdjJywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNh
Y2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtZmJ2cnRyNnUvc3JjL2RvY2tlci1zcmMuMjAyMC0wNi0xMC0x
NC4yMi4wMS4yMTQ1MzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hMDMyN2Fl
MmVmM2M0MTYzYmRkMzA3YjMwYmM5MGE3YwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1mYnZydHI2dS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0g
RXJyb3IgMgoKcmVhbCAgICAybTIwLjc5MXMKdXNlciAgICAwbTguNDgzcwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MTAxNDQxMjku
Mjc2NTktMS1kZW5Ab3BlbnZ6Lm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

