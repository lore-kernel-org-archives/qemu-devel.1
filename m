Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00261C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB062073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB062073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyYV-0005rw-Qz
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jIyXJ-0004E4-2H
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jIyXH-0002YN-Qw
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:49:21 -0400
Resent-Date: Mon, 30 Mar 2020 13:49:20 -0400
Resent-Message-Id: <E1jIyXH-0002YN-Qw@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jIyXE-0002XP-Lc; Mon, 30 Mar 2020 13:49:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585590495; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SuHXTQ0Gvl7LaT6cctY0DD2VBZ7xnIN5N5oaTLrhpa06/abEo/v5KXvO283PxSO8yyONv2sWIpweCO5MI9ugRsmKSoLknTvYr2jNQD6Yx4C9OGwtqshYANL8Kze+F6qHZYfXqGE0/XIlZAlgPMnZd+e4jASIt/xSVaP3Pktar1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585590495;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1ld2/wASbTUqwSQ3+eU5NSmlgO4Gi18jpyuPLVRaJ78=; 
 b=CrYbyfed7WbufnWdkqvGSiVVmQX0hW9y2tp3DIRtj9RhnEeW4YKtJzx4WgXeGqvNigzTKGOew4FyEDRrqf23yZ/a+gJ/4EheGQiQb/2fqSU/8C7zhTaLw441BXGGe68A5Xkg5PsQxdb3xEKY0KNJQvqfBUl4wPM2xOuvFjbUR8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585590494043863.062493777744;
 Mon, 30 Mar 2020 10:48:14 -0700 (PDT)
In-Reply-To: <20200330141818.31294-1-vsementsov@virtuozzo.com>
Subject: Re: [RFC 0/3] 64bit block-layer part I
Message-ID: <158559049164.12686.4896317587974944282@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Mon, 30 Mar 2020 10:48:14 -0700 (PDT)
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 berto@igalia.com, pavel.dovgaluk@ispras.ru, qemu-block@nongnu.org,
 dillaman@redhat.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, ari@tuxera.com, stefanha@redhat.com, pbonzini@redhat.com,
 den@openvz.org, jsnow@redhat.com, ronniesahlberg@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMzMDE0MTgxOC4zMTI5
NC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdGVz
dHMvdGVzdC1pbnQxMjgubwogIENDICAgICAgdGVzdHMvcmN1dG9ydHVyZS5vCiAgQ0MgICAgICB0
ZXN0cy90ZXN0LXJjdS1saXN0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtYmxvY2st
aW90aHJlYWQuYzo2ODo1OiBlcnJvcjogaW5pdGlhbGl6YXRpb24gZnJvbSBpbmNvbXBhdGlibGUg
cG9pbnRlciB0eXBlIFstV2Vycm9yXQogICAgIC5iZHJ2X2NvX3ByZWFkdiAgICAgICAgID0gYmRy
dl90ZXN0X2NvX3Byd3YsCiAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvdGVzdC1ibG9j
ay1pb3RocmVhZC5jOjY4OjU6IGVycm9yOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IgJ2JkcnZf
dGVzdC5iZHJ2X2NvX3ByZWFkdicpIFstV2Vycm9yXQovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMv
dGVzdC1ibG9jay1pb3RocmVhZC5jOjY5OjU6IGVycm9yOiBpbml0aWFsaXphdGlvbiBmcm9tIGlu
Y29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XZXJyb3JdCiAgICAgLmJkcnZfY29fcHdyaXRldiAg
ICAgICAgPSBiZHJ2X3Rlc3RfY29fcHJ3diwKICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0
cy90ZXN0LWJsb2NrLWlvdGhyZWFkLmM6Njk6NTogZXJyb3I6IChuZWFyIGluaXRpYWxpemF0aW9u
IGZvciAnYmRydl90ZXN0LmJkcnZfY29fcHdyaXRldicpIFstV2Vycm9yXQpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogW3Rlc3RzL3Rlc3QtYmxvY2st
aW90aHJlYWQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9k
b2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2Fs
bGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJy
b3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAn
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hYzNlNTg1OWMxYjU0YzY4OTg4YzA3Y2RhMDI5NThjZCcs
ICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICct
LXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0n
LCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19F
TlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9w
YXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12
JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC00Y3hkOGQzay9zcmMvZG9ja2VyLXNyYy4y
MDIwLTAzLTMwLTEzLjQ0LjQwLjI5ODYzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRv
czcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD1hYzNlNTg1OWMxYjU0YzY4OTg4YzA3Y2RhMDI5NThjZAptYWtlWzFdOiAqKiogW2RvY2tl
ci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC00Y3hkOGQzay9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1
aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgM20zMC45NjVzCnVzZXIgICAgMG04LjM3MXMK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwMzMwMTQxODE4LjMxMjk0LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuZG9j
a2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

