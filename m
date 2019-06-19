Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FCAC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 11:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF832054F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 11:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF832054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdYe9-0004Sn-L2
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 07:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40135)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdYdD-0003nS-Tf
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 07:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdYdB-0000RH-Va
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 07:19:59 -0400
Resent-Date: Wed, 19 Jun 2019 07:19:59 -0400
Resent-Message-Id: <E1hdYdB-0000RH-Va@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdYd6-0000LE-43; Wed, 19 Jun 2019 07:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560943136; cv=none; d=zoho.com; s=zohoarc; 
 b=ihk2UNxaP9UZe3TFzJJaD9CBqMCjDwmwdAa0bQpBCen7dW3fgQrM7lhUMmlszseb8TtHBiEA0ml0f1z1AtpQ2fdqPDRGuXIzSmSWL9vwV6ATjhclUL1pUzInTbZTJpcaqWcbkcftsmHHYBGpw4ZWH8By3BpRz+mgNnxqnytJMCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560943136;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=RWMvr33/R85WJTJqCToN3puFtYOAvxDkAXiY7kbmUO8=; 
 b=go1Qq5FX5cQJqrl6Vx1CYvn8j/GSymTbDixiHHNwz7i0aIwWldwEu7Gf9LCVQm/z+jh4/v6utlzCtuDjuN5MoVr1nZz3QwHa+w5tVAMSmDeX519dgeFRmcfwgAvgYuV+56MPdVj8fgSxIqDnDLJjyvrssWn0iP6JCVEiZTcmau8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560943136134605.6884371529646;
 Wed, 19 Jun 2019 04:18:56 -0700 (PDT)
In-Reply-To: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
Message-ID: <156094313483.26825.9880066904565206305@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shmuel.eiderman@oracle.com
Date: Wed, 19 Jun 2019 04:18:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [SeaBIOS] [QEMU] [PATCH v4 0/8] Add Qemu to
 SeaBIOS LCHS interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxOTA5MjkwNS4yNDAy
OS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbU2VhQklPU10gW1FFTVVdIFtQQVRDSCB2NCAw
LzhdIEFkZCBRZW11IHRvIFNlYUJJT1MgTENIUyBpbnRlcmZhY2UKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMTkwNjE5MDkyOTA1LjI0MDI5LTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCjQwNjA3NTAgaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBvdmVy
cmlkZQplYzA5MjllIGJvb3RkZXZpY2U6IEZXX0NGRyBpbnRlcmZhY2UgZm9yIExDSFMgdmFsdWVz
CjkxMDY5ODcgYm9vdGRldmljZTogUmVmYWN0b3IgZ2V0X2Jvb3RfZGV2aWNlc19saXN0CmZlNmEw
YzAgYm9vdGRldmljZTogR2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcwpmNjhh
MTVlIHNjc2k6IFByb3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFjayB0byBzY3NpLWhkCjEzNDdl
N2YgYm9vdGRldmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENIUwoyZmNkOTRkIGJsb2Nr
OiBTdXBwb3J0IHByb3ZpZGluZyBMQ0hTIGZyb20gdXNlcgo0M2MwY2RmIGJsb2NrOiBSZWZhY3Rv
ciBtYWNyb3MgLSBmaXggdGFiYmluZwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS84IENoZWNraW5n
IGNvbW1pdCA0M2MwY2RmNzNjNmEgKGJsb2NrOiBSZWZhY3RvciBtYWNyb3MgLSBmaXggdGFiYmlu
ZykKRVJST1I6IE1hY3JvcyB3aXRoIGNvbXBsZXggdmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBp
biBwYXJlbnRoZXNpcwojNTU6IEZJTEU6IGluY2x1ZGUvaHcvYmxvY2svYmxvY2suaDo2NToKKyNk
ZWZpbmUgREVGSU5FX0JMT0NLX0NIU19QUk9QRVJUSUVTKF9zdGF0ZSwgX2NvbmYpICAgICAgICAg
ICAgICAgICAgICAgIFwKKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoImN5bHMiLCBfc3RhdGUsIF9j
b25mLmN5bHMsIDApLCAgICAgICAgICAgICAgICAgIFwKKyAgICBERUZJTkVfUFJPUF9VSU5UMzIo
ImhlYWRzIiwgX3N0YXRlLCBfY29uZi5oZWFkcywgMCksICAgICAgICAgICAgICAgIFwKICAgICBE
RUZJTkVfUFJPUF9VSU5UMzIoInNlY3MiLCBfc3RhdGUsIF9jb25mLnNlY3MsIDApCgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDM3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvOCBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKMi84IENoZWNraW5nIGNvbW1pdCAyZmNkOTRkNzhkNjIgKGJs
b2NrOiBTdXBwb3J0IHByb3ZpZGluZyBMQ0hTIGZyb20gdXNlcikKMy84IENoZWNraW5nIGNvbW1p
dCAxMzQ3ZTdmMzhkNjIgKGJvb3RkZXZpY2U6IEFkZCBpbnRlcmZhY2UgdG8gZ2F0aGVyIExDSFMp
CjQvOCBDaGVja2luZyBjb21taXQgZjY4YTE1ZTQxMDcyIChzY3NpOiBQcm9wYWdhdGUgdW5yZWFs
aXplKCkgY2FsbGJhY2sgdG8gc2NzaS1oZCkKNS84IENoZWNraW5nIGNvbW1pdCBmZTZhMGMwYWQw
ZGUgKGJvb3RkZXZpY2U6IEdhdGhlciBMQ0hTIGZyb20gYWxsIHJlbGV2YW50IGRldmljZXMpCjYv
OCBDaGVja2luZyBjb21taXQgOTEwNjk4N2JhNGZhIChib290ZGV2aWNlOiBSZWZhY3RvciBnZXRf
Ym9vdF9kZXZpY2VzX2xpc3QpCjcvOCBDaGVja2luZyBjb21taXQgZWMwOTI5ZTA0NzY0IChib290
ZGV2aWNlOiBGV19DRkcgaW50ZXJmYWNlIGZvciBMQ0hTIHZhbHVlcykKOC84IENoZWNraW5nIGNv
bW1pdCA0MDYwNzUwYjYzYzkgKGhkLWdlby10ZXN0OiBBZGQgdGVzdHMgZm9yIGxjaHMgb3ZlcnJp
ZGUpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyNDI6IEZJTEU6IHRlc3RzL2hk
LWdlby10ZXN0LmM6NTc5OgorICAgICAgICAgICAgICAgICAgICAgKGNoYXIgKilyLT5kZXZfcGF0
aCwgJihyLT5jaHMuYyksICYoci0+Y2hzLmgpLCAmKHItPmNocy5zKSk7CgpXQVJOSU5HOiBCbG9j
ayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNjQwOiBGSUxF
OiB0ZXN0cy9oZC1nZW8tdGVzdC5jOjk5NToKKyAgICAgICAgICAgICAgICAgICAgICAgInNraXBw
aW5nIGhkLWdlby9vdmVycmlkZS8qIHRlc3RzIik7Cgp0b3RhbDogMCBlcnJvcnMsIDIgd2Fybmlu
Z3MsIDYwOCBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA2MTkwOTI5MDUuMjQwMjktMS1zaG11ZWwuZWlkZXJtYW5Ab3JhY2xlLmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


