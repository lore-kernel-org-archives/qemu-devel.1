Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA7EC43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A865F20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A865F20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMZQ-00015M-SA
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKMUh-0004n6-1e
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:08:44 -0400
Resent-Date: Mon, 21 Sep 2020 10:08:39 -0400
Resent-Message-Id: <E1kKMUh-0004n6-1e@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKMUd-0000HR-3I
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:08:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600697305; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mg+osyCE+GmiA/tbEBfc+82D06fzgOWvuNDsWSqloWeh1nMywVTcRBcRaOH/DtDxx2PUyqbUHh78Wk2yfpIkF+sljRGSZlhJkW059ZdTsAwXsLKEKdYFik/GhiPcTyYTGZWYTZeRvc19nAms0TxjRMzvdg/kiLDkWXf8OBZJQ5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600697305;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2TUdOq9ILCpA6hXcYf6/nWt4Ful6FXVWMrh6UzAmUgs=; 
 b=XYiPfGPDVmvI2xRQRIXhLOgaMBWesC6DvL4WMzzugmE04FFGy44jhjkl9y5ZyK6gGFkaKZKrzdhDp3NKXh6Ju+s1XtLIfmmE43tzLp5PWnYaZrQCHSc2Dilbmfbjaa+Q4mQ8SRZuJd+VnNCV3Klf5zwqeMKLHlM/HeEKmqzdZs8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 16006973038451021.3602729047459;
 Mon, 21 Sep 2020 07:08:23 -0700 (PDT)
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
Message-ID: <160069730268.23907.16716971959079980933@66eaa9a8a123>
In-Reply-To: <20200921112913.555392-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Mon, 21 Sep 2020 07:08:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 10:08:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMTExMjkxMy41NTUz
OTItMS1tc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTIxMTEyOTEzLjU1NTM5Mi0x
LW1zdEByZWRoYXQuY29tClN1YmplY3Q6IFtQVUxMIHYzIDAwLzE1XSB2aXJ0aW8scGMsYWNwaTog
Zml4ZXMsIHRlc3RzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBy
ZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCjVlZjQ1ZTMgdmlydGlvLWlvbW11LXBjaTogZm9yY2UgdmlydGlv
IHZlcnNpb24gMQplZTkxNzZiIHZpcnRpby1pb21tdTogQ2hlY2sgZ3RyZWVzIGFyZSBub24gbnVs
bCBiZWZvcmUgZGVzdHJveWluZyB0aGVtCjcwODAzNzU3IGNwaHA6IHJlbW92ZSBkZXByZWNhdGVk
IGNwdS1hZGQgY29tbWFuZChzKQo3NDdlMjUxIHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItdGVzdDog
ZW5hYmxlIHRoZSByZWNvbm5lY3QgdGVzdHMKYTI4Mzg4NCB0ZXN0cy9xdGVzdC92aG9zdC11c2Vy
LXRlc3Q6IGFkZCBtaWdyYXRlX3JlY29ubmVjdCB0ZXN0CjIxMTk5ZGEgdGVzdHMvcXRlc3Qvdmhv
c3QtdXNlci10ZXN0OiBhZGQgc3VwcG9ydCBmb3IgdGhlIHZob3N0LXVzZXItYmxrIGRldmljZQpk
MDdhMGRkIHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tYmxrOiBhZGQgc3VwcG9ydCBmb3Igdmhv
c3QtdXNlci1ibGsKMjcwYjkzZiB0ZXN0cy9xdGVzdC92aG9zdC11c2VyLXRlc3Q6IHByZXBhcmUg
dGhlIHRlc3RzIGZvciBhZGRpbmcgbmV3IGRldiBjbGFzcwo1YzJkODljIHZob3N0OiBjaGVjayBx
dWV1ZSBzdGF0ZSBpbiB0aGUgdmhvc3RfZGV2X3NldF9sb2cgcm91dGluZQo5MjlmYTFiIHZob3N0
OiByZWNoZWNrIGRldiBzdGF0ZSBpbiB0aGUgdmhvc3RfbWlncmF0aW9uX2xvZyByb3V0aW5lCjQy
Njc5NGIgcGM6IGZpeCBhdXRvX2VuYWJsZV9udW1hX3dpdGhfbWVtaHAvYXV0b19lbmFibGVfbnVt
YV93aXRoX21lbWRldiBmb3IgdGhlIDUuMCBtYWNoaW5lCmMwNmI4NzcgdmlydGlvLW1lbTogZGV0
YWNoIHRoZSBlbGVtZW50IGZyb20gdGhlIHZpcnRxdWV1ZSB3aGVuIGVycm9yIG9jY3VycwozOGRm
ZTIyIHZob3N0LXZkcGE6IGJhdGNoIHVwZGF0aW5nIElPVExCIG1hcHBpbmdzCmFhMjExNjcgdmhv
c3Q6IHN3aXRjaCB0byB1c2UgSU9UTEIgdjIgZm9ybWF0Cjc0NWUzOGIgbGludXggaGVhZGVyczog
c3luYyB0byA1LjktcmM0Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzE1IENoZWNraW5nIGNvbW1p
dCA3NDVlMzhiNTJhMjUgKGxpbnV4IGhlYWRlcnM6IHN5bmMgdG8gNS45LXJjNCkKMi8xNSBDaGVj
a2luZyBjb21taXQgYWEyMTE2Nzg5MjIyICh2aG9zdDogc3dpdGNoIHRvIHVzZSBJT1RMQiB2MiBm
b3JtYXQpCjMvMTUgQ2hlY2tpbmcgY29tbWl0IDM4ZGZlMjI5ZjNlMCAodmhvc3QtdmRwYTogYmF0
Y2ggdXBkYXRpbmcgSU9UTEIgbWFwcGluZ3MpCjQvMTUgQ2hlY2tpbmcgY29tbWl0IGMwNmI4Nzc5
Y2U2OCAodmlydGlvLW1lbTogZGV0YWNoIHRoZSBlbGVtZW50IGZyb20gdGhlIHZpcnRxdWV1ZSB3
aGVuIGVycm9yIG9jY3VycykKNS8xNSBDaGVja2luZyBjb21taXQgNDI2Nzk0YjQ0ZmM5IChwYzog
Zml4IGF1dG9fZW5hYmxlX251bWFfd2l0aF9tZW1ocC9hdXRvX2VuYWJsZV9udW1hX3dpdGhfbWVt
ZGV2IGZvciB0aGUgNS4wIG1hY2hpbmUpCjYvMTUgQ2hlY2tpbmcgY29tbWl0IDkyOWZhMWJmZmY4
ZSAodmhvc3Q6IHJlY2hlY2sgZGV2IHN0YXRlIGluIHRoZSB2aG9zdF9taWdyYXRpb25fbG9nIHJv
dXRpbmUpCjcvMTUgQ2hlY2tpbmcgY29tbWl0IDVjMmQ4OWNmY2E3ZSAodmhvc3Q6IGNoZWNrIHF1
ZXVlIHN0YXRlIGluIHRoZSB2aG9zdF9kZXZfc2V0X2xvZyByb3V0aW5lKQo4LzE1IENoZWNraW5n
IGNvbW1pdCAyNzBiOTNmNGU4ZDkgKHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItdGVzdDogcHJlcGFy
ZSB0aGUgdGVzdHMgZm9yIGFkZGluZyBuZXcgZGV2IGNsYXNzKQo5LzE1IENoZWNraW5nIGNvbW1p
dCBkMDdhMGRkYjYxOGEgKHRlc3RzL3F0ZXN0L2xpYnFvcy92aXJ0aW8tYmxrOiBhZGQgc3VwcG9y
dCBmb3Igdmhvc3QtdXNlci1ibGspCjEwLzE1IENoZWNraW5nIGNvbW1pdCAyMTE5OWRhNTI3Mzcg
KHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItdGVzdDogYWRkIHN1cHBvcnQgZm9yIHRoZSB2aG9zdC11
c2VyLWJsayBkZXZpY2UpCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzI1MjogRklMRTogdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci10ZXN0LmM6MTA3MDoKK15JICAgIHNp
emVvZihtc2ctPnBheWxvYWQuY29uZmlnLnJlZ2lvbikgKyBtc2ctPnBheWxvYWQuY29uZmlnLnNp
emU7JAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNTYgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggMTAvMTUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjExLzE1IENoZWNraW5nIGNvbW1p
dCBhMjgzODg0NGRhZGMgKHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItdGVzdDogYWRkIG1pZ3JhdGVf
cmVjb25uZWN0IHRlc3QpCjEyLzE1IENoZWNraW5nIGNvbW1pdCA3NDdlMjUxNWZmYWEgKHRlc3Rz
L3F0ZXN0L3Zob3N0LXVzZXItdGVzdDogZW5hYmxlIHRoZSByZWNvbm5lY3QgdGVzdHMpCjEzLzE1
IENoZWNraW5nIGNvbW1pdCA3MDgwMzc1N2U2ZjQgKGNwaHA6IHJlbW92ZSBkZXByZWNhdGVkIGNw
dS1hZGQgY29tbWFuZChzKSkKMTQvMTUgQ2hlY2tpbmcgY29tbWl0IGVlOTE3NmJlYmQzOCAodmly
dGlvLWlvbW11OiBDaGVjayBndHJlZXMgYXJlIG5vbiBudWxsIGJlZm9yZSBkZXN0cm95aW5nIHRo
ZW0pCjE1LzE1IENoZWNraW5nIGNvbW1pdCA1ZWY0NWUzMjJhMzAgKHZpcnRpby1pb21tdS1wY2k6
IGZvcmNlIHZpcnRpbyB2ZXJzaW9uIDEpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTIxMTEyOTEzLjU1NTM5Mi0xLW1zdEByZWRoYXQuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

