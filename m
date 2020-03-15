Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F9CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A5A20637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A5A20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTei-0006oL-PQ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jDTd1-0005ov-3e
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jDTcz-0006HH-7K
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:48:30 -0400
Resent-Date: Sun, 15 Mar 2020 09:48:30 -0400
Resent-Message-Id: <E1jDTcz-0006HH-7K@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jDTcy-00062Y-Vn
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:48:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584280085; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BquPqY0Zn4iTKBmiWfBZCCjAUUzh/Orbqub5tBHFho4lV11VcMRZM1b9aoCYXREtj22Q07D5JFTQHYmUq+jjk2DuT3u63oR+eY2qqLCyPmf+l89w6wrII6h8wD6+qRC1Crc1B8LHVh94O3lAa+egs7RZOnwt6umott/7fiNr+jk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584280085;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RRAJDfVZDjw+5G+JpXh8BX5xKa6v0HCw4ybWk+lOnyE=; 
 b=lrSNZpEPu/EDVmpQ7RjR4OjhIfj1KaNYWAW/E7A8pwXgWab4LeuUsPHCfSc/3xG5PF+qWamHykjBTW896jOSnQH75jPtjWDqM/YKsA7e282WwxCKwLi7EuF1GIEYYekA6jmtA/AeIjOHk5r+Z+2Fyca/MTU1ZN/rDHvnAb2rY8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584280083810903.8535066485549;
 Sun, 15 Mar 2020 06:48:03 -0700 (PDT)
In-Reply-To: <20200315132447.113131-1-liran.alon@oracle.com>
Subject: Re: [PATCH] hw/scsi/vmw_pvscsi: Remove assertion for kick after reset
Message-ID: <158428008248.6054.7878741749637968511@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Sun, 15 Mar 2020 06:48:03 -0700 (PDT)
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
Cc: fam@euphon.net, pbonzini@redhat.com, dmitry.fleytman@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxNTEzMjQ0Ny4xMTMx
MzEtMS1saXJhbi5hbG9uQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBBUyAgICAg
IHBjLWJpb3Mvb3B0aW9ucm9tL3B2aC5vCiAgQ0MgICAgICBwYy1iaW9zL29wdGlvbnJvbS9wdmhf
bWFpbi5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9zY3NpL3Ztd19wdnNjc2kuYzogSW4gZnVuY3Rp
b24gJ3B2c2NzaV9wcm9jZXNzX2lvJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3Njc2kvdm13X3B2
c2NzaS5jOjcyMzo5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3Fl
bXVfbG9nJzsgZGlkIHlvdSBtZWFuICdxZW11X2ZvcmsnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5j
dGlvbi1kZWNsYXJhdGlvbl0KICAgICAgICAgcWVtdV9sb2coIldBUk5JTkc6IFBWU0NTSTogQ2Fu
bm90IHByb2Nlc3MgSS9PIHdoZW4gIgogICAgICAgICBefn5+fn5+fgogICAgICAgICBxZW11X2Zv
cmsKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3Njc2kvdm13X3B2c2NzaS5jOjcyMzo5OiBlcnJvcjog
bmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAncWVtdV9sb2cnIFstV2Vycm9yPW5lc3RlZC1l
eHRlcm5zXQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAq
KiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L3Njc2kvdm13X3B2c2NzaS5v
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQlVJ
TEQgICBwYy1iaW9zL29wdGlvbnJvbS9tdWx0aWJvb3QuaW1nCiAgQlVJTEQgICBwYy1iaW9zL29w
dGlvbnJvbS9saW51eGJvb3QuaW1nCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD0wMGM1NTRlNjgxM2Y0MWE3YmQ2ODgwMDgxNDEyOWMyOCcsICctdScsICcxMDAzJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNI
RV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11
LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLWh1dW9mX2M5L3NyYy9kb2NrZXItc3JjLjIwMjAtMDMtMTUtMDkuNDYuMDgu
MTI5MDc6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDBjNTU0ZTY4MTNmNDFh
N2JkNjg4MDA4MTQxMjljMjgKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaHV1b2Zf
Yzkvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIK
CnJlYWwgICAgMW01My41MDlzCnVzZXIgICAgMG03LjcyMHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzE1MTMyNDQ3LjExMzEzMS0x
LWxpcmFuLmFsb25Ab3JhY2xlLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

