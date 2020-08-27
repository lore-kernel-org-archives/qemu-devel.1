Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DA2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 02:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5C92075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 02:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5C92075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB7xr-0000ls-4U
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 22:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kB7xF-0008LH-IU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 22:47:57 -0400
Resent-Date: Wed, 26 Aug 2020 22:47:57 -0400
Resent-Message-Id: <E1kB7xF-0008LH-IU@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kB7xC-00015R-NM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 22:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598496304; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZlAhrrFT6fWYse+5ySUsG4cadouBs6uaDar6rewJ/63tOVae2Bk3LbUyBJWpqi2Bo5WKKtfwgHY26X8F2eJIKzvAQkt7IdvEstCrlnmap2Ojc9tQ2tkzBUP+fxdOnj7cuS9HrC/ZBS1QPi7lpfQmLrQrBv+EZXVFZrFzRmqamy8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598496304;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=C6PGhJ7/A1K3P9FF5/Ucp9BC6zR8dd/24xfVrq766ps=; 
 b=DJb3po1rvT5SsVdaCKOZyEOA5koUVEdpFnOeFVslInlRI8t/42y+JrvJOXL3Hj5tFbVxAsl4mN5lDudM1yyGR3lkpTqQVM/Bdink6ZYTkTSaW2F242mR5374C29NrfBxA0+k7dQGtI6AIucXWTwlXnX6icqrhfQiebATEd9TPOk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159849630278063.384078810005576;
 Wed, 26 Aug 2020 19:45:02 -0700 (PDT)
Subject: Re: [PATCH] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
Message-ID: <159849630227.9089.3159324073181264054@66eaa9a8a123>
In-Reply-To: <20200825001649.1811-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luoyonggang@gmail.com
Date: Wed, 26 Aug 2020 19:45:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 22:47:52
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
Cc: pbonzini@redhat.com, luoyonggang@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgyNTAwMTY0OS4xODEx
LTEtbHVveW9uZ2dhbmdAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA4MjUwMDE2NDkuMTgx
MS0xLWx1b3lvbmdnYW5nQGdtYWlsLmNvbQpTdWJqZWN0OiBbUEFUQ0hdIG1lc29uOiBNaW5ndzY0
IGdjYyBkb2Vzbid0IHJlY29nbml6ZSBzeXN0ZW0gaW5jbHVkZV90eXBlIGZvciBzZGwyCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwODI2MTg0MzM0
LjQxMjA2MjAtMS1laGFia29zdEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA4MjYxODQzMzQu
NDEyMDYyMC0xLWVoYWJrb3N0QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo3MDBjZGM4IG1lc29uOiBNaW5ndzY0IGdjYyBkb2Vzbid0IHJlY29nbml6ZSBzeXN0ZW0g
aW5jbHVkZV90eXBlIGZvciBzZGwyCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogTWlzc2lu
ZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDkg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IDcwMGNkYzg0ZjRhZSAobWVzb246IE1pbmd3NjQgZ2NjIGRv
ZXNuJ3QgcmVjb2duaXplIHN5c3RlbSBpbmNsdWRlX3R5cGUgZm9yIHNkbDIpIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwODI1MDAxNjQ5LjE4MTEtMS1sdW95b25nZ2FuZ0BnbWFpbC5jb20vdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

