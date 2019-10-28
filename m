Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC83CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCB6208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCB6208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0Gi-0007Vf-6Q
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iP0FU-00068H-U5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iP0FT-00084I-5h
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:19:36 -0400
Resent-Date: Mon, 28 Oct 2019 04:19:36 -0400
Resent-Message-Id: <E1iP0FT-00084I-5h@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iP0FS-00083c-Sk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572250729; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q0jwmsVOz/gU+kRovDlO6m13MPYbZ8+PguYllx0e9viMBtCV1cwjJLoFv/QTrb4sQ5vl4v58R1qL7d4Eq3W+ZSBn+84TlNEVRjhVqE44Vw7Lqp37za0IfkMD/n12NC665lQo2MxC4UiUFmGegNj6ViqBrxey+fpeU1j4EPaFAFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572250729;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7mgu7QMh+XMZNAHBRt2zT6lq6h33DZRL+PsQrvR373U=; 
 b=cPN6yhYKYUa3Ec0STrZDtkxsHtI5XlvPrKnxyEBN358+upYoG+i5Vu8gVr/BdkSG21rbcMy+WGj7pGOWMTebLAfhpAG9dFLZa/7Twogmcd7ZnH0NeGV0LqUzK9dvWHODeDnPw5Hnre/R0tHj3mSwTfy9yyuogAu6N4EwJ4VPcmI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157225072717163.52354486831166;
 Mon, 28 Oct 2019 01:18:47 -0700 (PDT)
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
Subject: Re: [PATCH 00/26] tests/acceptance: Queue for 4.2
Message-ID: <157225072538.4191.11906984032119042461@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Mon, 28 Oct 2019 01:18:47 -0700 (PDT)
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
Cc: fam@euphon.net, kamil@netbsd.org, ehabkost@redhat.com,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, chouteau@adacore.com,
 frederic.konrad@adacore.com, wainersm@redhat.com, crosa@redhat.com,
 aleksandar.rikalo@rt-rk.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyODA3MzQ0MS42NDQ4
LTEtcGhpbG1kQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGJsb2Nr
L2RtZy5vCiAgQ0MgICAgICBibG9jay9xY293Mi5vCgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9y
OgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy9kZXZlbC90ZXN0aW5nLnJzdDo2Mjk6VGl0bGUgdW5k
ZXJsaW5lIHRvbyBzaG9ydC4KClRoZSBgYGF2b2NhZG9fcWVtdS5NYWNoaW5lVGVzdGBgIGJhc2Ug
dGVzdCBjbGFzcwotLS0KICBDQyAgICAgIGJsb2NrL3NuYXBzaG90Lm8KICBDQyAgICAgIGJsb2Nr
L2ZpbGUtd2luMzIubwogIENDICAgICAgYmxvY2svd2luMzItYWlvLm8KbWFrZTogKioqIFtNYWtl
ZmlsZToxMDAxOiBkb2NzL2RldmVsL2luZGV4Lmh0bWxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9k
dWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NTkzY2QzOTVmZjA3
NGFhZmIzNDMxOGRmZDAzODRmMTgnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2Nj
YWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1tZDYw
anB0My9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTI4LTA0LjE2LjU0LjEwNTMzOi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3
J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJl
bD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTU5M2NkMzk1ZmYwNzRhYWZiMzQzMThkZmQwMzg0ZjE4
Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW1kNjBqcHQzL3NyYycKbWFrZTogKioq
IFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDFtNTEuMjE5
cwp1c2VyICAgIDBtNy40MTRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAyODA3MzQ0MS42NDQ4LTEtcGhpbG1kQHJlZGhhdC5jb20v
dGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


