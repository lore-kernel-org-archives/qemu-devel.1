Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF7EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30250206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30250206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhD4g-0006Qx-Fg
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhD3t-0005cW-4Y; Fri, 05 Jun 2020 10:11:09 -0400
Resent-Date: Fri, 05 Jun 2020 10:11:09 -0400
Resent-Message-Id: <E1jhD3t-0005cW-4Y@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhD3q-00069B-Li; Fri, 05 Jun 2020 10:11:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591366238; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mQbQsRHZEV6PHTv8Z/xHZP65QsJLL7GU57iZ6WEitqRcKTAo0BbC8JsXY2HBvNJ67K8Sokqf7ebjtHhThbrRi5slI0Gnd9Vw/ti3PdrRpqOC4g2Fln2SBgAYlPPQAK6aEanCOnpoZ5SVUL+lr806nlxokGHNznI4NFFanrWhC4s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591366238;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=XwEEPGCgp405xjGVT+ttx6e+lnZgfLBWfg2dHZyZQMM=; 
 b=I2aZNg7aG9T7P6qMXzp1KLYP9B3t3IfgjD3EMaGUWrvUwkTDe/Q+KZrhS6a+MGXLk+NGJN7bzmd8TWCsXyXp2qLp3Y69D76UXo7Kb2trkHN5Hwks+US2h3hzuc6Jtkyo2ZrgVSkzx2y614TWERkZlZG1bO4Mk+fwn6DOFWkZJeg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591366233131158.63528573211363;
 Fri, 5 Jun 2020 07:10:33 -0700 (PDT)
Message-ID: <159136623114.19958.4975785864502539212@45ef0f9c86ae>
In-Reply-To: <20200605121342.534811-1-imammedo@redhat.com>
Subject: Re: [PATCH v2] numa: forbid '-numa node,
 mem' for 5.1 and newer machine types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Fri, 5 Jun 2020 07:10:33 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 10:11:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNTEyMTM0Mi41MzQ4
MTEtMS1pbWFtbWVkb0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
ICBDQyAgICAgIHRvb2xzL3ZpcnRpb2ZzZC9oZWxwZXIubwogIENDICAgICAgdG9vbHMvdmlydGlv
ZnNkL3NlY2NvbXAubwoKV2FybmluZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qv
c3JjL2RvY3Mvc3lzdGVtL2RlcHJlY2F0ZWQucnN0OjUwNzpUaXRsZSB1bmRlcmxpbmUgdG9vIHNo
b3J0LgoKYGAtbnVtYSBub2RlLG1lbT1gYFwgKnNpemUqIChyZW1vdmVkIGluIDUuMSkKLS0tCiAg
QlVOWklQMiBwYy1iaW9zL2VkazItaTM4Ni1jb2RlLmZkLmJ6MgogIEJVTlpJUDIgcGMtYmlvcy9l
ZGsyLWFybS12YXJzLmZkLmJ6MgogIEJVTlpJUDIgcGMtYmlvcy9lZGsyLWFhcmNoNjQtY29kZS5m
ZC5iejIKbWFrZTogKioqIFtNYWtlZmlsZToxMTE0OiAuZG9jc19zeXN0ZW1fcWVtdS4xX2RvY3Nf
c3lzdGVtX3FlbXUtYmxvY2stZHJpdmVycy43X2RvY3Nfc3lzdGVtX3FlbXUtY3B1LW1vZGVscy43
LnNlbnRpbmVsLl0gRXJyb3IgMgptYWtlOiAqKiogRGVsZXRpbmcgZmlsZSAnLmRvY3Nfc3lzdGVt
X3FlbXUuMV9kb2NzX3N5c3RlbV9xZW11LWJsb2NrLWRyaXZlcnMuN19kb2NzX3N5c3RlbV9xZW11
LWNwdS1tb2RlbHMuNy5zZW50aW5lbC4nCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uCgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMv
ZG9jcy9zeXN0ZW0vZGVwcmVjYXRlZC5yc3Q6NTA3OlRpdGxlIHVuZGVybGluZSB0b28gc2hvcnQu
CgpgYC1udW1hIG5vZGUsbWVtPWBgXCAqc2l6ZSogKHJlbW92ZWQgaW4gNS4xKQonJycnJycnJycn
JycnJycnJycnJycnJycnJycnJycnJycnJycnJycKbWFrZTogKioqIFtNYWtlZmlsZToxMTAzOiBk
b2NzL3N5c3RlbS9pbmRleC5odG1sXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2Fs
bCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NSwgaW4g
PG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPTM2ZjE0MTAxNDhiZDQ0NzRhZTAzODFmOGZiZGY5M2I2JywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09Q
VFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NI
T1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6Jywg
Jy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1mX3lqdG1uNy9zcmMvZG9ja2VyLXNy
Yy4yMDIwLTA2LTA1LTEwLjA2LjM2LjE4MjI2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZl
ZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16
ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5j
ZS51dWlkPTM2ZjE0MTAxNDhiZDQ0NzRhZTAzODFmOGZiZGY5M2I2Cm1ha2VbMV06ICoqKiBbZG9j
a2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLWZfeWp0bW43L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3Qt
ZGVidWdAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDNtNTMuNDE0cwp1c2VyICAgIDBtNy45ODJz
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDIwMDYwNTEyMTM0Mi41MzQ4MTEtMS1pbWFtbWVkb0ByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

