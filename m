Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6050C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EE220B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EE220B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUwp-0004Iy-TH
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hbSoG-00070O-LP
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hbSoC-0002ag-SN
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:42:42 -0400
Resent-Date: Thu, 13 Jun 2019 12:42:42 -0400
Resent-Message-Id: <E1hbSoC-0002ag-SN@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hbSo9-0002N4-0X; Thu, 13 Jun 2019 12:42:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560444096; cv=none; d=zoho.com; s=zohoarc; 
 b=ZF6mP/+tNti6BqxTLlz6zP5LrzrYWOkAMwEqmA5i2Y/CYFpo2wUUWGLH3227L9UhLdotkRmFcLimMBGEEzdy0GU07urI5Z6wucu3470ZqfDfRsoBkRniMRGG7mi1HHNG2s0tfGIjhXI5R/7DPpma4JqiafhxbcnwQ5JPf4UaYwY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560444096;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=BipR7r2foRQ1huq0fS49EWRe0E+AY5KY4V7DVP78Z/E=; 
 b=OgkORCwcCKb0rCncu/IwsUSK7S2hsWIa/gHm9niChaqWrMTL7qJTWsuBUjeng6/9JHV7JkDK0z6moA96qmQEqDyMXhUmnbUdS1V4viUejdRW1JZAf+48RrueflBUpukGJR/dPYdWBfbNjNK5NdK32IC3pog3HW8XkwevTk0LEHA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560444095825619.7468617326971;
 Thu, 13 Jun 2019 09:41:35 -0700 (PDT)
In-Reply-To: <20190529154654.95870-1-vsementsov@virtuozzo.com>
Message-ID: <156044409441.5426.11371380430772467807@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Thu, 13 Jun 2019 09:41:35 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v8 0/7] backup-top filter driver for backup
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyOTE1NDY1NC45NTg3
MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
YnVpbGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3
aWxsIGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGlu
ZyB0byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFz
ZSIKIyBicmFuY2gKc2V0IC1lCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApC
VUlMRD0kUFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJ
TEQKJFNSQy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBY
WFg6IHdlIG5lZWQgcmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBp
bnN0YWxsCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAiPT09IFBBQ0tB
R0VTID09PSIKcnBtIC1xYQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGJsb2Nr
L3JlcGxpY2F0aW9uLm8KICBDQyAgICAgIGJsb2NrL3Rocm90dGxlLm8KL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLWVnM2R3N3c1L3NyYy9ibG9jay9iYWNrdXAuYzogSW4gZnVuY3Rpb24g4oCY
YmFja3VwX3J1buKAmToKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWVnM2R3N3c1L3NyYy9i
bG9jay9iYWNrdXAuYzoyODM6ODogZXJyb3I6IOKAmGVycm9yX2lzX3JlYWTigJkgbWF5IGJlIHVz
ZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlh
bGl6ZWRdCiAgMjgzIHwgICAgIGlmIChyZWFkKSB7CiAgICAgIHwgICAgICAgIF4KL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWVnM2R3N3c1L3NyYy9ibG9jay9iYWNrdXAuYzozMzI6MTA6IG5v
dGU6IOKAmGVycm9yX2lzX3JlYWTigJkgd2FzIGRlY2xhcmVkIGhlcmUKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNTI5MTU0NjU0Ljk1
ODcwLTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=


