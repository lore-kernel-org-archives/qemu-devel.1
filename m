Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DAC2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DAC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7lXt-0008Nz-5B
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 16:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7lVx-0006XG-EM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:13:53 -0400
Resent-Date: Mon, 17 Aug 2020 16:13:53 -0400
Resent-Message-Id: <E1k7lVx-0006XG-EM@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7lVv-0007b8-4R
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597695214; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V3NHnUXlesgXuxthgIHdUXYvwLv8muUqNY1fJMHdBbcg42s5ae4NfrSI8mTvh/PJI2a7nDPJV1rPhgTwGLWFJ/DaTeS6iZi7HcleCMGKXm72f+VFjvjrNjaGMacK9JpIfBTSmGDTTO2Tc5SSihvRjvv5TVcBnBb3pP+Q7O7zkQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597695214;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=CgVUc7AdBvgIeChWQuL6mpdvqr2Mik0TIByvPkdlB3o=; 
 b=QJc/bzAdbs2177BA6O7IH+0y86k9MZogjKiirw2AOAroVTOxQZ5wzm0VGLQL68Gc2wW6qSOGC6b5OMpCIP+DWZyI7MXryih6Sght66dBxB8weTQcHALAMApOEykWtWQf2JLjEhxH9P3tsqe692fCc7tbFVwpV278PLCyFHxGpkY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597695210068943.033661704986;
 Mon, 17 Aug 2020 13:13:30 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] hw/misc: Add support for interleaved memory
 accesses
Message-ID: <159769520867.8769.3196388584391243698@66eaa9a8a123>
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Mon, 17 Aug 2020 13:13:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 16:13:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, armbru@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, f4bug@amsat.org, hpoussin@reactos.org,
 pbonzini@redhat.com, edgar.iglesias@gmail.com, rth@twiddle.net,
 philmd@redhat.com, atar4qemu@gmail.com, stephen.checkoway@oberlin.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNzE2MTg1My41OTMy
NDctMS1mNGJ1Z0BhbXNhdC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHRlc3RzL3F0ZXN0
L2UxMDAwLXRlc3QubwogIENDICAgICAgdGVzdHMvcXRlc3QvZTEwMDBlLXRlc3QubwogIENDICAg
ICAgdGVzdHMvcXRlc3QvZWVwcm8xMDAtdGVzdC5vCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9x
dGVzdC9tbWlvLXRlc3QuYzo5OjI0OiBmYXRhbCBlcnJvcjogcWVtdS9vc2RlcC5oOiBObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIgogICAgICAgICAgICAg
ICAgICAgICAgICBeCmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCiAgQ0MgICAgICB0ZXN0cy9xdGVz
dC9lczEzNzAtdGVzdC5vCiAgQ0MgICAgICB0ZXN0cy9xdGVzdC9pcG9jdGFsMjMyLXRlc3Qubwog
IENDICAgICAgdGVzdHMvcXRlc3QvbWVnYXNhcy10ZXN0Lm8KbWFrZTogKioqIFt0ZXN0cy9xdGVz
dC9tbWlvLXRlc3RdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KICBDQyAgICAgIHRlc3RfYWJjel9mMzIubwogIENDICAgICAgdGVzdF9hYl9mMzJfel9i
b29sLm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTg0ZmZjMGQ4MDhh
MzRiNjI4MjRlNmU0NzBjN2I3MDNhJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywg
J0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywg
J0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTov
dmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNGlt
c3lpbXEvc3JjL2RvY2tlci1zcmMuMjAyMC0wOC0xNy0xNi4wOC4yMy43MzU5Oi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWlj
ayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFi
ZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04NGZmYzBkODA4YTM0YjYyODI0ZTZlNDcwYzdiNzAz
YQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJl
Y3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC00aW1zeWltcS9zcmMnCm1ha2U6ICoq
KiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgNW01Ljk5
OXMKdXNlciAgICAwbTYuNTk4cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTcxNjE4NTMuNTkzMjQ3LTEtZjRidWdAYW1zYXQub3Jn
L3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

