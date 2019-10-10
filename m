Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211CAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 23:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED618206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 23:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED618206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIiEu-0001WE-3z
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 19:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIiDQ-000134-FT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 19:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIiDO-0005VY-TS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 19:51:28 -0400
Resent-Date: Thu, 10 Oct 2019 19:51:28 -0400
Resent-Message-Id: <E1iIiDO-0005VY-TS@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIiDN-0005T7-1j
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 19:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570751472; cv=none; d=zoho.com; s=zohoarc; 
 b=nUzUSz/jTt1uNMX/8L99phU2ie5d/h85UO5kIPZWIEIGiy3QGopdHCN7+UOEd3UVRf/tHP/+afDZdDIzIn+vsr2gJfQQrANgKkT7E76JEoLgWwf3EuTdrdEzHFkrhHAVnU/gTvLwRGlHISTDB5j0qpgSDY8oUmx6B7QEpGJuoYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570751472;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1J1Pdy4oZseqAFmYrTV9YXm4yOAEu8/DwwIyn1hLhBE=; 
 b=De04kKWDfOnD5qg7wOBaYYaF7j9fWCkZmdAIdq9Qs9bNDA7JtpYfNFN/pJsBVT8lCqBnqcQeWTZJfDIq3lv1s8PXMBEcAyALEcl4AnxFoR6AHmPDXArWlvMzmm9EqeNXs+bwWOIG6QH1rBrMSHzdoF1mednT4l5DMPv05rkq2Qo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570751471690149.8146693444006;
 Thu, 10 Oct 2019 16:51:11 -0700 (PDT)
In-Reply-To: <20191010205242.711-1-eric.auger@redhat.com>
Subject: Re: [PATCH v4] migration: Support gtree migration
Message-ID: <157075147039.11314.1969255003096566830@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Thu, 10 Oct 2019 16:51:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, eric.auger@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMDIwNTI0Mi43MTEt
MS1lcmljLmF1Z2VyQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGJs
b2NrL25iZC5vCiAgQ0MgICAgICBibG9jay9zaGVlcGRvZy5vCiAgQ0MgICAgICBibG9jay9hY2Nv
dW50aW5nLm8KbWFrZTogKioqIFtNYWtlZmlsZTo5OTQ6IGRvY3MvaW50ZXJvcC9pbmRleC5odG1s
XSBFcnJvciAyCm1ha2U6ICoqKiBEZWxldGluZyBmaWxlICdkb2NzL2ludGVyb3AvaW5kZXguaHRt
bCcKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrICht
b3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9YjA2NjVhNmIxMzNlNDdjNzgxMjM4NDUyZDUzYWFiZjEnLCAnLXUnLCAnMTAwMycsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1l
JywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC1mOXUyMWoydi9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTEwLTE5LjQ4LjQ1
LjI3MDg6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YjA2NjVhNmIxMzNlNDdj
NzgxMjM4NDUyZDUzYWFiZjEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZjl1MjFq
MnYvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIK
CnJlYWwgICAgMm0yNS4xODFzCnVzZXIgICAgMG03LjQ1NXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDEwMjA1MjQyLjcxMS0xLWVy
aWMuYXVnZXJAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=


