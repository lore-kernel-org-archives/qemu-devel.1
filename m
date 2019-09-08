Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61215C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 07:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C9C214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 07:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C9C214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6rPb-0006uR-7G
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 03:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i6rOz-0006Tc-P0
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 03:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i6rOy-00039o-28
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 03:14:25 -0400
Resent-Date: Sun, 08 Sep 2019 03:14:25 -0400
Resent-Message-Id: <E1i6rOy-00039o-28@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i6rOx-00037F-Ns
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 03:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567924112; cv=none; d=zoho.com; s=zohoarc; 
 b=nXbkFDUFRk5GEVHdCUTGKQC6M1XQW0vMPEaTcLvx0rGV63IJbAnr0Z7PcHt1/mGcgScQX2Sf2JGJUpRSt2mKK8v9fFyzSWQgfxdprujFQiNqPr8qskJUynXwEGuACDCKUSb9WeHKmpF/IfJhvwrcobVXXdT8msXZ4DCwhykSsjE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567924112;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=svdS+K4B+5I80kc1Kuzo9a0DUS90eETXqDv8wLrEezk=; 
 b=jhQwDOqZX0G/katYhy3co3ALC9ci+uG1salM8hljuebmVecqTtc5RAZGvEjTkKXR4eEyQjmO2SIWI6ZWf64PbJ70W90M+KdEodweRqWGA3jms3RaqBhet6+NPugnKBhVsY6piFieSBBXkOSwft1cxORtsgq/u4KlA7v55X1Np70=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1567924110027563.7607110848959;
 Sat, 7 Sep 2019 23:28:30 -0700 (PDT)
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
Message-ID: <156792410867.16498.10933662795528772615@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sat, 7 Sep 2019 23:28:30 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6 0/8] linux-user: strace improvements
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
Cc: agx@sigxcpu.org, riku.voipio@iki.fi, qemu-devel@nongnu.org, f4bug@amsat.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkwODA2MTU0My4yNTEz
Ni0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA5MDgwNjE1NDMuMjUxMzYtMS1mNGJ1Z0BhbXNhdC5v
cmcKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2NiAwLzhdIGxpbnV4LXVzZXI6IHN0cmFj
ZSBpbXByb3ZlbWVudHMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmQyMDE1ZTIgbGludXgtdXNlci9zdHJh
Y2U6IExldCBwcmludF9zb2NrYWRkcigpIGhhdmUgYSAnbGFzdCcgYXJndW1lbnQKNGM3ZGY0YiBs
aW51eC11c2VyL3N0cmFjZTogSW1wcm92ZSBiaW5kKCkgb3V0cHV0CjY1MjNhNDMgbGludXgtdXNl
ci9zdHJhY2U6IEFkZCBwcmludF9zb2NrZmQoKQowNzNmNmZkIGxpbnV4LXVzZXIvc3RyYWNlOiBE
dW1wIEFGX05FVExJTksgc29ja2FkZHIgY29udGVudAoyYWJkMzEyIGxpbnV4LXVzZXIvc3lzY2Fs
bDogSW50cm9kdWNlIHRhcmdldF9zb2NrYWRkcl9ubAowZjVlOGVkIGxpbnV4LXVzZXIvc3RyYWNl
OiBJbXByb3ZlIHNldHRpbWVvZmRheSgpCjE5MjMzZGYgbGludXgtdXNlci9zdHJhY2U6IEFkZCBw
cmludF90aW1lem9uZSgpCmJlMDk4YTEgbGludXgtdXNlci9zdHJhY2U6IERpc3BsYXkgaW52YWxp
ZCBwb2ludGVyIGluIHByaW50X3RpbWV2YWwoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS84IENo
ZWNraW5nIGNvbW1pdCBiZTA5OGExMzk4MDcgKGxpbnV4LXVzZXIvc3RyYWNlOiBEaXNwbGF5IGlu
dmFsaWQgcG9pbnRlciBpbiBwcmludF90aW1ldmFsKCkpCjIvOCBDaGVja2luZyBjb21taXQgMTky
MzNkZjhjNWRhIChsaW51eC11c2VyL3N0cmFjZTogQWRkIHByaW50X3RpbWV6b25lKCkpCkVSUk9S
OiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJh
dGlvbgojMTk6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6NjY6CitVTlVTRUQgc3RhdGljIHZv
aWQgcHJpbnRfdGltZXpvbmUoYWJpX3Vsb25nLCBpbnQpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAzMyBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzggaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCjMvOCBDaGVja2luZyBjb21taXQgMGY1ZThlZDk1M2JmIChsaW51eC11c2VyL3N0cmFj
ZTogSW1wcm92ZSBzZXR0aW1lb2ZkYXkoKSkKNC84IENoZWNraW5nIGNvbW1pdCAyYWJkMzEyNjA3
MjIgKGxpbnV4LXVzZXIvc3lzY2FsbDogSW50cm9kdWNlIHRhcmdldF9zb2NrYWRkcl9ubCkKNS84
IENoZWNraW5nIGNvbW1pdCAwNzNmNmZkZmUzMzggKGxpbnV4LXVzZXIvc3RyYWNlOiBEdW1wIEFG
X05FVExJTksgc29ja2FkZHIgY29udGVudCkKNi84IENoZWNraW5nIGNvbW1pdCA2NTIzYTQzMjgx
YzQgKGxpbnV4LXVzZXIvc3RyYWNlOiBBZGQgcHJpbnRfc29ja2ZkKCkpCjcvOCBDaGVja2luZyBj
b21taXQgNGM3ZGY0YjNiOGM3IChsaW51eC11c2VyL3N0cmFjZTogSW1wcm92ZSBiaW5kKCkgb3V0
cHV0KQo4LzggQ2hlY2tpbmcgY29tbWl0IGQyMDE1ZTI0ZTA4YyAobGludXgtdXNlci9zdHJhY2U6
IExldCBwcmludF9zb2NrYWRkcigpIGhhdmUgYSAnbGFzdCcgYXJndW1lbnQpCkVSUk9SOiBzdG9y
YWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgoj
MjI6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6NzA6CitVTlVTRUQgc3RhdGljIHZvaWQgcHJp
bnRfc29ja2FkZHIoYWJpX3Vsb25nIGFkZHIsIGFiaV9sb25nIGFkZHJsZW4sIGludCk7Cgp0b3Rh
bDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDQwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOCBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MDgwNjE1NDMuMjUxMzYtMS1mNGJ1Z0BhbXNhdC5vcmcv
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


