Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C496C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319CC21848
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319CC21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Kwv-000736-D8
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i2Kue-0005UC-U6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i2Kua-0003I9-59
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:44:22 -0400
Resent-Date: Mon, 26 Aug 2019 15:44:21 -0400
Resent-Message-Id: <E1i2Kua-0003I9-59@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i2KuX-0003Hf-US
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:44:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566848631; cv=none; d=zoho.com; s=zohoarc; 
 b=diUSYosgdrlyYnRDbbVSEEFHeClXCBLVIBg8e6XrYWDEsb6AYitfFnn+wWFWqndvoFPkfTRFBk+cxbruP19Objnx9sUN7Zm426OxgRRoKIGu7vNlYNu6ZNfEjPivnMeeS+KTFGIz3UJ5tFeXuIELCxngCMh7YAPPSFoM6vbju3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566848631;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=sgrfpD78TwoZS7lzinW24ZW0lxuB9LvHCeDzBmvnTP8=; 
 b=eOnC9r/sCDhDPEEoTYeh9INy6abd4ZExiHVhF/lerSkF/ocL9oV3n+UgF69+S1m/czYeTSv0ZNXaHK9xYx22jlhzUQRHhZIRIsoXlteN1fq3aVe47Do9WegWZXsd3VBwpIibeudGrVlIxtkKHPB8Siy7DdbgVIjBiMVi/mi313c=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566848624365304.30781536638904;
 Mon, 26 Aug 2019 12:43:44 -0700 (PDT)
In-Reply-To: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
Message-ID: <156684862078.8645.17844959654259899849@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwankhede@nvidia.com
Date: Mon, 26 Aug 2019 12:43:44 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v8 00/13] Add migration support for VFIO
 device
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, zhi.a.wang@intel.com,
 jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY2ODQ1NzUzLTE4OTkzLTEt
Z2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNTY2ODQ1
NzUzLTE4OTkzLTEtZ2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20KU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSCB2OCAwMC8xM10gQWRkIG1pZ3JhdGlvbiBzdXBwb3J0IGZvciBW
RklPIGRldmljZQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5n
IDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBu
ZXcgYnJhbmNoICd0ZXN0JwowYWViYTM4IHZmaW86IE1ha2UgdmZpby1wY2kgZGV2aWNlIG1pZ3Jh
dGlvbiBjYXBhYmxlLgphY2MwZDJiIHZmaW86IEFkZCB2ZmlvX2xpc3RlbmVyX2xvZ19zeW5jIHRv
IG1hcmsgZGlydHkgcGFnZXMKY2IxMWNkNiB2ZmlvOiBBZGQgZnVuY3Rpb24gdG8gZ2V0IGRpcnR5
IHBhZ2UgbGlzdAo2ZDQ2MDQyIHZmaW86IEFkZCBsb2FkIHN0YXRlIGZ1bmN0aW9ucyB0byBTYXZl
Vk1IYW5kbGVycwoxZjg4NDI4IHZmaW86IEFkZCBzYXZlIHN0YXRlIGZ1bmN0aW9ucyB0byBTYXZl
Vk1IYW5kbGVycwpkMGZiZjE4IHZmaW86IFJlZ2lzdGVyIFNhdmVWTUhhbmRsZXJzIGZvciBWRklP
IGRldmljZQowNDA5N2UxIHZmaW86IEFkZCBtaWdyYXRpb24gc3RhdGUgY2hhbmdlIG5vdGlmaWVy
CmMzYjk4NTcgdmZpbzogQWRkIFZNIHN0YXRlIGNoYW5nZSBoYW5kbGVyIHRvIGtub3cgc3RhdGUg
b2YgVk0KYTcxMmEzYSB2ZmlvOiBBZGQgbWlncmF0aW9uIHJlZ2lvbiBpbml0aWFsaXphdGlvbiBh
bmQgZmluYWxpemUgZnVuY3Rpb24KNzhiNjkyMCB2ZmlvOiBBZGQgc2F2ZSBhbmQgbG9hZCBmdW5j
dGlvbnMgZm9yIFZGSU8gUENJIGRldmljZXMKMDMyZDI3MiB2ZmlvOiBBZGQgdmZpb19nZXRfb2Jq
ZWN0IGNhbGxiYWNrIHRvIFZGSU9EZXZpY2VPcHMKOTU4MTdlZCB2ZmlvOiBBZGQgZnVuY3Rpb24g
dG8gdW5tYXAgVkZJTyByZWdpb24KZWFmNWJlNSB2ZmlvOiBLQUJJIGZvciBtaWdyYXRpb24gaW50
ZXJmYWNlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzEzIENoZWNraW5nIGNvbW1pdCBlYWY1YmU1
Yjk0ZjMgKHZmaW86IEtBQkkgZm9yIG1pZ3JhdGlvbiBpbnRlcmZhY2UpCjIvMTMgQ2hlY2tpbmcg
Y29tbWl0IDk1ODE3ZWRjNDJmOSAodmZpbzogQWRkIGZ1bmN0aW9uIHRvIHVubWFwIFZGSU8gcmVn
aW9uKQozLzEzIENoZWNraW5nIGNvbW1pdCAwMzJkMjcyY2EzMTEgKHZmaW86IEFkZCB2ZmlvX2dl
dF9vYmplY3QgY2FsbGJhY2sgdG8gVkZJT0RldmljZU9wcykKNC8xMyBDaGVja2luZyBjb21taXQg
NzhiNjkyMDgyODg0ICh2ZmlvOiBBZGQgc2F2ZSBhbmQgbG9hZCBmdW5jdGlvbnMgZm9yIFZGSU8g
UENJIGRldmljZXMpCjUvMTMgQ2hlY2tpbmcgY29tbWl0IGE3MTJhM2E3NDcxMyAodmZpbzogQWRk
IG1pZ3JhdGlvbiByZWdpb24gaW5pdGlhbGl6YXRpb24gYW5kIGZpbmFsaXplIGZ1bmN0aW9uKQpX
QVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJT
IG5lZWQgdXBkYXRpbmc/CiMyOTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogZ19mcmVl
KE5VTEwpIGlzIHNhZmUgdGhpcyBjaGVjayBpcyBwcm9iYWJseSBub3QgcmVxdWlyZWQKIzE3MTog
RklMRTogaHcvdmZpby9taWdyYXRpb24uYzoxMzg6CisgICAgaWYgKHZiYXNlZGV2LT5taWdyYXRp
b24pIHsKKyAgICAgICAgZ19mcmVlKHZiYXNlZGV2LT5taWdyYXRpb24pOwoKdG90YWw6IDEgZXJy
b3JzLCAxIHdhcm5pbmdzLCAxNzggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS8xMyBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKNi8xMyBDaGVja2luZyBjb21taXQgYzNiOTg1NzVlMzliICh2Zmlv
OiBBZGQgVk0gc3RhdGUgY2hhbmdlIGhhbmRsZXIgdG8ga25vdyBzdGF0ZSBvZiBWTSkKNy8xMyBD
aGVja2luZyBjb21taXQgMDQwOTdlMTY3YzhiICh2ZmlvOiBBZGQgbWlncmF0aW9uIHN0YXRlIGNo
YW5nZSBub3RpZmllcikKOC8xMyBDaGVja2luZyBjb21taXQgZDBmYmYxODFiOWRiICh2ZmlvOiBS
ZWdpc3RlciBTYXZlVk1IYW5kbGVycyBmb3IgVkZJTyBkZXZpY2UpCjkvMTMgQ2hlY2tpbmcgY29t
bWl0IDFmODg0MjhhODM0MCAodmZpbzogQWRkIHNhdmUgc3RhdGUgZnVuY3Rpb25zIHRvIFNhdmVW
TUhhbmRsZXJzKQoxMC8xMyBDaGVja2luZyBjb21taXQgNmQ0NjA0MjE0M2I5ICh2ZmlvOiBBZGQg
bG9hZCBzdGF0ZSBmdW5jdGlvbnMgdG8gU2F2ZVZNSGFuZGxlcnMpCjExLzEzIENoZWNraW5nIGNv
bW1pdCBjYjExY2Q2MjI5ZjggKHZmaW86IEFkZCBmdW5jdGlvbiB0byBnZXQgZGlydHkgcGFnZSBs
aXN0KQoxMi8xMyBDaGVja2luZyBjb21taXQgYWNjMGQyYmFhYzdkICh2ZmlvOiBBZGQgdmZpb19s
aXN0ZW5lcl9sb2dfc3luYyB0byBtYXJrIGRpcnR5IHBhZ2VzKQoxMy8xMyBDaGVja2luZyBjb21t
aXQgMGFlYmEzODQ0NDdiICh2ZmlvOiBNYWtlIHZmaW8tcGNpIGRldmljZSBtaWdyYXRpb24gY2Fw
YWJsZS4pCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzE1NjY4NDU3NTMtMTg5OTMtMS1naXQtc2VuZC1lbWFpbC1rd2Fua2hlZGVAbnZpZGlhLmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


