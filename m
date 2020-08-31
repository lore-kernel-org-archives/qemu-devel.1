Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE8C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239112068E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239112068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCobW-0007wZ-9W
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kCoao-0007W3-5O
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:31:46 -0400
Resent-Date: Mon, 31 Aug 2020 14:31:46 -0400
Resent-Message-Id: <E1kCoao-0007W3-5O@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kCoal-0006Lv-PA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598898690; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CcTRegQVLqT/SWm3cPqwsHIdYTR+t2CvHdK78m8pZh9l32w/r+Ycb24WDdtxUeKPAo0l5hh1DGprHL0V9CwrNd3oc+/cpe9djXUOH9O2RXFTqn9iGFux05UlvJM6eof6sp6fOzkgHtjZ8K5Z7t1camKhgWrF78CtIfulpBFb2p4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598898690;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=jxANCojl1yQbggAzrNdw2ok9AZ56R94FtJxYoL0ijs4=; 
 b=GZEdx2p2fPE/5ZSttYz3tqc5y9igKz72PmygZNIHo95UC6PxZY57aYgUroC9NoK14+8P/N/puHwaeay8ekmO+zCgZKWvqdfyoQlXfCbe5o+4YAU0JGg44GW0hkS2wn+m8TxTx9fC+RfWiegKGIlpaEIC/QHNUOXjnU+ycg3E96w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1598898689576872.631693368587;
 Mon, 31 Aug 2020 11:31:29 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] pc-bios: s390x: Cleanup part 2
Message-ID: <159889868824.5668.13582270939572327054@66eaa9a8a123>
In-Reply-To: <20200831150910.317171-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Mon, 31 Aug 2020 11:31:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:31:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgzMTE1MDkxMC4zMTcx
NzEtMS1mcmFua2phQGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDgzMTE1MDkxMC4z
MTcxNzEtMS1mcmFua2phQGxpbnV4LmlibS5jb20KU3ViamVjdDogW1BBVENIIHYzIDAvNV0gcGMt
YmlvczogczM5MHg6IENsZWFudXAgcGFydCAyCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDgzMTE1MDkxMC4zMTcxNzEtMS1mcmFua2ph
QGxpbnV4LmlibS5jb20gLT4gcGF0Y2hldy8yMDIwMDgzMTE1MDkxMC4zMTcxNzEtMS1mcmFua2ph
QGxpbnV4LmlibS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2MmM2YzE4IHBj
LWJpb3M6IHMzOTB4OiBHbyBpbnRvIGRpc2FibGVkIHdhaXQgd2hlbiBlbmNvdW50ZXJpbmcgYSBQ
R00gZXhjZXB0aW9uCjI4YTY4ZTQgcGMtYmlvczogczM5MHg6IFNhdmUgaW8gYW5kIGV4dGVybmFs
IG5ldyBQU1dzIGJlZm9yZSBvdmVyd3JpdGluZyB0aGVtCjU4YWVjOWUgcGMtYmlvczogczM5MHg6
IFVzZSByZXNldCBQU1cgaWYgYXZhbGlhYmxlCmI0Y2YwNDAgcGMtYmlvczogczM5MHg6IFNhdmUg
UFNXIHJld29yawozMGJhYjFhIHBjLWJpb3M6IHMzOTB4OiBGaXggYm9vdG1hcC5jIHppcGwgY29t
cG9uZW50IGVudHJ5IGRhdGEgaGFuZGxpbmcKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNSBDaGVj
a2luZyBjb21taXQgMzBiYWIxYWU3NTM2IChwYy1iaW9zOiBzMzkweDogRml4IGJvb3RtYXAuYyB6
aXBsIGNvbXBvbmVudCBlbnRyeSBkYXRhIGhhbmRsaW5nKQoyLzUgQ2hlY2tpbmcgY29tbWl0IGI0
Y2YwNDBhMWU1MyAocGMtYmlvczogczM5MHg6IFNhdmUgUFNXIHJld29yaykKMy81IENoZWNraW5n
IGNvbW1pdCA1OGFlYzllZmQxNTcgKHBjLWJpb3M6IHMzOTB4OiBVc2UgcmVzZXQgUFNXIGlmIGF2
YWxpYWJsZSkKNC81IENoZWNraW5nIGNvbW1pdCAyOGE2OGU0NTAzYjEgKHBjLWJpb3M6IHMzOTB4
OiBTYXZlIGlvIGFuZCBleHRlcm5hbCBuZXcgUFNXcyBiZWZvcmUgb3ZlcndyaXRpbmcgdGhlbSkK
RVJST1I6IGV4dGVybnMgc2hvdWxkIGJlIGF2b2lkZWQgaW4gLmMgZmlsZXMKIzIyOiBGSUxFOiBw
Yy1iaW9zL3MzOTAtY2N3L2p1bXAyaXBsLmM6MTc6CitleHRlcm4gdWludDY0X3QgcHN3X3NhdmVf
aW9bXSwgcHN3X3NhdmVfZXh0W107Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDExOCBs
aW5lcyBjaGVja2VkCgpQYXRjaCA0LzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvNSBD
aGVja2luZyBjb21taXQgNjJjNmMxODdjOTBmIChwYy1iaW9zOiBzMzkweDogR28gaW50byBkaXNh
YmxlZCB3YWl0IHdoZW4gZW5jb3VudGVyaW5nIGEgUEdNIGV4Y2VwdGlvbikKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MzExNTA5MTAuMzE3
MTcxLTEtZnJhbmtqYUBsaW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

