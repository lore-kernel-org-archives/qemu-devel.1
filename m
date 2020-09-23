Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B2EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E3421BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E3421BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4hx-0006dx-5f
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL4gq-0005YM-P8; Wed, 23 Sep 2020 09:20:08 -0400
Resent-Date: Wed, 23 Sep 2020 09:20:08 -0400
Resent-Message-Id: <E1kL4gq-0005YM-P8@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL4go-0003Ra-0D; Wed, 23 Sep 2020 09:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600867190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YAscWlQslsYO5xWyC+KwnCTFce0gf7vEohKbOF4RfU5UHKXLxpJkLa7/ct4+VGscxP+Sr5O0IMn9f4ebfmT2PiaoVKZSWQ0x+5EFaV9jcWpDc/a8vet7NXUE6bkMmZJhv6szUDMKcUJMLxHgwNl637uoZZpVE8bXaIFtGO4Cj8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600867190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=K+YOu8w9XoDhdx1qeMSyb62OUDOBtrAG9DlY5gPNhyA=; 
 b=gJTrHa66foTnCxoq3uhk3pt0ESjCOKhf4XO/RESM2hMWUHygLFiWPewdMys1UPpyBT8JgMMvA3ZzkNd0WBnVnSNxHsfNQ5CCJpFcLRND2QsTiTTGN7NmuffkRvVqFEps0NiE5dM+fReowvqgQ/O1p7hoF8iUaeLfa1vIS5HnjZ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600867188650167.82748159333482;
 Wed, 23 Sep 2020 06:19:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Add support for loading SMBIOS OEM strings from a
 file
Message-ID: <160086718660.23158.14368998722153069203@66eaa9a8a123>
In-Reply-To: <20200923104102.2068416-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Wed, 23 Sep 2020 06:19:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 09:20:02
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMzEwNDEwMi4yMDY4
NDE2LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tl
ci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dA
ZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpIb3N0IG1hY2hp
bmUgY3B1OiB4ODZfNjQKVGFyZ2V0IG1hY2hpbmUgY3B1IGZhbWlseTogeDg2ClRhcmdldCBtYWNo
aW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWlsZDoxMDogV0FSTklORzogTW9kdWxlIHVu
c3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNvbXBhdGliaWxpdHkg
YW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dyYW0gc2ggZm91bmQ6
IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0aG9uMykKQ29uZmln
dXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tCmRvbmUKY29weWluZyBzdGF0
aWMgZmlsZXMuLi4gLi4uIENvbXBpbGluZyBDIG9iamVjdCBsaWJxZW11LXg4Nl82NC1zb2Z0bW11
LmZhLnAvdGFyZ2V0X2kzODZfc2VnX2hlbHBlci5jLm9iagouLi9zcmMvaHcvc21iaW9zL3NtYmlv
cy5jOiBJbiBmdW5jdGlvbiAnc2F2ZV9vcHRfb25lJzoKLi4vc3JjL2h3L3NtYmlvcy9zbWJpb3Mu
Yzo5Nzg6MTg6IGVycm9yOiB0b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiAncWVtdV9vcGVu
JwogIDk3OCB8ICAgICAgICAgaW50IGZkID0gcWVtdV9vcGVuKHZhbHVlLCBPX1JET05MWSk7CiAg
ICAgIHwgICAgICAgICAgICAgICAgICBefn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4u
L3NyYy9ody9zbWJpb3Mvc21iaW9zLmM6MTg6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3Fl
bXUvb3NkZXAuaDo1MDU6NTogbm90ZTogZGVjbGFyZWQgaGVyZQogIDUwNSB8IGludCBxZW11X29w
ZW4oY29uc3QgY2hhciAqbmFtZSwgaW50IGZsYWdzLCBFcnJvciAqKmVycnApOwogICAgICB8ICAg
ICBefn5+fn5+fn4KbWFrZTogKioqIFtNYWtlZmlsZS5uaW5qYToxMzkxOiBsaWJjb21tb24uZmEu
cC9od19zbWJpb3Nfc21iaW9zLmMub2JqXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1
bmZpbmlzaGVkIGpvYnMuLi4uCmRvbmUKY29weWluZyBleHRyYSBmaWxlcy4uLiBkb25lCi0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tcm0nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTJhNjgxN2QxMjEzMTRl
NTVhMmY4YWU4MGY2NDFmOGQ4JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2Vj
Y29tcD11bmNvbmZpbmVkJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLV91aWJtZXl0L3NyYy9k
b2NrZXItc3JjLjIwMjAtMDktMjMtMDkuMTYuMTkuMTI3NTM6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXUvZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJu
ZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9MmE2ODE3ZDEyMTMxNGU1NWEyZjhhZTgwZjY0MWY4ZDgKbWFrZVsxXTog
KioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtX3VpYm1leXQvc3JjJwptYWtlOiAqKiogW2RvY2tlci1y
dW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgM20yNi41ODVzCnVzZXIgICAg
MG0yMS42OTZzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDkyMzEwNDEwMi4yMDY4NDE2LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS90ZXN0
aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

