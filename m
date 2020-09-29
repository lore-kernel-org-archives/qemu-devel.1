Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AADEC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91D2208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D2208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN5i9-0000hm-SS
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kN5hU-00083K-KO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:49:08 -0400
Resent-Date: Mon, 28 Sep 2020 22:49:08 -0400
Resent-Message-Id: <E1kN5hU-00083K-KO@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kN5hS-00045h-At
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601347717; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RhdmEIxiuDH9lnd60aKc+Y6HzLmtr1t8OLqg9cb3ljrdV6h2E7fdJ4r+mDGN47kbTlPoKg/GMPisYjsTu+PmgzjIRg+Rle8t8ALPQ162BzOiiSqlnkbogXtb+k97pPYEtGHg+Y0FQbcpT262NERfu9/EKQdA9ErH4w1DQ8ezZCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601347717;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=57QypP3sKGhKqz81w5xO/pEwNp9YkxtzP3hyKYr6drs=; 
 b=iObFMEJ/FxLhSwyyfWIqpv/p7d5J+BD1MnnfKU+9cO4mGCXB9vtF4AnTMVYf7C4TIDmIUKOE5niVyE5YDVcVkKNZxNai0aUnvhxhDZDoKV5gs1tv5eepgjQWgmM7JuPlIODJUg318PXQVcalFg/x8zYCk0pF5OcIHfSTsZStrQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601347716087227.83885203725572;
 Mon, 28 Sep 2020 19:48:36 -0700 (PDT)
Subject: Re: [RFC 0/3] QEMU as IPMI BMC emulator
Message-ID: <160134771435.17704.5155169843032704148@66eaa9a8a123>
In-Reply-To: <20200929003916.4183696-1-hskinnemoen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Mon, 28 Sep 2020 19:48:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 21:12:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
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
Cc: minyard@acm.org, Avi.Fishman@nuvoton.com, venture@google.com,
 qemu-devel@nongnu.org, hskinnemoen@google.com, wuhaotsh@google.com,
 kfting@nuvoton.com, clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyOTAwMzkxNi40MTgz
Njk2LTEtaHNraW5uZW1vZW5AZ29vZ2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTI5MDAzOTE2
LjQxODM2OTYtMS1oc2tpbm5lbW9lbkBnb29nbGUuY29tClN1YmplY3Q6IFtSRkMgMC8zXSBRRU1V
IGFzIElQTUkgQk1DIGVtdWxhdG9yCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVz
IFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1NzJkZjYxIGRvY3Mvc3BlY3M6IElQ
TUkgZGV2aWNlIGVtdWxhdGlvbjogQk1DCjI3YzE3NmQgZG9jcy9zcGVjczogSVBNSSBkZXZpY2Ug
ZW11bGF0aW9uOiBtYWluIHByb2Nlc3NvcgpjZjc5MjdlIGRvY3M6IGVuYWJsZSBzcGhpbnggYmxv
Y2tkaWFnIGV4dGVuc2lvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8zIENoZWNraW5nIGNvbW1p
dCBjZjc5MjdlNTU2MWUgKGRvY3M6IGVuYWJsZSBzcGhpbnggYmxvY2tkaWFnIGV4dGVuc2lvbikK
V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzE5OiBGSUxFOiBkb2NzL2NvbmYucHk6
NzA6CitleHRlbnNpb25zID0gWydrZXJuZWxkb2MnLCAncW1wX2xleGVyJywgJ2h4dG9vbCcsICdk
ZXBmaWxlJywgJ3NwaGlueGNvbnRyaWIuYmxvY2tkaWFnJ10KCldBUk5JTkc6IGxpbmUgb3ZlciA4
MCBjaGFyYWN0ZXJzCiMyMjogRklMRTogZG9jcy9jb25mLnB5OjczOgorYmxvY2tkaWFnX2ZvbnRw
YXRoID0gJy91c3Ivc2hhcmUvZm9udHMvdHJ1ZXR5cGUvbGliZXJhdGlvbi9MaWJlcmF0aW9uU2Fu
cy1SZWd1bGFyLnR0ZicKCnRvdGFsOiAwIGVycm9ycywgMiB3YXJuaW5ncywgMTEgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggMS8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjIvMyBDaGVja2luZyBj
b21taXQgMjdjMTc2ZDcwYmNkIChkb2NzL3NwZWNzOiBJUE1JIGRldmljZSBlbXVsYXRpb246IG1h
aW4gcHJvY2Vzc29yKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyNjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojNTE6IEZJTEU6IGRvY3Mvc3BlY3MvaXBtaS5y
c3Q6MjE6CisgICQKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTA2IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8zIENoZWNraW5nIGNv
bW1pdCA1NzJkZjYxMTA0NDggKGRvY3Mvc3BlY3M6IElQTUkgZGV2aWNlIGVtdWxhdGlvbjogQk1D
KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDkyOTAwMzkxNi40MTgzNjk2LTEtaHNraW5uZW1vZW5AZ29vZ2xlLmNvbS90ZXN0aW5nLmNoZWNr
cGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

