Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE5C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F5E20656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F5E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0fU-0001CT-59
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT0cL-0005Bo-E4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT0cK-0007IN-Vy
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:04:01 -0400
Resent-Date: Mon, 27 Apr 2020 06:04:01 -0400
Resent-Message-Id: <E1jT0cK-0007IN-Vy@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jT0cI-00075d-R6; Mon, 27 Apr 2020 06:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587981768; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MsJl0o/nr3mYfu3O/U789uhzmvpn6oVdAARtZwKAiz34cY+hD46OeyQY5+vkY5iNTgQWkCDVsY8s4gITFI382mlWt89LZrXJSBKVYXBW8CK0bH6Sf9su3v3hE8qA7yKS9lMn80isjEHYRyPgmEr1Cy9JzNA+aWDISP+Mu9QlUW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587981768;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=bfexMSzgZ6jIW1AOvihFrjnY4h5iMJl1MhbG71Le7XE=; 
 b=UiJ9+DSQXHZhAHNQeH2LORXPwxrPdBTyPfty8Oc+lDUPqm6sS2xgYxFst+5QFaiT5KYms8+RWcWrmpM7NkwbQTTpWOTnZ8c6DoSEkyiVZJtHyoEk/qEh4Sw2HSwlafbbBo5GWr1Lk2/0qICXHReKE4IXocyAlgVqcXW9gEtE1bU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158798176545878.03813021157896;
 Mon, 27 Apr 2020 03:02:45 -0700 (PDT)
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 00/17] 64bit block-layer
Message-ID: <158798176277.15667.14901963611957609957@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Mon, 27 Apr 2020 03:02:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 05:31:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: kwolf@redhat.com, fam@euphon.net, pbonzini@redhat.com,
 integration@gluster.org, berto@igalia.com, ronniesahlberg@gmail.com,
 qemu-block@nongnu.org, sw@weilnetz.de, stefanha@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, pavel.dovgaluk@ispras.ru,
 namei.unix@gmail.com, den@openvz.org, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyNzA4MjMyNS4xMDQx
NC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdGVz
dHMvdGVzdC1xaHQubwogIENDICAgICAgdGVzdHMvdGVzdC1xaHQtcGFyLm8KICBDQyAgICAgIHRl
c3RzL3FodC1iZW5jaC5vCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWJsb2NrLWlvdGhy
ZWFkLmM6Njg6NTogZXJyb3I6IGluaXRpYWxpemF0aW9uIGZyb20gaW5jb21wYXRpYmxlIHBvaW50
ZXIgdHlwZSBbLVdlcnJvcl0KICAgICAuYmRydl9jb19wcmVhZHYgICAgICAgICA9IGJkcnZfdGVz
dF9jb19wcnd2LAogICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtYmxvY2staW90
aHJlYWQuYzo2ODo1OiBlcnJvcjogKG5lYXIgaW5pdGlhbGl6YXRpb24gZm9yICdiZHJ2X3Rlc3Qu
YmRydl9jb19wcmVhZHYnKSBbLVdlcnJvcl0KL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3Qt
YmxvY2staW90aHJlYWQuYzo2OTo1OiBlcnJvcjogaW5pdGlhbGl6YXRpb24gZnJvbSBpbmNvbXBh
dGlibGUgcG9pbnRlciB0eXBlIFstV2Vycm9yXQogICAgIC5iZHJ2X2NvX3B3cml0ZXYgICAgICAg
ID0gYmRydl90ZXN0X2NvX3Byd3YsCiAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvdGVz
dC1ibG9jay1pb3RocmVhZC5jOjY5OjU6IGVycm9yOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3Ig
J2JkcnZfdGVzdC5iZHJ2X2NvX3B3cml0ZXYnKSBbLVdlcnJvcl0KL3RtcC9xZW11LXRlc3Qvc3Jj
L3Rlc3RzL3Rlc3QtYmxvY2staW90aHJlYWQuYzo3MDo1OiBlcnJvcjogaW5pdGlhbGl6YXRpb24g
ZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIFstV2Vycm9yXQogICAgIC5iZHJ2X2NvX3Bk
aXNjYXJkICAgICAgID0gYmRydl90ZXN0X2NvX3BkaXNjYXJkLAogICAgIF4KL3RtcC9xZW11LXRl
c3Qvc3JjL3Rlc3RzL3Rlc3QtYmxvY2staW90aHJlYWQuYzo3MDo1OiBlcnJvcjogKG5lYXIgaW5p
dGlhbGl6YXRpb24gZm9yICdiZHJ2X3Rlc3QuYmRydl9jb19wZGlzY2FyZCcpIFstV2Vycm9yXQpj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogW3Rlc3Rz
L3Rlc3QtYmxvY2staW90aHJlYWQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmls
ZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD05NTc0Nzk1NDBmYzc0MjIxYjU1OWE5
OGUyMDczNDE4OScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICct
dicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWRfemowaGlkL3NyYy9k
b2NrZXItc3JjLjIwMjAtMDQtMjctMDUuNTUuMzYuMTQxMjg6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPTk1NzQ3OTU0MGZjNzQyMjFiNTU5YTk4ZTIwNzM0MTg5Cm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWRfemowaGlkL3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICA3bTkuNDYxcwp1c2VyICAg
IDBtOS4zNjVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDQyNzA4MjMyNS4xMDQxNC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90
ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

