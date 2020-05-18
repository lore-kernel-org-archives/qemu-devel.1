Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF0CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F652070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 07:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F652070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaZtp-0003p1-1i
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 03:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaZt2-0003Bj-9r
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:08:32 -0400
Resent-Date: Mon, 18 May 2020 03:08:32 -0400
Resent-Message-Id: <E1jaZt2-0003Bj-9r@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaZt0-0000lS-GH
 for qemu-devel@nongnu.org; Mon, 18 May 2020 03:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589785702; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hejZ2GcPmsQiYcwipJqz50Go193kQPHX4/J4p+rlUWxbgq+U+YqLJvSMAyt60siN+h/RlevXed9M348x2oWXii+9/ufLm2DlX/8H/mN3cqLoty4og6QHZxbdmTzyGHBrq1dCVs7Ujjl1FagDroznkmf7x6VqmQzeKDfN5ss2uE8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589785702;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yxCNpFs6sFsikVRHq821CGSKEYixH8E811Ure2KkAi4=; 
 b=Kf6IpxORYaTHUjul17dQOrXDA9GwzI7/XrhhwQex9ZC0tKntgdcqMx/pTf6hYf9pTu6ZbpmQ5AGIT/id8pGdyQ83QzBbZ2oXRoff+XIM5Ttey6lSmoiYKCJqW15i9ikJWaK0n+pOynXNu1D+VEH5jjYcn3S92icEDyZdsgsNSOE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589785701607377.16629551569986;
 Mon, 18 May 2020 00:08:21 -0700 (PDT)
Message-ID: <158978570036.15373.12605145690499615164@45ef0f9c86ae>
In-Reply-To: <20200518051945.8621-1-armbru@redhat.com>
Subject: Re: [PATCH not-for-merge 0/5] Instrumentation for "Fixes around
 device realization"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Mon, 18 May 2020 00:08:21 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 02:54:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxODA1MTk0NS44NjIx
LTEtYXJtYnJ1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTE4MDUxOTQ1Ljg2MjEtMS1hcm1icnVAcmVkaGF0
LmNvbQpTdWJqZWN0OiBbUEFUQ0ggbm90LWZvci1tZXJnZSAwLzVdIEluc3RydW1lbnRhdGlvbiBm
b3IgIkZpeGVzIGFyb3VuZCBkZXZpY2UgcmVhbGl6YXRpb24iClR5cGU6IHNlcmllcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8xNTg5NzgyMzk4LTI0NDA2
LTEtZ2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20gLT4gcGF0Y2hldy8xNTg5Nzgy
Mzk4LTI0NDA2LTEtZ2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20KIC0gW3RhZyB1
cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDUxODA1MDQwOC40NTc5LTEtYXJtYnJ1QHJlZGhhdC5j
b20gLT4gcGF0Y2hldy8yMDIwMDUxODA1MDQwOC40NTc5LTEtYXJtYnJ1QHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0MzNjNjUzIHFkZXY6IEluc3RydW1lbnQgdG8g
ZGV0ZWN0IGJ1cyBtaXNtYXRjaAo0NWIxYWI3IHFkZXY6IEluc3RydW1lbnQgdG8gZGV0ZWN0IG1p
c3NlZCBRT00gcGFyZW50aW5nCjkwYWRjZTMgcWRldjogTWFrZSAiaW5mbyBxdHJlZSIgc2hvdyBj
aGlsZCBkZXZpY2VzIHNvcnRlZCBieSBRT00gcGF0aApmODE3MTkzIHFvbTogTWFrZSAiaW5mbyBx
b20tdHJlZSIgc2hvdyBjaGlsZHJlbiBzb3J0ZWQKNGYxYTdkMSBxb206IEluc3RydW1lbnQgdG8g
ZGV0ZWN0IG1pc3NlZCByZWFsaXplCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcg
Y29tbWl0IDRmMWE3ZDExZjBkMyAocW9tOiBJbnN0cnVtZW50IHRvIGRldGVjdCBtaXNzZWQgcmVh
bGl6ZSkKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzIwOiBGSUxFOiBxb20vcW9t
LWhtcC1jbWRzLmM6OTY6CisgICAgRGV2aWNlQ2xhc3MgKmRjID0gKERldmljZUNsYXNzICopb2Jq
ZWN0X2NsYXNzX2R5bmFtaWNfY2FzdChvYmotPmNsYXNzLCBUWVBFX0RFVklDRSk7Cgp0b3RhbDog
MCBlcnJvcnMsIDEgd2FybmluZ3MsIDE3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvNSBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoyLzUgQ2hlY2tpbmcgY29tbWl0IGY4MTcxOTNkOGY2YiAocW9t
OiBNYWtlICJpbmZvIHFvbS10cmVlIiBzaG93IGNoaWxkcmVuIHNvcnRlZCkKMy81IENoZWNraW5n
IGNvbW1pdCA5MGFkY2UzM2EzY2UgKHFkZXY6IE1ha2UgImluZm8gcXRyZWUiIHNob3cgY2hpbGQg
ZGV2aWNlcyBzb3J0ZWQgYnkgUU9NIHBhdGgpCjQvNSBDaGVja2luZyBjb21taXQgNDViMWFiNzli
ZjAwIChxZGV2OiBJbnN0cnVtZW50IHRvIGRldGVjdCBtaXNzZWQgUU9NIHBhcmVudGluZykKNS81
IENoZWNraW5nIGNvbW1pdCA0MzNjNjUzNjNiNDggKHFkZXY6IEluc3RydW1lbnQgdG8gZGV0ZWN0
IGJ1cyBtaXNtYXRjaCkKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMyMzogRklMRTog
aHcvY29yZS9xZGV2LmM6MTA2OgorICAgICAgICAgICAgIGJjID0gKEJ1c0NsYXNzICopb2JqZWN0
X2NsYXNzX2R5bmFtaWNfY2FzdChvYmplY3RfY2xhc3NfZ2V0X3BhcmVudChPQkpFQ1RfQ0xBU1Mo
YmMpKSwgVFlQRV9CVVMpKSB7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMjQ6
IEZJTEU6IGh3L2NvcmUvcWRldi5jOjEwNzoKKyAgICAgICAgICAgIGlmICghZ19zdHJjbXAwKGRj
LT5idXNfdHlwZSwgb2JqZWN0X2NsYXNzX2dldF9uYW1lKE9CSkVDVF9DTEFTUyhiYykpKSkgewoK
dG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCAyMyBsaW5lcyBjaGVja2VkCgpQYXRjaCA1LzUg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTE4MDUxOTQ1Ljg2MjEtMS1hcm1icnVAcmVkaGF0
LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

