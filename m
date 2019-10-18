Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F5DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 23:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD3A2089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 23:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD3A2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLbh1-0007re-Kb
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 19:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iLbgP-0007RT-Ij
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 19:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iLbgM-00017h-L0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 19:29:21 -0400
Resent-Date: Fri, 18 Oct 2019 19:29:21 -0400
Resent-Message-Id: <E1iLbgM-00017h-L0@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iLbgM-00015n-Dj; Fri, 18 Oct 2019 19:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571441347; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cTAWMD0Cr9Hu628ohSRUu+0aRtw/TClkionHtAjUIq9a2fPT6HylgNjnGng5HG/WYwjh7WOtz+TLdTEk9ZQKJFmN8wY5X5trbisHaOkP1iJaAxo25jAIr73GjIkD4RSJ6o0phJuBJOXqo7sgV4181Ami3R8IFssNzQmxJGkB4y4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571441347;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=f4yjxkBtH8jFEhclGK1E8gCwxE+9aToprEElST0s8sI=; 
 b=gvEAcIsyicRdMGFhLJyCNbnSjwJFGlHjI7Frx2h4EusIY6NldLOI1/2BZBCt1ka3Te4X2914r3WrWESSNPvy/9Ps82kOS2TLK8dQ4R3UdWChR8MJfAVZm/x0ffWaWffb+2/VMB4Wa5Ni7jYipi4lXajHWHz9hulF3sfCfCQl5mk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571441346092100.56928968137242;
 Fri, 18 Oct 2019 16:29:06 -0700 (PDT)
In-Reply-To: <20191018104438.6158-1-thuth@redhat.com>
Subject: Re: [PATCH] Do not use %m in common code to print error messages
Message-ID: <157144134474.24734.7450116290823922069@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Fri, 18 Oct 2019 16:29:06 -0700 (PDT)
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, kamil@netbsd.org,
 berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxODEwNDQzOC42MTU4
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcvbWlzYy9pbXg2
X2NjbS5vCiAgQ0MgICAgICBody9taXNjL2lteDZ1bF9jY20ubwovdG1wL3FlbXUtdGVzdC9zcmMv
aHcvbWlzYy90bXA0MjEuYzogSW4gZnVuY3Rpb24gJ3RtcDQyMV9zZXRfdGVtcGVyYXR1cmUnOgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvbWlzYy90bXA0MjEuYzoxNjY6OTogZXJyb3I6IGZvcm1hdCAn
JXMnIGV4cGVjdHMgYSBtYXRjaGluZyAnY2hhciAqJyBhcmd1bWVudCBbLVdlcnJvcj1mb3JtYXQ9
XQogICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJlcnJvciByZWFkaW5nICVzOiAlcyIsIGVycm1z
Zyk7CiAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMK
ICBDQyAgICAgIGh3L21pc2MvaW14N19jY20ubwogIENDICAgICAgaHcvbWlzYy9pbXgyX3dkdC5v
Cm1ha2U6ICoqKiBbaHcvbWlzYy90bXA0MjEub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+
Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vz
cy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAn
cnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1lYWUwNTQ0MzIyOTA0NTg0
YjMwZDNjZTdiY2I3N2E4MicsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2Nv
bXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRS
QV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJV
Rz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNo
ZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90
bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTc4Nm5zcmlx
L3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMTgtMTkuMjYuNTkuMTA2ODE6L3Zhci90bXAvcWVtdTp6
LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10n
IHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1j
b20ucWVtdS5pbnN0YW5jZS51dWlkPWVhZTA1NDQzMjI5MDQ1ODRiMzBkM2NlN2JjYjc3YTgyCm1h
a2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9y
eSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTc4Nm5zcmlxL3NyYycKbWFrZTogKioqIFtk
b2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTUuNTc4cwp1
c2VyICAgIDBtNy41MjJzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDE5MTAxODEwNDQzOC42MTU4LTEtdGh1dGhAcmVkaGF0LmNvbS90ZXN0
aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


