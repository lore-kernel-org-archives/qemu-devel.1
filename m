Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ADCC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB4B206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB4B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLP8E-0005XB-7B
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLP7d-0004Qf-1u
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLP7b-0001Ev-LE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:36:52 -0400
Resent-Date: Mon, 06 Apr 2020 06:36:52 -0400
Resent-Message-Id: <E1jLP7b-0001Ev-LE@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLP7b-0001D6-Dh
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:36:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586169385; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MU9k8IQylkNMdRmzQMd3mpRQZw1kvRRy/WlapOMnzxpHxIEMqhp7S5T1nq6C5Upo6uExEJR4eNFrEHAqjj910cAe7XLh04WAUQxx8mhi9mMEsFYachXrw5s1TcZCeQ1Q8iK3FEZu0YXtTyKAaw3exZka3eI0tUE5kW13PEfTBVE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586169385;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=kFxJvzb9fF3pAhexL4yVDAC5NTwh2lv+GXVPBBG1wU8=; 
 b=V/9KJ7NTrAaeBsaDf/N9oT6Rzk3FLoJitMdSHCDw2lzitMbkTva4B6/Qzs3hQHcG/VxHMK4x6RgIr60xvO+z5BSF8qQQ5TkySlmcar/2icQAgGysH8SYoO9Tml2HHn6euJNXSmX5COMrZHZRCsjUg1Wl1erMyEwdvaZTk4xfRUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586169378892923.0689572563675;
 Mon, 6 Apr 2020 03:36:18 -0700 (PDT)
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v6 00/36] Initial support for multi-process qemu
Message-ID: <158616937578.1460.617020505011105662@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: elena.ufimtseva@oracle.com
Date: Mon, 6 Apr 2020 03:36:18 -0700 (PDT)
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTg2MTY1NTU1Lmdp
dC5lbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIExJTksg
ICAgcWVtdS1lZGlkLmV4ZQpsaWJxZW11dXRpbC5hKHFlbXUtc29ja2V0cy5vKTogSW4gZnVuY3Rp
b24gYHNvY2tldF9nZXRfZmQnOgovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9xZW11LXNvY2tldHMu
YzoxMDc5OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBtb25pdG9yX2dldF9mZCcKY29sbGVjdDI6
IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2U6ICoqKiBbTWFrZWZpbGU6Njg5
OiBxZW11LWdhLmV4ZV0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLgpsaWJxZW11dXRpbC5hKHFlbXUtc29ja2V0cy5vKTogSW4gZnVuY3Rpb24gYHNvY2tl
dF9nZXRfZmQnOgovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9xZW11LXNvY2tldHMuYzoxMDc5OiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBtb25pdG9yX2dldF9mZCcKY29sbGVjdDI6IGVycm9yOiBs
ZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1
bGVzLm1hazoxMjQ6IHFlbXUtaW8uZXhlXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQg
Y2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwg
aW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9j
ZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29t
bWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVt
dS5pbnN0YW5jZS51dWlkPWEyOWNmOWE3YjZhMjQxMzA5NjVmYTcwZjE4ZThhYjU0JywgJy11Jywg
JzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAn
LWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScs
ICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIv
LmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZG53bGJfajAvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0w
Ni0wNi4zMS4yOS45MDcwOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWEyOWNm
OWE3YjZhMjQxMzA5NjVmYTcwZjE4ZThhYjU0Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLWRud2xiX2owL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3Jh
XSBFcnJvciAyCgpyZWFsICAgIDRtNDYuNTE0cwp1c2VyICAgIDBtNS4yNDRzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTg2MTY1
NTU1LmdpdC5lbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0Bm
ZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

