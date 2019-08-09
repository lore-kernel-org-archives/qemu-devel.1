Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05157C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3C12086A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3C12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58085 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw2KJ-0004T3-4X
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hw2Ju-0003yH-Ae
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hw2Jr-0001WG-Kj
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:40:26 -0400
Resent-Date: Fri, 09 Aug 2019 06:40:24 -0400
Resent-Message-Id: <E1hw2Jr-0001WG-Kj@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hw2Jq-0001QP-G8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565347210; cv=none; d=zoho.com; s=zohoarc; 
 b=b9t4ixqNrLbZNrOt6kTk5GizdsmRJGSUS2cXN9LuT3bHK0gXJngh6AFWozZSpb0sL5Tb2uUluIUF2lNV3pyLp84p+ET/4Vq44jj/HGaAS0RNoogfirru+yotJWEMEtOO9XL7FoceD31khy2InxDp629H7A4TiL8HbRk1AA5b6Rk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565347210;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=51WtHaHse9MaUNI7z9MnkHTwJXt+UfmeTRWiKrWKeL8=; 
 b=Esrzo5TX1buMKpMhAaogFp2NLfdvr6tjZXGDpQLACj3rk1cKMPjGsQk0V6yl2nVnbqKM133ea6iWFW/LwOFPMVgOTmspoYs97jevO5V2+getgIXLXwN45Zlyd4qG4W1YO7cE1VEO9LO/yTQshGaooQ09HcR0pv38I68Ix8kA/cM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565347208272498.2272534150304;
 Fri, 9 Aug 2019 03:40:08 -0700 (PDT)
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
Message-ID: <156534720660.13950.4622856098662127156@b08f24806b7e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Fri, 9 Aug 2019 03:40:08 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v3 00/29] Tame a few "touch this,
 recompile the world" headers
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
Cc: berrange@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, alistair.francis@wdc.com, stefanha@redhat.com,
 imammedo@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwOTA2NDY0NS4yMjY1
Ni0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKCmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0g
UEFDS0FHRVMgPT09IgpycG0gLXFhCgplY2hvCmVjaG8gIj09PSBVTkFNRSA9PT0iCnVuYW1lIC1h
CgpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApt
a2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJl
IC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlh
YmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2UgaW5zdGFsbAo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKICBDQyAgICAgIHMzOTB4LXNvZnRtbXUvaHcvaW50Yy9zMzkwX2ZsaWMu
bwogIENDICAgICAgczM5MHgtc29mdG1tdS9ody9pbnRjL3MzOTBfZmxpY19rdm0ubwovdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAteWhpcmcycDMvc3JjL2h3L2ludGMvczM5MF9mbGljX2t2bS5j
OiBJbiBmdW5jdGlvbiDigJhrdm1fZmxpY19zYXZl4oCZOgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAteWhpcmcycDMvc3JjL2h3L2ludGMvczM5MF9mbGljX2t2bS5jOjM5NTo5OiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYcWVtdV9wdXRfYmU2NOKAmSBbLVdl
cnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAzOTUgfCAgICAgICAgIHFlbXVf
cHV0X2JlNjQoZiwgRkxJQ19GQUlMRUQpOwogICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fgov
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteWhpcmcycDMvc3JjL2h3L2ludGMvczM5MF9mbGlj
X2t2bS5jOjM5NTo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiDigJhxZW11
X3B1dF9iZTY04oCZIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQovdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAteWhpcmcycDMvc3JjL2h3L2ludGMvczM5MF9mbGljX2t2bS5jOjQxMDo5OiBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYcWVtdV9wdXRfYnVmZmVy4oCZ
IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDQxMCB8ICAgICAgICAg
cWVtdV9wdXRfYnVmZmVyKGYsICh1aW50OF90ICopIGJ1ZiwKICAgICAgfCAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteWhpcmcycDMvc3JjL2h3L2lu
dGMvczM5MF9mbGljX2t2bS5jOjQxMDo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlv
biBvZiDigJhxZW11X3B1dF9idWZmZXLigJkgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC15aGlyZzJwMy9zcmMvaHcvaW50Yy9zMzkwX2ZsaWNfa3Zt
LmM6IEluIGZ1bmN0aW9uIOKAmGt2bV9mbGljX2xvYWTigJk6Ci92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC15aGlyZzJwMy9zcmMvaHcvaW50Yy9zMzkwX2ZsaWNfa3ZtLmM6NDM4OjEzOiBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYcWVtdV9nZXRfYmU2NOKAmTsg
ZGlkIHlvdSBtZWFuIOKAmHFlbXVfZ2V0X25pY+KAmT8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dCiAgNDM4IHwgICAgIGNvdW50ID0gcWVtdV9nZXRfYmU2NChmKTsKICAg
ICAgfCAgICAgICAgICAgICBefn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgICAgICAgcWVtdV9n
ZXRfbmljCi92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15aGlyZzJwMy9zcmMvaHcvaW50Yy9z
MzkwX2ZsaWNfa3ZtLmM6NDM4OjEzOiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBv
ZiDigJhxZW11X2dldF9iZTY04oCZIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQovdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAteWhpcmcycDMvc3JjL2h3L2ludGMvczM5MF9mbGljX2t2bS5jOjQ1
NDo5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYcWVtdV9nZXRf
YnVmZmVy4oCZOyBkaWQgeW91IG1lYW4g4oCYcWVtdV9nZXRfcXVldWXigJk/IFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDQ1NCB8ICAgICBpZiAocWVtdV9nZXRfYnVm
ZmVyKGYsICh1aW50OF90ICopIGJ1ZiwgbGVuKSAhPSBsZW4pIHsKICAgICAgfCAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgcWVtdV9nZXRfcXVldWUKL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLXloaXJnMnAzL3NyYy9ody9pbnRjL3MzOTBfZmxpY19rdm0uYzo0NTQ6
OTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2Yg4oCYcWVtdV9nZXRfYnVmZmVy
4oCZIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogWy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15
aGlyZzJwMy9zcmMvcnVsZXMubWFrOjY5OiBody9pbnRjL3MzOTBfZmxpY19rdm0ub10gRXJyb3Ig
MQptYWtlOiAqKiogW01ha2VmaWxlOjQ3MjogczM5MHgtc29mdG1tdS9hbGxdIEVycm9yIDIKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
ODA5MDY0NjQ1LjIyNjU2LTEtYXJtYnJ1QHJlZGhhdC5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


