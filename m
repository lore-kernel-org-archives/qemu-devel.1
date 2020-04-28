Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3803EC83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF2A206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF2A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRd3-0004Pb-5A
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTRbm-0002Wd-UT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTRbm-00029G-Ff
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:53:14 -0400
Resent-Date: Tue, 28 Apr 2020 10:53:14 -0400
Resent-Message-Id: <E1jTRbm-00029G-Ff@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTRbj-00028S-HB; Tue, 28 Apr 2020 10:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588085584; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZdDnVa0BS3gPW4WawgL5NXXwCa82olzRlyMjvVP9HAo8MV5LzFswHrXFmJiWY20S8qZexceCHwa/6OYgyjoTx2UYPHc5KnA9/FQ8WL9qtUreCYVbLK9aO4CmvdzV0KOC6l380U9DxerraovXQvCCIKj7a+dJ4mFJhujIohYi2IM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588085584;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=D9cfZP795nBp9vxAusTKYfSlZs0g0TB4Q1N76bNo9Lc=; 
 b=fR7vGdFwopNbrEuj7TRhHprylAyrYZ0TVdGKR9APwAkImgXZDtbZfztoQD3GvcgJQ+nXy1UgKqZpLzj7LFMBJP9RYQiagNy1mNhsRIJB1M+uWX3kPNEFfIilNekIgQf2hCU9JnIRAYKm9HxDDOXBXlnKPk2/DiRknihtqtKHx0o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158808558142829.318800076204752;
 Tue, 28 Apr 2020 07:53:01 -0700 (PDT)
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Message-ID: <158808557997.30407.687553726778977682@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Tue, 28 Apr 2020 07:53:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:39:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODEzMjYyOS43OTY3
NTMtMS1tcmVpdHpAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9
eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
QlVJTEQgICBwYy1iaW9zL29wdGlvbnJvbS9wdmguaW1nCiAgQlVJTEQgICBwYy1iaW9zL29wdGlv
bnJvbS9wdmgucmF3CiAgU0lHTiAgICBwYy1iaW9zL29wdGlvbnJvbS9wdmguYmluCi90bXAvcWVt
dS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6Mjc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbiAnYmxrX25ld193aXRoX2JzJyBpcyBpbnZhbGlkIGluIEM5OSBbLVdlcnJv
ciwtV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgIG9sZF9iYWNraW5nX2Js
ayA9IGJsa19uZXdfd2l0aF9icyhicywgQkxLX1BFUk1fV1JJVEUsIEJMS19QRVJNX0FMTCwKICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEw
NzE6Mjc6IGVycm9yOiB0aGlzIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGlzIG5vdCBhIHByb3RvdHlw
ZSBbLVdlcnJvciwtV3N0cmljdC1wcm90b3R5cGVzXQovdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS1p
bWcuYzoxMDcxOjI1OiBlcnJvcjogaW5jb21wYXRpYmxlIGludGVnZXIgdG8gcG9pbnRlciBjb252
ZXJzaW9uIGFzc2lnbmluZyB0byAnQmxvY2tCYWNrZW5kIConIChha2EgJ3N0cnVjdCBCbG9ja0Jh
Y2tlbmQgKicpIGZyb20gJ2ludCcgWy1XZXJyb3IsLVdpbnQtY29udmVyc2lvbl0KICAgICAgICBv
bGRfYmFja2luZ19ibGsgPSBibGtfbmV3X3dpdGhfYnMoYnMsIEJMS19QRVJNX1dSSVRFLCBCTEtf
UEVSTV9BTEwsCiAgICAgICAgICAgICAgICAgICAgICAgIF4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgozIGVycm9ycyBnZW5lcmF0ZWQuCm1ha2U6ICoq
KiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogcWVtdS1pbWcub10gRXJyb3IgMQpt
YWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3Qg
cmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGlu
ZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD1jMDFjOGE3YjgwNzk0Y2IyYTQ0NThmZDE3YjE4ZmY4MycsICctdScsICcxMDAxJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScs
ICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC03a2tiejdzZC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTI4
LTEwLjQ4LjM5LjYzODQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzAxYzhh
N2I4MDc5NGNiMmE0NDU4ZmQxN2IxOGZmODMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtN2trYno3c2Qvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0BmZWRvcmFd
IEVycm9yIDIKCnJlYWwgICAgNG0yMi40NTdzCnVzZXIgICAgMG04LjgyOXMKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI4MTMyNjI5
Ljc5Njc1My0xLW1yZWl0ekByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

