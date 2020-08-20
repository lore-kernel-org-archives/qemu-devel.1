Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067AEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE57D2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE57D2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8n63-0001sl-4M
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8n1c-0002ZF-9e; Thu, 20 Aug 2020 12:02:48 -0400
Resent-Date: Thu, 20 Aug 2020 12:02:48 -0400
Resent-Message-Id: <E1k8n1c-0002ZF-9e@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8n1Z-0005Le-Ju; Thu, 20 Aug 2020 12:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597939352; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JqRrsePgnizk72Vqr3Z6qM/aH+gC7LTOic1bEVS6VfPhmCFokd+XiItIMwiexdoNFS/QdTx1+v5azGUXW6iQyiNxWktSZpQzYuS0TzzTPTlxEqGxXuraP7LSnNkfsNhuHQrJUKcSm/lVPQTfvX47PDgQn3lvn39SEvV1mseeePI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597939352;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5YCB4eGED+SkDhlRAvqeeab5MSrUGrUAHoHjZKjk1s8=; 
 b=TFHl8ydc1SL7y1M6b1QC1FC7UuQpZ96N1YN/D+18X2NUjUM+nUgoIMTutIQjffWOwovpZ2nD9qtgi71h/thacKWR8c8ufi5D0c8qXTYVJXjk9Qo4M2h4okuQhiFrjuFipvR8KtM1ysUaLRwAfDfkr/GpV92KIcQKXk38A7almTg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597939346580816.931645754998;
 Thu, 20 Aug 2020 09:02:26 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/sbsa-ref.c : Add a fake embedded controller
Message-ID: <159793934514.7760.1676298581701295415@66eaa9a8a123>
In-Reply-To: <20200820133201.80577-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: graeme@nuviainc.com
Date: Thu, 20 Aug 2020 09:02:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 12:02:38
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
Cc: graeme@nuviainc.com, peter.maydell@linaro.org, rad@semihalf.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgyMDEzMzIwMS44MDU3
Ny0xLWdyYWVtZUBudXZpYWluYy5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS90YXJnZXQvYXJtL3RyYW5zbGF0ZS1zdmUubwogIENDICAgICAgYWFyY2g2
NC1zb2Z0bW11L3RyYWNlL2dlbmVyYXRlZC1oZWxwZXJzLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2FybS9zYnNhLXJlZi5jOiBJbiBmdW5jdGlvbiAnY3JlYXRlX3NlY3VyZV9lYyc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ody9hcm0vc2JzYS1yZWYuYzo2NTE6MjQ6IGVycm9yOiBpbXBsaWNpdCBkZWNs
YXJhdGlvbiBvZiBmdW5jdGlvbiAncWRldl9jcmVhdGUnOyBkaWQgeW91IG1lYW4gJ2JkcnZfY3Jl
YXRlJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgNjUxIHwgICAg
IERldmljZVN0YXRlICpkZXYgPSBxZGV2X2NyZWF0ZShOVUxMLCBUWVBFX1NFQ1VSRV9FQyk7CiAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fgogICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgYmRydl9jcmVhdGUKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FybS9zYnNh
LXJlZi5jOjY1MToyNDogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ3FkZXZf
Y3JlYXRlJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Fy
bS9zYnNhLXJlZi5jOjY1MToyNDogZXJyb3I6IGluaXRpYWxpemF0aW9uIG9mICdEZXZpY2VTdGF0
ZSAqJyB7YWthICdzdHJ1Y3QgRGV2aWNlU3RhdGUgKid9IGZyb20gJ2ludCcgbWFrZXMgcG9pbnRl
ciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XZXJyb3I9aW50LWNvbnZlcnNpb25dCmNj
MTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbL3Rt
cC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvYXJtL3Nic2EtcmVmLm9dIEVycm9yIDEK
bWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IGFhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBHRU4gICAgIHg4Nl82NC1z
b2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NC5leGUKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxs
IGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YjAwNmM5Zjkz
YjAzNDhhYWEyZTUwZTk1M2M2NGY1NzYnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1w
L2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hl
Oi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13
aF80aGkyay9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4LTIwLTExLjU4LjA5LjMwMTUxOi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11L2ZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1p
bmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWIwMDZjOWY5M2IwMzQ4YWFhMmU1MGU5NTNjNjRm
NTc2Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXdoXzRoaTJrL3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDRtMTUu
OTUzcwp1c2VyICAgIDBtOC4zMTBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgyMDEzMzIwMS44MDU3Ny0xLWdyYWVtZUBudXZpYWlu
Yy5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

