Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC06ECE599
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C0E21835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C0E21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKoox-0006eb-GJ
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 15:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKonr-00065g-Vf
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKonq-0007GF-Hc
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:17:47 -0400
Resent-Date: Wed, 16 Oct 2019 15:17:47 -0400
Resent-Message-Id: <E1iKonq-0007GF-Hc@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKonq-0007Fa-A8
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:17:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571253436; cv=none; d=zoho.com; s=zohoarc; 
 b=QKwteOkAhonZQ3U9ZuWWTD+sboGzlkuTxe9JU5s1HVWlaspAQsNAmAVYAmkIPYEaKeR2w2hbRZqSbZdQD+nIDJTbqfu1wBpP3YfgR1bfp4XGoX6XdaK70Y0MIha+Ch1ncbRoEZ7oJ0yvcTqvDAxbfJgKPw3cdKFF159+HEm34Ok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571253436;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5GHhjemoNO/OEDDLAZQJ/C3ACvaKepribzwUSIpTTZY=; 
 b=RpvXkfeC/DVECPF2FIhRqZ5udZoMI0kKSgwgIDdnE7trZy1ZeVO+jlD0p7S+ZTz5E9YH8UgYVqDCLIBcliY278hdoGxYYj73x3vdAM1ddS3f0KxU1eYIhBw9r+LXShH65FUHOJ/jsxQskHcjquUX96WzIlEIaqiACx5sUocgK8U=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157125343426373.19325636141127;
 Wed, 16 Oct 2019 12:17:14 -0700 (PDT)
In-Reply-To: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v4 0/4] qcow2: advanced compression options
Message-ID: <157125343247.16217.14509317350988321635@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Wed, 16 Oct 2019 12:17:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxMjQzMzMzLTg4MjMwMi0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRv
Y2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1
aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIGJsb2NrL3FlZC10YWJsZS5vCiAgQ0MgICAgICBibG9jay9xZWQtY2x1
c3Rlci5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOiBJbiBmdW5jdGlvbiAncWNv
dzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3BhcnQnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
cWNvdzIuYzo0MjQ0Ojk6IGVycm9yOiAncmV0JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGlu
IHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICBpbnQgcmV0
OwogICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1h
a2U6ICoqKiBbYmxvY2svcWNvdzIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmls
ZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1iMTA5YWJhY2Q4MDU0ZWZjOTkyZDY2
ZmEyOGNhN2Q4YycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICct
dicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2Nj
YWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1nZTlpa3Zlei9zcmMv
ZG9ja2VyLXNyYy4yMDE5LTEwLTE2LTE1LjE1LjA4Ljk4MzI6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPWIxMDlhYmFjZDgwNTRlZmM5OTJkNjZmYTI4Y2E3ZDhjCm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWdlOWlrdmV6L3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTQuNTQzcwp1c2VyICAg
IDBtOC4xNjFzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8xNTcxMjQzMzMzLTg4MjMwMi0xLWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2
aWNoQHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


