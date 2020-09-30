Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F12AC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA22207F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA22207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgcn-0003jo-Uu
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kNgao-0002aP-ED; Wed, 30 Sep 2020 14:12:43 -0400
Resent-Date: Wed, 30 Sep 2020 14:12:42 -0400
Resent-Message-Id: <E1kNgao-0002aP-ED@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kNgak-00071M-Nr; Wed, 30 Sep 2020 14:12:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601489538; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WO1qPPWaufAXSuCKHboDwKWiRb5M1kYYfMXblYySsJK+GecaP/ROIURQNm8Rick7ew7rwlE7OBxH3f661DkkTleyE/Cx0g5jznGy3KfQ32vTIPR+e6fTKQs2imli3jRpkh1JQKBUweI6MntQZkltE+p6s6ddF9l6T8skrHrXIX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601489538;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dMccYrZiwIA23PnhoKFAxr76vyg0V8/fqnzs2Wt8qU4=; 
 b=O2lVJcThtqPa0jxCGkE/Gi/S4GaTHoP8rAsmLXkqEfgIi6kcm16MAlPzqoBEtDwBDiqamgJnwXsKvHN3An25HlhCCrdeiaGbRkf/dXEa9DXdra+mzPfqfS2EzWseossh0ltvuh0NRstQcsrrTE2grzjc14lJx+R4Sw8qwcRoOHM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601489537545582.1532880744478;
 Wed, 30 Sep 2020 11:12:17 -0700 (PDT)
Subject: Re: [PATCH 0/4] assorted gcc 10/fedora32 compile warning fixes
Message-ID: <160148953593.11932.3604940641617994907@66eaa9a8a123>
In-Reply-To: <20200930155859.303148-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: borntraeger@de.ibm.com
Date: Wed, 30 Sep 2020 11:12:17 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 14:12:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, borntraeger@de.ibm.com,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkzMDE1NTg1OS4zMDMx
NDgtMS1ib3JudHJhZWdlckBkZS5pYm0uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA5MzAxNTU4NTku
MzAzMTQ4LTEtYm9ybnRyYWVnZXJAZGUuaWJtLmNvbQpTdWJqZWN0OiBbUEFUQ0ggMC80XSBhc3Nv
cnRlZCBnY2MgMTAvZmVkb3JhMzIgY29tcGlsZSB3YXJuaW5nIGZpeGVzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwOTMwMDQzMTUwLjE0NTQ3NjYt
MS1qc25vd0ByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA5MzAwNDMxNTAuMTQ1NDc2Ni0xLWpz
bm93QHJlZGhhdC5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDkzMDA5NTMy
MS4yMDA2LTEtemhhb2xpY2hhbmdAaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzIwMjAwOTMwMDk1MzIx
LjIwMDYtMS16aGFvbGljaGFuZ0BodWF3ZWkuY29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNo
ZXcvMjAyMDA5MzAxNTE2MTYuMzU4ODE2NS0xLW1reXNlbEB0YWNoeXVtLmNvbSAtPiBwYXRjaGV3
LzIwMjAwOTMwMTUxNjE2LjM1ODgxNjUtMS1ta3lzZWxAdGFjaHl1bS5jb20KIC0gW3RhZyB1cGRh
dGVdICAgICAgcGF0Y2hldy8yMDIwMDkzMDE1NTg1OS4zMDMxNDgtMS1ib3JudHJhZWdlckBkZS5p
Ym0uY29tIC0+IHBhdGNoZXcvMjAyMDA5MzAxNTU4NTkuMzAzMTQ4LTEtYm9ybnRyYWVnZXJAZGUu
aWJtLmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwOTMwMTY0OTQ5LjE0MjUy
OTQtMS1waGlsbWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwOTMwMTY0OTQ5LjE0MjUyOTQt
MS1waGlsbWRAcmVkaGF0LmNvbQpmYXRhbDogZmFpbGVkIHRvIHdyaXRlIHJlZi1wYWNrIGZpbGUK
ZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBlY3RlZGx5ClRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICJwYXRjaGV3LXRlc3Rlci9zcmMvcGF0Y2hldy1j
bGkiLCBsaW5lIDUyMSwgaW4gdGVzdF9vbmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJy
ZXBvIl0sIHJbImhlYWQiXSwgbG9nZiwgVHJ1ZSkKICBGaWxlICJwYXRjaGV3LXRlc3Rlci9zcmMv
cGF0Y2hldy1jbGkiLCBsaW5lIDUzLCBpbiBnaXRfY2xvbmVfcmVwbwogICAgc3VicHJvY2Vzcy5j
aGVja19jYWxsKGNsb25lX2NtZCwgc3RkZXJyPWxvZ2YsIHN0ZG91dD1sb2dmKQogIEZpbGUgIi9v
cHQvcmgvcmgtcHl0aG9uMzYvcm9vdC91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHki
LCBsaW5lIDI5MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0
JywgJ2Nsb25lJywgJy1xJywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3BhdGNoZXctZ2l0LWNhY2hl
L2h0dHBzZ2l0aHViY29tcGF0Y2hld3Byb2plY3RxZW11LTNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTUyOWg5Ymhh
L3NyYyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxMjguCgoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MzAxNTU4NTku
MzAzMTQ4LTEtYm9ybnRyYWVnZXJAZGUuaWJtLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

