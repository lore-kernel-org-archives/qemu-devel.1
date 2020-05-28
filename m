Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C06C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8326208A7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8326208A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOBU-0001oK-0V
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeOAJ-0000oF-UQ; Thu, 28 May 2020 15:26:07 -0400
Resent-Date: Thu, 28 May 2020 15:26:07 -0400
Resent-Message-Id: <E1jeOAJ-0000oF-UQ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeOAH-0007NP-O2; Thu, 28 May 2020 15:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590693953; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c2EFVQrXCFZPyfF/aWO15Q1diSWjFcqkFbtxOd9SQtHcRX4tCBbRpBaaNMGEWiCmCI6XW+vclFZZhSg+XAavE9Pu++n4S6hUhGMYjwL5jxClx0PCoDyttzj2PKb4++RGV1MLvW+3Dxum5cHN9yCtm65MACL1TqSJaomyezYjLoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590693953;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=asCDpoXj7AVedWp8mswn8KD3YetPHszID9FN6AclA1Q=; 
 b=K02Kv+Qz3TK1QbwHefv9wx1LOOQmupI2eecYUOt8uODdzBB9BU7tkqDxKdOvhZ/n4Fpn4fHF0Azk7atZhXeeR4fkjE0yXSf4FA1/naz+LyPcVAp1FvR+vzjwqqVWcz0zkCsJnxc3RCoGE8KP2YzpA+lT8OG3iYz5BQAu4j40OvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590693950039299.8939020208626;
 Thu, 28 May 2020 12:25:50 -0700 (PDT)
Message-ID: <159069394828.20666.8800325140315031525@45ef0f9c86ae>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
Subject: Re: [PULL 00/21] Vga 20200528 patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 28 May 2020 12:25:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:26:02
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
Cc: peter.maydell@linaro.org, i.mitsyanko@gmail.com, alistair@alistair23.me,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, kraxel@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyODEyMzYwOS4yNzM2
Mi0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUyODEyMzYwOS4yNzM2Mi0xLWtyYXhlbEByZWRo
YXQuY29tClN1YmplY3Q6IFtQVUxMIDAwLzIxXSBWZ2EgMjAyMDA1MjggcGF0Y2hlcwpUeXBlOiBz
ZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAy
MDA1MjgxNTM3NDIuMjc0MTY0LTEta3dvbGZAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNTI4
MTUzNzQyLjI3NDE2NC0xLWt3b2xmQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0Jwo5ZjJkZThjIHNtNTAxOiBSZW1vdmUgb2Jzb2xldGUgY2hhbmdlbG9nIGFuZCB0b2Rv
IGNvbW1lbnQKNDBjNjE3OSBzbTUwMTogT3B0aW1pemUgc21hbGwgb3ZlcmxhcHBpbmcgYmxpdHMK
YTU3ZjU0OSBzbTUwMTogUmVwbGFjZSBoYW5kIHdyaXR0ZW4gaW1wbGVtZW50YXRpb24gd2l0aCBw
aXhtYW4gd2hlcmUgcG9zc2libGUKNzU3ZWI5NCBzbTUwMTogQ2xlYW4gdXAgbG9jYWwgdmFyaWFi
bGVzIGluIHNtNTAxXzJkX29wZXJhdGlvbgo4ZDhlM2JlIHNtNTAxOiBVc2UgQklUKHgpIG1hY3Jv
IHRvIHNob3J0ZW4gY29uc3RhbnQKZTdiYWEwYiBzbTUwMTogU2hvcnRlbiBsb25nIHZhcmlhYmxl
IG5hbWVzIGluIHNtNTAxXzJkX29wZXJhdGlvbgpiMDM4NTkwIHNtNTAxOiBDb252ZXJ0IHByaW50
ZiArIGFib3J0IHRvIHFlbXVfbG9nX21hc2sKYTUyNGIxMSBody9kaXNwbGF5L3B4YTJ4eF9sY2Q6
IFJlcGxhY2UgcHJpbnRmKCkgY2FsbCBieSBxZW11X2xvZ19tYXNrKCkKNDEwMDBmMSBody9kaXNw
bGF5L29tYXBfZHNzOiBSZXBsYWNlIGZwcmludGYoKSBjYWxsIGJ5IHFlbXVfbG9nX21hc2soTE9H
X1VOSU1QKQpkYWQzMmYzIGh3L2Rpc3BsYXkvZXh5bm9zNDIxMF9maW1kOiBVc2UgcWVtdV9sb2df
bWFzayhHVUVTVF9FUlJPUikKOThiNmQxYiBody9kaXNwbGF5L3Ztd2FyZV92Z2E6IExldCB0aGUg
UENJIGRldmljZSBvd24gaXRzIEkvTyBNZW1vcnlSZWdpb24KZjFlYWRhYyBody9kaXNwbGF5L3Zt
d2FyZV92Z2E6IFJlcGxhY2UgcHJpbnRmKCkgY2FsbHMgYnkgcWVtdV9sb2dfbWFzayhFUlJPUikK
NmFkMWUzOSBody9kaXNwbGF5L3hsbnhfZHA6IFJlcGxhY2UgZGlzYWJsZWQgRFBSSU5URigpIGJ5
IGVycm9yX3JlcG9ydCgpCjNjZmZjNTkgaHcvZGlzcGxheS9kcGNkOiBDb252ZXJ0IGRlYnVnIHBy
aW50ZigpcyB0byB0cmFjZSBldmVudHMKZTM1OTA4NCBody9kaXNwbGF5L2RwY2Q6IEZpeCBtZW1v
cnkgcmVnaW9uIHNpemUKMGUxOTk3MyBody9kaXNwbGF5L2NpcnJ1c192Z2E6IENvbnZlcnQgZGVi
dWcgcHJpbnRmKCkgdG8gdHJhY2UgZXZlbnQKOTdmMzY5ZiBody9kaXNwbGF5L2NpcnJ1c192Z2E6
IFVzZSBxZW11X2xvZ19tYXNrKEVSUk9SKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50ZgowNzU4NTY2
IGh3L2Rpc3BsYXkvY2lycnVzX3ZnYTogVXNlIHFlbXVfbG9nX21hc2soVU5JTVApIGluc3RlYWQg
b2YgZGVidWcgcHJpbnRmCjQ2ZjQ3ODIgaHcvZGlzcGxheS9jaXJydXNfdmdhOiBDb252ZXJ0IGRl
YnVnIHByaW50ZigpIHRvIHRyYWNlIGV2ZW50CjRlMmQ0N2YgaHcvZGlzcGxheS9jZzM6IENvbnZl
cnQgZGVidWcgcHJpbnRmKClzIHRvIHRyYWNlIGV2ZW50cwo2MGE0MTQ2IGh3L2Rpc3BsYXkvZWRp
ZDogQWRkIG1pc3NpbmcgJ3FkZXYtcHJvcGVydGllcy5oJyBoZWFkZXIKCj09PSBPVVRQVVQgQkVH
SU4gPT09CjEvMjEgQ2hlY2tpbmcgY29tbWl0IDYwYTQxNDZkZmYzNCAoaHcvZGlzcGxheS9lZGlk
OiBBZGQgbWlzc2luZyAncWRldi1wcm9wZXJ0aWVzLmgnIGhlYWRlcikKMi8yMSBDaGVja2luZyBj
b21taXQgNGUyZDQ3ZjgyYzFlIChody9kaXNwbGF5L2NnMzogQ29udmVydCBkZWJ1ZyBwcmludGYo
KXMgdG8gdHJhY2UgZXZlbnRzKQozLzIxIENoZWNraW5nIGNvbW1pdCA0NmY0NzgyMmVmZWEgKGh3
L2Rpc3BsYXkvY2lycnVzX3ZnYTogQ29udmVydCBkZWJ1ZyBwcmludGYoKSB0byB0cmFjZSBldmVu
dCkKNC8yMSBDaGVja2luZyBjb21taXQgMDc1ODU2NmI1YTA5IChody9kaXNwbGF5L2NpcnJ1c192
Z2E6IFVzZSBxZW11X2xvZ19tYXNrKFVOSU1QKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50ZikKNS8y
MSBDaGVja2luZyBjb21taXQgOTdmMzY5ZjI0NzlkIChody9kaXNwbGF5L2NpcnJ1c192Z2E6IFVz
ZSBxZW11X2xvZ19tYXNrKEVSUk9SKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50ZikKRVJST1I6IHN1
c3BlY3QgY29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDE2LCAxMikKIzM0
OiBGSUxFOiBody9kaXNwbGF5L2NpcnJ1c192Z2EuYzoxMDM4OgogICAgICAgICAgICAgICAgaWYg
KHMtPmNpcnJ1c19ibHRfcGl4ZWx3aWR0aCA+IDIpIHsKKyAgICAgICAgICAgIHFlbXVfbG9nX21h
c2soTE9HX0dVRVNUX0VSUk9SLAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNTYgbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggNS8yMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi8yMSBD
aGVja2luZyBjb21taXQgMGUxOTk3MzY2MTVlIChody9kaXNwbGF5L2NpcnJ1c192Z2E6IENvbnZl
cnQgZGVidWcgcHJpbnRmKCkgdG8gdHJhY2UgZXZlbnQpCjcvMjEgQ2hlY2tpbmcgY29tbWl0IGUz
NTkwODQyY2M2MyAoaHcvZGlzcGxheS9kcGNkOiBGaXggbWVtb3J5IHJlZ2lvbiBzaXplKQo4LzIx
IENoZWNraW5nIGNvbW1pdCAzY2ZmYzU5MGRkYzEgKGh3L2Rpc3BsYXkvZHBjZDogQ29udmVydCBk
ZWJ1ZyBwcmludGYoKXMgdG8gdHJhY2UgZXZlbnRzKQo5LzIxIENoZWNraW5nIGNvbW1pdCA2YWQx
ZTM5OGIzYTEgKGh3L2Rpc3BsYXkveGxueF9kcDogUmVwbGFjZSBkaXNhYmxlZCBEUFJJTlRGKCkg
YnkgZXJyb3JfcmVwb3J0KCkpCjEwLzIxIENoZWNraW5nIGNvbW1pdCBmMWVhZGFjYmYxN2IgKGh3
L2Rpc3BsYXkvdm13YXJlX3ZnYTogUmVwbGFjZSBwcmludGYoKSBjYWxscyBieSBxZW11X2xvZ19t
YXNrKEVSUk9SKSkKMTEvMjEgQ2hlY2tpbmcgY29tbWl0IDk4YjZkMWIyODRiMSAoaHcvZGlzcGxh
eS92bXdhcmVfdmdhOiBMZXQgdGhlIFBDSSBkZXZpY2Ugb3duIGl0cyBJL08gTWVtb3J5UmVnaW9u
KQoxMi8yMSBDaGVja2luZyBjb21taXQgZGFkMzJmM2IyZDdhIChody9kaXNwbGF5L2V4eW5vczQy
MTBfZmltZDogVXNlIHFlbXVfbG9nX21hc2soR1VFU1RfRVJST1IpKQoxMy8yMSBDaGVja2luZyBj
b21taXQgNDEwMDBmMTk4NzJjIChody9kaXNwbGF5L29tYXBfZHNzOiBSZXBsYWNlIGZwcmludGYo
KSBjYWxsIGJ5IHFlbXVfbG9nX21hc2soTE9HX1VOSU1QKSkKMTQvMjEgQ2hlY2tpbmcgY29tbWl0
IGE1MjRiMTFhMmNiMyAoaHcvZGlzcGxheS9weGEyeHhfbGNkOiBSZXBsYWNlIHByaW50ZigpIGNh
bGwgYnkgcWVtdV9sb2dfbWFzaygpKQoxNS8yMSBDaGVja2luZyBjb21taXQgYjAzODU5MDE2NDY3
IChzbTUwMTogQ29udmVydCBwcmludGYgKyBhYm9ydCB0byBxZW11X2xvZ19tYXNrKQoxNi8yMSBD
aGVja2luZyBjb21taXQgZTdiYWEwYjRiZGRlIChzbTUwMTogU2hvcnRlbiBsb25nIHZhcmlhYmxl
IG5hbWVzIGluIHNtNTAxXzJkX29wZXJhdGlvbikKMTcvMjEgQ2hlY2tpbmcgY29tbWl0IDhkOGUz
YmU0MDc5NiAoc201MDE6IFVzZSBCSVQoeCkgbWFjcm8gdG8gc2hvcnRlbiBjb25zdGFudCkKMTgv
MjEgQ2hlY2tpbmcgY29tbWl0IDc1N2ViOTRiZDAwNyAoc201MDE6IENsZWFuIHVwIGxvY2FsIHZh
cmlhYmxlcyBpbiBzbTUwMV8yZF9vcGVyYXRpb24pCjE5LzIxIENoZWNraW5nIGNvbW1pdCBhNTdm
NTQ5ODQ2YTEgKHNtNTAxOiBSZXBsYWNlIGhhbmQgd3JpdHRlbiBpbXBsZW1lbnRhdGlvbiB3aXRo
IHBpeG1hbiB3aGVyZSBwb3NzaWJsZSkKMjAvMjEgQ2hlY2tpbmcgY29tbWl0IDQwYzYxNzk5MjVm
MCAoc201MDE6IE9wdGltaXplIHNtYWxsIG92ZXJsYXBwaW5nIGJsaXRzKQoyMS8yMSBDaGVja2lu
ZyBjb21taXQgOWYyZGU4YzcwMmEzIChzbTUwMTogUmVtb3ZlIG9ic29sZXRlIGNoYW5nZWxvZyBh
bmQgdG9kbyBjb21tZW50KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDUyODEyMzYwOS4yNzM2Mi0xLWtyYXhlbEByZWRoYXQuY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

