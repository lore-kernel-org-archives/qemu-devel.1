Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B345C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F63220737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F63220737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr0kv-0003zm-LV
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr0kC-0003ME-8f
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:03:20 -0400
Resent-Date: Thu, 02 Jul 2020 11:03:20 -0400
Resent-Message-Id: <E1jr0kC-0003ME-8f@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr0k3-0007qs-VD
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:03:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593702167; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dL1HC0BxULwp2/od/EAejj6kYFmHqegRjzxov205+VtsTulqQqCdMGh5lJBWs+carfDmdbJalWpd/JK4qjEs/GANw5PRErdLQ8yiCeNtiAPfVdzf2XuFODq67b1FZGCtjXs+0Y+1rXHfxgfGdYg+tJpY2SQ1xyl+YROg+it0WYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593702167;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ue5DhMlLrn22ITHhBUAbq85IJlCDu+aNq5HnQVN6F50=; 
 b=U1otSV6pixtljQMD2UiFnnqT9ATwqSMNYI/w2tQXpu1vQrGsTiHtTm3Nez8VUouj/iFw7Ze06vWk4XRgQbnQmBnkrJb4PaPZtNKH48IlSomx2cRMHizzqkuZLguCoXyCzMTRXXZie5PDc8rENbrhR0WEUey3Oggcl076iTDPvqw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593702164077225.0616294548505;
 Thu, 2 Jul 2020 08:02:44 -0700 (PDT)
Message-ID: <159370216235.5308.365872465723013188@d1fd068a5071>
Subject: Re: [PATCH v2 0/1] Add Script for Dissecting QEMU Execution
In-Reply-To: <20200702142942.4887-1-ahmedkhaledkaraman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ahmedkhaledkaraman@gmail.com
Date: Thu, 2 Jul 2020 08:02:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:03:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, ahmedkhaledkaraman@gmail.com,
 aleksandar.qemu.devel@gmail.com, crosa@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMjE0Mjk0Mi40ODg3
LTEtYWhtZWRraGFsZWRrYXJhbWFuQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgYnVpbGQgdGVzdCBvbiBGcmVlQlNEIGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJl
bG93LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2Ny
aXB0IHdpbGwgYmUgaW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBv
aW50aW5nIHRvIGEgY29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9m
ICJiYXNlIgojIGJyYW5jaAppZiBxZW11LXN5c3RlbS14ODZfNjQgLS1oZWxwID4vZGV2L251bGwg
Mj4mMTsgdGhlbgogIFFFTVU9cWVtdS1zeXN0ZW0teDg2XzY0CmVsaWYgL3Vzci9saWJleGVjL3Fl
bXUta3ZtIC0taGVscCA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICBRRU1VPS91c3IvbGliZXhlYy9x
ZW11LWt2bQplbHNlCiAgZXhpdCAxCmZpCm1ha2Ugdm0tYnVpbGQtZnJlZWJzZCBKPTIxIFFFTVU9
JFFFTVUKZXhpdCAwCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAyMTQyOTQyLjQ4ODct
MS1haG1lZGtoYWxlZGthcmFtYW5AZ21haWwuY29tL3Rlc3RpbmcuRnJlZUJTRC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

