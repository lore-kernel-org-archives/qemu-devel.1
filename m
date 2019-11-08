Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBDCC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C622085B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C622085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2yv-0007MP-It
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iT2wz-0006Ex-5F
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iT2wu-0006Cl-2l
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:01:13 -0500
Resent-Date: Fri, 08 Nov 2019 07:01:13 -0500
Resent-Message-Id: <E1iT2wu-0006Cl-2l@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iT2wq-0005y7-Gd; Fri, 08 Nov 2019 07:01:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573214448; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WL8F83rL4Vg/cyldiJzKDH94/DYWccYKqUHBQLuF1G9+7B6YuacR66i99V7ACXng/tOcrd2RGpQ/3fwx9/EyWSjjBvJdDN99k5Q6W8vbU28Ptif39Gqr2/F+Yruw0qlpusTqcCsu/DRD97j2gyDizDcEIJxtzewC1mTkrevNShc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573214448;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qgjne4f+JI6AGgrKHyYiv9lTgRZG5zV9fDjl6uoNpts=; 
 b=O7xnvCrqgQcHemCv8s5tcwDNGwjiGjmlichEr+OrD8H++N1r03JPyPiEG6si4/NmbVkxIeZqamYGE6lLg40X1A1w64ZJoRjaIvXJFvdltTpluGiePT+i+soUd42Z+Tt3GtO+Fof0LkHtLICWvH9XmdaetNz5PT29Xvh4lPArBA8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573214445895422.60992837946367;
 Fri, 8 Nov 2019 04:00:45 -0800 (PST)
In-Reply-To: <20191108101655.10611-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 0/2] Deprecate implicit filters
Message-ID: <157321444410.31898.1482127132000677175@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 8 Nov 2019 04:00:45 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: kwolf@redhat.com, mlevitsk@redhat.com, pkrempa@redhat.com,
 qemu-block@nongnu.org, libvir-list@redhat.com, jsnow@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, vsementsov@virtuozzo.com,
 dinechin@redhat.com, den@openvz.org, mreitz@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwODEwMTY1NS4xMDYx
MS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFNJR04g
ICAgcGMtYmlvcy9vcHRpb25yb20vcHZoLmJpbgogIEdFTiAgICAgZG9jcy9pbnRlcm9wL3FlbXUt
Z2EtcmVmLjcKL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtZGVwcmVjYXRlZC50ZXhpOjIxMDogQG9w
dGlvbiBleHBlY3RlZCBicmFjZXMKbWFrZTogKioqIFtNYWtlZmlsZTo5OTQ6IHFlbXUtZG9jLnR4
dF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgovdG1w
L3FlbXUtdGVzdC9zcmMvcWVtdS1kZXByZWNhdGVkLnRleGk6MjEwOiBAb3B0aW9uIGV4cGVjdGVk
IGJyYWNlcwptYWtlOiAqKiogW01ha2VmaWxlOjk4NzogcWVtdS1kb2MuaHRtbF0gRXJyb3IgMQpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0t
LQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5D
YWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVu
JywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0zZDQwNDQ4MjI3OWY0ZmU2OGZj
YjJjOTk3MWYyNDgwYScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9
dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9D
T05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0n
LCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywg
Jy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9j
Y2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbWxwb2t3dGcvc3Jj
L2RvY2tlci1zcmMuMjAxOS0xMS0wOC0wNi41Ni4zMy4yMzgwNTovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFl
bXUuaW5zdGFuY2UudXVpZD0zZDQwNDQ4MjI3OWY0ZmU2OGZjYjJjOTk3MWYyNDgwYQptYWtlWzFd
OiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1tbHBva3d0Zy9zcmMnCm1ha2U6ICoqKiBbZG9ja2Vy
LXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICA0bTExLjE3MHMKdXNlciAg
ICAwbTQuNDA0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTExMDgxMDE2NTUuMTA2MTEtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20v
dGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


