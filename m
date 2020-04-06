Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB798C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB182054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB182054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOsB-0005GJ-P5
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLOm7-0002cU-5y
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLOm5-0004h9-Mn
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:38 -0400
Resent-Date: Mon, 06 Apr 2020 06:14:38 -0400
Resent-Message-Id: <E1jLOm5-0004h9-Mn@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLOm5-0004gE-El
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586168048; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E/e7j7UHgcY2V/u1o47Ys0bkksfBWNFjw9TYVjRnekx+MIdVrbUT/XtjQVWadLFprsO+ADp7A+xXT96MeN1WSTCNtt8xFtXD+43mRzOJRl9G+35BbjWLxd4n6bgbT9XCksnI3YIbPj5wRm6WbnyZnnKrwN+s3Jdk2biTBCGSKJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586168048;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6guS2k0K1aAcCilb3T6qfWYfloClyx+X9/7/Jbfm514=; 
 b=XHOXBbJIDsq7ClW5bbydbLSEIO0fJq9vKHeHEJRCzJ1cVpArPTVjnW2zeU5oOvEo2k3xObfLQwZsTgXydBdoSj+vq2oETdVl3mVrNo3nlbJkjzZD21HFSzMas7rdYYjafb1H+VKgAMtp5bS8K1Sy4i3ZuSLnWeZX14XepUS9C7s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586168042959951.2855408957737;
 Mon, 6 Apr 2020 03:14:02 -0700 (PDT)
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v6 00/36] Initial support for multi-process qemu
Message-ID: <158616803979.1460.13294311898021421882@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: elena.ufimtseva@oracle.com
Date: Mon, 6 Apr 2020 03:14:02 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTg2MTY1NTU1Lmdp
dC5lbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5k
CnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNh
biBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9y
YSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VU
X0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KCiAgQ0MgICAgICBzdHVicy94ZW4tY29tbW9uLm8KICBDQyAgICAgIHN0dWJzL3hlbi1odm0u
bwogIENDICAgICAgc3R1YnMvcGNpLWhvc3QtcGlpeC5vCi90bXAvcWVtdS10ZXN0L3NyYy9zdHVi
cy9tb25pdG9yLmM6MjU6MTQ6IGVycm9yOiB3ZWFrIGlkZW50aWZpZXIgJ3FhcGlfZXZlbnRfZW1p
dCcgbmV2ZXIgZGVjbGFyZWQgWy1XZXJyb3JdCiNwcmFnbWEgd2VhayBxYXBpX2V2ZW50X2VtaXQK
ICAgICAgICAgICAgIF4KMSBlcnJvciBnZW5lcmF0ZWQuCiAgQ0MgICAgICBzdHVicy9yYW0tYmxv
Y2subwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHN0dWJzL21v
bml0b3Iub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2Nr
ZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD1kYjVlZTgwZDhlNTk0MTQ3OGU2ODdlYmZlMGQ3ZGRiNScsICct
dScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYn
LCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2Fj
aGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtODhmY2dxNV8vc3JjL2Rv
Y2tlci1zcmMuMjAyMC0wNC0wNi0wNi4wOS4zNS4yMTI3MzovdmFyL3RtcC9xZW11Onoscm8nLCAn
cWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5l
ZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUu
aW5zdGFuY2UudXVpZD1kYjVlZTgwZDhlNTk0MTQ3OGU2ODdlYmZlMGQ3ZGRiNQptYWtlWzFdOiAq
KiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC04OGZjZ3E1Xy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1
bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICA0bTIzLjc4NnMKdXNlciAgICAw
bTguNjY3cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvY292ZXIuMTU4NjE2NTU1NS5naXQuZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20vdGVz
dGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

