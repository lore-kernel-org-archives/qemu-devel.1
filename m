Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF4C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACB92083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACB92083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmLl-000782-UU
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 07:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLmKm-0006LF-QF; Fri, 25 Sep 2020 07:56:16 -0400
Resent-Date: Fri, 25 Sep 2020 07:56:16 -0400
Resent-Message-Id: <E1kLmKm-0006LF-QF@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLmKk-0002pc-Bh; Fri, 25 Sep 2020 07:56:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601034965; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JsrlPWDoF0gqxtWXAUvnMTQFkt0Ih1fWgBZxR9Mq13ZXema7Ze3VYfy0hO7F8jqggW/egcXIaaHz62Gyj75rriz3bqSsYrXq0zPH8of+LnzYCr4BrIbtzhQYGQO4CaD8b7GnZsQL+GEcHwKdklmzUow04st34f9NJY2kDl28kzM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601034965;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=e47laVpHD7tFVTzPUrqKJVN+kYY3gOmkPZ81kd4q4Rk=; 
 b=IvcsdG5FSCeY8U1PR4WQYNFYAoBT2W6GJkcQiU4oKipiG8m0v/D9Fur1geNSejd+lXdwOHTlZTo+PlYC1NP/Dc0LscR9jmRCn7QGVev3dTrxsNARRj6bwBAnOZUYY6o9ugypS7lrw4VRIvsQQJMto7eemuGDQlJjzin/ShjpyAI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601034962850746.3295282995545;
 Fri, 25 Sep 2020 04:56:02 -0700 (PDT)
Subject: Re: [PATCH 00/14] raspi: add the bcm2835 cprman clock manager
Message-ID: <160103496128.12744.12223263817740860098@66eaa9a8a123>
In-Reply-To: <20200925101731.2159827-1-luc@lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luc@lmichel.fr
Date: Fri, 25 Sep 2020 04:56:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 07:56:12
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
Cc: peter.maydell@linaro.org, luc@lmichel.fr, qemu-devel@nongnu.org,
 Andrew.Baumann@microsoft.com, f4bug@amsat.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNTEwMTczMS4yMTU5
ODI3LTEtbHVjQGxtaWNoZWwuZnIvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQyBsaW5rZXIgZm9yIHRoZSBob3N0
IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhvc3QgbWFjaGluZSBjcHUgZmFtaWx5OiB4ODZf
NjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWlsZDoxMDogV0FSTklO
RzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNv
bXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dy
YW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0
aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tClJ1bm5p
bmcgdGVzdCBxdGVzdC1hYXJjaDY0OiBxbXAtdGVzdApCcm9rZW4gcGlwZQouLi9zcmMvdGVzdHMv
cXRlc3QvbGlicXRlc3QuYzoxNzU6IGtpbGxfcWVtdSgpIGRldGVjdGVkIFFFTVUgZGVhdGggZnJv
bSBzaWduYWwgMTEgKFNlZ21lbnRhdGlvbiBmYXVsdCkgKGNvcmUgZHVtcGVkKQpFUlJPUiBxdGVz
dC1hYXJjaDY0OiBkZXZpY2UtaW50cm9zcGVjdC10ZXN0IC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4
cGVjdGVkIDYsIGdvdCA1KQpDb3VsZCBub3QgYWNjZXNzIEtWTSBrZXJuZWwgbW9kdWxlOiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5CnFlbXUtc3lzdGVtLXg4Nl82NDogLWFjY2VsIGt2bTogZmFp
bGVkIHRvIGluaXRpYWxpemUga3ZtOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CnFlbXUtc3lz
dGVtLXg4Nl82NDogZmFsbGluZyBiYWNrIHRvIHRjZwptYWtlOiAqKiogW3J1bi10ZXN0LTE2Nl0g
RXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgoKTG9va2lu
ZyBmb3IgZXhwZWN0ZWQgZmlsZSAndGVzdHMvZGF0YS9hY3BpL3EzNS9GQUNQLmlwbWlidCcKLS0t
CiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNh
bGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4n
LCAnLS1ybScsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NGU1NDBlOGI2MmY3
NDZiMDgyYWQ0NzY5M2UyNTIxZmEnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NP
TkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScs
ICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywg
Jy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9j
Y2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZDR1ZXM1eV8vc3Jj
L2RvY2tlci1zcmMuMjAyMC0wOS0yNS0wNy40Ny40OC4xODEyNjovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9NGU1NDBlOGI2MmY3NDZiMDgyYWQ0NzY5M2UyNTIxZmEKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZDR1ZXM1eV8vc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDhtMTMuMTMzcwp1c2Vy
ICAgIDBtMjAuNTgwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAyMDA5MjUxMDE3MzEuMjE1OTgyNy0xLWx1Y0BsbWljaGVsLmZyL3Rlc3Rp
bmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

