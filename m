Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26938C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE82925268
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE82925268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpw0z-0002iQ-8h
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpvyy-0007rj-Mr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:46:08 -0400
Resent-Date: Mon, 29 Jun 2020 11:46:08 -0400
Resent-Message-Id: <E1jpvyy-0007rj-Mr@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpvyv-0005g5-DN
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593445553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gyWRJAlTJxzclfV4pnh8fgb3ykLaEC7kGHEICFKObJdXA2OHr2jpTwtvlK5/vpm2nwY3eobhiq3q+YiMIXHH4cSnWVPy1UCVxC+Ciz//W6ZuzK61XPciX99UoibR24p0I8lNxuBi3kx5v+Gr2ELm7TkJwrbsrpycCq5WCPClvjI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593445553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=QAdjn2vAZT7d85GX+JvdYf4/FHskpiBft7FcM/zM2Uo=; 
 b=NtU0k3/iOm7rw7c68mRTCI73z24Jt7qWYgPHRUoJk27/sN/urp5LfeAgoGrEyWeWRtxpJ8BmBpJ++YNaytSwZ3LNU3XxHqvkVZzU0BwOTFx+pw6JIaMncbRY1177NmD+tNw4bY2zuBisACq34J7vUPwYc4aOOCth3F9zLJZTlwo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159344551592423.155462223089103;
 Mon, 29 Jun 2020 08:45:15 -0700 (PDT)
Message-ID: <159344551488.15477.7802905287480431571@d1fd068a5071>
Subject: Re: [PATCH] coverity: provide Coverity-friendly MIN_CONST and
 MAX_CONST
In-Reply-To: <20200629151642.11974-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Mon, 29 Jun 2020 08:45:15 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 11:31:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyOTE1MTY0Mi4xMTk3
NC0xLXBib256aW5pQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSF0gY292ZXJpdHk6IHByb3ZpZGUgQ292ZXJpdHkt
ZnJpZW5kbHkgTUlOX0NPTlNUIGFuZCBNQVhfQ09OU1QKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6
IDIwMjAwNjI5MTUxNjQyLjExOTc0LTEtcGJvbnppbmlAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDYyOTE0MDkzOC4xNzU2Ni0x
LWRyam9uZXNAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNjI5MTQwOTM4LjE3NTY2LTEtZHJq
b25lc0ByZWRoYXQuY29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDA2MjkxNTE2
NDIuMTE5NzQtMS1wYm9uemluaUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA2MjkxNTE2NDIu
MTE5NzQtMS1wYm9uemluaUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKYjRlNTJhOSBjb3Zlcml0eTogcHJvdmlkZSBDb3Zlcml0eS1mcmllbmRseSBNSU5fQ09OU1Qg
YW5kIE1BWF9DT05TVAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogYXJjaGl0ZWN0dXJl
IHNwZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzM5OiBGSUxFOiBpbmNsdWRlL3Fl
bXUvb3NkZXAuaDoyNjk6CisjaWZkZWYgX19DT1ZFUklUWV9fCgpFUlJPUjogTWFjcm9zIHdpdGgg
Y29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM0MDogRklM
RTogaW5jbHVkZS9xZW11L29zZGVwLmg6MjcwOgorI2RlZmluZSBNSU5fQ09OU1QoYSwgYikgKGEp
IDwgKGIpID8gKGEpIDogKGIpCgpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hv
dWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM0MTogRklMRTogaW5jbHVkZS9xZW11L29z
ZGVwLmg6MjcxOgorI2RlZmluZSBNQVhfQ09OU1QoYSwgYikgKGEpID4gKGIpID8gKGEpIDogKGIp
Cgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDM0IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBi
NGU1MmE5N2JhZWQgKGNvdmVyaXR5OiBwcm92aWRlIENvdmVyaXR5LWZyaWVuZGx5IE1JTl9DT05T
VCBhbmQgTUFYX0NPTlNUKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYyOTE1MTY0Mi4xMTk3
NC0xLXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

