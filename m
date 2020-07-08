Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E771221FA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E771221FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt5m5-0006H0-R5
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 04:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jt5lY-0005eM-KI
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:49:20 -0400
Resent-Date: Wed, 08 Jul 2020 04:49:20 -0400
Resent-Message-Id: <E1jt5lY-0005eM-KI@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jt5lU-0001Wl-Vv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:49:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594198138; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AiVOG8FlEg4c2FXfBSMVaJVaIFyPGLHG0p9Pypi8WDGpbO8Urj+rmrdKSUgPtpH3AzR5/EHHab6Sts2YLWz7tQAxilGM9Ag8onVruJ+fikuGdDHxZEIFmucJuoyKpeTdnKWlkhm0fRYiacwR/DRGmc7tA2oBwX+UhGnHIP9KVDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594198138;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/vVGte5/FTDR+KxVBwSmZc3b+5TVa1oU5Yzxg1a6qsk=; 
 b=TYynF0OT0ySeqWeCxGToWmxPdR2gRFagDDnAHZ7LKqHM9VTUYM1fToA3JkqdReAEyempE8RSDKoBP7mk0FRAZ1BhBkyykGDZHsObuspov/nDJj5nBCiNfV58RjPoZ1CWaqmzMbsDHX86oHhsItEHaoy1axu0f6f+TkboYsjPkAk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594198135377280.916658743845;
 Wed, 8 Jul 2020 01:48:55 -0700 (PDT)
Subject: Re: [PATCH] tests/docker: update toolchain set in debian-xtensa-cross
Message-ID: <159419813395.5639.4031547180514166722@07a7f0d89f7d>
In-Reply-To: <20200708082347.27318-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jcmvbkbc@gmail.com
Date: Wed, 8 Jul 2020 01:48:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 04:49:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, alex.bennee@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, jcmvbkbc@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwODA4MjM0Ny4yNzMx
OC0xLWpjbXZia2JjQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgotLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4KKy4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLkUuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CitFUlJPUjogdGVzdF9wYXVzZSAo
X19tYWluX18uVGVzdFNpbmdsZUJsb2NrZGV2VW5hbGlnbmVkTGVuZ3RoKQorLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQorVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgorICBGaWxlICIwNDEiLCBsaW5l
IDEwOCwgaW4gdGVzdF9wYXVzZQotLS0KIFJhbiAxMDQgdGVzdHMKIAotT0sKK0ZBSUxFRCAoZXJy
b3JzPTEpCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0MgogIFRFU1QgICAgY2hlY2stcXRlc3Qt
eDg2XzY0OiB0ZXN0cy9xdGVzdC9udW1hLXRlc3QKICBURVNUICAgIGlvdGVzdC1xY293MjogMDQz
Ci0tLQpOb3QgcnVuOiAyNTkKRmFpbHVyZXM6IDA0MQpGYWlsZWQgMSBvZiAxMTkgaW90ZXN0cwpt
YWtlOiAqKiogW2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxClRyYWNlYmFjayAo
bW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHki
LCBsaW5lIDY2OSwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTllZTY4MGY4MTBjYjQxYTNiMDU5YjY5NTcwYmVi
NmRlJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9o
b21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtX2VoaGxweWUvc3JjL2RvY2tlci1z
cmMuMjAyMC0wNy0wOC0wNC4yOS4zNS4yNjcxNDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpj
ZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9u
LXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9OWVlNjgwZjgxMGNiNDFhM2IwNTliNjk1NzBiZWI2ZGUKbWFrZVsxXTogKioqIFtk
b2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtX2VoaGxweWUvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVz
dC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE5bTE5LjUzMXMKdXNlciAgICAwbTku
NDQ2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDA3MDgwODIzNDcuMjczMTgtMS1qY212YmtiY0BnbWFpbC5jb20vdGVzdGluZy5kb2Nr
ZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

