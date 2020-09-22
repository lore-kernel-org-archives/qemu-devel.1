Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323EC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5142399A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5142399A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkYF-0008K3-4h
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKkQd-0004BO-95; Tue, 22 Sep 2020 11:42:03 -0400
Resent-Date: Tue, 22 Sep 2020 11:42:03 -0400
Resent-Message-Id: <E1kKkQd-0004BO-95@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKkQb-0000xM-4B; Tue, 22 Sep 2020 11:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600789312; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mqB73DnKCRpplCitT+qAs4zqxKOHmXtcepDrn7ODblsw1kgRMkEERCNH69dH3yKSQJkjZsofmKqTXHJvie3S4V4NWSZ6WxRjiDZJqGaq5DBLJoHmv3gya8/rxBlNFBX1CLVde9rsRsM2r3LavFws0Vmh9I/qZVimia618NbpMbc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600789312;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=jasGoHnI5roOZMajOHtEsc58h72ByZSWh5oBwAfNBdo=; 
 b=jdXillUhLmnoUOrtTOd3Mgsjfxeg5fjjR+c81wPETsH8l8w/YIjViM50W1skstS0QxWvjjyzR4CiP4gpc11uDJpJ3b5n+vrJS+fH2NXYL2VA0chIg6J43qF8jgb8qVaa+y/QzjPvGczop7droLoIFDPzbogKpVJZ0uVKTAdJ8ZU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600789310892500.1750869849311;
 Tue, 22 Sep 2020 08:41:50 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] s390x/tcg: Implement some z14 facilities
Message-ID: <160078930948.1915.7276761242992072728@66eaa9a8a123>
In-Reply-To: <20200922103129.12824-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@redhat.com
Date: Tue, 22 Sep 2020 08:41:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 11:40:46
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMjEwMzEyOS4xMjgy
NC0xLWRhdmlkQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDkyMjEwMzEyOS4xMjgyNC0x
LWRhdmlkQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYxIDAvOF0gczM5MHgvdGNnOiBJbXBs
ZW1lbnQgc29tZSB6MTQgZmFjaWxpdGllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0YTcxMGNiIHMzOTB4L3RjZzogSW1wbGVt
ZW50IENJUEhFUiBNRVNTQUdFIFdJVEggQVVUSEVOVElDQVRJT04gKEtNQSkKNjdjOGU0MCBzMzkw
eC90Y2c6IFdlIHN1cHBvcnQgTWlzY2VsbGFuZW91cy1JbnN0cnVjdGlvbi1FeHRlbnNpb25zIEZh
Y2lsaXR5IDIKZTg2N2M3YiBzMzkweC90Y2c6IEltcGxlbWVudCBNVUxUSVBMWSBTSU5HTEUgKE1T
QywgTVNHQywgTVNHUktDLCBNU1JLQykKMmFmOWI4MyBzMzkweC90Y2c6IEltcGxlbWVudCBCUkFO
Q0ggSU5ESVJFQ1QgT04gQ09ORElUSU9OIChCSUMpCjY1NmNmODkgczM5MHgvdGNnOiBJbXBsZW1l
bnQgTVVMVElQTFkgSEFMRldPUkQgKE1HSCkKNjI2MmQyZSBzMzkweC90Y2c6IEltcGxlbWVudCBN
VUxUSVBMWSAoTUcsIE1HUkspCjNhYmE0ZTIgczM5MHgvdGNnOiBJbXBsZW1lbnQgU1VCVFJBQ1Qg
SEFMRldPUkQgKFNHSCkKYzY5YTM4NSBzMzkweC90Y2c6IEltcGxlbWVudCBBREQgSEFMRldPUkQg
KEFHSCkKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgYzY5YTM4NWQ4
MzhjIChzMzkweC90Y2c6IEltcGxlbWVudCBBREQgSEFMRldPUkQgKEFHSCkpCkVSUk9SOiBsaW5l
IG92ZXIgOTAgY2hhcmFjdGVycwojMzI6IEZJTEU6IHRhcmdldC9zMzkweC90cmFuc2xhdGUuYzo2
MTAxOgorI2RlZmluZSBGQUNfTUlFMiAgICAgICAgUzM5MF9GRUFUX01JU0NfSU5TVFJVQ1RJT05f
RVhUIC8qIG1pc2NlbGxhbmVvdXMtaW5zdHJ1Y3Rpb24tZXh0ZW5zaW9ucyBmYWNpbGl0eSAyICov
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEv
OCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi84IENoZWNraW5nIGNvbW1pdCAzYWJhNGUy
NWU0NTYgKHMzOTB4L3RjZzogSW1wbGVtZW50IFNVQlRSQUNUIEhBTEZXT1JEIChTR0gpKQozLzgg
Q2hlY2tpbmcgY29tbWl0IDYyNjJkMmVkYzc2ZCAoczM5MHgvdGNnOiBJbXBsZW1lbnQgTVVMVElQ
TFkgKE1HLCBNR1JLKSkKNC84IENoZWNraW5nIGNvbW1pdCA2NTZjZjg5ZDIzNTUgKHMzOTB4L3Rj
ZzogSW1wbGVtZW50IE1VTFRJUExZIEhBTEZXT1JEIChNR0gpKQo1LzggQ2hlY2tpbmcgY29tbWl0
IDJhZjliODNiNjFiZSAoczM5MHgvdGNnOiBJbXBsZW1lbnQgQlJBTkNIIElORElSRUNUIE9OIENP
TkRJVElPTiAoQklDKSkKNi84IENoZWNraW5nIGNvbW1pdCBlODY3YzdiNDI0MDAgKHMzOTB4L3Rj
ZzogSW1wbGVtZW50IE1VTFRJUExZIFNJTkdMRSAoTVNDLCBNU0dDLCBNU0dSS0MsIE1TUktDKSkK
Ny84IENoZWNraW5nIGNvbW1pdCA2N2M4ZTQwMjRmZDAgKHMzOTB4L3RjZzogV2Ugc3VwcG9ydCBN
aXNjZWxsYW5lb3VzLUluc3RydWN0aW9uLUV4dGVuc2lvbnMgRmFjaWxpdHkgMikKOC84IENoZWNr
aW5nIGNvbW1pdCA0YTcxMGNiNThmNTIgKHMzOTB4L3RjZzogSW1wbGVtZW50IENJUEhFUiBNRVNT
QUdFIFdJVEggQVVUSEVOVElDQVRJT04gKEtNQSkpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTIyMTAzMTI5LjEyODI0LTEtZGF2aWRAcmVk
aGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

