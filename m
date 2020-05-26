Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95213C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 01:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B1F2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 01:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B1F2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdOmV-00023C-Mf
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 21:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdOly-0000hC-P5
 for qemu-devel@nongnu.org; Mon, 25 May 2020 21:52:54 -0400
Resent-Date: Mon, 25 May 2020 21:52:54 -0400
Resent-Message-Id: <E1jdOly-0000hC-P5@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdOlx-00077L-Be
 for qemu-devel@nongnu.org; Mon, 25 May 2020 21:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590457966; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XtLMdwkG4WKtXLie77pxqg/57y9YujNOvZJ3OadYuMYFXJgHAwznZejIGqOjD5VztfDLQAsoLyoneyDSqXUV7G5P3vfAoemO2Vb8gtsvQ1Hk6kYKgEQF6LiRKyQYuPM5UcTyftfe9ZlGDaQ3PTc8TXaBioLXTOQ3cPPs6EUE4DQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590457966;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JdszUJOcc16dailULVnqT9LmQUUbwAcTYtsToV1uxqI=; 
 b=N3lMrdPwv+4o+VkK4WjNqa5hFg5BT/8x/iPrhFB26N3CdNQRgIIvvF/6xvaWcpLzj4fGr8JNGkzbQOJJaRuw7eWymkudtS9218pD9tmZ0nAO6awnj6VJOQeokVUDS+OkS+es7XmgH3lPofBZZWtG60szApD0GDEtell4/gD8SL0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590457964006480.0799516803477;
 Mon, 25 May 2020 18:52:44 -0700 (PDT)
Message-ID: <159045796252.6628.11006658994793943127@45ef0f9c86ae>
In-Reply-To: <20200525134101.24740-1-kraxel@redhat.com>
Subject: Re: [PATCH 0/3] microvm: memory config tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Mon, 25 May 2020 18:52:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 21:48:04
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNTEzNDEwMS4yNDc0
MC0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L2V4Y3BfaGVscGVyLm8KICBDQyAgICAg
IHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L2ZwdV9oZWxwZXIubwogIENDICAgICAgeDg2XzY0
LXNvZnRtbXUvdGFyZ2V0L2kzODYvaW50X2hlbHBlci5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9p
Mzg2L3hlbi94ZW4taHZtLmM6MjA2OjM0OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRp
ZmllciAnWDg2X01BQ0hJTkVfTUFYX1JBTV9CRUxPV180RycKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgWDg2X01BQ0hJTkVfTUFYX1JBTV9CRUxPV180RywKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXgoxIGVycm9yIGdlbmVyYXRlZC4KbWFrZVsxXTogKioqIFsvdG1w
L3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9pMzg2L3hlbi94ZW4taHZtLm9dIEVycm9y
IDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAg
IHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L21lbV9oZWxwZXIubwptYWtlOiAqKiogW01ha2Vm
aWxlOjUyNzogeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNl
bnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2
NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPWEyZmU4ZmI2NjgxYjRlYWZiYjZkYTI1YTYyMzQ4NjZhJywgJy11
JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklH
VVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1l
JywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNo
ZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC11NjdhZDB3bS9zcmMvZG9j
a2VyLXNyYy4yMDIwLTA1LTI1LTIxLjQ4LjI3LjIzMjIxOi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPWEyZmU4ZmI2NjgxYjRlYWZiYjZkYTI1YTYyMzQ4NjZhCm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXU2N2FkMHdtL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtZGVidWdAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDRtMTQuNTIwcwp1c2VyICAgIDBt
OC43MDBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDUyNTEzNDEwMS4yNDc0MC0xLWtyYXhlbEByZWRoYXQuY29tL3Rlc3RpbmcuYXNh
bi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

