Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499D8C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2081F24249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2081F24249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuge-0003Py-42
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1icub6-0005WF-TR
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1icub5-0005rt-5E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:07:24 -0500
Resent-Date: Thu, 05 Dec 2019 12:07:24 -0500
Resent-Message-Id: <E1icub5-0005rt-5E@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1icub4-0005hV-Rs
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:07:23 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575565630; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=by10fFvWjjqXFWeR2DRLGSNP+iLVbT74TppbEahnQFfaSyDRpM/U4y+rWq6tbcDMr6tnIN1Q7JvzKzNvyOiuEVGvFzc6KvEv7B/ScF7jgZfmRl2rewvOMyMmhZe0wF46/98y3rWsZlokUUR+vokeQwmjy4AhlPuwpHzQMokxKao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575565630;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RqZxDVZBceSbGTdF2qwMxsq0Ioeo4aSef7fc5Blfmng=; 
 b=G2gqtl5pEH+SR/fcjtf/jpwW/e04nYs8HAmdH/nFuFFAhMjIGcuslgly2pgL0XcKSiFk/X9TRNH2/a45VZkP56hrMrOGZAFu1tWrJxVnnKhkpMQa8MvCi7RuPZKnf3uM1VwA5BAuhrrE1z90jK5CIs5+6Yk82P8bbbZNQpvmT4I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575565627875236.3926562708872;
 Thu, 5 Dec 2019 09:07:07 -0800 (PST)
In-Reply-To: <20191205140645.6071-1-aastier@freebox.fr>
Subject: Re: [PATCH] socket: websocket refresh of max_size outside of poll
Message-ID: <157556562680.28471.17998029208459109470@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aastier@freebox.fr
Date: Thu, 5 Dec 2019 09:07:07 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: aastier@freebox.fr, berrange@redhat.com, jusual@mail.ru,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwNTE0MDY0NS42MDcx
LTEtYWFzdGllckBmcmVlYm94LmZyLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHNvY2tldDogd2Vic29ja2V0IHJlZnJlc2ggb2Yg
bWF4X3NpemUgb3V0c2lkZSBvZiBwb2xsClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTIw
NTE0MDY0NS42MDcxLTEtYWFzdGllckBmcmVlYm94LmZyCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoxN2M1N2RkIHNv
Y2tldDogd2Vic29ja2V0IHJlZnJlc2ggb2YgbWF4X3NpemUgb3V0c2lkZSBvZiBwb2xsCgo9PT0g
T1VUUFVUIEJFR0lOID09PQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBh
cmVudGhlc2lzICcoJwojMzE6IEZJTEU6IGNoYXJkZXYvY2hhci1zb2NrZXQuYzo1MDg6CisgICAg
aWYocy0+aXNfd2Vic29jaykKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMzMjog
RklMRTogY2hhcmRldi9jaGFyLXNvY2tldC5jOjUwOToKKyAgICAgICAgLyogR3JlZWR5IHJlYWRl
ciBkb2VzIG5vdCBoYXZlIGV2ZW50IGxvb3AgcmVmcmVzaCBieSB0Y3BfY2hyX3JlYWRfcG9sbCAq
LwoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA5IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAx
N2M1N2RkZjgzMTAgKHNvY2tldDogd2Vic29ja2V0IHJlZnJlc2ggb2YgbWF4X3NpemUgb3V0c2lk
ZSBvZiBwb2xsKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTIwNTE0MDY0NS42MDcxLTEtYWFz
dGllckBmcmVlYm94LmZyL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


