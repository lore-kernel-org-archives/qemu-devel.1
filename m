Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A554DCA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 12:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D7420640
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 12:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D7420640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMAnL-0006aI-FN
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 08:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMAmF-0005hB-T2
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 08:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMAmD-0001va-Ld
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 08:57:43 -0400
Resent-Date: Sun, 20 Oct 2019 08:57:42 -0400
Resent-Message-Id: <E1iMAmD-0001va-Ld@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMAmB-0001v4-Kr
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 08:57:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571576233; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UWy0H6nGaode+RHp1iy504PkBJgrYF1U2jBPS95yQp59YJq4UlAkWXAnSULWJIzqswbofGHIfN4dJodU2soXXvpGHVxbJM3Z2Juihn5i30Vq/gC3kbaq57hpuhHv46l5kGgQUJW9GUN2yu/mKqCuuG8pd1hZDrP+n2Uwb3wKj0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571576233;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rcUB2XxWKdmh1j8A6qREOzm6ONkaaORD/V3zfyRhQCE=; 
 b=fyaD2eWh+Y5RJh6TUdSIXY96A2p2pJXF6BOJsTwgR6BC+y/Gn0LzdgQXpBENCqnf+7EBzazPJBXviOA+3xMYnT1Hb2k8WRLbYs2AK4FQq2ZuSlPuaC8+G7AG2vjO6HiWaMD2tHbAKcTXEEhMQXnTjk2kYUGlgl5qmXM1yIryjqo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571576232730694.8871239046193;
 Sun, 20 Oct 2019 05:57:12 -0700 (PDT)
In-Reply-To: <20191020111125.27659-1-tao3.xu@intel.com>
Subject: Re: [PATCH v13 00/12] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <157157623112.24734.16823570057075336330@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Sun, 20 Oct 2019 05:57:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, tao3.xu@intel.com,
 fan.du@intel.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMDExMTEyNS4yNzY1
OS0xLXRhbzMueHVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkxvb2tpbmcgZm9yIGV4cGVjdGVk
IGZpbGUgJ3Rlc3RzL2RhdGEvYWNwaS9wYy9TUkFULmFjcGlobWF0JwpMb29raW5nIGZvciBleHBl
Y3RlZCBmaWxlICd0ZXN0cy9kYXRhL2FjcGkvcGMvU1JBVCcKKioKRVJST1I6L3RtcC9xZW11LXRl
c3Qvc3JjL3Rlc3RzL2Jpb3MtdGFibGVzLXRlc3QuYzozNTQ6bG9hZF9leHBlY3RlZF9hbWw6IGFz
c2VydGlvbiBmYWlsZWQ6IChleHBfc2R0LmFtbF9maWxlKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJP
UjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvYmlvcy10YWJsZXMtdGVzdC5jOjM1NDpsb2FkX2V4
cGVjdGVkX2FtbDogYXNzZXJ0aW9uIGZhaWxlZDogKGV4cF9zZHQuYW1sX2ZpbGUpCm1ha2U6ICoq
KiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZp
bmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAzNQogIFRFU1QgICAgY2hl
Y2stdW5pdDogdGVzdHMvdGVzdC1idWZmZXJpc3plcm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9j
ZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29t
bWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVt
dS5pbnN0YW5jZS51dWlkPTMzMzUyOGIzZGVmNDRiZWRiNzg2ODE2M2QxNjdkZThhJywgJy11Jywg
JzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAn
LWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScs
ICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywg
Jy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcv
LmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtODN4N2NwZWMvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0y
MC0wOC40Ni4zMC4xNjUzNzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzMz
NTI4YjNkZWY0NGJlZGI3ODY4MTYzZDE2N2RlOGEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtODN4N2NwZWMvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50
b3M3XSBFcnJvciAyCgpyZWFsICAgIDEwbTQwLjg4NnMKdXNlciAgICAwbTguNzAzcwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMjAx
MTExMjUuMjc2NTktMS10YW8zLnh1QGludGVsLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50
b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


