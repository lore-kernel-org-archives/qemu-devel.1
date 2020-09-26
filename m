Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5FFC4727C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 00:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0C822211
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 00:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0C822211
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLy2q-0005u3-1b
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 20:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLy1t-0005Nl-N1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 20:25:33 -0400
Resent-Date: Fri, 25 Sep 2020 20:25:33 -0400
Resent-Message-Id: <E1kLy1t-0005Nl-N1@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLy1r-00061Q-Ft
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 20:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601079919; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Hz9JPHW4UuvEqdank2xDaTWt9VbVo4y3pu+e3qPqVrzrxGbCVi5+1Ao1p2nCBCXi2fhfz9NRtL56iRygCimA0CYALkve8OpXPG85s8/SMXbLf8DQgXI2BO/NXFh8SghqS5U1p1UtmslOJ0b7ob5rJdzyLvu15MJY63xqefGBrbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601079919;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=l+zBX/f3LMU893EA4EcJ6JKrHEjWfhqgKm+snhF8WO0=; 
 b=LVl+UdBSf+51z4cOH8l/yM6M2rDv4RxHZhh/ZdiqOs6cnDoPGAXefL9e99OxJZ4A6F621DpRPJbrqsP9WG23r4ay/PDtPgjxy5IlgGCU6ATlei/p5qnypHb8IZyS9k8KL6k0njBuMlRP7sJ6caphbam3crPh0KXKbSViJyKEgOQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601079917540256.5119746948046;
 Fri, 25 Sep 2020 17:25:17 -0700 (PDT)
Subject: Re: [PATCH] i386: Document when features can be added to
 kvm_default_props
Message-ID: <160107991616.10465.6574326558842522453@66eaa9a8a123>
In-Reply-To: <20200925211021.4158567-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Fri, 25 Sep 2020 17:25:17 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 18:53:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, rth@twiddle.net,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNTIxMTAyMS40MTU4
NTY3LTEtZWhhYmtvc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpDIGxpbmtlciBmb3IgdGhl
IGhvc3QgbWFjaGluZTogY2MgbGQuYmZkIDIuMjctNDMKSG9zdCBtYWNoaW5lIGNwdSBmYW1pbHk6
IHg4Nl82NApIb3N0IG1hY2hpbmUgY3B1OiB4ODZfNjQKLi4vc3JjL21lc29uLmJ1aWxkOjEwOiBX
QVJOSU5HOiBNb2R1bGUgdW5zdGFibGUta2V5dmFsIGhhcyBubyBiYWNrd2FyZHMgb3IgZm9yd2Fy
ZHMgY29tcGF0aWJpbGl0eSBhbmQgbWlnaHQgbm90IGV4aXN0IGluIGZ1dHVyZSByZWxlYXNlcy4K
UHJvZ3JhbSBzaCBmb3VuZDogWUVTClByb2dyYW0gcHl0aG9uMyBmb3VuZDogWUVTICgvdXNyL2Jp
bi9weXRob24zKQpDb25maWd1cmluZyBuaW5qYXRvb2wgdXNpbmcgY29uZmlndXJhdGlvbgotLS0K
ICBURVNUICAgIGlvdGVzdC1xY293MjogMDI0CnNvY2tldF9hY2NlcHQgZmFpbGVkOiBSZXNvdXJj
ZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZQoqKgpFUlJPUjouLi9zcmMvdGVzdHMvcXRlc3QvbGli
cXRlc3QuYzozMDE6cXRlc3RfaW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBm
YWlsZWQ6IChzLT5mZCA+PSAwICYmIHMtPnFtcF9mZCA+PSAwKQouLi9zcmMvdGVzdHMvcXRlc3Qv
bGlicXRlc3QuYzoxNjY6IGtpbGxfcWVtdSgpIHRyaWVkIHRvIHRlcm1pbmF0ZSBRRU1VIHByb2Nl
c3MgYnV0IGVuY291bnRlcmVkIGV4aXQgc3RhdHVzIDEgKGV4cGVjdGVkIDApCkVSUk9SIHF0ZXN0
LWFhcmNoNjQ6IGJpb3MtdGFibGVzLXRlc3QgLSBCYWlsIG91dCEgRVJST1I6Li4vc3JjL3Rlc3Rz
L3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBh
c3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKbWFrZTogKioq
IFtydW4tdGVzdC0xNTldIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMDI1CiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDAyNwotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLXJtJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0x
YmYxODAyZGY3ZDQ0MzkyOWI5MmU5NTM0ZTRhODNmZicsICctdScsICcxMDAzJywgJy0tc2VjdXJp
dHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3Rt
cC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
cTVjZ2k0Z3Avc3JjL2RvY2tlci1zcmMuMjAyMC0wOS0yNS0yMC4wNy4wMC4xMDIzNjovdmFyL3Rt
cC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
cXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MWJmMTgwMmRmN2Q0NDM5MjliOTJlOTUzNGU0
YTgzZmYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcTVjZ2k0Z3Avc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE4
bTE1LjU4OHMKdXNlciAgICAwbTE2LjgzOHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTI1MjExMDIxLjQxNTg1NjctMS1laGFia29z
dEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

