Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE47C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55E721BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55E721BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4lX-00089t-Mi
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL4kv-0007Ra-WB; Wed, 23 Sep 2020 09:24:22 -0400
Resent-Date: Wed, 23 Sep 2020 09:24:21 -0400
Resent-Message-Id: <E1kL4kv-0007Ra-WB@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL4kt-00041F-CF; Wed, 23 Sep 2020 09:24:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600867438; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HLwA/Nklkrb7Y0wXHBINdv16+Ff/UF2SVv7IKyiS3tbjYl8x4S5i0oQJjGOX4QanaZ6eVdEtX4cnowSWpU9VMyhBYkgoQHl0xCVGQahYg4S0FOl3Peb1Hn9as7JCChQua6DiUJj+Hiv9WMhao9ky3BsL7wj/YAkNBwQRUcjBpNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600867438;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=VnIUSkHnw6myX2RXAFJceLS3dna7G98MvpRpeIMO9Yw=; 
 b=AE4lyy0EfXGZEg+IgsxkAusWYAoICgsf/YDUQIDv9IK1TfgH9/lBjzFLIympV2DjdjAezWRKbhHA2jkvzB5ljLax25tCu7qZ25qfweENC+++n/cc8r1iQu+JsVgOsYcCvz+Do4V5bIXkENE3Nif3ZiIAFp5qqhEwn/kE464nZ+E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600867437013782.0463689580795;
 Wed, 23 Sep 2020 06:23:57 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Add support for loading SMBIOS OEM strings from a
 file
Message-ID: <160086743498.23158.999351932696569376@66eaa9a8a123>
In-Reply-To: <20200923104102.2068416-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Wed, 23 Sep 2020 06:23:57 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 09:20:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMzEwNDEwMi4yMDY4
NDE2LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
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
Q29tcGlsaW5nIEMgb2JqZWN0IGxpYmNvbW1vbi5mYS5wL2h3X3RpbWVyX2hwZXQuYy5vCkNvbXBp
bGluZyBDIG9iamVjdCBsaWJjb21tb24uZmEucC91aV9pbnB1dC1rZXltYXAuYy5vCi4uL3NyYy9o
dy9zbWJpb3Mvc21iaW9zLmM6IEluIGZ1bmN0aW9uICdzYXZlX29wdF9vbmUnOgouLi9zcmMvaHcv
c21iaW9zL3NtYmlvcy5jOjk3ODo5OiBlcnJvcjogdG9vIGZldyBhcmd1bWVudHMgdG8gZnVuY3Rp
b24gJ3FlbXVfb3BlbicKICAgICAgICAgaW50IGZkID0gcWVtdV9vcGVuKHZhbHVlLCBPX1JET05M
WSk7CiAgICAgICAgIF4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uL3NyYy9ody9zbWJpb3Mvc21i
aW9zLmM6MTg6MDoKL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9vc2RlcC5oOjUwNTo1
OiBub3RlOiBkZWNsYXJlZCBoZXJlCiBpbnQgcWVtdV9vcGVuKGNvbnN0IGNoYXIgKm5hbWUsIGlu
dCBmbGFncywgRXJyb3IgKiplcnJwKTsKICAgICBeCm1ha2U6ICoqKiBbbGliY29tbW9uLmZhLnAv
aHdfc21iaW9zX3NtYmlvcy5jLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUg
Ii4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgotLS0KICAg
IHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVk
UHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICct
LXJtJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD01ZGQzNmQxMDljYjg0OWQw
YWY4YTFhMjY0MjRhNGQxOCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2Nv
bXA9dW5jb25maW5lZCcsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklH
VVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1l
JywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYn
LCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2Fj
aGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtN2FrM2R2ZDEvc3JjL2Rv
Y2tlci1zcmMuMjAyMC0wOS0yMy0wOS4yMC4yNC4xODM0OTovdmFyL3RtcC9xZW11Onoscm8nLCAn
cWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJu
ZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9NWRkMzZkMTA5Y2I4NDlkMGFmOGExYTI2NDI0YTRkMTgKbWFrZVsxXTog
KioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtN2FrM2R2ZDEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1y
dW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDNtMzAuNjM0cwp1c2VyICAg
IDBtMjIuNjE0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDA5MjMxMDQxMDIuMjA2ODQxNi0xLWJlcnJhbmdlQHJlZGhhdC5jb20vdGVz
dGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

