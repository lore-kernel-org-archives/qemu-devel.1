Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E8B20767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E8B20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXaN-0007il-SY
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joXZA-0006Rx-Ul
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:29:46 -0400
Resent-Date: Thu, 25 Jun 2020 15:29:44 -0400
Resent-Message-Id: <E1joXZA-0006Rx-Ul@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joXZ5-0007MT-ML
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:29:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593113368; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hOag4oVd4RkEfXCDF1TLpgMEhaojnOvsjJjX1i2A35n+XbsHSo7OMcUfSi9F3uxRNgYmeNKC1gcRMm1EyfIzFysoacvop3H4MbD3XJ4O6QuVyttfhoLwZcm/fEByFY1CLLae5dEF5lEiyxd8rTQQ/BG0R60PBO0vkoUhg9Otlag=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593113368;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=eKEAGeM8d8/luivS5wDqi6OkTix5rXHiBQl2Fawhxns=; 
 b=kNtYroUd5C3G/O106jGHTTFtaZaXWEcbgdzfpWLT/VM/MvUhmKaXnX4plEqr3l0HHXLGoi7t5CyZNaJV+O8UuVY2/wufBvtUVFQ+xg2pC0l3JFG+KKfECmqw7lMDLxUMPqQQOr598W51gKmOsrDBybTUX1J1wGV/KQ9++l6IVkQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593113366137817.8291891869176;
 Thu, 25 Jun 2020 12:29:26 -0700 (PDT)
Message-ID: <159311336469.25974.763596705743975012@d1fd068a5071>
Subject: Re: [RFC 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
In-Reply-To: <20200625191651.5817-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eperezma@redhat.com
Date: Thu, 25 Jun 2020 12:29:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:27:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, avi@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNTE5MTY1MS41ODE3
LTEtZXBlcmV6bWFAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1JGQyAwLzFdIG1lbW9yeTogRGVsZXRlIGFzc2VydGlvbiBp
biBtZW1vcnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMjAwNjI1MTkxNjUxLjU4MTctMS1lcGVyZXptYUByZWRoYXQuY29tCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDYy
NTE5MTY1MS41ODE3LTEtZXBlcmV6bWFAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNjI1MTkx
NjUxLjU4MTctMS1lcGVyZXptYUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKM2RjYjEyMCBtZW1vcnk6IERlbGV0ZSBhc3NlcnRpb24gaW4gbWVtb3J5X3JlZ2lvbl91
bnJlZ2lzdGVyX2lvbW11X25vdGlmaWVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogZG8g
bm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzI0OiBGSUxFOiBtZW1vcnkuYzoxOTE4OgorICAgIC8v
IGFzc2VydChlbnRyeS0+aW92YSA+PSBub3RpZmllci0+c3RhcnQgJiYgZW50cnlfZW5kIDw9IG5v
dGlmaWVyLT5lbmQpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCAzZGNiMTIwNDIyM2EgKG1lbW9yeTogRGVsZXRlIGFzc2VydGlvbiBpbiBtZW1v
cnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIpIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwNjI1MTkxNjUxLjU4MTctMS1lcGVyZXptYUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

