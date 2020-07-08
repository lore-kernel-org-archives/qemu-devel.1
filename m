Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3316DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E5020658
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E5020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtFxS-0007aZ-8W
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtFwr-00079S-AV
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:41:41 -0400
Resent-Date: Wed, 08 Jul 2020 15:41:41 -0400
Resent-Message-Id: <E1jtFwr-00079S-AV@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtFwo-0004eB-M6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 15:41:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594237283; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gtDAk9ec4l6eOmf7oXJjYoWskCImY14z6Md95BJPs/1v+D+cS/CwiXaVDy0l5Iv6z2hDkXLUI5VWpeOWYbHVf2rLZhyUOBs9oPvNFPwHErf+YcZxivES714lqspdNHHVLhPmfVjNOKAbxOZ3Io2d9WInzZBHHDH/ntuY4NfVQB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594237283;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9MENnI/2MiMROXLGzOvUXBeO9R9qlWUrijuUYmM3nJk=; 
 b=SiwEgJRlsiynXhMQQrE7jkJSGpuaro7YBdnWPJ62K4qLb3zh3CLtgIlDWfarUTnbIaziWzRGpHNIHGs6vtMVXlcZ/M6Ub8MaftdiXtPMAT+XS8EdE48oPHI8LOTn/5j4EPxCCgB/o5OjWq1cfjgIY749qbKMZTPTsugjAUHNV44=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594237280276623.5001523861886;
 Wed, 8 Jul 2020 12:41:20 -0700 (PDT)
Subject: Re: [PATCH 0/2] keepalive default
Message-ID: <159423727868.12725.11739775474362564458@07a7f0d89f7d>
In-Reply-To: <20200708191540.28455-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 8 Jul 2020 12:41:20 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:41:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwODE5MTU0MC4yODQ1
NS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgaHcvaHBwYS90cmFjZS5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9z
cmMvdXRpbC9xZW11LXNvY2tldHMuYzoyNDoKL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcWVtdS1z
b2NrZXRzLmM6IEluIGZ1bmN0aW9uICdpbmV0X3NldF9rZWVwYWxpdmUnOgovdG1wL3FlbXUtdGVz
dC9zcmMvdXRpbC9xZW11LXNvY2tldHMuYzo0Njk6NDY6IGVycm9yOiAnVENQX0tFRVBJRExFJyB1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICA0NjkgfCAgICAgcmV0ID0g
cWVtdV9zZXRzb2Nrb3B0KHNvY2ssIElQUFJPVE9fVENQLCBUQ1BfS0VFUElETEUsICZ2YWwsIHNp
emVvZih2YWwpKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS1jb21t
b24uaDo0ODozMTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAncWVtdV9zZXRzb2Nrb3B0
JwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS1jb21tb24uaDo0ODozMTogbm90
ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAncWVtdV9zZXRzb2Nrb3B0JwogICA0OCB8ICAgICBz
ZXRzb2Nrb3B0KHNvY2tmZCwgbGV2ZWwsIG9wdG5hbWUsIChjb25zdCB2b2lkICopb3B0dmFsLCBv
cHRsZW4pCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fgovdG1w
L3FlbXUtdGVzdC9zcmMvdXRpbC9xZW11LXNvY2tldHMuYzo0NzY6NDY6IGVycm9yOiAnVENQX0tF
RVBJTlRWTCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgNDc2IHwg
ICAgIHJldCA9IHFlbXVfc2V0c29ja29wdChzb2NrLCBJUFBST1RPX1RDUCwgVENQX0tFRVBJTlRW
TCwgJnZhbCwgc2l6ZW9mKHZhbCkpOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1
ZGUvcWVtdS1jb21tb24uaDo0ODozMTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAncWVt
dV9zZXRzb2Nrb3B0JwogICA0OCB8ICAgICBzZXRzb2Nrb3B0KHNvY2tmZCwgbGV2ZWwsIG9wdG5h
bWUsIChjb25zdCB2b2lkICopb3B0dmFsLCBvcHRsZW4pCiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9xZW11LXNvY2tl
dHMuYzo0ODM6NDY6IGVycm9yOiAnVENQX0tFRVBDTlQnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBp
biB0aGlzIGZ1bmN0aW9uKQogIDQ4MyB8ICAgICByZXQgPSBxZW11X3NldHNvY2tvcHQoc29jaywg
SVBQUk9UT19UQ1AsIFRDUF9LRUVQQ05ULCAmdmFsLCBzaXplb2YodmFsKSk7CiAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4KL3Rt
cC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS1jb21tb24uaDo0ODozMTogbm90ZTogaW4gZGVm
aW5pdGlvbiBvZiBtYWNybyAncWVtdV9zZXRzb2Nrb3B0JwogICA0OCB8ICAgICBzZXRzb2Nrb3B0
KHNvY2tmZCwgbGV2ZWwsIG9wdG5hbWUsIChjb25zdCB2b2lkICopb3B0dmFsLCBvcHRsZW4pCiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fgptYWtlOiAqKiogWy90
bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHV0aWwvcWVtdS1zb2NrZXRzLm9dIEVycm9y
IDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrICht
b3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIs
IGxpbmUgNjY5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9YmFiMjU1MjQ1ZDk0NDMyYWFiZWZlYjQxODljNmFjZWQnLCAnLXUnLCAnMTAwMScsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1l
JywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11
LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLW1jazA0YjV1L3NyYy9kb2NrZXItc3JjLjIwMjAtMDctMDgtMTUuMzguMDgu
MTczNzY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YmFiMjU1MjQ1ZDk0NDMy
YWFiZWZlYjQxODljNmFjZWQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbWNrMDRi
NXUvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIK
CnJlYWwgICAgM20xMS4yNjRzCnVzZXIgICAgMG04Ljk3NnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzA4MTkxNTQwLjI4NDU1LTEt
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

