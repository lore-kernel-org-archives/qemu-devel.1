Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99238C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAED20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAED20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWlq-0007HP-NC
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:42:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLWkZ-0006Xc-5i
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLWkV-0003u2-3f
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:41:02 -0400
Resent-Date: Tue, 30 Apr 2019 13:41:01 -0400
Resent-Message-Id: <E1hLWkV-0003u2-3f@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLWkT-0003rV-8T
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:40:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556646037; cv=none; d=zoho.com; s=zohoarc; 
	b=c/ImklGOf0Mx76e7cF7AvB3bxLnSmjHDtWVY8wfmCOOlzeTBFu9o/v07gH2b7eDFA2RPyY7URrww3mTYwDVNl2ILyi1zGtjVE4fXOPOMG9TojLaWeG0j3jqHCov71gvgbnJSpf17QfaaRLh2yyBFGfu87lSkHL4+MQQjeATjlvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556646037;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=3vDh5WxEm12BQsxdGloRGsOUJ7Z5k6d3M1rZ2q9qNSM=; 
	b=e96V2qJDr5S7CKhFJPB/y7U8GIPSuU/AxEDZx/1BSSlB9U+afvL+i0vBi/1GkXuni7JuoZzQ8+YN+GICLiW1gBlA6rcCqR6H4aGd3bMd2grlaE3BiJcYTarDOgHxSoxssHE2KKTuA41cIMcBoeAypXUtqjQmuDaK4oF3pggxHyo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556646026894844.8809037914904;
	Tue, 30 Apr 2019 10:40:26 -0700 (PDT)
In-Reply-To: <20190430172236.14325-1-paul.c.lai@intel.com>
Message-ID: <155664602568.10667.9152899747507219100@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: paul.c.lai@intel.com
Date: Tue, 30 Apr 2019 10:40:26 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] Introduce SnowRidge CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, luwei.kang@intel.com, tao3.xu@intel.com,
	qemu-devel@nongnu.org, wei.w.wang@intel.com, paul.c.lai@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430174026.AkDUiPA-G9GUEarzTqNfTlf8PsmArsrfvWNFPLh8yKA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQzMDE3MjIzNi4xNDMy
NS0xLXBhdWwuYy5sYWlAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA0MzAxNzIyMzYuMTQz
MjUtMS1wYXVsLmMubGFpQGludGVsLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBJ
bnRyb2R1Y2UgU25vd1JpZGdlIENQVSBtb2RlbAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0
YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQzMDE3MjIzNi4xNDMyNS0xLXBhdWwuYy5s
YWlAaW50ZWwuY29tIC0+IHBhdGNoZXcvMjAxOTA0MzAxNzIyMzYuMTQzMjUtMS1wYXVsLmMubGFp
QGludGVsLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjRhNGNhNjhjMjEgSW50
cm9kdWNlIFNub3dSaWRnZSBDUFUgbW9kZWwKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBj
b2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzM3OiBGSUxFOiB0YXJnZXQvaTM4Ni9j
cHUuYzoyNjc1OgorXkkgICAgLyogbWlzc2luZzogQ1BVSURfUE4gQ1BVSURfSUE2NCAqLyQKCkVS
Uk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJ3wnIChjdHg6VnhXKQojMzk6IEZJTEU6
IHRhcmdldC9pMzg2L2NwdS5jOjI2Nzc6CisgICAgICAgICAgICBDUFVJRF9GUDg3IHwgQ1BVSURf
Vk1FIHwgQ1BVSURfREV8IENQVUlEX1BTRSB8CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5n
IC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNDM6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5jOjI2ODE6
CisgICAgICAgICAgICBDUFVJRF9QQVQgfCBDUFVJRF9QU0UzNiB8IC8qIENQVUlEX1BOIHwgKi8g
Q1BVSURfQ0xGTFVTSCB8CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNTI6IEZJ
TEU6IHRhcmdldC9pMzg2L2NwdS5jOjI2OTA6CisgICAgICAgICAgICBDUFVJRF9FWFRfU1NFNDIg
fCBDUFVJRF9FWFRfWDJBUElDIHwgQ1BVSURfRVhUX01PVkJFIHwgQ1BVSURfRVhUX1BPUENOVCB8
CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzgwOiBGSUxFOiB0YXJnZXQvaTM4Ni9j
cHUuYzoyNzE4OgorICAgICAgICAgICAgQ1BVSURfN18wX0VEWF9BUkNIX0NBUEFCSUxJVElFUyB8
IENQVUlEXzdfMF9FRFhfU1BFQ19DVFJMX1NTQkQsIC8qIG1pc3NpbmcgYml0IDMwICovCgpXQVJO
SU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQoj
ODE6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5jOjI3MTk6CisgICAgICAgIC8qIE1pc3Npbmc6IFhT
QVZFUyAobm90IHN1cHBvcnRlZCBieSBzb21lIExpbnV4IHZlcnNpb25zLAoKV0FSTklORzogQmxv
Y2sgY29tbWVudHMgc2hvdWxkIGFsaWduIHRoZSAqIG9uIGVhY2ggbGluZQojODI6IEZJTEU6IHRh
cmdldC9pMzg2L2NwdS5jOjI3MjA6CisgICAgICAgIC8qIE1pc3Npbmc6IFhTQVZFUyAobm90IHN1
cHBvcnRlZCBieSBzb21lIExpbnV4IHZlcnNpb25zLAorICAgICAgICAgICAgICAgICogaW5jbHVk
aW5nIHY0LjEgdG8gdjQuMTIpLgoKdG90YWw6IDMgZXJyb3JzLCA0IHdhcm5pbmdzLCA3MiBsaW5l
cyBjaGVja2VkCgpDb21taXQgNGE0Y2E2OGMyMWJhIChJbnRyb2R1Y2UgU25vd1JpZGdlIENQVSBt
b2RlbCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MzAxNzIyMzYuMTQzMjUtMS1wYXVsLmMu
bGFpQGludGVsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


