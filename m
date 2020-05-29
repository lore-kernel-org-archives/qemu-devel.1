Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870BEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBF3206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBF3206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelfL-0004iB-Jj
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeleE-0003VK-Ds
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:30:35 -0400
Resent-Date: Fri, 29 May 2020 16:30:34 -0400
Resent-Message-Id: <E1jeleE-0003VK-Ds@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeleB-0002Ix-K3
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590784151; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Oe2T71MFnfwtqj+o6sVrE6xdMXJ09uhn2BFYkPbeDPUiH1/IjK4am0b06fVpiwD3gw1kNjkcpQI8E3yJo2TsEaLYHVWLWPmhOZkBrdrqh1RCtevLFlJXV9inSPjoZY3wYCMYfPKc5Enmn2WR+ptALdVEyhD7AD1XRC4kw90i0IE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590784151;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rHLKYFKe2sRU0i9UPIQaAzkijMre4K2SJrFkr+IQPvE=; 
 b=PMoyBG6/bWuTu+b7KC2FVbjoSdvutacAAUlJKNDITKI7f8rql6goJJkEHZ+DcTG08utZ8dsEloxZWqRQ/21N2ZpGodrxEDP7y1MLPsn/ut3I9L+/unR6h4LTOYAhEyci/TEZZcltPieT1BcboSZYDJkFvqbSbJQChszb6iyBTI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590784148602397.8959808762702;
 Fri, 29 May 2020 13:29:08 -0700 (PDT)
Message-ID: <159078414532.27167.6385744211111654003@45ef0f9c86ae>
In-Reply-To: <20200529140620.28759-1-lulu@redhat.com>
Subject: Re: [RFC v3 0/8] vDPA support in qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lulu@redhat.com
Date: Fri, 29 May 2020 13:29:08 -0700 (PDT)
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
OS0xLWx1bHVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgeDg2XzY0LXNvZnRt
bXUvaHcvdmlydGlvL3Zob3N0LXVzZXItZnMtcGNpLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11
L2h3L3ZpcnRpby92aXJ0aW8taW9tbXUubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvdmlydGlvL3Zo
b3N0LXZkcGEuYzogSW4gZnVuY3Rpb24gJ3Zob3N0X3ZkcGFfc2V0X2NvbmZpZyc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ody92aXJ0aW8vdmhvc3QtdmRwYS5jOjMyMzoxNzogZXJyb3I6ICdWSE9TVF9W
RFBBX01BWF9DT05GSUdfU0laRScgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rp
b24pCiAgICAgaWYgKChzaXplID4gVkhPU1RfVkRQQV9NQVhfQ09ORklHX1NJWkUpIHx8IChkYXRh
ID09IE5VTEwpKSB7CiAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvdmly
dGlvL3Zob3N0LXZkcGEuYzozMjM6MTc6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVy
IGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCm1h
a2VbMV06ICoqKiBbaHcvdmlydGlvL3Zob3N0LXZkcGEub10gRXJyb3IgMQptYWtlWzFdOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11
L2h3L3ZmaW8vY29tbW9uLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody92ZmlvL3NwYXBy
Lm8KLS0tCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvdmlydGlvL3Zob3N0LXZzb2NrLm8K
ICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody92aXJ0aW8vdmhvc3QtdnNvY2stcGNpLm8KL3Rt
cC9xZW11LXRlc3Qvc3JjL2h3L3ZpcnRpby92aG9zdC12ZHBhLmM6IEluIGZ1bmN0aW9uICd2aG9z
dF92ZHBhX3NldF9jb25maWcnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvdmlydGlvL3Zob3N0LXZk
cGEuYzozMjM6MTc6IGVycm9yOiAnVkhPU1RfVkRQQV9NQVhfQ09ORklHX1NJWkUnIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogICAgIGlmICgoc2l6ZSA+IFZIT1NUX1ZE
UEFfTUFYX0NPTkZJR19TSVpFKSB8fCAoZGF0YSA9PSBOVUxMKSkgewogICAgICAgICAgICAgICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3ZpcnRpby92aG9zdC12ZHBhLmM6MzIzOjE3OiBub3Rl
OiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVh
Y2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgptYWtlWzFdOiAqKiogW2h3L3ZpcnRpby92aG9zdC12
ZHBhLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KbWFrZTogKioqIFt4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFthYXJjaDY0LXNvZnRtbXUvYWxs
XSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rl
c3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0
KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2Rv
Y2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWM0ZDBhZmY5
NzE5ZTRlNjk4NjI1MmIxY2RhZDJkNzhhJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQn
LCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
anhraGdibnEvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0yOS0xNi4yNS41OS4yMjE0MDovdmFyL3Rt
cC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
cXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzRkMGFmZjk3MTllNGU2OTg2MjUyYjFjZGFk
MmQ3OGEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtanhraGdibnEvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDNt
Ny4wNzJzCnVzZXIgICAgMG05LjA1OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTI5MTQwNjIwLjI4NzU5LTEtbHVsdUByZWRoYXQu
Y29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

