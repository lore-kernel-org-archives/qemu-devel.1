Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D76C49EAD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E63217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E63217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvJa-0005BY-SY
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iRvIq-0004Ey-75
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iRvIo-0000x6-Uu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:39:08 -0500
Resent-Date: Tue, 05 Nov 2019 04:39:08 -0500
Resent-Message-Id: <E1iRvIo-0000x6-Uu@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21860)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iRvIm-0000td-CI; Tue, 05 Nov 2019 04:39:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572946731; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VeLPgtWDmvh7Lim1Dfcks6d11Zpfd1fD3Bgxvp/1dkSYpjYxASvdtkMgl/nO+W3ZzJaWlwSOSf3bSU2BPTHjLhfLC/RECrI0Qi5cV2qhLhIaFTEQofw2huIrpWY27hAO0iwBeOFx/fW38bnnfpX7yar5wRFA3KM0iHMJXK9H9ZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572946731;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=tRAUzc0vF+ip47ILtykuGhN5utdensmtZBGfJp9iUVg=; 
 b=Ghmo/Mm4W69y+uzlcn60MuNQZi7vlkrPXnoFVAeejR7jH1Hr/Q9yXBssR9VW+aBdUhqG1/fez/Hw8jf3HVLyvji1JNSLYy8IEqFLxWcyf1d6nRfGSf7BF20qEaTGqpUuPoSjy7GnwNSyvAWls5+Utbj9+LM5v0wDCce2AynnW04=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572946730014501.9923676384676;
 Tue, 5 Nov 2019 01:38:50 -0800 (PST)
In-Reply-To: <20191105091056.9541-1-guoheyi@huawei.com>
Subject: Re: [RFC v2 00/14] Add SDEI support for arm64
Message-ID: <157294672808.27285.2932737819886573001@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: guoheyi@huawei.com
Date: Tue, 5 Nov 2019 01:38:50 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, mst@redhat.com,
 marc.zyngier@arm.com, wanghaibin.wang@huawei.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 james.morse@arm.com, pbonzini@redhat.com, guoheyi@huawei.com,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNTA5MTA1Ni45NTQx
LTEtZ3VvaGV5aUBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWlt
YWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPTM3MDhiMmUyNzJmYTQ1M2FhYTJmNmRkMzFmNWM0YmZmJywg
Jy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0
Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdics
ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYWNsYng2ajIvc3JjL2RvY2tlci1zcmMuMjAx
OS0xMS0wNS0wNC4zNi41MS4xODc3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScs
ICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlk
PTM3MDhiMmUyNzJmYTQ1M2FhYTJmNmRkMzFmNWM0YmZmCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1
bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWFjbGJ4NmoyL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dA
ZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDFtNTcuNTUzcwp1c2VyICAgIDBtNy43MjhzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTEw
NTA5MTA1Ni45NTQxLTEtZ3VvaGV5aUBodWF3ZWkuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZl
ZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


