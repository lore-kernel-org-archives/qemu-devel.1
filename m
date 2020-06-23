Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59419C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B7620720
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B7620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnk7Y-0002yv-GK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnk6Q-0002Hf-J1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:40:46 -0400
Resent-Date: Tue, 23 Jun 2020 10:40:46 -0400
Resent-Message-Id: <E1jnk6Q-0002Hf-J1@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnk6N-0001VZ-PF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:40:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592923237; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NzmTi518osYDPvYt8oycTOggUyAEInzPnT9S9qRamvNfoO9aODvYlMlIqsPBP/zKAWkzIMYE8cU78vcfauX1yr556z4DqVemxhk/N0bczHqb2+IfBK90HCxm+YIkC8pgzwJ2CCE/+y2h2dFVmCO59p7rM+W20g4qwPCl/veSBkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592923237;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oT/RnN3x/LWLUxB7s9ZZZvvvxAQiyK/6IqehLJp+O6U=; 
 b=NdfjtSBM8Y5uuCzBFLW1QgaXKHaQO1bgpjG6EvG4RZtZpkDvyTcb8ccUMWEiHcyS8pxUNtXRj9s3G53WDmt31Zv2FMqtK9Lub0cEuFKA+aE6Bl+foUmK5YSur+HFqMZeaeKEkeg6QA8fBfdixCtoI45d2AHOnPtBkJ6hqIjezTk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592923234041652.6409926611818;
 Tue, 23 Jun 2020 07:40:34 -0700 (PDT)
Message-ID: <159292323314.6613.14411653927906993400@d1fd068a5071>
Subject: Re: [PULL 00/16] Qdev patches for 2020-06-23
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 23 Jun 2020 07:40:34 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 08:25:27
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyMzE0MjMyNi4yMzQ5
NDE2LTEtYXJtYnJ1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQVUxMIDAwLzE2XSBRZGV2IHBhdGNoZXMgZm9yIDIwMjAt
MDYtMjMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNjIzMTQyMzI2LjIzNDk0MTYtMS1h
cm1icnVAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApn
aXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZy
b20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAg
ICAgICAgIHBhdGNoZXcvMjAyMDA2MjMxNDIzMjYuMjM0OTQxNi0xLWFybWJydUByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAyMDA2MjMxNDIzMjYuMjM0OTQxNi0xLWFybWJydUByZWRoYXQuY29tClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYWM2N2RlZiBzZC9taWxreW1pc3QtbWVtY2Fy
ZDogRml4IGVycm9yIEFQSSB2aW9sYXRpb24KNzZiNzgyYyBzZC9weGEyeHhfbW1jaTogRG9uJ3Qg
Y3Jhc2ggb24gcHhhMnh4X21tY2lfaW5pdCgpIGVycm9yCjA4NmNmMmIgYXJtL2FzcGVlZDogRHJv
cCBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVzKCkgcGFyYW1ldGVyIEBlcnJwCjZiZDY3MGMgcWRl
djogTWFrZSBxZGV2X3Byb3Bfc2V0X2RyaXZlKCkgbWF0Y2ggdGhlIG90aGVyIGhlbHBlcnMKN2Vl
YWM5ZSBxZGV2OiBSZWplY3QgY2hhcmRldiBwcm9wZXJ0eSBvdmVycmlkZQpjZTAxNWJlIHFkZXY6
IFJlamVjdCBkcml2ZSBwcm9wZXJ0eSBvdmVycmlkZQo0YWRkOWE4IHFkZXY6IEltcHJvdmUgbmV0
ZGV2IHByb3BlcnR5IG92ZXJyaWRlIGVycm9yIGEgYml0CmNiNTVjNmIgcWRldjogRWxpbWluYXRl
IGdldF9wb2ludGVyKCksIHNldF9wb2ludGVyKCkKNjA0NzE5MiBibG9ja2RldjogRGVwcmVjYXRl
IC1kcml2ZSB3aXRoIGJvZ3VzIGludGVyZmFjZSB0eXBlCmE4OTVmN2UgZG9jcy9xZGV2LWRldmlj
ZS11c2UudHh0OiBVcGRhdGUgc2VjdGlvbiAiRGVmYXVsdCBEZXZpY2VzIgpiMTZhOWRkIGZkYzog
RGVwcmVjYXRlIGNvbmZpZ3VyaW5nIGZsb3BwaWVzIHdpdGggLWdsb2JhbCBpc2EtZmRjCjIxYWU5
MGEgZmRjOiBPcGVuLWNvZGUgZmRjdHJsX2luaXRfaXNhKCkKN2YyOGVhMiBmZGM6IFJlamVjdCBj
bGFzaCBiZXR3ZWVuIC1kcml2ZSBpZj1mbG9wcHkgYW5kIC1nbG9iYWwgaXNhLWZkYwozMmFiZDFl
IGlvdGVzdHMvMTcyOiBDb3ZlciAtZ2xvYmFsIGZsb3BweS5kcml2ZT0uLi4KOTRkODdlNCBpb3Rl
c3RzLzE3MjogQ292ZXIgZW1wdHkgZmlsZW5hbWUgYW5kIG11bHRpcGxlIHVzZSBvZiBkcml2ZXMK
ZTg2ZWQwOCBpb3Rlc3RzLzE3MjogSW5jbHVkZSAiaW5mbyBibG9jayIgaW4gdGVzdCBvdXRwdXQK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hlY2tpbmcgY29tbWl0IGU4NmVkMDhkZDU5MCAo
aW90ZXN0cy8xNzI6IEluY2x1ZGUgImluZm8gYmxvY2siIGluIHRlc3Qgb3V0cHV0KQoyLzE2IENo
ZWNraW5nIGNvbW1pdCA5NGQ4N2U0YjcwZDkgKGlvdGVzdHMvMTcyOiBDb3ZlciBlbXB0eSBmaWxl
bmFtZSBhbmQgbXVsdGlwbGUgdXNlIG9mIGRyaXZlcykKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3Bh
Y2UKIzQ5OiBGSUxFOiB0ZXN0cy9xZW11LWlvdGVzdHMvMTcyLm91dDoxOTA6CitUZXN0aW5nOiAt
ZmRiICQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgODYgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggMi8xNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8xNiBDaGVja2luZyBjb21taXQg
MzJhYmQxZTI3MWRlIChpb3Rlc3RzLzE3MjogQ292ZXIgLWdsb2JhbCBmbG9wcHkuZHJpdmU9Li4u
KQo0LzE2IENoZWNraW5nIGNvbW1pdCA3ZjI4ZWEyZDBmYjMgKGZkYzogUmVqZWN0IGNsYXNoIGJl
dHdlZW4gLWRyaXZlIGlmPWZsb3BweSBhbmQgLWdsb2JhbCBpc2EtZmRjKQo1LzE2IENoZWNraW5n
IGNvbW1pdCAyMWFlOTBhOTM5YTAgKGZkYzogT3Blbi1jb2RlIGZkY3RybF9pbml0X2lzYSgpKQo2
LzE2IENoZWNraW5nIGNvbW1pdCBiMTZhOWRkNzkzMDAgKGZkYzogRGVwcmVjYXRlIGNvbmZpZ3Vy
aW5nIGZsb3BwaWVzIHdpdGggLWdsb2JhbCBpc2EtZmRjKQo3LzE2IENoZWNraW5nIGNvbW1pdCBh
ODk1ZjdlNTYwYTcgKGRvY3MvcWRldi1kZXZpY2UtdXNlLnR4dDogVXBkYXRlIHNlY3Rpb24gIkRl
ZmF1bHQgRGV2aWNlcyIpCjgvMTYgQ2hlY2tpbmcgY29tbWl0IDYwNDcxOTJhNjBiNiAoYmxvY2tk
ZXY6IERlcHJlY2F0ZSAtZHJpdmUgd2l0aCBib2d1cyBpbnRlcmZhY2UgdHlwZSkKOS8xNiBDaGVj
a2luZyBjb21taXQgY2I1NWM2Yjk1NjBjIChxZGV2OiBFbGltaW5hdGUgZ2V0X3BvaW50ZXIoKSwg
c2V0X3BvaW50ZXIoKSkKMTAvMTYgQ2hlY2tpbmcgY29tbWl0IDRhZGQ5YTgyZTEyMCAocWRldjog
SW1wcm92ZSBuZXRkZXYgcHJvcGVydHkgb3ZlcnJpZGUgZXJyb3IgYSBiaXQpCjExLzE2IENoZWNr
aW5nIGNvbW1pdCBjZTAxNWJlNDRlMjMgKHFkZXY6IFJlamVjdCBkcml2ZSBwcm9wZXJ0eSBvdmVy
cmlkZSkKMTIvMTYgQ2hlY2tpbmcgY29tbWl0IDdlZWFjOWU0YWFjOCAocWRldjogUmVqZWN0IGNo
YXJkZXYgcHJvcGVydHkgb3ZlcnJpZGUpCjEzLzE2IENoZWNraW5nIGNvbW1pdCA2YmQ2NzBjNTk2
YTkgKHFkZXY6IE1ha2UgcWRldl9wcm9wX3NldF9kcml2ZSgpIG1hdGNoIHRoZSBvdGhlciBoZWxw
ZXJzKQoxNC8xNiBDaGVja2luZyBjb21taXQgMDg2Y2YyYjNmYmU3IChhcm0vYXNwZWVkOiBEcm9w
IGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoKSBwYXJhbWV0ZXIgQGVycnApCjE1LzE2IENoZWNr
aW5nIGNvbW1pdCA3NmI3ODJjOGZlMTYgKHNkL3B4YTJ4eF9tbWNpOiBEb24ndCBjcmFzaCBvbiBw
eGEyeHhfbW1jaV9pbml0KCkgZXJyb3IpCjE2LzE2IENoZWNraW5nIGNvbW1pdCBhYzY3ZGVmNGRm
YTcgKHNkL21pbGt5bWlzdC1tZW1jYXJkOiBGaXggZXJyb3IgQVBJIHZpb2xhdGlvbikKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MjMxNDIz
MjYuMjM0OTQxNi0xLWFybWJydUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

