Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC3C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5388D2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 19:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5388D2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGT7J-0007X5-Ev
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 15:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iGT5U-0006TM-H2
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iGT5S-0003Y4-L4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 15:17:59 -0400
Resent-Date: Fri, 04 Oct 2019 15:17:59 -0400
Resent-Message-Id: <E1iGT5S-0003Y4-L4@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iGT5S-0003Xh-DB; Fri, 04 Oct 2019 15:17:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570216666; cv=none; d=zoho.com; s=zohoarc; 
 b=W06mf5A0P4EAjhHmJVHi3wVGctfjAxjv9ut1gKPZhgOLI9/YpdV7oNzep/KTnT+plC3bwczEDoPSikFwp38xHf9Xd/yHc3BoLQ9Ev9BwkqykYu0wRhg8XEMnrnzlNKCLadDbvobdEFf58IxfN+Z0xvQZ+YJE+/sjrnGm/D9jMKo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570216666;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=12em7lGr+BlbtBpbDDf3U7J8dU5dgpOXl2Gp2EHOVWg=; 
 b=hip/y8cP/vmLIL6LeIhZLS2u7SISRmmzbsTiM9I13Y3SuV4PU3wU4JypBDDZ3Gck+26YQFp1hyalhUzb1LTsyy63bRiYMQMgj0VcvclAFgMVpA8IFGpKHby2lBqAw4qfsW+/rR/pcnyw4ENsoYVHtxXxT63kkd0fFVGcXSQbjTk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570216664085562.2652022907888;
 Fri, 4 Oct 2019 12:17:44 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm/arch_dump: Add SVE notes
In-Reply-To: <20191004120313.5347-1-drjones@redhat.com>
Message-ID: <157021666243.31166.13502635150843909281@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: drjones@redhat.com
Date: Fri, 4 Oct 2019 12:17:44 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, eric.auger@redhat.com, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwNDEyMDMxMy41MzQ3
LTEtZHJqb25lc0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEwMDQxMjAzMTMuNTM0Ny0x
LWRyam9uZXNAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjJdIHRhcmdldC9hcm0vYXJjaF9k
dW1wOiBBZGQgU1ZFIG5vdGVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5ZDIxYTlhIHRhcmdldC9hcm0vYXJjaF9k
dW1wOiBBZGQgU1ZFIG5vdGVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRl
bnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMyMTogRklMRTogaW5jbHVkZS9lbGYuaDoxNjUzOgor
I2RlZmluZSBOVF9BUk1fU1ZFXkkweDQwNV5JXkkvKiBBUk0gU2NhbGFibGUgVmVjdG9yIEV4dGVu
c2lvbiQKCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBh
cmF0ZSBsaW5lCiMyMTogRklMRTogaW5jbHVkZS9lbGYuaDoxNjUzOgorI2RlZmluZSBOVF9BUk1f
U1ZFICAgICAweDQwNSAgICAgICAgICAgLyogQVJNIFNjYWxhYmxlIFZlY3RvciBFeHRlbnNpb24K
CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzIyOiBGSUxFOiBpbmNs
dWRlL2VsZi5oOjE2NTQ6CiteSV5JXkleSV5JICAgcmVnaXN0ZXJzICovJAoKV0FSTklORzogQmxv
Y2sgY29tbWVudHMgdXNlICogb24gc3Vic2VxdWVudCBsaW5lcwojMjI6IEZJTEU6IGluY2x1ZGUv
ZWxmLmg6MTY1NDoKKyNkZWZpbmUgTlRfQVJNX1NWRSAgICAgMHg0MDUgICAgICAgICAgIC8qIEFS
TSBTY2FsYWJsZSBWZWN0b3IgRXh0ZW5zaW9uCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZWdpc3RlcnMgKi8KCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBh
IHRyYWlsaW5nICovIG9uIGEgc2VwYXJhdGUgbGluZQojMjI6IEZJTEU6IGluY2x1ZGUvZWxmLmg6
MTY1NDoKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lzdGVy
cyAqLwoKdG90YWw6IDIgZXJyb3JzLCAzIHdhcm5pbmdzLCAxODMgbGluZXMgY2hlY2tlZAoKQ29t
bWl0IDlkMjFhOWE1Y2JhMiAodGFyZ2V0L2FybS9hcmNoX2R1bXA6IEFkZCBTVkUgbm90ZXMpIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDA0MTIwMzEzLjUzNDctMS1kcmpvbmVzQHJlZGhhdC5j
b20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


