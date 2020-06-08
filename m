Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51CAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7684620823
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7684620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiN1r-0007kE-RV
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jiMzv-00071d-GP
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:59:51 -0400
Resent-Date: Mon, 08 Jun 2020 14:59:51 -0400
Resent-Message-Id: <E1jiMzv-00071d-GP@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jiMzt-0005G4-CF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591642781; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F6fR3nZgQKX/P6gMMUniZ44FgbANpYUF8nXVFW8+XsOBmITKVOTobkD6LAn9or9edaxl1+ACn4dhMT8EUsuO0I522JpWtzMSKgT3CyozhBR2qDdDLPTxOaNOTo/T3MSqwobt6wttMRB+8nFIHSVNNDzu8+VdXaEm009Jbu20nPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591642781;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hXGdMDeOc7qyoGA1VdMtel3tgsWxIj2HJnt+x2uzU4k=; 
 b=VYXmIp0M/JXNBoRnWfA9Ltek4nvbWq/sO+jG+9W8093w3J2/r1FG6DNpDcmVw52Q9AlY0ko5SCsAjejXPMh+mmMOsp8SAJYtmrY4Bqrdw6v/PTZmkVXMBbb62AXJbF7uKOhE79QOLu8UG/y9Fk6Rr9aRQD6c3VObMIjDIvlcyWs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591642779327754.3172302658085;
 Mon, 8 Jun 2020 11:59:39 -0700 (PDT)
Message-ID: <159164277821.7663.13445087503598606993@45ef0f9c86ae>
In-Reply-To: <20200608164357.25065-1-filip.bozuta@syrmia.com>
Subject: Re: [PATCH v2 0/6] Add strace support for printing arguments of
 selected syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: filip.bozuta@syrmia.com
Date: Mon, 8 Jun 2020 11:59:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 14:59:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwODE2NDM1Ny4yNTA2
NS0xLWZpbGlwLmJvenV0YUBzeXJtaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDYwODE2NDM1Ny4yNTA2NS0xLWZpbGlw
LmJvenV0YUBzeXJtaWEuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzZdIEFkZCBzdHJhY2Ugc3Vw
cG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIHNlbGVjdGVkIHN5c2NhbGxzClR5cGU6IHNl
cmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNo
ZXcvMjAyMDA2MDgxNjQzNTcuMjUwNjUtMS1maWxpcC5ib3p1dGFAc3lybWlhLmNvbSAtPiBwYXRj
aGV3LzIwMjAwNjA4MTY0MzU3LjI1MDY1LTEtZmlsaXAuYm96dXRhQHN5cm1pYS5jb20KU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozMjBmODc0IGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ug
c3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGZhbGxvY2F0ZSgpCmE0ZGY0YjggbGlu
dXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hv
d24oKS9sY2hvd24oKQoyYTVhNzRkIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3Ig
cHJpbnRpbmcgYXJndW1lbnRzIG9mIGxzZWVrKCkKZWJjODFjYiBsaW51eC11c2VyOiBBZGQgc3Ry
YWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4
dGVuZGVkIGF0dHJpYnV0ZXMKNTk1ZGM5NiBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQg
Zm9yIGEgZ3JvdXAgb2Ygc3lzY2FsbHMKYjUzZjliOSBsaW51eC11c2VyOiBFeHRlbmQgc3RyYWNl
IHN1cHBvcnQgdG8gZW5hYmxlIGFyZ3VtZW50IHByaW50aW5nIGFmdGVyIHN5c2NhbGwgZXhlY3V0
aW9uCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzYgQ2hlY2tpbmcgY29tbWl0IGI1M2Y5YjkxMzIx
MyAobGludXgtdXNlcjogRXh0ZW5kIHN0cmFjZSBzdXBwb3J0IHRvIGVuYWJsZSBhcmd1bWVudCBw
cmludGluZyBhZnRlciBzeXNjYWxsIGV4ZWN1dGlvbikKMi82IENoZWNraW5nIGNvbW1pdCA1OTVk
Yzk2NjJkYTYgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgYSBncm91cCBvZiBz
eXNjYWxscykKMy82IENoZWNraW5nIGNvbW1pdCBlYmM4MWNiMWQ2ODQgKGxpbnV4LXVzZXI6IEFk
ZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnQgb2Ygc3lzY2FsbHMgdXNlZCBm
b3IgZXh0ZW5kZWQgYXR0cmlidXRlcykKNC82IENoZWNraW5nIGNvbW1pdCAyYTVhNzRkMWM2Mjkg
KGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9m
IGxzZWVrKCkpCjUvNiBDaGVja2luZyBjb21taXQgYTRkZjRiODVhZTg3IChsaW51eC11c2VyOiBB
ZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBjaG93bigpL2xjaG93
bigpKQo2LzYgQ2hlY2tpbmcgY29tbWl0IDMyMGY4NzQxZWNlNCAobGludXgtdXNlcjogQWRkIHN0
cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgZmFsbG9jYXRlKCkpCkVSUk9S
OiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJh
dGlvbgojNjk6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6MTE0NzoKK1VOVVNFRCBzdGF0aWMg
c3RydWN0IGZsYWdzIGZhbGxvY19mbGFnc1tdID0gewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5p
bmdzLCAxMDQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDIwMDYwODE2NDM1Ny4yNTA2NS0xLWZpbGlwLmJvenV0YUBzeXJtaWEuY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

