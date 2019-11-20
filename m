Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E988BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C135E223D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 02:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C135E223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXFJK-0000OW-QX
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 21:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iXFID-00080g-7s
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iXFIB-0004bw-HJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:00:28 -0500
Resent-Date: Tue, 19 Nov 2019 21:00:28 -0500
Resent-Message-Id: <E1iXFIB-0004bw-HJ@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iXFIB-0004Ws-BI
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 21:00:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574215214; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bip/5C2GDQR85ZDnZYxQSjrRqg79YLSpG6NtS9AJGmOStw4MC+Q5wtk/kcBSot5UvXt6H9HYLelRoLO+r/58u9BGnEz6vDQQOvIroZhSbjXRFHq8qczpmcjCWXZjeOThsda5R3A4ixCg0Suce7BT3r9fMUXwNPnbKF+X9D06uQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574215214;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Cjm3Y5ILOY8aRcyNcIqTgIE7zcdnJ3P1/vqIh1JICt0=; 
 b=IQ4bozj7CzzGfPObDL4hz1K5jBRtd/ImRP673AkNtJH5spB7X5nbOwPEjpJo7FK1QVdiw4AP381RNLnPygH8j5y3mheqN6MoHtV7uZJVBv976Puh2ZxLYK/NoJHfiJA+a2wvP2mM6fh9t2YFlGJgVRuFDm9z0cl+VNLoVibaAyw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574215212861323.98159380686604;
 Tue, 19 Nov 2019 18:00:12 -0800 (PST)
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [PULL 00/12] Misc patches for QEMU 4.2-rc
Message-ID: <157421521182.2797.15337357350909803331@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 19 Nov 2019 18:00:12 -0800 (PST)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc0MTc5NzI4LTM1NTM1LTEt
Z2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMDAvMTJdIE1pc2MgcGF0Y2hl
cyBmb3IgUUVNVSA0LjItcmMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NzQxNzk3MjgtMzU1
MzUtMS1naXQtc2VuZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBl
eGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiMTMx
MzZmIG1jMTQ2ODE4cnRjOiBmaXggdGltZXIgaW50ZXJydXB0IHJlaW5qZWN0aW9uIGFnYWluCmM4
YWJhMjMgUmV2ZXJ0ICJtYzE0NjgxOHJ0YzogZml4IHRpbWVyIGludGVycnVwdCByZWluamVjdGlv
biIKZThhZGNhYiBzY3NpOiBkZXByZWNhdGUgc2NzaS1kaXNrCjQyMDkyYzUgaHcvaTM4NjogTW92
ZSBzYXZlX3RzY19raHogZnJvbSBQQ01hY2hpbmVDbGFzcyB0byBYODZNYWNoaW5lQ2xhc3MKMDZj
NzQ3MSBkb2NzL21pY3Jvdm0ucnN0OiBhZGQgaW5zdHJ1Y3Rpb25zIGZvciBzaHV0dGluZyBkb3du
IHRoZSBndWVzdAoxM2MwYzlkIGRvY3MvbWljcm92bS5yc3Q6IGZpeCBhbGlnbm1lbnQgaW4gIkxp
bWl0YXRpb25zIgowMmY3ODI2IGh3L2kzODY6IEZpeCBjb21waWxlciB3YXJuaW5nIHdoZW4gQ09O
RklHX0lERV9JU0EgaXMgZGlzYWJsZWQKOTA2MjE5NCB0YXJnZXQvaTM4NjogRXhwb3J0IFRBQV9O
TyBiaXQgdG8gZ3Vlc3RzCjE5NTAwNzUgdGFyZ2V0L2kzODY6IGFkZCBQU0NIQU5HRV9OTyBiaXQg
Zm9yIHRoZSBBUkNIX0NBUEFCSUxJVElFUyBNU1IKODg1ODI1ZSBtaWNyb3ZtOiBmaXggbWVtb3J5
IGxlYWsgaW4gbWljcm92bV9maXhfa2VybmVsX2NtZGxpbmUKN2VmZGZiMSBzY3JpcHRzOiBEZXRl
Y3QgZ2l0IHdvcmt0cmVlcyBmb3IgZ2V0X21haW50YWluZXIucGwgLS1naXQKCj09PSBPVVRQVVQg
QkVHSU4gPT09CjEvMTEgQ2hlY2tpbmcgY29tbWl0IDdlZmRmYjE4MTc5ZiAoc2NyaXB0czogRGV0
ZWN0IGdpdCB3b3JrdHJlZXMgZm9yIGdldF9tYWludGFpbmVyLnBsIC0tZ2l0KQoyLzExIENoZWNr
aW5nIGNvbW1pdCA4ODU4MjVlNWYzNDMgKG1pY3Jvdm06IGZpeCBtZW1vcnkgbGVhayBpbiBtaWNy
b3ZtX2ZpeF9rZXJuZWxfY21kbGluZSkKMy8xMSBDaGVja2luZyBjb21taXQgMTk1MDA3NTBkMTdj
ICh0YXJnZXQvaTM4NjogYWRkIFBTQ0hBTkdFX05PIGJpdCBmb3IgdGhlIEFSQ0hfQ0FQQUJJTElU
SUVTIE1TUikKNC8xMSBDaGVja2luZyBjb21taXQgOTA2MjE5NDhmOGY0ICh0YXJnZXQvaTM4Njog
RXhwb3J0IFRBQV9OTyBiaXQgdG8gZ3Vlc3RzKQo1LzExIENoZWNraW5nIGNvbW1pdCAwMmY3ODI2
MDQ1YTYgKGh3L2kzODY6IEZpeCBjb21waWxlciB3YXJuaW5nIHdoZW4gQ09ORklHX0lERV9JU0Eg
aXMgZGlzYWJsZWQpCjYvMTEgQ2hlY2tpbmcgY29tbWl0IDEzYzBjOWQ5MzBhMyAoZG9jcy9taWNy
b3ZtLnJzdDogZml4IGFsaWdubWVudCBpbiAiTGltaXRhdGlvbnMiKQo3LzExIENoZWNraW5nIGNv
bW1pdCAwNmM3NDcxNDE0NzEgKGRvY3MvbWljcm92bS5yc3Q6IGFkZCBpbnN0cnVjdGlvbnMgZm9y
IHNodXR0aW5nIGRvd24gdGhlIGd1ZXN0KQo4LzExIENoZWNraW5nIGNvbW1pdCA0MjA5MmM1ZTgy
OGMgKGh3L2kzODY6IE1vdmUgc2F2ZV90c2Nfa2h6IGZyb20gUENNYWNoaW5lQ2xhc3MgdG8gWDg2
TWFjaGluZUNsYXNzKQo5LzExIENoZWNraW5nIGNvbW1pdCBlOGFkY2FiODVjYzQgKHNjc2k6IGRl
cHJlY2F0ZSBzY3NpLWRpc2spCjEwLzExIENoZWNraW5nIGNvbW1pdCBjOGFiYTIzMzE0NjggKFJl
dmVydCAibWMxNDY4MThydGM6IGZpeCB0aW1lciBpbnRlcnJ1cHQgcmVpbmplY3Rpb24iKQoxMS8x
MSBDaGVja2luZyBjb21taXQgYjEzMTM2ZmZlZTUwIChtYzE0NjgxOHJ0YzogZml4IHRpbWVyIGlu
dGVycnVwdCByZWluamVjdGlvbiBhZ2FpbikKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJz
CiMzMzogRklMRTogaHcvcnRjL21jMTQ2ODE4cnRjLmM6MTcxOgorcGVyaW9kaWNfdGltZXJfdXBk
YXRlKFJUQ1N0YXRlICpzLCBpbnQ2NF90IGN1cnJlbnRfdGltZSwgdWludDMyX3Qgb2xkX3Blcmlv
ZCwgYm9vbCBwZXJpb2RfY2hhbmdlKQoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMK
IzEwMTogRklMRTogaHcvcnRjL21jMTQ2ODE4cnRjLmM6ODA4OgorICAgICAgICAgICAgcGVyaW9k
aWNfdGltZXJfdXBkYXRlKHMsIHFlbXVfY2xvY2tfZ2V0X25zKHJ0Y19jbG9jayksIHMtPnBlcmlv
ZCwgZmFsc2UpOwoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA2OSBsaW5lcyBjaGVja2Vk
CgpQYXRjaCAxMS8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3NDE3OTcyOC0zNTUzNS0xLWdp
dC1zZW5kLWVtYWlsLXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


