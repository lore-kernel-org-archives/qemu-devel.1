Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96625C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45591222CC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45591222CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1dp-0008DB-M2
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iD1GE-0003iP-SJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iD1GD-0002A6-Pz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:58:50 -0400
Resent-Date: Wed, 25 Sep 2019 02:58:50 -0400
Resent-Message-Id: <E1iD1GD-0002A6-Pz@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iD1GA-00027Q-4H; Wed, 25 Sep 2019 02:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569394700; cv=none; d=zoho.com; s=zohoarc; 
 b=d05H5eQZTfn/gVOC4Wf3VXBQClUQL55Tsdly/85GattlAAHwpF/uqSfiHjFveYZLWObcGPUm9w7QsRA0YymVEG+f+E1AUeLEyIKDLy+oGOD8ri1WKUZyQmN+0CHGkFdsOlFXyCTSjCAkB9RMV/6SP69J0B1rZYZUSg353VqzbUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569394700;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=OuuvftXiZpEYTEx33ue2LCEfHJMeIVr9mOUMhJPV78Y=; 
 b=byq5MDNSx2YkRS19wMpHq8c0/GRqYQMT2dEWS6vZ+luz2tzWp99LjmkddzQ6BjfzsGgheMfC3UJMMGUPlxOXB3XC1kYYpQtIzU1dUPA1U3eOC7o7I1UY9uHKtv8kVbh6Kb71p2IkIWliek9VZdF9CWw14u3YG69croJifCjaP54=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569394698476125.88900174032096;
 Tue, 24 Sep 2019 23:58:18 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] Add SDEI support for arm64
In-Reply-To: <1569338511-3572-1-git-send-email-guoheyi@huawei.com>
Message-ID: <156939469669.4188.3839690402456058930@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: guoheyi@huawei.com
Date: Tue, 24 Sep 2019 23:58:18 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, marc.zyngier@arm.com,
 qemu-devel@nongnu.org, Dave.Martin@arm.com, qemu-arm@nongnu.org,
 james.morse@arm.com, guoheyi@huawei.com, wanghaibin.wang@huawei.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY5MzM4NTExLTM1NzItMS1n
aXQtc2VuZC1lbWFpbC1ndW9oZXlpQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFr
ZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0
LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9hcm0vdG9zYS5vCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvaHcvYXJtL3oyLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmM6MzU6Ci90bXAvcWVtdS10ZXN0L3NyYy90YXJnZXQv
YXJtL3NkZWkuaDoyNjoxMDogZmF0YWwgZXJyb3I6IGxpbnV4L2t2bS5oOiBObyBzdWNoIGZpbGUg
b3IgZGlyZWN0b3J5CiAjaW5jbHVkZSA8bGludXgva3ZtLmg+CiAgICAgICAgICBefn5+fn5+fn5+
fn5+CmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTY5MzM4NTExLTM1NzItMS1naXQtc2VuZC1lbWFp
bC1ndW9oZXlpQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t


