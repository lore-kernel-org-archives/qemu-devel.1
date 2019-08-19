Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A9AC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE182082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 08:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE182082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzcxP-0000Vc-Vp
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 04:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1hzcwc-0008Re-Gs
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hzcwb-0003uB-BG
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 04:23:14 -0400
Resent-Date: Mon, 19 Aug 2019 04:23:14 -0400
Resent-Message-Id: <E1hzcwb-0003uB-BG@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hzcwY-0003oD-7C; Mon, 19 Aug 2019 04:23:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566202979; cv=none; d=zoho.com; s=zohoarc; 
 b=DdzjNbFkJNRcuoTGPd5oBGAhsi6f11xei3+u5ozCGkwwUGV7af9nOtjJnJmnL3yS8uQAhu4djzkUWMxIZx0SzmciFdo3nqUanfoEEvI6J1mGL9UlqsRuTeEnvY7DsMJyU2o767n8sfJ1681GTK8GE4Kn6+LFcqiLiGUrER7OJaM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566202979;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=B7833eTmPeeXCU/WXcwBMvY50mOz98xGyPlwuefJAjY=; 
 b=Gtz9EduO9M1RnvJcj/z/VcUDcy/Av8K5Xs7vCVIO6FnAq0/YE7z3J7jruGVA2EmkNKMk9FzMMuG26ckU3pov5kPbR5KWhjmD6rhvqnyKmeFXVIV6VhzG3uBh2GphuIce5A1jQeJC1FYNIu3zy/tio59lJgSp8xdtrvepLUKsJcI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566202978719246.62199644069733;
 Mon, 19 Aug 2019 01:22:58 -0700 (PDT)
In-Reply-To: <20190819075348.4078-1-thuth@redhat.com>
Message-ID: <156620297756.5280.6675788443526590563@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Mon, 19 Aug 2019 01:22:58 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] iotests: Check for enabled drivers before
 testing them
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgxOTA3NTM0OC40MDc4
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQgdGVz
dCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxsIGJlIGlu
dm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0byBhIGNv
bW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIKIyBicmFu
Y2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAiPT09IFBB
Q0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0gVU5BTUUgPT09Igp1bmFtZSAtYQoK
Q0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQV0QvYnVpbGQKbWtk
aXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2NvbmZpZ3VyZSAt
LWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVlZCByZWxpYWJs
ZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KCiAgQ0MgICAgICBtaXBzLXNvZnRtbXUvdHJhY2UvY29udHJvbC10YXJnZXQu
bwogIENDICAgICAgbWlwcy1zb2Z0bW11L3RyYWNlL2dlbmVyYXRlZC1oZWxwZXJzLm8KICBMSU5L
ICAgIG1pcHMtc29mdG1tdS9xZW11LXN5c3RlbS1taXBzCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0
dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjIwOTogcWVtdS1zeXN0
ZW0tbWlwc2VsXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDcyOiBtaXBzZWwtc29mdG1t
dS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
LS0tCiAgQ0MgICAgICBocHBhLXNvZnRtbXUvaHcvYmxvY2svdmhvc3QtdXNlci1ibGsubwogIEND
ICAgICAgbWljcm9ibGF6ZS1zb2Z0bW11L2JhbGxvb24ubwogIENDICAgICAgaHBwYS1zb2Z0bW11
L2h3L2Jsb2NrL2RhdGFwbGFuZS92aXJ0aW8tYmxrLm8KY29sbGVjdDI6IGVycm9yOiBsZCByZXR1
cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjA5OiBxZW11LXN5c3Rl
bS1taXBzXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDcyOiBtaXBzLXNvZnRtbXUvYWxs
XSBFcnJvciAyCiAgQ0MgICAgICBocHBhLXNvZnRtbXUvaHcvY2hhci92aXJ0aW8tc2VyaWFsLWJ1
cy5vCi0tLQogIENDICAgICAgbWljcm9ibGF6ZS1zb2Z0bW11L3RyYWNlL2dlbmVyYXRlZC1oZWxw
ZXJzLm8KICBMSU5LICAgIG1pY3JvYmxhemUtc29mdG1tdS9xZW11LXN5c3RlbS1taWNyb2JsYXpl
CiAgTElOSyAgICBocHBhLXNvZnRtbXUvcWVtdS1zeXN0ZW0taHBwYQpjb2xsZWN0MjogZXJyb3I6
IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDk6IHFl
bXUtc3lzdGVtLW1pY3JvYmxhemVdIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0NzI6IG1p
Y3JvYmxhemUtc29mdG1tdS9hbGxdIEVycm9yIDIKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5l
ZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjA5OiBxZW11LXN5c3RlbS1o
cHBhXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDcyOiBocHBhLXNvZnRtbXUvYWxsXSBF
cnJvciAyCj09PSBPVVRQVVQgRU5EID09PQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA4MTkwNzUzNDguNDA3OC0xLXRodXRoQHJlZGhh
dC5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


