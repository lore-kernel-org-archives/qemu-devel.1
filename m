Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26B1C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA7B208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA7B208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsk9-0004wE-51
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43914)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hcsZL-0004gn-29
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hcsZJ-0002S4-3X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:25:10 -0400
Resent-Date: Mon, 17 Jun 2019 10:25:10 -0400
Resent-Message-Id: <E1hcsZJ-0002S4-3X@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hcsZH-0002I8-3h
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560781444; cv=none; d=zoho.com; s=zohoarc; 
 b=mE5N5cu8zav1FMio3EchwWfMILPQlMl4hk8wgOG/TaonMNB09tS/uaU+v+6Kv2JnKn9czUMnvDNSkURvdnpnotZm50dY9qBSCJzBnVv9j9svnpi9EGtTVEiZ0ZM443hc89qyNrs/w8/CBjkgNtv+GtEu2KHx+c4Y+xWSawEFKAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560781444;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=3hHXPkvcZvo3Z6JOLD5VFHJDvIyFZ+NxTvUkraKEUMI=; 
 b=MZiaegZXOtv06XjwKbq+S6A0amTrhJW+Ucpt8s3buGj6+1G0FnBu039g6Ko8GWAOV8NYT3ksQe8xV/SFVAavMLBjiMPQn0K6LvKbWixxJOZjjPz9Su3ZtsUr4bA45ctytfknu5vCiKJezylRCSa7zgk5wnyM0kzi+guCujvNlN4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560781442872904.5329668189513;
 Mon, 17 Jun 2019 07:24:02 -0700 (PDT)
In-Reply-To: <20190617131103.1413-1-berrange@redhat.com>
Message-ID: <156078144156.13573.14809923576191207765@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Mon, 17 Jun 2019 07:24:02 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: berrange@redhat.com, arnd@arndb.de, gerhard.stenzel@de.ibm.com,
 riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu,
 borntraeger@de.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNzEzMTEwMy4xNDEz
LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gbGludXgtdXNlcjog
Zml4IHRvIGhhbmRsZSB2YXJpYWJseSBzaXplZCBTSU9DR1NUQU1QIHdpdGggbmV3IGtlcm5lbHMK
VHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNjE3MTMxMTAzLjE0MTMtMS1iZXJyYW5nZUBy
ZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYt
cGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRj
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3
LzIwMTkwNjE1MTU0MzUyLjI2ODI0LTEtcGhpbG1kQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5
MDYxNTE1NDM1Mi4yNjgyNC0xLXBoaWxtZEByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKYWViMTRiNSBsaW51eC11c2VyOiBmaXggdG8gaGFuZGxlIHZhcmlhYmx5IHNp
emVkIFNJT0NHU1RBTVAgd2l0aCBuZXcga2VybmVscwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJS
T1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM3ODogRklMRTogbGludXgtdXNlci9zeXNjYWxs
X2RlZnMuaDo3NTU6CisjZGVmaW5lIFRBUkdFVF9TSU9DR1NUQU1QX05FVyAgIFRBUkdFVF9JT0Mo
VEFSR0VUX0lPQ19SRUFELCAncycsIDYsIHNpemVvZihsb25nIGxvbmcpICsgc2l6ZW9mKGxvbmcp
KSAvKiBHZXQgc3RhbXAgKHRpbWV2YWw2NCkgKi8KCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFj
dGVycwojNzk6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbF9kZWZzLmg6NzU2OgorI2RlZmluZSBU
QVJHRVRfU0lPQ0dTVEFNUE5TX05FVyBUQVJHRVRfSU9DKFRBUkdFVF9JT0NfUkVBRCwgJ3MnLCA3
LCBzaXplb2YobG9uZyBsb25nKSArIHNpemVvZihsb25nKSkgLyogR2V0IHN0YW1wICh0aW1lc3Bl
YzY0KSAqLwoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA1MSBsaW5lcyBjaGVja2VkCgpD
b21taXQgYWViMTRiNTk5ZDhiIChsaW51eC11c2VyOiBmaXggdG8gaGFuZGxlIHZhcmlhYmx5IHNp
emVkIFNJT0NHU1RBTVAgd2l0aCBuZXcga2VybmVscykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA2MTcxMzExMDMuMTQxMy0xLWJlcnJhbmdlQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


