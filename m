Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB720C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B2126CCE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B2126CCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkzo-0001cW-VY
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:07:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWkyM-0000xO-Kf
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWkyL-00066G-4S
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:05:42 -0400
Resent-Date: Fri, 31 May 2019 13:05:42 -0400
Resent-Message-Id: <E1hWkyL-00066G-4S@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hWkyJ-0005uI-9p
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:05:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559319513; cv=none; d=zoho.com; s=zohoarc; 
	b=aJyyMOcFE5frvCiTWTIdcWj5jz+fQkE8Z0R77B1hcEaIJg0lrcUCu7aDckxIo1SEQDc7czqqJHDR0d+1UBuTNxBD2iqYlIUO3l3wGfPUsRH3vFhWrb8+povjSwtokVzVRJfIDI4pctqKlyKZ2FmVQuu0TLt8VqIyv1ATe5ECdAo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559319513;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=SkWGZBZ9BhVLu8XbGCUPtzKgVXcBVtFAfQFg6VZ+Udw=; 
	b=fYSzd8m0prcBtgR97bYxOX174UFzFIx1LdslAX8jTJCyGB1fqv8wUvdVnagZwi9QBIw8o8adTH0OLIT3maTGMRHNYYfB4J9GtpPHeCBGk440PX7uGeR7/VNwgaIv5lW+uCmAiQtV/O+kw7rE5Brihp7OCykV/b1Apuym9Di9AP4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 155931951101099.43089206900481;
	Fri, 31 May 2019 09:18:31 -0700 (PDT)
In-Reply-To: <20190531154735.20809-1-philmd@redhat.com>
Message-ID: <155931950942.4137.194678647486612190@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Fri, 31 May 2019 09:18:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: peter.maydell@linaro.org, arikalo@wavecomp.com, alex.bennee@linaro.org,
	richard.henderson@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
	mrezanin@redhat.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUzMTE1NDczNS4yMDgw
OS0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1JGQyBQQVRDSCAwLzJdIHRhcmdldDog
QnVpbGQgd2l0aCBDT05GSUdfU0VNSUhPU1RJTkcgZGlzYWJsZWQKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMTkwNTMxMTU0NzM1LjIwODA5LTEtcGhpbG1kQHJlZGhhdC5jb20KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkw
NTMxMTU0NzM1LjIwODA5LTEtcGhpbG1kQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDUzMTE1
NDczNS4yMDgwOS0xLXBoaWxtZEByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKMzAzZmJjODExZiB0YXJnZXQvbWlwczogQWRkIHN0dWJzIHRvIGJ1aWxkIHdpdGggQ09O
RklHX1NFTUlIT1NUSU5HIGRpc2FibGVkCmFhZDFiZDg1ZTEgdGFyZ2V0L2FybTogQWRkIHN0dWJz
IHRvIGJ1aWxkIHdpdGggQ09ORklHX1NFTUlIT1NUSU5HIGRpc2FibGVkCgo9PT0gT1VUUFVUIEJF
R0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IGFhZDFiZDg1ZTFlNSAodGFyZ2V0L2FybTogQWRk
IHN0dWJzIHRvIGJ1aWxkIHdpdGggQ09ORklHX1NFTUlIT1NUSU5HIGRpc2FibGVkKQpXQVJOSU5H
OiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQg
dXBkYXRpbmc/CiM0MDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEg
d2FybmluZ3MsIDI3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMiBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoyLzIgQ2hlY2tpbmcgY29tbWl0IDMwM2ZiYzgxMWYyNCAodGFyZ2V0L21pcHM6IEFk
ZCBzdHVicyB0byBidWlsZCB3aXRoIENPTkZJR19TRU1JSE9TVElORyBkaXNhYmxlZCkKV0FSTklO
RzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVk
IHVwZGF0aW5nPwojNDA6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGV4dGVybnMgc2hv
dWxkIGJlIGF2b2lkZWQgaW4gLmMgZmlsZXMKIzYyOiBGSUxFOiB0YXJnZXQvbWlwcy9taXBzLXNl
bWktc3R1YnMuYzoxODoKK2V4dGVybiB2b2lkIGhlbHBlcl9kb19zZW1paG9zdGluZyhDUFVNSVBT
U3RhdGUgKmVudik7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDMwIGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDIvMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA1MzExNTQ3MzUuMjA4MDkt
MS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


