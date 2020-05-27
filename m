Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2BB20776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2BB20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpkR-0004Wa-Q8
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdpjj-0003lc-ON; Wed, 27 May 2020 02:40:23 -0400
Resent-Date: Wed, 27 May 2020 02:40:23 -0400
Resent-Message-Id: <E1jdpjj-0003lc-ON@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdpjh-0005u9-TT; Wed, 27 May 2020 02:40:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590561594; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EnYHFtnaBJxEXTrWItuFlCDZPgrt4v6WWlB61nKqgzaF+Ngzf/5w5x8wHE1qTSRhncBVElqbhVVyrfWU21sExYnQx0DgAxiKNfzOqPkMe5RPEFqtMx5uuSSJNsAZKyd6CMLnYStqJLQy2CcpuXKclrGEqTtKiYsxX938nYjlE4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590561594;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dsLPa3S3UB9BSy2Gqb0M89no3o8hCte30SQPboOZZls=; 
 b=jImihRvKQfoMOnvtZtmGKDpdotbX+7aN0qlX/nhmx6Zl0hjke6e84/5k1UJAoOlVulbTPcV7Qq5fxkYYwxsPvEFgxXQjB3gd3Hu0e0bSyyr+flbirzmhOiyFHfVJrZ/MUxQ7c7KNvuHyD66eKXDLid9G/FjTnZ21LfdDbEoz8Ig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590561591637870.0423659077027;
 Tue, 26 May 2020 23:39:51 -0700 (PDT)
Message-ID: <159056159016.16318.6211976050011650064@45ef0f9c86ae>
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
Subject: Re: [PULL 00/15] ppc-for-5.1 queue 20200527
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@gibson.dropbear.id.au
Date: Tue, 26 May 2020 23:39:51 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 02:40:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNzA1MzgwOS4zNTYx
NjgtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTI3MDUzODA5LjM1NjE2OC0x
LWRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdQpTdWJqZWN0OiBbUFVMTCAwMC8xNV0gcHBjLWZv
ci01LjEgcXVldWUgMjAyMDA1MjcKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkMzk3NTQ5IHZm
aW8vbnZsaW5rOiBSZW1vdmUgZXhlYyBwZXJtaXNzaW9uIHRvIGF2b2lkIFNFTGludXggQVZDcwpk
NGJmZTQ4IHRhcmdldC9wcGM6IEZpeCBhcmd1bWVudCB0byBwcGNfcmFkaXg2NF9wYXJ0aXRpb25f
c2NvcGVkX3hsYXRlKCkgYWdhaW4KMGQ2MzdjYyBody9udnJhbS9tYWNfbnZyYW06IENvbnZlcnQg
ZGVidWcgcHJpbnRmKClzIHRvIHRyYWNlIGV2ZW50cwowMjZkZTc5IGh3L3BjaS1icmlkZ2UvZGVj
OiBSZW1vdmUgZGVhZCBkZWJ1ZyBjb2RlCjhjZTI0MjkgdGFyZ2V0L3BwYzogRG9uJ3QgdXBkYXRl
IHJhZGl4IFBURSBSL0MgYml0cyB3aXRoIGdkYnN0dWIKNDgwYmIzOSB0YXJnZXQvcHBjOiBGaXgg
YXJndW1lbnRzIHRvIHBwY19yYWRpeDY0X3BhcnRpdGlvbl9zY29wZWRfeGxhdGUoKQowNzQzZGQw
IHRhcmdldC9wcGM6IEFkZCBtaXNzaW5nIGJyYWNlcyBpbiBwcGNfcmFkaXg2NF9wYXJ0aXRpb25f
c2NvcGVkX3hsYXRlKCkKM2YwZmZiNCB0YXJnZXQvcHBjOiBEb24ndCBpbml0aWFsaXplIHNvbWUg
bG9jYWwgdmFyaWFibGVzIGluIHBwY19yYWRpeDY0X3hsYXRlKCkKYTA0M2VkNSB0YXJnZXQvcHBj
OiBQYXNzIGNvbnN0IHBvaW50ZXIgdG8gcHBjX3JhZGl4NjRfZ2V0X2Z1bGx5X3F1YWxpZmllZF9h
ZGRyKCkKMTQ5NmUxZCB0YXJnZXQvcHBjOiBQYXNzIGNvbnN0IHBvaW50ZXIgdG8gcHBjX3JhZGl4
NjRfZ2V0X3Byb3RfYW1yKCkKNWFmMjg1YiBwcGMvc3BhcHI6IEFkZCBob3RyZW1vdmFibGUgZmxh
ZyBvbiBESU1NIExNQnMgb24gZHJtZW1fdjIKNWFlMDdmMyB0YXJnZXQvcHBjOiBBZGQgc3VwcG9y
dCBmb3Igc2N2IGFuZCByZnNjdiBpbnN0cnVjdGlvbnMKY2JjNDU3OCB0YXJnZXQvcHBjOiBVbnRh
YmlmeSBleGNwX2hlbHBlci5jCjQzZWM2NzUgcHBjL3NwYXByOiBhZGQgYSBQT1dFUjEwIENQVSBt
b2RlbAo1ODI0Y2Q0IHBwYy9wbnY6IEZpeCBOTUkgc3lzdGVtIHJlc2V0IFNSUjEgdmFsdWUKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvMTUgQ2hlY2tpbmcgY29tbWl0IDU4MjRjZDRlOTg5YiAocHBj
L3BudjogRml4IE5NSSBzeXN0ZW0gcmVzZXQgU1JSMSB2YWx1ZSkKRVJST1I6IGxpbmUgb3ZlciA5
MCBjaGFyYWN0ZXJzCiM0MzogRklMRTogaHcvcHBjL3Budi5jOjE5OTQ6CisgICAgICAgICAgICB3
YXJuX3JlcG9ydCgicHBjX2NwdV9kb19zeXN0ZW1fcmVzZXQgZG9lcyBub3Qgc2V0IHN5c3RlbSBy
ZXNldCB3YWtldXAgcmVhc29uIik7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDMyIGxp
bmVzIGNoZWNrZWQKClBhdGNoIDEvMTUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvMTUg
Q2hlY2tpbmcgY29tbWl0IDQzZWM2NzUzZDJjMCAocHBjL3NwYXByOiBhZGQgYSBQT1dFUjEwIENQ
VSBtb2RlbCkKMy8xNSBDaGVja2luZyBjb21taXQgY2JjNDU3OGJjMWIzICh0YXJnZXQvcHBjOiBV
bnRhYmlmeSBleGNwX2hlbHBlci5jKQo0LzE1IENoZWNraW5nIGNvbW1pdCA1YWUwN2YzNDYxZDQg
KHRhcmdldC9wcGM6IEFkZCBzdXBwb3J0IGZvciBzY3YgYW5kIHJmc2N2IGluc3RydWN0aW9ucykK
NS8xNSBDaGVja2luZyBjb21taXQgNWFmMjg1YjU1OGU1IChwcGMvc3BhcHI6IEFkZCBob3RyZW1v
dmFibGUgZmxhZyBvbiBESU1NIExNQnMgb24gZHJtZW1fdjIpCjYvMTUgQ2hlY2tpbmcgY29tbWl0
IDE0OTZlMWQxMWMxZiAodGFyZ2V0L3BwYzogUGFzcyBjb25zdCBwb2ludGVyIHRvIHBwY19yYWRp
eDY0X2dldF9wcm90X2FtcigpKQo3LzE1IENoZWNraW5nIGNvbW1pdCBhMDQzZWQ1NDc1ZjggKHRh
cmdldC9wcGM6IFBhc3MgY29uc3QgcG9pbnRlciB0byBwcGNfcmFkaXg2NF9nZXRfZnVsbHlfcXVh
bGlmaWVkX2FkZHIoKSkKOC8xNSBDaGVja2luZyBjb21taXQgM2YwZmZiNDc5MzFmICh0YXJnZXQv
cHBjOiBEb24ndCBpbml0aWFsaXplIHNvbWUgbG9jYWwgdmFyaWFibGVzIGluIHBwY19yYWRpeDY0
X3hsYXRlKCkpCjkvMTUgQ2hlY2tpbmcgY29tbWl0IDA3NDNkZDA0MTU3OSAodGFyZ2V0L3BwYzog
QWRkIG1pc3NpbmcgYnJhY2VzIGluIHBwY19yYWRpeDY0X3BhcnRpdGlvbl9zY29wZWRfeGxhdGUo
KSkKMTAvMTUgQ2hlY2tpbmcgY29tbWl0IDQ4MGJiMzk2OTczMCAodGFyZ2V0L3BwYzogRml4IGFy
Z3VtZW50cyB0byBwcGNfcmFkaXg2NF9wYXJ0aXRpb25fc2NvcGVkX3hsYXRlKCkpCjExLzE1IENo
ZWNraW5nIGNvbW1pdCA4Y2UyNDI5OWE2ZTQgKHRhcmdldC9wcGM6IERvbid0IHVwZGF0ZSByYWRp
eCBQVEUgUi9DIGJpdHMgd2l0aCBnZGJzdHViKQoxMi8xNSBDaGVja2luZyBjb21taXQgMDI2ZGU3
OTAzMTNmIChody9wY2ktYnJpZGdlL2RlYzogUmVtb3ZlIGRlYWQgZGVidWcgY29kZSkKMTMvMTUg
Q2hlY2tpbmcgY29tbWl0IDBkNjM3Y2MyZTQ0NSAoaHcvbnZyYW0vbWFjX252cmFtOiBDb252ZXJ0
IGRlYnVnIHByaW50ZigpcyB0byB0cmFjZSBldmVudHMpCjE0LzE1IENoZWNraW5nIGNvbW1pdCBk
NGJmZTQ4MjAyZmIgKHRhcmdldC9wcGM6IEZpeCBhcmd1bWVudCB0byBwcGNfcmFkaXg2NF9wYXJ0
aXRpb25fc2NvcGVkX3hsYXRlKCkgYWdhaW4pCjE1LzE1IENoZWNraW5nIGNvbW1pdCBkMzk3NTQ5
YTYzYTggKHZmaW8vbnZsaW5rOiBSZW1vdmUgZXhlYyBwZXJtaXNzaW9uIHRvIGF2b2lkIFNFTGlu
dXggQVZDcykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDA1MjcwNTM4MDkuMzU2MTY4LTEtZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1L3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

