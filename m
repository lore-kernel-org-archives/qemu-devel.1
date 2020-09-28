Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8780C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF7E20759
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF7E20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtOJ-0005nd-IK
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMtKL-0001M2-Kg; Mon, 28 Sep 2020 09:36:26 -0400
Resent-Date: Mon, 28 Sep 2020 09:36:25 -0400
Resent-Message-Id: <E1kMtKL-0001M2-Kg@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMtKJ-00056f-59; Mon, 28 Sep 2020 09:36:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601300165; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WEoRGMsLWPsdCCLB60bCaDaLx+WB1B3cEIhRJoRiJ075Qc6d6WOuWxRiI8YR9SJzO+bBI7VOsUF2vCyLixLNKOivp8wzKbBc+7/Pt3bISbCwTLSkbnjvcsd+1JLT1UOs983d/tu2WMz9kEBtiR87x1NSw747CU6cT9JDgPuAhs8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601300165;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=y5mZEDPuXkxPnzBJGInpwafJQWHIWlBuq89DLfAS3UY=; 
 b=njhZQoTdW8FkHbHSq+qcAP5WU5trsJpl51xLdcszeWjJHCn+j2v5SS2XvEKcU84GBlZQKjwZoHqPrMbaKwW+jmSfD2A7Zd95wR3I5HHZv3OTfi/x1tAA6lAsKlhcUiEDFqkttLgtLqkFBcXmGmhU89aYAQn/uQLAEX9bCtr8mQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601300162939502.83080742976983;
 Mon, 28 Sep 2020 06:36:02 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] s390x/tcg: Implement some z14 facilities
Message-ID: <160130016121.10465.5676018291318875903@66eaa9a8a123>
In-Reply-To: <20200928122717.30586-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@redhat.com
Date: Mon, 28 Sep 2020 06:36:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:36:16
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyODEyMjcxNy4zMDU4
Ni0xLWRhdmlkQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDkyODEyMjcxNy4zMDU4Ni0x
LWRhdmlkQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYyIDAvOV0gczM5MHgvdGNnOiBJbXBs
ZW1lbnQgc29tZSB6MTQgZmFjaWxpdGllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQK
RnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRh
dGVdICAgICAgcGF0Y2hldy8yMDIwMDkyNTE2MjMxNi4yMTIwNS0xLXBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZyAtPiBwYXRjaGV3LzIwMjAwOTI1MTYyMzE2LjIxMjA1LTEtcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA5MjgwNjEyMDEuMTYw
MS0xLXdhbmd6aGlxaWFuZy5iakBieXRlZGFuY2UuY29tIC0+IHBhdGNoZXcvMjAyMDA5MjgwNjEy
MDEuMTYwMS0xLXdhbmd6aGlxaWFuZy5iakBieXRlZGFuY2UuY29tCiAqIFtuZXcgdGFnXSAgICAg
ICAgIHBhdGNoZXcvMjAyMDA5MjgwOTI3MDUuMzczMC0xLXdhbmd6aGlxaWFuZy5iakBieXRlZGFu
Y2UuY29tIC0+IHBhdGNoZXcvMjAyMDA5MjgwOTI3MDUuMzczMC0xLXdhbmd6aGlxaWFuZy5iakBi
eXRlZGFuY2UuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA5MjgxMjU4NTku
NzM0Mjg3LTEtcGhpbG1kQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDkyODEyNTg1OS43MzQy
ODctMS1waGlsbWRAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAw
OTI4MTMxOTM0LjczOTQ1MS0xLXBoaWxtZEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA5Mjgx
MzE5MzQuNzM5NDUxLTEtcGhpbG1kQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0Jwo5ZDQyYzZiIHMzOTB4L3RjZzogSW1wbGVtZW50IENJUEhFUiBNRVNTQUdFIFdJVEgg
QVVUSEVOVElDQVRJT04gKEtNQSkKMzNiYjQyNiBzMzkweC90Y2c6IFdlIHN1cHBvcnQgTWlzY2Vs
bGFuZW91cy1JbnN0cnVjdGlvbi1FeHRlbnNpb25zIEZhY2lsaXR5IDIKNzQ5ZjE4MyBzMzkweC90
Y2c6IEltcGxlbWVudCBNVUxUSVBMWSBTSU5HTEUgKE1TQywgTVNHQywgTVNHUktDLCBNU1JLQykK
NDhkODVlNiBzMzkweC90Y2c6IEltcGxlbWVudCBCUkFOQ0ggSU5ESVJFQ1QgT04gQ09ORElUSU9O
IChCSUMpCmNlMDRlNzcgczM5MHgvdGNnOiBJbXBsZW1lbnQgTVVMVElQTFkgSEFMRldPUkQgKE1H
SCkKOTZmOWM5YyBzMzkweC90Y2c6IEltcGxlbWVudCBNVUxUSVBMWSAoTUcsIE1HUkspCmZmNWIw
NDcgczM5MHgvdGNnOiBJbXBsZW1lbnQgU1VCVFJBQ1QgSEFMRldPUkQgKFNHSCkKMThmMjA1NSBz
MzkweC90Y2c6IEltcGxlbWVudCBBREQgSEFMRldPUkQgKEFHSCkKNzUzM2Q4ZiBzMzkweC9jcHVf
bW9kZWw6IFMzOTBfRkVBVF9NSVNDX0lOU1RSVUNUSU9OX0VYVCAtPiBTMzkwX0ZFQVRfTUlTQ19J
TlNUUlVDVElPTl9FWFQyCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzkgQ2hlY2tpbmcgY29tbWl0
IDc1MzNkOGZkN2NhMSAoczM5MHgvY3B1X21vZGVsOiBTMzkwX0ZFQVRfTUlTQ19JTlNUUlVDVElP
Tl9FWFQgLT4gUzM5MF9GRUFUX01JU0NfSU5TVFJVQ1RJT05fRVhUMikKMi85IENoZWNraW5nIGNv
bW1pdCAxOGYyMDU1NWVkNmYgKHMzOTB4L3RjZzogSW1wbGVtZW50IEFERCBIQUxGV09SRCAoQUdI
KSkKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMzNDogRklMRTogdGFyZ2V0L3MzOTB4
L3RyYW5zbGF0ZS5jOjYxMDE6CisjZGVmaW5lIEZBQ19NSUUyICAgICAgICBTMzkwX0ZFQVRfTUlT
Q19JTlNUUlVDVElPTl9FWFQyIC8qIG1pc2NlbGxhbmVvdXMtaW5zdHJ1Y3Rpb24tZXh0ZW5zaW9u
cyBmYWNpbGl0eSAyICovCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE0IGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDIvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy85IENoZWNraW5n
IGNvbW1pdCBmZjViMDQ3NjEyNWMgKHMzOTB4L3RjZzogSW1wbGVtZW50IFNVQlRSQUNUIEhBTEZX
T1JEIChTR0gpKQo0LzkgQ2hlY2tpbmcgY29tbWl0IDk2ZjljOWNhYzBlNyAoczM5MHgvdGNnOiBJ
bXBsZW1lbnQgTVVMVElQTFkgKE1HLCBNR1JLKSkKNS85IENoZWNraW5nIGNvbW1pdCBjZTA0ZTc3
MzczZGIgKHMzOTB4L3RjZzogSW1wbGVtZW50IE1VTFRJUExZIEhBTEZXT1JEIChNR0gpKQo2Lzkg
Q2hlY2tpbmcgY29tbWl0IDQ4ZDg1ZTY0MzZiYiAoczM5MHgvdGNnOiBJbXBsZW1lbnQgQlJBTkNI
IElORElSRUNUIE9OIENPTkRJVElPTiAoQklDKSkKNy85IENoZWNraW5nIGNvbW1pdCA3NDlmMTgz
YjliZTQgKHMzOTB4L3RjZzogSW1wbGVtZW50IE1VTFRJUExZIFNJTkdMRSAoTVNDLCBNU0dDLCBN
U0dSS0MsIE1TUktDKSkKOC85IENoZWNraW5nIGNvbW1pdCAzM2JiNDI2NDY5ZmQgKHMzOTB4L3Rj
ZzogV2Ugc3VwcG9ydCBNaXNjZWxsYW5lb3VzLUluc3RydWN0aW9uLUV4dGVuc2lvbnMgRmFjaWxp
dHkgMikKOS85IENoZWNraW5nIGNvbW1pdCA5ZDQyYzZiN2YxZjggKHMzOTB4L3RjZzogSW1wbGVt
ZW50IENJUEhFUiBNRVNTQUdFIFdJVEggQVVUSEVOVElDQVRJT04gKEtNQSkpCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTI4MTIyNzE3LjMw
NTg2LTEtZGF2aWRAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

