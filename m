Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD6C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A85205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A85205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieOA5-0004yv-4p
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieNjK-0003m3-S4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieNjJ-0006K9-Ji
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:25:58 -0500
Resent-Date: Mon, 09 Dec 2019 13:25:58 -0500
Resent-Message-Id: <E1ieNjJ-0006K9-Ji@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieNjJ-0006Jr-Bc
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:25:57 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575915835; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aJg6tjLfpJHJRXBr5iAeBt9EmVA0H/GcxkGFlDAPwB0Sv61pjcCeIl1AdglYeA3p5yQkQL5owGQQea2OPcIZu9STD8Vf+21N5KN+Yu//DO1yS0Rv6bFSYkKPYPHgCb2aistQtQR8q7q+qgPIpanLFW0uIy4k5ZAucgj4ZGmo7/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575915835;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/MQPQtMAKJ32amM3CkUJGLOwRmwsZnCR3KgDFVovi/8=; 
 b=XqLsePwjlAiarZOLFqyuvWatuoylUm78TfroJcWLIlNATZmTBgX7QRlgNcigRR17l+mqMhue+nkn4ByUvMhKXmMD/YfzqsqjoqLsoYtmmEAsKTdWMPv4s/IIBHRhRfE1u9JUGRmNxZOs78B/rhynwD/6v4bDEWdZESWfCvahlGA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575915833346424.6480689921857;
 Mon, 9 Dec 2019 10:23:53 -0800 (PST)
In-Reply-To: <20191209125248.5849-1-thuth@redhat.com>
Subject: Re: [libvirt] [PATCH v2 0/4] Remove deprecated pc-0.x machine types
 and related hacks
Message-ID: <157591583189.7675.17491337491732382921@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Mon, 9 Dec 2019 10:23:53 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwOTEyNTI0OC41ODQ5
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTdWJtb2R1bGUgJ2R0Yycg
KGh0dHBzOi8vZ2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0KSByZWdpc3RlcmVkIGZvciBwYXRoICdk
dGMnCkNsb25pbmcgaW50byAnZHRjJy4uLgpyZW1vdGU6IENvdW50aW5nIG9iamVjdHM6IDUyODAs
IGRvbmUuICAgICAgICAKZXJyb3I6IFJQQyBmYWlsZWQ7IHJlc3VsdD0xOCwgSFRUUCBjb2RlID0g
MjAwCmZhdGFsOiBUaGUgcmVtb3RlIGVuZCBodW5nIHVwIHVuZXhwZWN0ZWRseQpmYXRhbDogcHJv
dG9jb2wgZXJyb3I6IGJhZCBwYWNrIGhlYWRlcgpDbG9uZSBvZiAnaHR0cHM6Ly9naXQucWVtdS5v
cmcvZ2l0L2R0Yy5naXQnIGludG8gc3VibW9kdWxlIHBhdGggJ2R0YycgZmFpbGVkCmZhaWxlZCB0
byB1cGRhdGUgc3VibW9kdWxlIGR0YwpTdWJtb2R1bGUgJ2R0YycgKGh0dHBzOi8vZ2l0LnFlbXUu
b3JnL2dpdC9kdGMuZ2l0KSB1bnJlZ2lzdGVyZWQgZm9yIHBhdGggJ2R0YycKbWFrZVsxXTogKioq
IFsvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOWxjbnV4YXQvc3JjL2RvY2tlci1zcmMuMjAx
OS0xMi0wOS0xMy4xOS4xOC43MjI5XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5
IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOWxjbnV4YXQvc3JjJwptYWtlOiAqKiogW2Rv
Y2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG0zNS4xODNzCnVz
ZXIgICAgMG0yLjY1N3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkxMjA5MTI1MjQ4LjU4NDktMS10aHV0aEByZWRoYXQuY29tL3Rlc3Rp
bmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


