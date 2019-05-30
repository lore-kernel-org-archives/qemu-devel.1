Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F46C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBC32576C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBC32576C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWFv8-0002rl-Gj
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 03:56:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWFtv-0002Ai-Ez
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWFtu-0006Ym-59
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:55:03 -0400
Resent-Date: Thu, 30 May 2019 03:55:03 -0400
Resent-Message-Id: <E1hWFtu-0006Ym-59@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hWFtt-0006YM-TX
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559202847; cv=none; d=zoho.com; s=zohoarc; 
	b=V/fXQgiG0LMCiDXzh3JapdhG6iQYNYz2QeMXmL5tjb5At0dQILQA9OsjXXmTdJI8Oby4EfsdXKuM+tPsHBh7kuRn0VBOdYkRQLiFSQl6eOnl2ZtD6dBOl6TowFhgZjBo/ly9OsTlu0znuFAHfXFPXXki6SHRc7QcFPM+zOh6XgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559202847;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=ZMdpE4yv1cpGFJjk29UCUUrRq2XME/Gj4+ytZ72LlzE=; 
	b=Xe3zaN58kFxhSVmikVpG4/zwjLsrUqKJyWjLPhV49hlSaLHtvaKY598swCqEvfvPhjUKLUfduQjXtW5S46re0a8kSzI70dBIwSlf99+XBM0G8Dy9CtkgmARy7JgrYjPeiWm2t7bWeYeyhxo4DQu2HXnjje2DHHQ5kV7IrFR2J+U=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559202846496192.148363570387;
	Thu, 30 May 2019 00:54:06 -0700 (PDT)
In-Reply-To: <20190530073205.5293-1-kwolf@redhat.com>
Message-ID: <155920284527.9187.14210063698054538086@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwolf@redhat.com
Date: Thu, 30 May 2019 00:54:06 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3 0/6] file-posix: Add
 dynamic-auto-read-only QAPI feature
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUzMDA3MzIwNS41Mjkz
LTEta3dvbGZAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFzYW4g
YnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91
dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJs
eSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14ODZf
NjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKY2xhbmcr
KyAtTC90bXAvcWVtdS10ZXN0L2J1aWxkL2R0Yy9saWJmZHQgIC1JL3Vzci9pbmNsdWRlL3BpeG1h
bi0xICAtSS90bXAvcWVtdS10ZXN0L3NyYy9kdGMvbGliZmR0IC1XZXJyb3IgLURIQVNfTElCU1NI
Ml9TRlRQX0ZTWU5DICAtcHRocmVhZCAtSS91c3IvaW5jbHVkZS9nbGliLTIuMCAtSS91c3IvbGli
NjQvZ2xpYi0yLjAvaW5jbHVkZSAgLWZQSUUgLURQSUUgLW02NCAtbWN4MTYgLURfR05VX1NPVVJD
RSAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1EX0xBUkdFRklMRV9TT1VSQ0UgLVdzdHJpY3QtcHJv
dG90eXBlcyAtV3JlZHVuZGFudC1kZWNscyAtV2FsbCAtV3VuZGVmIC1Xd3JpdGUtc3RyaW5ncyAt
V21pc3NpbmctcHJvdG90eXBlcyAtZm5vLXN0cmljdC1hbGlhc2luZyAtZm5vLWNvbW1vbiAtZndy
YXB2IC1zdGQ9Z251OTkgIC1Xbm8tc3RyaW5nLXBsdXMtaW50IC1Xbm8tdHlwZWRlZi1yZWRlZmlu
aXRpb24gLVduby1pbml0aWFsaXplci1vdmVycmlkZXMgLVdleHBhbnNpb24tdG8tZGVmaW5lZCAt
V2VuZGlmLWxhYmVscyAtV25vLXNoaWZ0LW5lZ2F0aXZlLXZhbHVlIC1Xbm8tbWlzc2luZy1pbmNs
dWRlLWRpcnMgLVdlbXB0eS1ib2R5IC1XbmVzdGVkLWV4dGVybnMgLVdmb3JtYXQtc2VjdXJpdHkg
LVdmb3JtYXQteTJrIC1XaW5pdC1zZWxmIC1XaWdub3JlZC1xdWFsaWZpZXJzIC1Xb2xkLXN0eWxl
LWRlZmluaXRpb24gLVd0eXBlLWxpbWl0cyAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgIC1JL3Vz
ci9pbmNsdWRlL3AxMS1raXQtMSAgICAgLUkvdXNyL2luY2x1ZGUvbGlicG5nMTYgIC1JL3Vzci9p
bmNsdWRlL3NwaWNlLTEgLUkvdXNyL2luY2x1ZGUvc3BpY2Utc2VydmVyIC1JL3Vzci9pbmNsdWRl
L2NhY2FyZCAtSS91c3IvaW5jbHVkZS9nbGliLTIuMCAtSS91c3IvbGliNjQvZ2xpYi0yLjAvaW5j
bHVkZSAtSS91c3IvaW5jbHVkZS9uc3MzIC1JL3Vzci9pbmNsdWRlL25zcHI0IC1wdGhyZWFkIC1J
L3Vzci9pbmNsdWRlL2xpYm1vdW50IC1JL3Vzci9pbmNsdWRlL2Jsa2lkIC1JL3Vzci9pbmNsdWRl
L3V1aWQgLUkvdXNyL2luY2x1ZGUvcGl4bWFuLTEgICAtSS90bXAvcWVtdS10ZXN0L3NyYy90ZXN0
cyAtZnNhbml0aXplPXVuZGVmaW5lZCAtZnNhbml0aXplPWFkZHJlc3MgLWcgIC1XbCwtLXdhcm4t
Y29tbW9uIC1XbCwteixyZWxybyAtV2wsLXosbm93IC1waWUgLW02NCAtZyAgLW8gdGVzdHMvdGVz
dC1vcHRzLXZpc2l0b3IgdGVzdHMvdGVzdC1vcHRzLXZpc2l0b3IubyB0ZXN0cy90ZXN0LXFhcGkt
dHlwZXMubyB0ZXN0cy9pbmNsdWRlL3Rlc3QtcWFwaS10eXBlcy1zdWItbW9kdWxlLm8gdGVzdHMv
dGVzdC1xYXBpLXR5cGVzLXN1Yi1zdWItbW9kdWxlLm8gdGVzdHMvdGVzdC1xYXBpLXZpc2l0Lm8g
dGVzdHMvaW5jbHVkZS90ZXN0LXFhcGktdmlzaXQtc3ViLW1vZHVsZS5vIHRlc3RzL3Rlc3QtcWFw
aS12aXNpdC1zdWItc3ViLW1vZHVsZS5vIHRlc3RzL3Rlc3QtcWFwaS1pbnRyb3NwZWN0Lm8gcW9t
L29iamVjdC5vIHFvbS9jb250YWluZXIubyBxb20vcW9tLXFvYmplY3QubyBxb20vb2JqZWN0X2lu
dGVyZmFjZXMubyAgbGlicWVtdXV0aWwuYSAgIC1sbSAtbHogIC1sZ3RocmVhZC0yLjAgLXB0aHJl
YWQgLWxnbGliLTIuMCAgLWxuZXR0bGUgIC1sZ251dGxzICAgLWxydCAtbHogLWx1dGlsIC1sY2Fw
LW5nIAovdXNyL2Jpbi9sZDogdGVzdHMvdGVzdC1xYXBpLWNvbW1hbmRzLm86IGluIGZ1bmN0aW9u
IGBxbXBfbWFyc2hhbF90ZXN0X2ZlYXR1cmVzJzoKL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMv
dGVzdC1xYXBpLWNvbW1hbmRzLmM6NjkzOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBxbXBfdGVz
dF9mZWF0dXJlcycKY2xhbmctNzogZXJyb3I6IGxpbmtlciBjb21tYW5kIGZhaWxlZCB3aXRoIGV4
aXQgY29kZSAxICh1c2UgLXYgdG8gc2VlIGludm9jYXRpb24pCm1ha2U6ICoqKiBbL3RtcC9xZW11
LXRlc3Qvc3JjL3J1bGVzLm1hazoxMjQ6IHRlc3RzL3Rlc3QtcW1wLWNtZHNdIEVycm9yIDEKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZVsxXTogTGVhdmluZyBk
aXJlY3RvcnkgJy90bXAvcWVtdS10ZXN0L2J1aWxkL3Rlc3RzL2ZwJwoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA1MzAwNzMyMDUuNTI5
My0xLWt3b2xmQHJlZGhhdC5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


