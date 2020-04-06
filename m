Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A818C2BA80
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342202072F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 20:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342202072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLYYE-0008R8-Ey
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 16:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLYXP-0007oy-6A
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLYXO-0005ks-0b
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:40:07 -0400
Resent-Date: Mon, 06 Apr 2020 16:40:07 -0400
Resent-Message-Id: <E1jLYXO-0005ks-0b@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLYXN-0005jZ-PN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 16:40:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586205590; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ejT237q+vWGLyXTl9L7nG+WaiZfY/pvuRDwCSnS3by1hKSqE7ECQvcO9XVyHUCOyr7rpz3K9qvN2fcgoAfUX2QEJwRm/sw1FbEqTAFeDUadTm8qExZ1S2cOQKbQG5L61tAfwN5UB28U7X1mx3KQZHKz50Qqq87MABGDW8vCN3D0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586205590;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wmkHAF7m6ZW0vDvcD0k9nYX/dj6sdQx8OvsZZif9Dac=; 
 b=J3N1SEjFXS2gAWqLgjGuJoLi++viRunLjGlggWWtK0teTe39ovsrvAlNFgtYNkMl9lWB4tgp0ouv7RSTsrl9QeaFn/QeiE2h3cdMdbx1h83eUlUlE2+5az7KE2DfMQ2kwDUCikGxEnXwEcJpjneaNyHtD2pTorGqpgNPN5DoEvE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158620558562019.978086141694007;
 Mon, 6 Apr 2020 13:39:45 -0700 (PDT)
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v2 00/54] various: Fix error-propagation with
 Coccinelle scripts
Message-ID: <158620558415.11348.6623024802074701567@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Mon, 6 Apr 2020 13:39:45 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwNjE3NDc0My4xNjk1
Ni0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEJVSUxEICAgZnAtdGVzdAogIEND
ICAgICAgdGVzdHMvcXRlc3QvZW5kaWFubmVzcy10ZXN0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3Rl
c3RzL3Rlc3QtcWRldi1nbG9iYWwtcHJvcHMuYzogSW4gZnVuY3Rpb24gJ2R5bmFtaWNfaW5zdGFu
Y2VfaW5pdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LXFkZXYtZ2xvYmFsLXByb3Bz
LmM6MTU0OjM4OiBlcnJvcjogJ2Vycm9yX2Fib3J0JyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4g
dGhpcyBmdW5jdGlvbikKICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwsICZlcnJv
cl9hYm9ydCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3Fl
bXUtdGVzdC9zcmMvdGVzdHMvdGVzdC1xZGV2LWdsb2JhbC1wcm9wcy5jOjE1NDozODogbm90ZTog
ZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNo
IGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KbWFrZTogKioqIFt0ZXN0cy90ZXN0LXFkZXYtZ2xvYmFs
LXByb3BzLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KICBDQyAgICAgIGZwLXRlc3QubwogIENDICAgICAgc2xvd2Zsb2F0Lm8KLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWM4MzRlY2RjZmY0ZTQ3YzU5NmViZGNmODU3MjQ1
MjIzJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9o
b21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMTJzaHB4czAvc3JjL2RvY2tlci1z
cmMuMjAyMC0wNC0wNi0xNi4zNi41Ny45Njk4Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNl
bnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFu
Y2UudXVpZD1jODM0ZWNkY2ZmNGU0N2M1OTZlYmRjZjg1NzI0NTIyMwptYWtlWzFdOiAqKiogW2Rv
Y2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC0xMnNocHhzMC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0
LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMm00Ny43MjdzCnVzZXIgICAgMG04Ljk5
N3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwNDA2MTc0NzQzLjE2OTU2LTEtZjRidWdAYW1zYXQub3JnL3Rlc3RpbmcuZG9ja2VyLXF1
aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

