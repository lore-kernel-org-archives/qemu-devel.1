Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD81B2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD81B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelli-00014Y-13
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jelkx-0000e6-28
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:37:32 -0400
Resent-Date: Fri, 29 May 2020 16:37:31 -0400
Resent-Message-Id: <E1jelkx-0000e6-28@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jelkt-0004Pt-Di
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:37:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590784627; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Rl5wlPpwvZexASfJ1aNri9K5dcQWSEolpFYINOTZw0QXXu/kqws4crkH2wquoGJ4j5ODfI2qZcCVI5jN4CwjWelmU3zix/tyjTB7XjdSroiJ6Yyizf5r2dSm1WHuZ8AX1lvVhM43fl263YRB0YxF1fKYsRxis7DrP0gsXC7bSOI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590784627;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=n7Uep5GmWnNfC1hwaPHRbjpmq9WgHmZSEs56etps05I=; 
 b=eBAnuXfA4Bs3Zrb6UHd37S2BZv8WHzgJtcnAaEn0yzCuJGLR7VzEX1V2VEJEyZDyNUQuvfWEEScFhzC96WVqBSuMVNHC09XBl1b3tYg5CYpD2Kb9jcdVZqDw5cdxCw7ncqD6Gm930SdM0RWJ7StSf6O2yYcHL+Y5fgXIuSeC52U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590784626806439.24765494294115;
 Fri, 29 May 2020 13:37:06 -0700 (PDT)
Message-ID: <159078462335.27167.17200430374234267995@45ef0f9c86ae>
In-Reply-To: <20200529140620.28759-1-lulu@redhat.com>
Subject: Re: [RFC v3 0/8] vDPA support in qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lulu@redhat.com
Date: Fri, 29 May 2020 13:37:06 -0700 (PDT)
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
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaW8vY2hh
bm5lbC13ZWJzb2NrLm8KICBDQyAgICAgIGlvL2NoYW5uZWwtdXRpbC5vCgpXYXJuaW5nLCB0cmVh
dGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8uLi9xZW11LW9wdGlvbnMuaHg6
MjkyMDpJbmxpbmUgbGl0ZXJhbCBzdGFydC1zdHJpbmcgd2l0aG91dCBlbmQtc3RyaW5nLgogIEND
ICAgICAgaW8vZG5zLXJlc29sdmVyLm8KICBDQyAgICAgIGlvL25ldC1saXN0ZW5lci5vCi0tLQog
IENDICAgICAgcW9tL2NvbnRhaW5lci5vCiAgQ0MgICAgICBxb20vcW9tLXFvYmplY3QubwoKV2Fy
bmluZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvLi4vcWVtdS1v
cHRpb25zLmh4OjI5MjA6SW5saW5lIGxpdGVyYWwgc3RhcnQtc3RyaW5nIHdpdGhvdXQgZW5kLXN0
cmluZy4KICBDQyAgICAgIHFvbS9vYmplY3RfaW50ZXJmYWNlcy5vCiAgQ0MgICAgICBxZW11LWlv
Lm8KLS0tCiAgQ0MgICAgICBpb3RocmVhZC5vCiAgQ0MgICAgICBqb2ItcW1wLm8KICBDQyAgICAg
IG9zLXdpbjMyLm8KbWFrZTogKioqIFtNYWtlZmlsZToxMTAzOiBkb2NzL3N5c3RlbS9pbmRleC5o
dG1sXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1h
a2U6ICoqKiBbTWFrZWZpbGU6MTExNDogLmRvY3Nfc3lzdGVtX3FlbXUuMV9kb2NzX3N5c3RlbV9x
ZW11LWJsb2NrLWRyaXZlcnMuN19kb2NzX3N5c3RlbV9xZW11LWNwdS1tb2RlbHMuNy5zZW50aW5l
bC5dIEVycm9yIDIKbWFrZTogKioqIERlbGV0aW5nIGZpbGUgJy5kb2NzX3N5c3RlbV9xZW11LjFf
ZG9jc19zeXN0ZW1fcWVtdS1ibG9jay1kcml2ZXJzLjdfZG9jc19zeXN0ZW1fcWVtdS1jcHUtbW9k
ZWxzLjcuc2VudGluZWwuJwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmls
ZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0xYjA1ZTBmNjcxMDA0OGM3OGRhMjhl
OGRiN2FkZGM4NycsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2Fj
aGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOW1mZmo3eTQvc3JjL2Rv
Y2tlci1zcmMuMjAyMC0wNS0yOS0xNi4zNS4xMy43ODY5Oi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPTFiMDVlMGY2NzEwMDQ4Yzc4ZGEyOGU4ZGI3YWRkYzg3Cm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTltZmZqN3k0L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDFtNTAuNTUycwp1c2VyICAgIDBt
OC42ODBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDUyOTE0MDYyMC4yODc1OS0xLWx1bHVAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tl
ci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

