Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5EC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F8D2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F8D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwAI-0004AK-Sr
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hvw9r-0003ex-GK
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hvw9q-0001FC-Be
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:05:39 -0400
Resent-Date: Fri, 09 Aug 2019 00:05:39 -0400
Resent-Message-Id: <E1hvw9q-0001FC-Be@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hvw9n-0001D2-M0; Fri, 09 Aug 2019 00:05:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565323516; cv=none; d=zoho.com; s=zohoarc; 
 b=b59rF0lBEMUSgDCZ6KLIC6af0+yvIdUurgomXK8h6PtkVbjT4ICV10gthz6ifwq40x5mwtCy/Fppm9EAMVImcPe+GVqCW31X+8DlQ+nsPW93ifXWGkgcmcgF4pGJ3ahuClyohJ03z0egtR0nXKnu9xGK329p/8TZlRVUzLSsVYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565323516;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=RXZP4r0Zt6moYcZejD2zJtloY2Zh227fIx1GRBrYlJ4=; 
 b=CMkITvSIFZLpuqE28OIpJ7Vx/k/xI5H82upp6O+HF1zV1jGg2n2uINoh4Qw4UPVqeR0CA2qrtJK7RkioxfmAXXsf//5rL+QV8GzOIel4UgufNKwq2h1h5tlExbtCV7xnEj08WJnj4Ymi3/XkIuRZhQEST0gx1SrWd0bP4qEbcFQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565323513823279.0885523840261;
 Thu, 8 Aug 2019 21:05:13 -0700 (PDT)
In-Reply-To: <20190809031321.14760-1-andrew@aj.id.au>
Message-ID: <156532351253.12874.1201096794967354035@b08f24806b7e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrew@aj.id.au
Date: Thu, 8 Aug 2019 21:05:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH] target-arm: Make the counter tick relative
 to cntfrq
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, joel@jms.id.au, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwOTAzMTMyMS4xNDc2
MC0xLWFuZHJld0Bhai5pZC5hdS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQgdGVz
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
SVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJjaDY0X2JlLWxpbnV4LXVzZXIvdGFyZ2V0L2FybS9h
cm0tc2VtaS5vCiAgQ0MgICAgICBhYXJjaDY0X2JlLWxpbnV4LXVzZXIvdGFyZ2V0L2FybS9oZWxw
ZXIubwovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaGtkN3VhMW4vc3JjL3RhcmdldC9hcm0v
aGVscGVyLmM6IEluIGZ1bmN0aW9uIOKAmGd0X3ZpcnRfY250X3JlYWTigJk6Ci92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1oa2Q3dWExbi9zcmMvdGFyZ2V0L2FybS9oZWxwZXIuYzoyOTIxOjEy
OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYZ3RfY2FsY190aWNr
4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogMjkyMSB8ICAgICBy
ZXR1cm4gZ3RfY2FsY190aWNrKGVudiwgY3B1X2dldF9jbG9jaygpKTsKICAgICAgfCAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaGtkN3VhMW4vc3Jj
L3RhcmdldC9hcm0vaGVscGVyLmM6MjkyMToxMjogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFy
YXRpb24gb2Yg4oCYZ3RfY2FsY190aWNr4oCZIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQpjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogWy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1oa2Q3dWExbi9zcmMvcnVsZXMubWFrOjY5OiB0YXJnZXQv
YXJtL2hlbHBlci5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDcyOiBhYXJjaDY0X2Jl
LWxpbnV4LXVzZXIvYWxsXSBFcnJvciAyCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDgwOTAzMTMyMS4xNDc2MC0xLWFuZHJld0Bhai5p
ZC5hdS90ZXN0aW5nLnMzOTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


