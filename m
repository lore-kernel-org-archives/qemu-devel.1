Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881CDC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 23:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1346621707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 23:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1346621707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJPjw-0008W4-4O
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 19:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJPiZ-0007Wa-7s; Fri, 18 Sep 2020 19:23:03 -0400
Resent-Date: Fri, 18 Sep 2020 19:23:03 -0400
Resent-Message-Id: <E1kJPiZ-0007Wa-7s@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJPiW-0000gq-I1; Fri, 18 Sep 2020 19:23:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600471374; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fix4TiDItcG1Fm6hCgW4P8WUm6vZksR75hsYdV0LPhzaEXZW6HzrTBixETIwbUuQEy+T5b6rLwpNErTomIQdTT3NAUgzSI7aSq0WGcHaz1DpDJy/2+GWqxNIQDwKw1ibtnQxdaK98ScquYCHu1FXnYEv5mI5Lw3kYzAVwj9v03Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600471374;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=KGz2efmS7rYgGy4coNLZXEwGdtlAVPQQr3D4KOJ7BWA=; 
 b=Q5KpgXggsUrNmbzPZ7NUSVcQm2+eSpX9Cuu6SeKSqc3RoPaQRYswrQGnnWvLK24NpHx8n/Ksy4R3DKNqe+JglOoNrvP2iPiA0m0uvpx57KncqRpXAkDsMv215l5375tgUUHVFiCq7UlfZ2JhNFXO+Pbzz8FqWbeuSphwez6DakQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600471373003845.9142355334806;
 Fri, 18 Sep 2020 16:22:53 -0700 (PDT)
Subject: Re: [PATCH 0/6] Convert pc-bios Makefiles to meson
Message-ID: <160047137158.8478.14482341478314665248@66eaa9a8a123>
In-Reply-To: <20200918204759.225810-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Fri, 18 Sep 2020 16:22:53 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 18:35:34
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
Cc: thuth@redhat.com, pbonzini@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxODIwNDc1OS4yMjU4
MTAtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50
b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hP
V19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQyBsaW5rZXIg
Zm9yIHRoZSBob3N0IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhvc3QgbWFjaGluZSBjcHUg
ZmFtaWx5OiB4ODZfNjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWls
ZDoxMDogV0FSTklORzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9y
IGZvcndhcmRzIGNvbXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVs
ZWFzZXMuClByb2dyYW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAo
L3Vzci9iaW4vcHl0aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRp
b24KLS0tCkNvbXBpbGluZyBDIG9iamVjdCBzdWJwcm9qZWN0cy9vcHRpb25yb20vbGludXhib290
LmltZy5wL2xpbnV4Ym9vdC5TLm8KQ29tcGlsaW5nIEMgb2JqZWN0IHN1YnByb2plY3RzL29wdGlv
bnJvbS9rdm12YXBpYy5pbWcucC9rdm12YXBpYy5TLm8KL3RtcC9xZW11LXRlc3Qvc3JjL3N1YnBy
b2plY3RzL29wdGlvbnJvbS9jb2RlMTZnY2MuaDogQXNzZW1ibGVyIG1lc3NhZ2VzOgovdG1wL3Fl
bXUtdGVzdC9zcmMvc3VicHJvamVjdHMvb3B0aW9ucm9tL2NvZGUxNmdjYy5oOjE6IEVycm9yOiBp
bnZhbGlkIGNoYXJhY3RlciAnKCcgaW4gbW5lbW9uaWMKL3RtcC9xZW11LXRlc3Qvc3JjL3N1YnBy
b2plY3RzL29wdGlvbnJvbS9jb2RlMTZnY2MuaDoyOiBFcnJvcjogdW5rbm93biBwc2V1ZG8tb3A6
IGAuY29kZTE2Z2NjXG4nCi90bXAvcWVtdS10ZXN0L3NyYy9zdWJwcm9qZWN0cy9vcHRpb25yb20v
Y29kZTE2Z2NjLmg6MzogRXJyb3I6IGp1bmsgYXQgZW5kIG9mIGxpbmUsIGZpcnN0IHVucmVjb2du
aXplZCBjaGFyYWN0ZXIgaXMgYCknCm1ha2U6ICoqKiBbc3VicHJvamVjdHMvb3B0aW9ucm9tL211
bHRpYm9vdC5pbWcucC9tdWx0aWJvb3QuUy5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uCi90bXAvcWVtdS10ZXN0L3NyYy9zdWJwcm9qZWN0cy9vcHRp
b25yb20vY29kZTE2Z2NjLmg6IEFzc2VtYmxlciBtZXNzYWdlczoKL3RtcC9xZW11LXRlc3Qvc3Jj
L3N1YnByb2plY3RzL29wdGlvbnJvbS9jb2RlMTZnY2MuaDoxOiBFcnJvcjogaW52YWxpZCBjaGFy
YWN0ZXIgJygnIGluIG1uZW1vbmljCi90bXAvcWVtdS10ZXN0L3NyYy9zdWJwcm9qZWN0cy9vcHRp
b25yb20vY29kZTE2Z2NjLmg6MjogRXJyb3I6IHVua25vd24gcHNldWRvLW9wOiBgLmNvZGUxNmdj
Y1xuJwovdG1wL3FlbXUtdGVzdC9zcmMvc3VicHJvamVjdHMvb3B0aW9ucm9tL2NvZGUxNmdjYy5o
OjM6IEVycm9yOiBqdW5rIGF0IGVuZCBvZiBsaW5lLCBmaXJzdCB1bnJlY29nbml6ZWQgY2hhcmFj
dGVyIGlzIGApJwptYWtlOiAqKiogW3N1YnByb2plY3RzL29wdGlvbnJvbS9saW51eGJvb3QuaW1n
LnAvbGludXhib290LlMub10gRXJyb3IgMQovdG1wL3FlbXUtdGVzdC9zcmMvc3VicHJvamVjdHMv
b3B0aW9ucm9tL2NvZGUxNmdjYy5oOiBBc3NlbWJsZXIgbWVzc2FnZXM6Ci90bXAvcWVtdS10ZXN0
L3NyYy9zdWJwcm9qZWN0cy9vcHRpb25yb20vY29kZTE2Z2NjLmg6MTogRXJyb3I6IGludmFsaWQg
Y2hhcmFjdGVyICcoJyBpbiBtbmVtb25pYwovdG1wL3FlbXUtdGVzdC9zcmMvc3VicHJvamVjdHMv
b3B0aW9ucm9tL2NvZGUxNmdjYy5oOjI6IEVycm9yOiB1bmtub3duIHBzZXVkby1vcDogYC5jb2Rl
MTZnY2NcbicKL3RtcC9xZW11LXRlc3Qvc3JjL3N1YnByb2plY3RzL29wdGlvbnJvbS9jb2RlMTZn
Y2MuaDozOiBFcnJvcjoganVuayBhdCBlbmQgb2YgbGluZSwgZmlyc3QgdW5yZWNvZ25pemVkIGNo
YXJhY3RlciBpcyBgKScKbWFrZTogKioqIFtzdWJwcm9qZWN0cy9vcHRpb25yb20va3ZtdmFwaWMu
aW1nLnAva3ZtdmFwaWMuUy5vXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDcwOSwgaW4gPG1v
ZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1ybScsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9M2I3ZjFhZjdlNzViNDhmM2JiNjlkOGZhMzBlYjVhMmUnLCAnLXUn
LCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtNGExb2Rpbzcvc3JjL2RvY2tlci1zcmMuMjAyMC0wOS0xOC0xOS4x
OS40OC4yMzU2MzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9M2I3ZjFhZjdl
NzViNDhmM2JiNjlkOGZhMzBlYjVhMmUKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
NGExb2Rpbzcvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDNtMy4wMDFzCnVzZXIgICAgMG0xOC41NDdzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkxODIwNDc1OS4y
MjU4MTAtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tA
Y2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

