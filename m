Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B7EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A4920748
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A4920748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqg51-0006IH-As
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqg1g-000299-Sn
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:56:00 -0400
Resent-Date: Wed, 01 Jul 2020 12:56:00 -0400
Resent-Message-Id: <E1jqg1g-000299-Sn@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqg1e-00065j-5C
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593622550; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fJhdhtbMaRwvYWasS6x9CM5qOne5RgkOpYJVdCeUTlUORxAaGKSVLCezyZIoXCR3/EFQlvCyazhjH/cO1PZLL8gZSX4UUhAUzqxipghBs2woOokO3k/2J3El9s51N6wXX1hn8HJDJkVJgXZIHi0HxY0Nh/e3cE/VAtAK64A5R0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593622550;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=tkhBi4MxHt41ZvPQqUaSaf0sQkcT/2cg2U9DX4DTBwU=; 
 b=eNT7tcCIcCuvT+i8vjjMLblU6Cc62Dk/X0T5fFTZThxRTsJtEwAIDsCNV7dHDliPG7e/8bfgd024n4/ER7SvnXEPHh+c3G52Rbyigxa+0vK2AzZ88bsTHcm8UI9tHszFoU+yLL0+kcWq5OZHA86/Z0DqGQ2COGx6MiOR/SPV8js=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593622548206359.87797769110557;
 Wed, 1 Jul 2020 09:55:48 -0700 (PDT)
Message-ID: <159362254716.26405.135052473618794853@d1fd068a5071>
Subject: Re: [PATCH  v2 0/3] some docs (booting, mttcg, icount)
In-Reply-To: <20200701161153.30988-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 1 Jul 2020 09:55:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:55:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMTE2MTE1My4zMDk4
OC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IHV0aWwvY3V0aWxzLm8KICBDQyAgICAgIHV0aWwvdW5pY29kZS5vCgpXYXJuaW5nLCB0cmVhdGVk
IGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy9pbnRlcm9wL2Jvb3RpbmcucnN0OjE0
MTpUaXRsZSBsZXZlbCBpbmNvbnNpc3RlbnQ6CgpIYXJkd2FyZQotLS0KICBDQyAgICAgIHV0aWwv
cWVtdS10aHJlYWQtd2luMzIubwogIENDICAgICAgdXRpbC9lbnZsaXN0Lm8KCldhcm5pbmcsIHRy
ZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0L3NyYy9kb2NzL2ludGVyb3AvYm9vdGluZy5y
c3Q6MTQxOlRpdGxlIGxldmVsIGluY29uc2lzdGVudDoKCkhhcmR3YXJlCn5+fn5+fn5+CiAgQ0Mg
ICAgICB1dGlsL3BhdGgubwptYWtlOiAqKiogW01ha2VmaWxlOjExMDg6IC5kb2NzX2ludGVyb3Bf
cWVtdS1nYS44LnNlbnRpbmVsLl0gRXJyb3IgMgptYWtlOiAqKiogRGVsZXRpbmcgZmlsZSAnLmRv
Y3NfaW50ZXJvcF9xZW11LWdhLjguc2VudGluZWwuJwptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW01ha2VmaWxlOjEwOTM6IGRvY3MvaW50ZXJvcC9p
bmRleC5odG1sXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBG
aWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2OSwgaW4gPG1vZHVsZT4KICAg
IHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywg
Jy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlk
PThhYTVjYTFiZjYwZDRhOWE4NDQwMjE4MTlhYmM2N2U0JywgJy11JywgJzEwMDEnLCAnLS1zZWN1
cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJ
U1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJ
Uj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2Nr
ZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1jaGM5MjJteS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTAxLTEyLjUyLjQyLjEyODM2
Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bics
ICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0t
LWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPThhYTVjYTFiZjYwZDRhOWE4NDQw
MjE4MTlhYmM2N2U0Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBM
ZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWNoYzkyMm15L3Ny
YycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFs
ICAgIDNtNS41NTlzCnVzZXIgICAgMG04LjU3MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAxMTYxMTUzLjMwOTg4LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

