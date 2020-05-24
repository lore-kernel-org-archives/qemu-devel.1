Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C562C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C5E20776
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C5E20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcy4U-0006zA-AD
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 17:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcy3i-0006S6-Oq; Sun, 24 May 2020 17:21:26 -0400
Resent-Date: Sun, 24 May 2020 17:21:26 -0400
Resent-Message-Id: <E1jcy3i-0006S6-Oq@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcy3h-00013h-5s; Sun, 24 May 2020 17:21:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590355276; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QERCCUjh2AkIfqm11ACMGM/0xhxJGqU6cxfHoQ+Tlpe2C1bNVnx7hTaov+Lc6jkk1WGv+cpPvFvTdxofYKQa3LOlnEGcQzKSV6omWg7jO3O3pgHJT3Kd2qCpSc0yPSvccuvkB/AWrc8h6Z2wHbnbHBz2Ml/UEo8pXN/O2qbeZdU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590355276;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/8UyLX7zF0oYmDdTjyrRrawZ0qE3onfshNF4MOdYjpY=; 
 b=IMPIEbSWzwlXxiGt+Mr/q5YM9eYYclhdZymth4lOKuNBAGc0XesGXSlE4Hq2inPr9W7DgPOHwraWuxsQQI2OaHNsI02evwXUFigswNPTNW1vJFgzFgHDiSOEFce3X2j26b+8hRqv9g0RlfzyxC8TvQHpDc1ObVKlFzTZvu4pN7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590355275006304.58522192594853;
 Sun, 24 May 2020 14:21:15 -0700 (PDT)
Message-ID: <159035527349.27266.4919574995461866734@45ef0f9c86ae>
In-Reply-To: <cover.1590344541.git.lukasstraub2@web.de>
Subject: Re: [PATCH v3 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lukasstraub2@web.de
Date: Sun, 24 May 2020 14:21:15 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 17:16:27
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwMzQ0NTQxLmdp
dC5sdWthc3N0cmF1YjJAd2ViLmRlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKbWln
cmF0aW9uL3FlbXUtZmlsZS1jaGFubmVsLm86IGluIGZ1bmN0aW9uIGBjaGFubmVsX2Nsb3NlJzoK
L3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9xZW11LWZpbGUtY2hhbm5lbC5jOjExMTogdW5k
ZWZpbmVkIHJlZmVyZW5jZSB0byBgeWFua19nZW5lcmljX2lvY2hhbm5lbCcKL3Vzci9iaW4vbGQ6
IC90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vcWVtdS1maWxlLWNoYW5uZWwuYzoxMTA6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYHlhbmtfdW5yZWdpc3Rlcl9mdW5jdGlvbicKY2xhbmctODog
ZXJyb3I6IGxpbmtlciBjb21tYW5kIGZhaWxlZCB3aXRoIGV4aXQgY29kZSAxICh1c2UgLXYgdG8g
c2VlIGludm9jYXRpb24pCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazox
MjQ6IHRlc3RzL3Rlc3Qtdm1zdGF0ZV0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmls
ZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0xOGU1NDBjMGZhZTE0YWM2OGU1NzEw
MjNjYzA5NmUzMScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3Rt
cC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hl
Oi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC05
MnFfd3Jzdy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1LTI0LTE3LjE1LjU4LjI3MTU0Oi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRl
YnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTE4ZTU0MGMwZmFlMTRhYzY4ZTU3MTAyM2NjMDk2
ZTMxCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTkycV93cnN3L3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDVtMTQu
Njk5cwp1c2VyICAgIDBtOC45NzBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTkwMzQ0NTQxLmdpdC5sdWthc3N0cmF1YjJAd2Vi
LmRlL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

