Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15123C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36A120656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36A120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5Rz-0007iC-6f
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj5PM-0005Fq-Do; Wed, 10 Jun 2020 14:25:04 -0400
Resent-Date: Wed, 10 Jun 2020 14:25:04 -0400
Resent-Message-Id: <E1jj5PM-0005Fq-Do@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj5PK-0006We-Kv; Wed, 10 Jun 2020 14:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591813491; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XJzIP79JWqsxj8t0EGhvEIQadvx0TI3E8Y2yhb90MflhEpWFtpZYZXkiF4UTYLEgipEsSzBzmyx+X0CxR/wOfaEhoyuyLRu5ApD/fr/Ql/kNHOGOPp4VA0YDurg2jbZHZ2+Xlz5zY5/EQtxC3nxmbfTfc66gnwH83VVV2cIp87o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591813491;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=e97MUL3aNyR58j52ECn66dPUSyLslExuknjgqz+YdqI=; 
 b=I+VdyAtlCGmvHNFx9d7tGVyVWaXsQ/rVZR53INQAOnyPhJw7JpSsASSHMZ8TAJsy+/Ehwx9Iq3UsRKjFVWcLxRHxGrlfhQiKF6KbXN5kyx6JHm6Xy8i78jmZ81XmzAtHgp0/Ye+Hl2ZTNwL6btdvT+qjYLHThLBqnAkI9DNwyp4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591813488374647.7444244054805;
 Wed, 10 Jun 2020 11:24:48 -0700 (PDT)
Message-ID: <159181348711.21115.11091430700411380327@45ef0f9c86ae>
In-Reply-To: <20200610144129.27659-1-den@openvz.org>
Subject: Re: [PATCH 0/2] qcow2: seriously improve savevm performance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: den@openvz.org
Date: Wed, 10 Jun 2020 11:24:48 -0700 (PDT)
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
OS0xLWRlbkBvcGVudnoub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBi
dWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0
cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5
IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14ODZf
NjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIGJsb2NrL2dsdXN0ZXIubwogIENDICAgICAgYmxvY2svc3NoLm8KICBDQyAgICAgIGJsb2Nr
L2RtZy1iejIubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo1MTM5Ojk6IGVycm9y
OiB2YXJpYWJsZSAnZXJyJyBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQgd2hlbmV2ZXIgJ2lmJyBjb25k
aXRpb24gaXMgZmFsc2UgWy1XZXJyb3IsLVdzb21ldGltZXMtdW5pbml0aWFsaXplZF0KICAgIGlm
ICh0LT5ieXRlcyAhPSAwKSB7CiAgICAgICAgXn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9z
cmMvYmxvY2svcWNvdzIuYzo1MTQ3OjEyOiBub3RlOiB1bmluaXRpYWxpemVkIHVzZSBvY2N1cnMg
aGVyZQotLS0KICAgICAgICAgICBeCiAgICAgICAgICAgID0gMAoxIGVycm9yIGdlbmVyYXRlZC4K
bWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBibG9jay9xY293Mi5v
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDY2NSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPTIxM2E4ZGE2OTA4MTQ1OWI5MWRiNjM4ODhlMWNjNmEwJywgJy11JywgJzEw
MDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09Q
VFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NI
T1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXY1NGhnaXkyL3NyYy9kb2NrZXItc3Jj
LjIwMjAtMDYtMTAtMTQuMjAuMzkuMTkzMTU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVk
b3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9MjEzYThkYTY5MDgxNDU5YjkxZGI2Mzg4OGUxY2M2YTAKbWFrZVsxXTogKioqIFtkb2Nr
ZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtdjU0aGdpeTIvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1k
ZWJ1Z0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG04LjYwOXMKdXNlciAgICAwbTguOTE3cwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA2MTAxNDQxMjkuMjc2NTktMS1kZW5Ab3BlbnZ6Lm9yZy90ZXN0aW5nLmFzYW4vP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

