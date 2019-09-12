Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E7C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA912075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA912075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8If2-0003en-Ir
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i8IVW-0002f8-FO
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i8IVU-0005n2-Qh
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:23:05 -0400
Resent-Date: Thu, 12 Sep 2019 02:23:05 -0400
Resent-Message-Id: <E1i8IVU-0005n2-Qh@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i8IVU-0005lp-Fj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:23:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568268462; cv=none; d=zoho.com; s=zohoarc; 
 b=eD1EZHwUPf5/+ULzpuoifA+m7okq8tli+h7jHTtieM32zYJQomEGRxeIKmmfNXta+eTOuBsU1iALS1QychpAtx46CwTQ5RUfLp1uVKN0kiOy79taOCY2KVS23J35xsuC9N9xxEwEPkYE8UAxLaht5zukp3WLyvhi5+4T/8YyDGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568268462;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=uEJTt2ImCAnNKpCYlvlr0IsyOz+4WLMoRn4IizJ//PQ=; 
 b=e9FQKkT5vSZ7mp9C5w8rwDD0NEnFoauQ861qz3qcVOPiuD1WouyklWegBlqLEcLaj7VSEQNLM3gQaoHFkQIBz4OPkrZdrluOnfz1O46ANIWluuHnz1wkBgIAQO0Uo/wUzKAaA1tfrjwjUD+/HNLdW8GnZXHpycKLfe6gI4++xuY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568268454269251.9810127971316;
 Wed, 11 Sep 2019 23:07:34 -0700 (PDT)
In-Reply-To: <20190912053638.4858-1-tao3.xu@intel.com>
Message-ID: <156826845281.21839.13142130847236071484@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Wed, 11 Sep 2019 23:07:34 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v11 00/11] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, tao3.xu@intel.com,
 fan.du@intel.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMjA1MzYzOC40ODU4
LTEtdGFvMy54dUBpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKbGlidWRldiAgICAgICAgICAgbm8K
ZGVmYXVsdCBkZXZpY2VzICAgeWVzCgp3YXJuaW5nOiBQeXRob24gMiBzdXBwb3J0IGlzIGRlcHJl
Y2F0ZWQKd2FybmluZzogUHl0aG9uIDMgd2lsbCBiZSByZXF1aXJlZCBmb3IgYnVpbGRpbmcgZnV0
dXJlIHZlcnNpb25zIG9mIFFFTVUKCk5PVEU6IGNyb3NzLWNvbXBpbGVycyBlbmFibGVkOiAgJ2Nj
JwogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvY29uZmlnLWRldmljZXMubWFrLnRtcAotLS0KTG9v
a2luZyBmb3IgZXhwZWN0ZWQgZmlsZSAndGVzdHMvZGF0YS9hY3BpL3BjL1NSQVQuYWNwaWhtYXQn
Ckxvb2tpbmcgZm9yIGV4cGVjdGVkIGZpbGUgJ3Rlc3RzL2RhdGEvYWNwaS9wYy9TUkFUJwoqKgpF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvYmlvcy10YWJsZXMtdGVzdC5jOjMyNzpsb2Fk
X2V4cGVjdGVkX2FtbDogYXNzZXJ0aW9uIGZhaWxlZDogKGV4cF9zZHQuYW1sX2ZpbGUpCkVSUk9S
IC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9iaW9zLXRhYmxlcy10
ZXN0LmM6MzI3OmxvYWRfZXhwZWN0ZWRfYW1sOiBhc3NlcnRpb24gZmFpbGVkOiAoZXhwX3NkdC5h
bWxfZmlsZSkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293Mjog
MDM2CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MDkxMjA1MzYzOC40ODU4LTEtdGFvMy54dUBpbnRlbC5jb20vdGVzdGluZy5kb2NrZXIt
cXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


