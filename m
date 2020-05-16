Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1127FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 08:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D734D205CB
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 08:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D734D205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZsDF-0004nl-TK
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 04:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZsCb-0004DI-GR; Sat, 16 May 2020 04:29:49 -0400
Resent-Date: Sat, 16 May 2020 04:29:49 -0400
Resent-Message-Id: <E1jZsCb-0004DI-GR@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZsCZ-0006GK-SN; Sat, 16 May 2020 04:29:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589617766; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ys0rGXWNJZMZHJKvHcN9cr/5akj6qbdTh4sc+6CzPMrtgRQOSIBHjeBhJEbX5A8k14XA28XCRGh80IrnTZiqYEswMAQeBx5Nb6GiRooW4iUNc0TDLL6G6xkvFLpeSR+gETKiGBO4IR/kAC0R8F6sZpYaYJUQW9oNHqSRNqplu7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589617766;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DjJr4v9gIVXllfOBzHiNzBTok5T2DQkadVFzpwxoMpw=; 
 b=Ensuji0IY/TnRqWKJIFtWgd6NoUJx68m7x0001Kx58BR3M6Pqqx+gCqG7zJh+SDQOT98xDr7hY+H9lOF11QJ6VXaxHbv4vj6OlHSihvar8ShaFjDrIuFs7RYSbpoyBZQrb68hPp9DvNp0cjurnW5Wkpvsg/N+9kVehudRAoEH0o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589617764883266.97711975474;
 Sat, 16 May 2020 01:29:24 -0700 (PDT)
Message-ID: <158961776278.15373.15563171252292830868@45ef0f9c86ae>
In-Reply-To: <20200515150421.25479-1-kraxel@redhat.com>
Subject: Re: [PATCH v6 00/16] acpi: i386 tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Sat, 16 May 2020 01:29:24 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 23:45:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: lvivier@redhat.com, kwolf@redhat.com, thuth@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, marcandre.lureau@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, jsnow@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNTE1MDQyMS4yNTQ3
OS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUxNTE1MDQyMS4yNTQ3OS0xLWtyYXhlbEByZWRo
YXQuY29tClN1YmplY3Q6IFtQQVRDSCB2NiAwMC8xNl0gYWNwaTogaTM4NiB0d2Vha3MKVHlwZTog
c2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0Jwo2OWZmMmI5IGFjcGk6IHEzNTogZHJvcCBfU0IuUENJMC5JU0Eu
TFBDRCBvcHJlZ2lvbi4KMGU2MDhlMSBhY3BpOiBkcm9wIGJ1aWxkX3BpaXg0X3BtKCkKNzliYjQx
ZiBhY3BpOiBkcm9wIHNlcmlhbC9wYXJhbGxlbCBlbmFibGUgYml0cyBmcm9tIGRzZHQKM2Q0ODNl
MSBhY3BpOiBzaW1wbGlmeSBidWlsZF9pc2FfZGV2aWNlc19hbWwoKQpjOWRiMzVlIGFjcGk6IGZh
Y3RvciBvdXQgZndfY2ZnX2FkZF9hY3BpX2RzZHQoKQo0ZDBjNWJhIGFjcGk6IG1vdmUgYW1sIGJ1
aWxkZXIgY29kZSBmb3IgaTgwNDIgKGtiZCttb3VzZSkgZGV2aWNlCmRiOWE1ZmEgZmxvcHB5OiBt
b3ZlIGNtb3NfZ2V0X2ZkX2RyaXZlX3R5cGUoKSBmcm9tIHBjCjNkOTlhNGQgZmxvcHB5OiBtYWtl
IGlzYV9mZGNfZ2V0X2RyaXZlX21heF9jaHMgc3RhdGljCjUwZWMzODMgYWNwaTogbW92ZSBhbWwg
YnVpbGRlciBjb2RlIGZvciBmbG9wcHkgZGV2aWNlCmNhNTg1YzAgYWNwaTogbW92ZSBhbWwgYnVp
bGRlciBjb2RlIGZvciBwYXJhbGxlbCBkZXZpY2UKZGI0MzhkMCBhY3BpOiBwYXJhbGxlbDogZG9u
J3QgdXNlIF9TVEEgbWV0aG9kCjZhNTU1MGQgYWNwaTogbW92ZSBhbWwgYnVpbGRlciBjb2RlIGZv
ciBzZXJpYWwgZGV2aWNlCjU4NWQzMDggYWNwaTogc2VyaWFsOiBkb24ndCB1c2UgX1NUQSBtZXRo
b2QKNjM5MGRjYiBhY3BpOiBydGM6IHVzZSBhIHNpbmdsZSBjcnMgcmFuZ2UKNzMwZWRhNyBhY3Bp
OiBtb3ZlIGFtbCBidWlsZGVyIGNvZGUgZm9yIHJ0YyBkZXZpY2UKMGY1OGRmYSBxdGVzdDogYWxs
b3cgRFNEVCBhY3BpIHRhYmxlIGNoYW5nZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hl
Y2tpbmcgY29tbWl0IDBmNThkZmFmMDNkMiAocXRlc3Q6IGFsbG93IERTRFQgYWNwaSB0YWJsZSBj
aGFuZ2VzKQoyLzE2IENoZWNraW5nIGNvbW1pdCA3MzBlZGE3NWYzMmYgKGFjcGk6IG1vdmUgYW1s
IGJ1aWxkZXIgY29kZSBmb3IgcnRjIGRldmljZSkKMy8xNiBDaGVja2luZyBjb21taXQgNjM5MGRj
YmM3NjA2IChhY3BpOiBydGM6IHVzZSBhIHNpbmdsZSBjcnMgcmFuZ2UpCjQvMTYgQ2hlY2tpbmcg
Y29tbWl0IDU4NWQzMDhiNWE3MyAoYWNwaTogc2VyaWFsOiBkb24ndCB1c2UgX1NUQSBtZXRob2Qp
CjUvMTYgQ2hlY2tpbmcgY29tbWl0IDZhNTU1MGQ2MTA2OSAoYWNwaTogbW92ZSBhbWwgYnVpbGRl
ciBjb2RlIGZvciBzZXJpYWwgZGV2aWNlKQo2LzE2IENoZWNraW5nIGNvbW1pdCBkYjQzOGQwOTQ2
ODQgKGFjcGk6IHBhcmFsbGVsOiBkb24ndCB1c2UgX1NUQSBtZXRob2QpCjcvMTYgQ2hlY2tpbmcg
Y29tbWl0IGNhNTg1YzA3YzMzOCAoYWNwaTogbW92ZSBhbWwgYnVpbGRlciBjb2RlIGZvciBwYXJh
bGxlbCBkZXZpY2UpCjgvMTYgQ2hlY2tpbmcgY29tbWl0IDUwZWMzODMwODdmMSAoYWNwaTogbW92
ZSBhbWwgYnVpbGRlciBjb2RlIGZvciBmbG9wcHkgZGV2aWNlKQpXQVJOSU5HOiBhZGRlZCwgbW92
ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMy
NDU6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAy
MjEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC8xNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo5
LzE2IENoZWNraW5nIGNvbW1pdCAzZDk5YTRkYWU3MTYgKGZsb3BweTogbWFrZSBpc2FfZmRjX2dl
dF9kcml2ZV9tYXhfY2hzIHN0YXRpYykKMTAvMTYgQ2hlY2tpbmcgY29tbWl0IGRiOWE1ZmEwMGZh
MyAoZmxvcHB5OiBtb3ZlIGNtb3NfZ2V0X2ZkX2RyaXZlX3R5cGUoKSBmcm9tIHBjKQpFUlJPUjog
TWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDgyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDEwLzE2IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgoxMS8xNiBDaGVja2luZyBjb21taXQgNGQwYzViYWI2ZGFlIChhY3BpOiBtb3ZlIGFtbCBi
dWlsZGVyIGNvZGUgZm9yIGk4MDQyIChrYmQrbW91c2UpIGRldmljZSkKMTIvMTYgQ2hlY2tpbmcg
Y29tbWl0IGM5ZGIzNWViMmM3MyAoYWNwaTogZmFjdG9yIG91dCBmd19jZmdfYWRkX2FjcGlfZHNk
dCgpKQoxMy8xNiBDaGVja2luZyBjb21taXQgM2Q0ODNlMTgxMGM3IChhY3BpOiBzaW1wbGlmeSBi
dWlsZF9pc2FfZGV2aWNlc19hbWwoKSkKMTQvMTYgQ2hlY2tpbmcgY29tbWl0IDc5YmI0MWY3MDFm
MyAoYWNwaTogZHJvcCBzZXJpYWwvcGFyYWxsZWwgZW5hYmxlIGJpdHMgZnJvbSBkc2R0KQoxNS8x
NiBDaGVja2luZyBjb21taXQgMGU2MDhlMTg5ODAwIChhY3BpOiBkcm9wIGJ1aWxkX3BpaXg0X3Bt
KCkpCjE2LzE2IENoZWNraW5nIGNvbW1pdCA2OWZmMmI5MWM4NmIgKGFjcGk6IHEzNTogZHJvcCBf
U0IuUENJMC5JU0EuTFBDRCBvcHJlZ2lvbi4pCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTE1MTUwNDIxLjI1NDc5LTEta3JheGVsQHJlZGhh
dC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

