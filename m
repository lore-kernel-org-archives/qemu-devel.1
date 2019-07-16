Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF3C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405FE20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405FE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOFO-0002Ag-Tk
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hnOF2-0001O3-5z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hnOF0-00065F-RH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:15:40 -0400
Resent-Date: Tue, 16 Jul 2019 10:15:40 -0400
Resent-Message-Id: <E1hnOF0-00065F-RH@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hnOF0-00064R-Kg; Tue, 16 Jul 2019 10:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563286483; cv=none; d=zoho.com; s=zohoarc; 
 b=CrD+LVZQvYLe13ovF7vgjFzkCNFEn8HJISHKYSVr5SlOI58Py2+FL5vLi5UQZ/JV9SWEWwa0p+Y/yen6wCvqqGNdewohow9lZ8tL3sQFbwVewYF3U8z9LwOoBZmv/5zOjtWk4YiN7OgI6ebevrTOHyp2vIkUqXNZHM2mI9MDOto=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563286483;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=mKESzVD2dSHs6Co5PY1b54s2EhLh2vWJuz6cSoRYUAs=; 
 b=YXNv5kP8UoPcHoRlwKkdqcdV5TMlpwOzVL1LFFDhIpRJoUhqBH9lAnir7bpW0bzHwbrPgBKhJa2XEyR+XDHC0YDqJWTpiTY6g1A7Lkdwv19IQmZd+gpKxKfY81NOTNRvdVvX+BKtQowLOIQeX25vtr14hEENkGXBL3DjLz6SeKM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563286481320244.7377986805792;
 Tue, 16 Jul 2019 07:14:41 -0700 (PDT)
Message-ID: <156328647934.3080.7715534955297688180@c4a48874b076>
In-Reply-To: <20190715152225.26135-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Tue, 16 Jul 2019 07:14:41 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1? v2 0/5] semihosting: Build
 with CONFIG_SEMIHOSTING disabled
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, arikalo@wavecomp.com,
 jhogan@kernel.org, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu, alex.bennee@linaro.org, qemu-arm@nongnu.org,
 amarkovic@wavecomp.com, pbonzini@redhat.com, james.hogan@mips.com,
 philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxNTE1MjIyNS4yNjEz
NS0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
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
Q1JJUFQgRU5EID09PQoKICBDQyAgICAgIG1pcHMtbGludXgtdXNlci90YXJnZXQvbWlwcy9nZGJz
dHViLm8KICBDQyAgICAgIG1pcHMtbGludXgtdXNlci90YXJnZXQvbWlwcy9tc2FfaGVscGVyLm8K
ICBDQyAgICAgIG1pcHNlbC1saW51eC11c2VyL3RhcmdldC9taXBzL21pcHMtc2VtaS1zdHVicy5v
Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0zZGtkbTVmdC9zcmMvdGFyZ2V0L21pcHMvbWlw
cy1zZW1pLXN0dWJzLmM6MTk6NjogZXJyb3I6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCY
aGVscGVyX2RvX3NlbWlob3N0aW5n4oCZIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10KICAg
MTkgfCB2b2lkIGhlbHBlcl9kb19zZW1paG9zdGluZyhDUFVNSVBTU3RhdGUgKmVudikKICAgICAg
fCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwotLS0KICBDQyAgICAgIG1pcHM2NC1saW51eC11c2VyL2ZwdS9zb2Z0Zmxv
YXQubwogIENDICAgICAgbWlwcy1saW51eC11c2VyL3RhcmdldC9taXBzL21pcHMtc2VtaS1zdHVi
cy5vCiAgQ0MgICAgICBtaXBzNjQtbGludXgtdXNlci9nZGJzdHViLm8KL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLTNka2RtNWZ0L3NyYy90YXJnZXQvbWlwcy9taXBzLXNlbWktc3R1YnMuYzox
OTo2OiBlcnJvcjogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhoZWxwZXJfZG9fc2VtaWhv
c3RpbmfigJkgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5cGVzXQogICAxOSB8IHZvaWQgaGVscGVy
X2RvX3NlbWlob3N0aW5nKENQVU1JUFNTdGF0ZSAqZW52KQogICAgICB8ICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCi0t
LQogIENDICAgICAgbWlwczY0LWxpbnV4LXVzZXIvYWNjZWwvdGNnL3RjZy1ydW50aW1lLWd2ZWMu
bwogIENDICAgICAgbWlwczY0ZWwtbGludXgtdXNlci90YXJnZXQvbWlwcy9taXBzLXNlbWktc3R1
YnMubwogIENDICAgICAgbWlwczY0LWxpbnV4LXVzZXIvYWNjZWwvdGNnL2NwdS1leGVjLm8KL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTNka2RtNWZ0L3NyYy90YXJnZXQvbWlwcy9taXBzLXNl
bWktc3R1YnMuYzoxOTo2OiBlcnJvcjogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhoZWxw
ZXJfZG9fc2VtaWhvc3RpbmfigJkgWy1XZXJyb3I9bWlzc2luZy1wcm90b3R5cGVzXQogICAxOSB8
IHZvaWQgaGVscGVyX2RvX3NlbWlob3N0aW5nKENQVU1JUFNTdGF0ZSAqZW52KQogICAgICB8ICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCi0tLQogIENDICAgICAgbWlwczY0LWxpbnV4LXVzZXIvdGFyZ2V0L21pcHMvZ2Ri
c3R1Yi5vCiAgQ0MgICAgICBtaXBzNjQtbGludXgtdXNlci90YXJnZXQvbWlwcy9tc2FfaGVscGVy
Lm8KICBDQyAgICAgIG1pcHM2NC1saW51eC11c2VyL3RhcmdldC9taXBzL21pcHMtc2VtaS1zdHVi
cy5vCi92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0zZGtkbTVmdC9zcmMvdGFyZ2V0L21pcHMv
bWlwcy1zZW1pLXN0dWJzLmM6MTk6NjogZXJyb3I6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig
4oCYaGVscGVyX2RvX3NlbWlob3N0aW5n4oCZIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10K
ICAgMTkgfCB2b2lkIGhlbHBlcl9kb19zZW1paG9zdGluZyhDUFVNSVBTU3RhdGUgKmVudikKICAg
ICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAxOTA3MTUxNTIyMjUuMjYxMzUtMS1waGlsbWRAcmVkaGF0LmNvbS90
ZXN0aW5nLnMzOTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


