Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB55FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C093C206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C093C206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZ9c-0000KL-3A
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jlZ8o-0008Kp-RJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:34:14 -0400
Resent-Date: Wed, 17 Jun 2020 10:34:14 -0400
Resent-Message-Id: <E1jlZ8o-0008Kp-RJ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jlZ8m-0007J9-64
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:34:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592404434; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cIEOr/HXpuWXAmTdFpwKvr+k9JggO1pEHxxL/46r3cMC6CTD9Gbqz3QK6qgdMphPyV4lWPPicacBDAzkdXCvIhQ029kjRbAlb3UzS+3yTuZtyBdv98Yrkiu9uZqK8o/UmYHLFCYbHJq3nocCTqjgFBDIfrOUjsMEz61RJkr/tyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592404434;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=N1F2qHx84k4KeX1eejK4XD20oW8TIdZiIn9h1H0pv5o=; 
 b=NynK51yyos6uTkmzIOafAkQ6tVJJ5ct3Ml9ZUzG0aNlNdIWUYy+Uicpfszi5wBVqKc1lTd+hSEVvneC4orGeQ0zWLXutjXlfKhXq9GmLTzwBMeJjeD1+Y7gXgzAuTRLsePdarFElNgiO2ZhgH8x814X+EORP+wcesVXfjJC4n9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592404433748368.35078825238065;
 Wed, 17 Jun 2020 07:33:53 -0700 (PDT)
Message-ID: <159240443226.14731.15935853570073325984@d1fd068a5071>
Subject: Re: [PATCH v4 0/8] tpm: Enable usage of TPM TIS with interrupts
In-Reply-To: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanb@linux.vnet.ibm.com
Date: Wed, 17 Jun 2020 07:33:53 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 06:55:17
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
Cc: stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 mkedzier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxNzE0MjMwNS4xMTk4
NjcyLTEtc3RlZmFuYkBsaW51eC52bmV0LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2NCAwLzhdIHRwbTogRW5hYmxl
IHVzYWdlIG9mIFRQTSBUSVMgd2l0aCBpbnRlcnJ1cHRzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlk
OiAyMDIwMDYxNzE0MjMwNS4xMTk4NjcyLTEtc3RlZmFuYkBsaW51eC52bmV0LmlibS5jb20KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4g
L2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJh
Y2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZm
ODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA2MTcxNDIz
MDUuMTE5ODY3Mi0xLXN0ZWZhbmJAbGludXgudm5ldC5pYm0uY29tIC0+IHBhdGNoZXcvMjAyMDA2
MTcxNDIzMDUuMTE5ODY3Mi0xLXN0ZWZhbmJAbGludXgudm5ldC5pYm0uY29tClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKNTI3ZjZhNiB0cG06IERpc2FibGUgaW50ZXJydXB0IHN1cHBv
cnQgZm9yIFRJUyBvbiBzeXNidXMKMjQwOTY2MCB0cG06IEd1YXJkIGlycSByZWxhdGVkIG9wcyBp
biBjYXNlIGludGVycnVwdHMgYXJlIGRpc2FibGVkCjcyN2RiNWEgdGVzdHM6IEFkZCB1cGRhdGVk
IERTRFQKOWFlMGIwZCBhY3BpOiBFbmFibGUgVFBNIElSUQo2MmE2NTlhIHRwbTogU3BsaXQgVFBN
X1RJU19JUlEgaW50byBUUE1fVElTX0lTQV9JUlEgYW5kIFRQTV9USVNfU1lTQlVTX0lSUQo0ZTM5
OTRhIHRlc3RzOiBUZW1wb3JhcmlseSBpZ25vcmUgRFNEVCB0YWJsZSBkaWZmZXJlbmNlcwo2NTFk
ZGYwIHRwbTogRXh0ZW5kIFRQTUlmQ2xhc3Mgd2l0aCBnZXRfaXJxbnVtKCkgZnVuY3Rpb24KOWZl
MjViMSB0cG1fdGlzOiBBbGxvdyBsb3dlcmluZyBvZiBJUlEgYWxzbyB3aGVuIGxvY2FsaXR5IGlz
IG5vdCBhY3RpdmUKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgOWZl
MjViMTFhMjMxICh0cG1fdGlzOiBBbGxvdyBsb3dlcmluZyBvZiBJUlEgYWxzbyB3aGVuIGxvY2Fs
aXR5IGlzIG5vdCBhY3RpdmUpCjIvOCBDaGVja2luZyBjb21taXQgNjUxZGRmMDNhNDEzICh0cG06
IEV4dGVuZCBUUE1JZkNsYXNzIHdpdGggZ2V0X2lycW51bSgpIGZ1bmN0aW9uKQpFUlJPUjogTWFj
cm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lz
CiM3NzogRklMRTogaW5jbHVkZS9zeXNlbXUvdHBtLmg6Mjg6CisjZGVmaW5lIFRQTV9JUlFfRElT
QUJMRUQgIH4wCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDcwIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDIvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy84IENoZWNraW5nIGNvbW1p
dCA0ZTM5OTRhZTllNDUgKHRlc3RzOiBUZW1wb3JhcmlseSBpZ25vcmUgRFNEVCB0YWJsZSBkaWZm
ZXJlbmNlcykKNC84IENoZWNraW5nIGNvbW1pdCA2MmE2NTlhYjVjMTIgKHRwbTogU3BsaXQgVFBN
X1RJU19JUlEgaW50byBUUE1fVElTX0lTQV9JUlEgYW5kIFRQTV9USVNfU1lTQlVTX0lSUSkKNS84
IENoZWNraW5nIGNvbW1pdCA5YWUwYjBkNmY3MjQgKGFjcGk6IEVuYWJsZSBUUE0gSVJRKQo2Lzgg
Q2hlY2tpbmcgY29tbWl0IDcyN2RiNWFjNzhhYyAodGVzdHM6IEFkZCB1cGRhdGVkIERTRFQpCjcv
OCBDaGVja2luZyBjb21taXQgMjQwOTY2MDAxYjg2ICh0cG06IEd1YXJkIGlycSByZWxhdGVkIG9w
cyBpbiBjYXNlIGludGVycnVwdHMgYXJlIGRpc2FibGVkKQo4LzggQ2hlY2tpbmcgY29tbWl0IDUy
N2Y2YTZmZGIxNiAodHBtOiBEaXNhYmxlIGludGVycnVwdCBzdXBwb3J0IGZvciBUSVMgb24gc3lz
YnVzKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDIwMDYxNzE0MjMwNS4xMTk4NjcyLTEtc3RlZmFuYkBsaW51eC52bmV0LmlibS5jb20vdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

