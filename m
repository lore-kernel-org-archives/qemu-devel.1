Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B1EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B65E251E3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B65E251E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvmK-0002mk-QA
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpvke-0001Ks-RR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:31:21 -0400
Resent-Date: Mon, 29 Jun 2020 11:31:20 -0400
Resent-Message-Id: <E1jpvke-0001Ks-RR@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpvkX-0002ou-WF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:31:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593444656; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YAcLwwZGrgjUBwtgzaWLLcDhJidoaFj2TdpfbimDR/bTYQcOqb0q055hvbIhNnHlTrlwVY15SBAmbhPLhpAsb0XvINA2OCH5/z3gvD2fSk+lFFxC87w9hXIvBZhlkfX1dJtJbLvu1hD/j4SzO7iYF5B+M6hXJ38LRs84l/p+BEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593444656;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IwbH5EFSqXsL1SHb7/RsXkkWwQvMn+aXD5UXgN4U5WE=; 
 b=JLacatbquWd1+1JfGL6O105Dlwg58TQNf9SfrOAS8+EGIfCbybXHWP9R2g+xR5jBieotj5baJzKUuasUq2+WBjB4vtgTtVBnSoRYJkXsjNEx5zqqP1G93uijbwvxWycMQvam8dHjpA7sSz5YTSUH2ibn+Zj7q6aqo0zttOSSYHE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593444105703223.69756248879946;
 Mon, 29 Jun 2020 08:21:45 -0700 (PDT)
Message-ID: <159344410468.15477.8209266914104937697@d1fd068a5071>
Subject: Re: [PATCH] coverity: provide Coverity-friendly MIN_CONST and
 MAX_CONST
In-Reply-To: <20200629151642.11974-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Mon, 29 Jun 2020 08:21:45 -0700 (PDT)
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
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXct
cHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA2MjkxNTE2NDIu
MTE5NzQtMS1wYm9uemluaUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA2MjkxNTE2NDIuMTE5
NzQtMS1wYm9uemluaUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
M2FlZTBkZSBjb3Zlcml0eTogcHJvdmlkZSBDb3Zlcml0eS1mcmllbmRseSBNSU5fQ09OU1QgYW5k
IE1BWF9DT05TVAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogYXJjaGl0ZWN0dXJlIHNw
ZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzM4OiBGSUxFOiBpbmNsdWRlL3FlbXUv
b3NkZXAuaDoyNjk6CisjaWZkZWYgX19DT1ZFUklUWV9fCgpFUlJPUjogTWFjcm9zIHdpdGggY29t
cGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiMzOTogRklMRTog
aW5jbHVkZS9xZW11L29zZGVwLmg6MjcwOgorI2RlZmluZSBNSU5fQ09OU1QoYSwgYikgKGEpIDwg
KGIpID8gKGEpIDogKGIpCgpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxk
IGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM0MDogRklMRTogaW5jbHVkZS9xZW11L29zZGVw
Lmg6MjcxOgorI2RlZmluZSBNQVhfQ09OU1QoYSwgYikgKGEpID4gKGIpID8gKGEpIDogKGIpCgp0
b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDM0IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAzYWVl
MGRlMzBhZDIgKGNvdmVyaXR5OiBwcm92aWRlIENvdmVyaXR5LWZyaWVuZGx5IE1JTl9DT05TVCBh
bmQgTUFYX0NPTlNUKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYyOTE1MTY0Mi4xMTk3NC0x
LXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t

