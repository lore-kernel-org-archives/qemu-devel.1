Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B2C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAD820644
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 14:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAD820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htByV-0001rJ-Se
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 10:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1htBxG-0000Xp-SJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1htBxC-0007Yi-FI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:21:17 -0400
Resent-Date: Thu, 01 Aug 2019 10:21:15 -0400
Resent-Message-Id: <E1htBxC-0007Yi-FI@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1htBxB-0007XF-PR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 10:21:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564669249; cv=none; d=zoho.com; s=zohoarc; 
 b=Ut640Bb74u0mDYVqEmgkwTynkowi7GEYnOJpZL01qB0F0EbYw7Ks0Ug9HYKRSCR5huAnCaSDetzQkVUCvrRV468IBt+jfJbX64ZJYpLjFZuWQPvt9yJUUg2Z6IILoyHt7N09fY7qE/9sHCxGKYpBfnWe1lsKpZinNyD7AhNAM4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564669249;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=YUdW/fK+5qZhRObPZwHCpPSMfDQ+iOFnL/PRrDrBpwk=; 
 b=EL8olLKaXKGueV9pYYTgMv6XIqGJC4jV9setYD+pY4J56+kOeyN1BcpG47Ug7To3ce+c/BNNnsbHg806TQ3Z/e5mnwPg9B95HFUPKrAJqL0BJ69jIqisHD7I3gbRkeroMxi8sdpPO8kqFuM3aGN4+GR5ewqoxh1pO6V3UXVrLA8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1564669248959535.9394427273625;
 Thu, 1 Aug 2019 07:20:48 -0700 (PDT)
Message-ID: <156466924771.20702.18065485967290808270@c4a48874b076>
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Thu, 1 Aug 2019 07:20:48 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH  v4 00/54] plugins for TCG
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
Cc: bobby.prani@gmail.com, cota@braap.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDczMTE2MDcxOS4xMTM5
Ni0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0
aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4g
cHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUg
bWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4ODZfNjQt
c29mdG1tdS9jcHVzLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2dkYnN0dWIubwogIENDICAg
ICAgeDg2XzY0LXNvZnRtbXUvYmFsbG9vbi5vCi90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUw
Mzo1OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnY3NoJwogICAgY3NoIGhh
bmRsZTsKICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTA0OjU6IGVycm9yOiB1c2Ug
b2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdjc19pbnNuJwogICAgY3NfaW5zbiAqaW5zbjsKICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTA0OjE0OiBlcnJvcjogdXNlIG9mIHVuZGVj
bGFyZWQgaWRlbnRpZmllciAnaW5zbic7IGRpZCB5b3UgbWVhbiAnaW5mbyc/CiAgICBjc19pbnNu
ICppbnNuOwogICAgICAgICAgICAgXn5+fgogICAgICAgICAgICAgaW5mbwovdG1wL3FlbXUtdGVz
dC9zcmMvZGlzYXMuYzo1MDA6NDY6IG5vdGU6ICdpbmZvJyBkZWNsYXJlZCBoZXJlCmJvb2wgcGx1
Z2luX2NhcF9kaXNhc19pbnNuKGRpc2Fzc2VtYmxlX2luZm8gKmluZm8sIHVpbnQ2NF90IHBjLCBz
aXplX3Qgc2l6ZSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XgovdG1wL3FlbXUtdGVzdC9zcmMvZGlzYXMuYzo1MDk6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uICdjYXBfZGlzYXNfc3RhcnQnIGlzIGludmFsaWQgaW4gQzk5IFst
V2Vycm9yLC1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICBpZiAoY2FwX2Rpc2Fz
X3N0YXJ0KGluZm8sICZoYW5kbGUpICE9IENTX0VSUl9PSykgewogICAgICAgIF4KL3RtcC9xZW11
LXRlc3Qvc3JjL2Rpc2FzLmM6NTA5Ojk6IGVycm9yOiB0aGlzIGZ1bmN0aW9uIGRlY2xhcmF0aW9u
IGlzIG5vdCBhIHByb3RvdHlwZSBbLVdlcnJvciwtV3N0cmljdC1wcm90b3R5cGVzXQovdG1wL3Fl
bXUtdGVzdC9zcmMvZGlzYXMuYzo1MDk6MzI6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVu
dGlmaWVyICdoYW5kbGUnCiAgICBpZiAoY2FwX2Rpc2FzX3N0YXJ0KGluZm8sICZoYW5kbGUpICE9
IENTX0VSUl9PSykgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUt
dGVzdC9zcmMvZGlzYXMuYzo1MDk6NDM6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlm
aWVyICdDU19FUlJfT0snCiAgICBpZiAoY2FwX2Rpc2FzX3N0YXJ0KGluZm8sICZoYW5kbGUpICE9
IENTX0VSUl9PSykgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
Ci90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUxMjo1OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFy
ZWQgaWRlbnRpZmllciAnaW5zbicKICAgIGluc24gPSBjYXBfaW5zbjsKICAgIF4KL3RtcC9xZW11
LXRlc3Qvc3JjL2Rpc2FzLmM6NTEyOjEyOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRp
ZmllciAnY2FwX2luc24nCiAgICBpbnNuID0gY2FwX2luc247CiAgICAgICAgICAgXgovdG1wL3Fl
bXUtdGVzdC9zcmMvZGlzYXMuYzo1MTg6MTM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBv
ZiBmdW5jdGlvbiAnY3NfZGlzYXNtJyBpcyBpbnZhbGlkIGluIEM5OSBbLVdlcnJvciwtV2ltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgY291bnQgPSBjc19kaXNhc20oaGFuZGxlLCBj
YnVmLCBzaXplLCAwLCAxLCAmaW5zbik7CiAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2Rpc2FzLmM6NTE4OjEzOiBlcnJvcjogdGhpcyBmdW5jdGlvbiBkZWNsYXJhdGlvbiBpcyBub3Qg
YSBwcm90b3R5cGUgWy1XZXJyb3IsLVdzdHJpY3QtcHJvdG90eXBlc10KL3RtcC9xZW11LXRlc3Qv
c3JjL2Rpc2FzLmM6NTE4OjIzOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAn
aGFuZGxlJwogICAgY291bnQgPSBjc19kaXNhc20oaGFuZGxlLCBjYnVmLCBzaXplLCAwLCAxLCAm
aW5zbik7CiAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5j
OjUxODo1MDogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ2luc24nCiAgICBj
b3VudCA9IGNzX2Rpc2FzbShoYW5kbGUsIGNidWYsIHNpemUsIDAsIDEsICZpbnNuKTsKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRl
c3Qvc3JjL2Rpc2FzLmM6NTIxOjM3OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmll
ciAnaW5zbicKICAgICAgICBnX3N0cmluZ19wcmludGYocywgIiVzICVzIiwgaW5zbi0+bW5lbW9u
aWMsIGluc24tPm9wX3N0cik7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
L3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTIxOjUzOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFy
ZWQgaWRlbnRpZmllciAnaW5zbicKICAgICAgICBnX3N0cmluZ19wcmludGYocywgIiVzICVzIiwg
aW5zbi0+bW5lbW9uaWMsIGluc24tPm9wX3N0cik7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUy
Njo1OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2NzX2Nsb3NlJyBp
cyBpbnZhbGlkIGluIEM5OSBbLVdlcnJvciwtV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9u
XQogICAgY3NfY2xvc2UoJmhhbmRsZSk7CiAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5j
OjUyNjo1OiBlcnJvcjogdGhpcyBmdW5jdGlvbiBkZWNsYXJhdGlvbiBpcyBub3QgYSBwcm90b3R5
cGUgWy1XZXJyb3IsLVdzdHJpY3QtcHJvdG90eXBlc10KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2Fz
LmM6NTI2OjE1OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnaGFuZGxlJwog
ICAgY3NfY2xvc2UoJmhhbmRsZSk7CiAgICAgICAgICAgICAgXgoxOCBlcnJvcnMgZ2VuZXJhdGVk
LgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTA3MzExNjA3MTkuMTEzOTYtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3RpbmcuYXNh
bi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


