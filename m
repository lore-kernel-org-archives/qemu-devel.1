Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928AEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A532071A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A532071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeliK-00076y-KC
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jelhc-0006Gz-8a
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:34:04 -0400
Resent-Date: Fri, 29 May 2020 16:34:04 -0400
Resent-Message-Id: <E1jelhc-0006Gz-8a@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jelhZ-0000RS-I5
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590784421; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AeqpZQryj4VxUptP6c6dL2Lrxt543dN+iGONwaNOn0wwz3+OIhNLV4Jtd74mZqKOIDF0GAD3wzjIwFgAMlTZH4qk0gmIFlTUj/z0mmwzR3qklQEAij6dTXumiA90i3ZAOdjg2D9r/FK4Lt46X25dyFgIPOgE71zQA6l5zmqSWww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590784421;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Sp/yk3lTx1nMXoDxkiHxNV3d7rAqz2Fhhr85DQo4Km8=; 
 b=QIeCrSLO4V4jmvsUDESreYEuWwM1PQL5wUjjBYqxK6pvfXnIrAav5Yfv3/IXEowatX3+Y5kG3xnZtk2X3YDwpGJUqM5vgYG3miBcMW3f53pUo+kcqqiJ9vSCh5HekJSzUIXTXIKUVlTh3F30ZT7v85EQTXpCdtuAZ6lKaIAcalQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590784419454405.1762031759382;
 Fri, 29 May 2020 13:33:39 -0700 (PDT)
Message-ID: <159078441621.27167.16238722568778352476@45ef0f9c86ae>
In-Reply-To: <20200529140620.28759-1-lulu@redhat.com>
Subject: Re: [RFC v3 0/8] vDPA support in qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lulu@redhat.com
Date: Fri, 29 May 2020 13:33:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 16:30:28
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
Cc: rdunlap@infradead.org, mst@redhat.com, mhabets@solarflare.com,
 qemu-devel@nongnu.org, rob.miller@broadcom.com, saugatm@xilinx.com,
 lulu@redhat.com, armbru@redhat.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, jasowang@redhat.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 maxime.coquelin@redhat.com, aadam@redhat.com, cohuck@redhat.com,
 hanand@xilinx.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyOTE0MDYyMC4yODc1
OS0xLWx1bHVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFzYW4g
YnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91
dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJs
eSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICBhY2NlbC90Y2cvdHJhY2UubwogIENDICAgICAgYmFja2VuZHMvdHJhY2UubwoKV2Fybmlu
ZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvLi4vcWVtdS1vcHRp
b25zLmh4OjI5MjA6SW5saW5lIGxpdGVyYWwgc3RhcnQtc3RyaW5nIHdpdGhvdXQgZW5kLXN0cmlu
Zy4KICBDQyAgICAgIGNyeXB0by90cmFjZS5vCiAgQ0MgICAgICBtb25pdG9yL3RyYWNlLm8KLS0t
CiAgQ0MgICAgICBibG9jay90cmFjZS5vCiAgQ0MgICAgICBpby90cmFjZS5vCiAgQ0MgICAgICBu
YmQvdHJhY2UubwptYWtlOiAqKiogW01ha2VmaWxlOjExMTQ6IC5kb2NzX3N5c3RlbV9xZW11LjFf
ZG9jc19zeXN0ZW1fcWVtdS1ibG9jay1kcml2ZXJzLjdfZG9jc19zeXN0ZW1fcWVtdS1jcHUtbW9k
ZWxzLjcuc2VudGluZWwuXSBFcnJvciAyCm1ha2U6ICoqKiBEZWxldGluZyBmaWxlICcuZG9jc19z
eXN0ZW1fcWVtdS4xX2RvY3Nfc3lzdGVtX3FlbXUtYmxvY2stZHJpdmVycy43X2RvY3Nfc3lzdGVt
X3FlbXUtY3B1LW1vZGVscy43LnNlbnRpbmVsLicKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KCldhcm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0
L3NyYy9kb2NzLy4uL3FlbXUtb3B0aW9ucy5oeDoyOTIwOklubGluZSBsaXRlcmFsIHN0YXJ0LXN0
cmluZyB3aXRob3V0IGVuZC1zdHJpbmcuCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEwMzogZG9jcy9z
eXN0ZW0vaW5kZXguaHRtbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFz
dCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1
bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9y
KHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1sn
c3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFu
Y2UudXVpZD05N2FjZmRhYjY4ZDM0ZWQ0YWJkOGZkY2JmZjcyNzkzYycsICctdScsICcxMDAxJywg
Jy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RB
UkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0
Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12Jywg
Jy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1sM2NsZ3Yyay9zcmMvZG9ja2VyLXNyYy4yMDIw
LTA1LTI5LTE2LjMwLjA0LjIwOTc6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
OTdhY2ZkYWI2OGQzNGVkNGFiZDhmZGNiZmY3Mjc5M2MKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtbDNjbGd2Mmsvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0Bm
ZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgM20zMi42NjBzCnVzZXIgICAgMG04LjMxMHMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTI5
MTQwNjIwLjI4NzU5LTEtbHVsdUByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

