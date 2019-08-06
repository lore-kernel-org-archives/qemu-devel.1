Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB6CC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CD320717
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 17:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CD320717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2sR-0001ii-TK
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 13:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hv2le-0000iQ-RA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hv2ld-00059M-Ff
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:56:58 -0400
Resent-Date: Tue, 06 Aug 2019 12:56:58 -0400
Resent-Message-Id: <E1hv2ld-00059M-Ff@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hv2ld-00058V-9K
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565110611; cv=none; d=zoho.com; s=zohoarc; 
 b=QNrXnyp2EsoWEDmyqY1BX6Tej2XndzXBGD8OJLeMe/sNHdjirZLaQO0SlCoUfaUFeSV9ud43hhShfKexjL2POBZBayxKgivdLXkYviQwqVERkr4c2bDqT8S+ytYjy6TrFvcdelSuTN5wzoV0AdKERdILlk5GAdkx+uXZD+M+7gw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565110611;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=3jrgbnF7uUNDzKbUNkN6rVt5U5HncjFF5gxb/Ri7qOk=; 
 b=ThiONbP1g1kDO6RNcBwCWtDncOBDabL/dK94rZDICDCLKcDj61g/wjljtxsbwL32Hy1wm/MHaea6+60Uyu7ntDo0tunpCadcjHGmOvH+fQPnCUmnU8P18SRXwB9wBkrNBfojwhtBE5hSO2LxJmzrmy9YONnKzuG3LbmQs85tYB0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156511060978852.364458521500296;
 Tue, 6 Aug 2019 09:56:49 -0700 (PDT)
In-Reply-To: <20190806151435.10740-1-armbru@redhat.com>
Message-ID: <156511060852.1900.3869299503342383503@b08f24806b7e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 6 Aug 2019 09:56:49 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 00/29] Tame a few "touch this,
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwNjE1MTQzNS4xMDc0
MC0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
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
Q1JJUFQgRU5EID09PQoKICBDQyAgICAgIHJpc2N2NjQtc29mdG1tdS9ody9uZXQvdmlydGlvLW5l
dC5vCiAgQ0MgICAgICBzMzkweC1zb2Z0bW11L2h3L2ludGMvczM5MF9mbGljX2t2bS5vCi92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1rdmwzejNqeS9zcmMvaHcvaW50Yy9zMzkwX2ZsaWNfa3Zt
LmM6IEluIGZ1bmN0aW9uIOKAmGt2bV9mbGljX3NhdmXigJk6Ci92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1rdmwzejNqeS9zcmMvaHcvaW50Yy9zMzkwX2ZsaWNfa3ZtLmM6Mzk1Ojk6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhxZW11X3B1dF9iZTY04oCZIFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDM5NSB8ICAgICAgICAgcWVt
dV9wdXRfYmU2NChmLCBGTElDX0ZBSUxFRCk7CiAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+
Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1rdmwzejNqeS9zcmMvaHcvaW50Yy9zMzkwX2Zs
aWNfa3ZtLmM6Mzk1Ojk6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mIOKAmHFl
bXVfcHV0X2JlNjTigJkgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC1rdmwzejNqeS9zcmMvaHcvaW50Yy9zMzkwX2ZsaWNfa3ZtLmM6NDEwOjk6IGVy
cm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhxZW11X3B1dF9idWZmZXLi
gJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNDEwIHwgICAgICAg
ICBxZW11X3B1dF9idWZmZXIoZiwgKHVpbnQ4X3QgKikgYnVmLAogICAgICB8ICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1rdmwzejNqeS9zcmMvaHcv
aW50Yy9zMzkwX2ZsaWNfa3ZtLmM6NDEwOjk6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0
aW9uIG9mIOKAmHFlbXVfcHV0X2J1ZmZlcuKAmSBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWt2bDN6M2p5L3NyYy9ody9pbnRjL3MzOTBfZmxpY19r
dm0uYzogSW4gZnVuY3Rpb24g4oCYa3ZtX2ZsaWNfbG9hZOKAmToKL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWt2bDN6M2p5L3NyYy9ody9pbnRjL3MzOTBfZmxpY19rdm0uYzo0Mzg6MTM6IGVy
cm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhxZW11X2dldF9iZTY04oCZ
OyBkaWQgeW91IG1lYW4g4oCYcWVtdV9nZXRfbmlj4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5j
dGlvbi1kZWNsYXJhdGlvbl0KICA0MzggfCAgICAgY291bnQgPSBxZW11X2dldF9iZTY0KGYpOwog
ICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICBxZW11
X2dldF9uaWMKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWt2bDN6M2p5L3NyYy9ody9pbnRj
L3MzOTBfZmxpY19rdm0uYzo0Mzg6MTM6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9u
IG9mIOKAmHFlbXVfZ2V0X2JlNjTigJkgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1rdmwzejNqeS9zcmMvaHcvaW50Yy9zMzkwX2ZsaWNfa3ZtLmM6
NDU0Ojk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhxZW11X2dl
dF9idWZmZXLigJk7IGRpZCB5b3UgbWVhbiDigJhxZW11X2dldF9xdWV1ZeKAmT8gWy1XZXJyb3I9
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNDU0IHwgICAgIGlmIChxZW11X2dldF9i
dWZmZXIoZiwgKHVpbnQ4X3QgKikgYnVmLCBsZW4pICE9IGxlbikgewogICAgICB8ICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgICBxZW11X2dldF9xdWV1ZQovdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAta3ZsM3ozankvc3JjL2h3L2ludGMvczM5MF9mbGljX2t2bS5jOjQ1
NDo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiDigJhxZW11X2dldF9idWZm
ZXLigJkgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWt2bDN6M2p5L3NyYy9ydWxlcy5tYWs6Njk6IGh3L2ludGMvczM5MF9mbGljX2t2bS5vXSBFcnJv
ciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDcyOiBzMzkweC1zb2Z0bW11L2FsbF0gRXJyb3IgMgoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA4MDYxNTE0MzUuMTA3NDAtMS1hcm1icnVAcmVkaGF0LmNvbS90ZXN0aW5nLnMzOTB4Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


