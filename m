Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F7C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047F5206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047F5206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCpv-0001Yv-6I
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYCmh-00050h-TY
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:04:11 -0400
Resent-Date: Mon, 11 May 2020 14:04:11 -0400
Resent-Message-Id: <E1jYCmh-00050h-TY@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYCmg-0001Gn-Q6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:04:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589220237; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aHzLXB3g79dVj83XD8Xw1HqpGGcTapHWslgD5af1it3ZVmV2GCT6PtFEeGl8EH2xVCgatgkOZhYntxEjrOO39sWj8Qvzyyk1yAp/jrud1f7w1yqyplaly6rfMrV7Ji0A5QaAXT8S646ANP5Cw9/YvyHH6UFOz2v0MAmsJQ7Vaxo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589220237;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ssaolsH5abo67FAkqXSmOEtkFvN5GuWgVBOOO+PPKw0=; 
 b=eN++gFyutOpkWflrncMbmZw80Up/2O8aN9kpQ2cVo7mbY/JC6ONUNVP04ZCIWyhfVbS8l4T3Yg7AD2udeNftLeHMz8OracXayw+DsHje3OA15MXDNDtsPsq4ImtHviYVfI1bcVfdh29hoBkrVAMcgPqPpfEYDjY47WbyHLEzUMg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589220235660534.5215559568405;
 Mon, 11 May 2020 11:03:55 -0700 (PDT)
Message-ID: <158922023425.26583.1084030649985843744@45ef0f9c86ae>
In-Reply-To: <20200511160951.8733-1-mlevitsk@redhat.com>
Subject: Re: [PATCH v2 0/7] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Mon, 11 May 2020 11:03:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 14:03:32
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
Cc: fam@euphon.net, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, mlevitsk@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMTE2MDk1MS44NzMz
LTEtbWxldml0c2tAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MTExNjA5NTEuODczMy0xLW1sZXZpdHNrQHJl
ZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYyIDAvN10gUkZDL1dJUDogRml4IHNjc2kgZGV2aWNl
cyBwbHVnL3VucGx1ZyByYWNlcyB3LnIudCB2aXJ0aW8tc2NzaSBpb3RocmVhZApUeXBlOiBzZXJp
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCmYxMGFjYzYgdmlydGlvLXNjc2k6IHVzZSBzY3NpX2RldmljZV9nZXQK
NGIyOGU0MSBzY3NpOiBBZGQgc2NzaV9kZXZpY2VfZ2V0Cjk2OWM3ODQgdmlydGlvLXNjc2k6IGRv
bid0IHRvdWNoIHNjc2kgZGV2aWNlcyB0aGF0IGFyZSBub3QgeWV0IHJlYWxpemVkIG9yIGFib3V0
IHRvIGJlIHVuLXJlYWxpemVkCmM5NWMzM2YgZGV2aWNlLWNvcmU6IHVzZSBhdG9taWNfc2V0IG9u
IC5yZWFsaXplZCBwcm9wZXJ0eQoyMzlhOGNlIGRldmljZS1jb3JlOiB1c2UgUkNVIGZvciBsaXN0
IG9mIGNoaWxkcyBvZiBhIGJ1cwpkZDBjM2E4IEltcGxlbWVudCBkcmFpbl9jYWxsX3JjdSBhbmQg
dXNlIGl0IGluIGhtcF9kZXZpY2VfZGVsCmNjN2EwODUgc2NzaS9zY3NpX2J1czogc3dpdGNoIHNl
YXJjaCBkaXJlY3Rpb24gaW4gc2NzaV9kZXZpY2VfZmluZAoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
MS83IENoZWNraW5nIGNvbW1pdCBjYzdhMDg1YzJjNTkgKHNjc2kvc2NzaV9idXM6IHN3aXRjaCBz
ZWFyY2ggZGlyZWN0aW9uIGluIHNjc2lfZGV2aWNlX2ZpbmQpCjIvNyBDaGVja2luZyBjb21taXQg
ZGQwYzNhOGNmZDliIChJbXBsZW1lbnQgZHJhaW5fY2FsbF9yY3UgYW5kIHVzZSBpdCBpbiBobXBf
ZGV2aWNlX2RlbCkKMy83IENoZWNraW5nIGNvbW1pdCAyMzlhOGNlZTNjNjAgKGRldmljZS1jb3Jl
OiB1c2UgUkNVIGZvciBsaXN0IG9mIGNoaWxkcyBvZiBhIGJ1cykKNC83IENoZWNraW5nIGNvbW1p
dCBjOTVjMzNmNGE3ZGMgKGRldmljZS1jb3JlOiB1c2UgYXRvbWljX3NldCBvbiAucmVhbGl6ZWQg
cHJvcGVydHkpCjUvNyBDaGVja2luZyBjb21taXQgOTY5Yzc4NGI4ZDhlICh2aXJ0aW8tc2NzaTog
ZG9uJ3QgdG91Y2ggc2NzaSBkZXZpY2VzIHRoYXQgYXJlIG5vdCB5ZXQgcmVhbGl6ZWQgb3IgYWJv
dXQgdG8gYmUgdW4tcmVhbGl6ZWQpCjYvNyBDaGVja2luZyBjb21taXQgNGIyOGU0MWVlNzcyIChz
Y3NpOiBBZGQgc2NzaV9kZXZpY2VfZ2V0KQpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSB0
cmFpbGluZyAqLyBvbiBhIHNlcGFyYXRlIGxpbmUKIzI5OiBGSUxFOiBody9zY3NpL3Njc2ktYnVz
LmM6MTU5MjoKKyAqICovCgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBh
cm1zIG9mIHRoaXMgc3RhdGVtZW50CiM2NzogRklMRTogaHcvc2NzaS9zY3NpLWJ1cy5jOjE2MzA6
CisgICAgaWYgKCFkZXYpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDY2IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDYvNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNy83IENo
ZWNraW5nIGNvbW1pdCBmMTBhY2M2MzFjZjcgKHZpcnRpby1zY3NpOiB1c2Ugc2NzaV9kZXZpY2Vf
Z2V0KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDIwMDUxMTE2MDk1MS44NzMzLTEtbWxldml0c2tAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

