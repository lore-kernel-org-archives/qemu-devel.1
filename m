Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2299A20709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2299A20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQwN-0000Zw-Cj
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbQvl-0008FB-9c; Wed, 20 May 2020 11:46:53 -0400
Resent-Date: Wed, 20 May 2020 11:46:53 -0400
Resent-Message-Id: <E1jbQvl-0008FB-9c@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbQvi-0008QL-QS; Wed, 20 May 2020 11:46:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589989592; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JjXKDnHfzbG0F3pv5eqzoRsDmYm7h9YekicqNTqpZoLdnl0HEO0xTGNN6a7iEMjmOji3IcBNdBl1jzdD2z9Ph3O/AoTaQAYs+LLFohPbJOZSp4u8p+SC1iOPamW+q2Ydbm+pj2aomti7aZcJSgihY8CN0S86C2V995Q5FkwxhDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589989592;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SpqsM4PIGVpITCq3Wa25exovhIYupk7y+yWxhCnNkYI=; 
 b=NdbZDgltofN6BXaACOp6RGlbv580MX9Qh8EI5FDFCLAGmGNKXZLXgs4zbj2UsfC207OkNx2nn4Af9gYpLAFfYpSDXq2Nlblm0fyx6thO6foORiieAQKaHycriR8RAqzOKJ8ZPAF0FW/WjxmNouLIl4hCGm3d60uGiTUwqBI1KrQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589989589169152.62668925978915;
 Wed, 20 May 2020 08:46:29 -0700 (PDT)
Message-ID: <158998958743.28633.1092966168018027071@45ef0f9c86ae>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
Subject: Re: [PATCH v3 00/22] microvm: add acpi support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 20 May 2020 08:46:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 11:46:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMDEzMjAwMy45NDky
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGFhcmNoNjQtc29m
dG1tdS9ody9hcm0vaW50ZWdyYXRvcmNwLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L2kz
ODYva3ZtL2k4MjU0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kzODYvYWNwaS1taWNyb3ZtLmM6
IEluIGZ1bmN0aW9uICdidWlsZF9kc2R0X21pY3Jvdm0nOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
aTM4Ni9hY3BpLW1pY3Jvdm0uYzoxMDk6NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9m
IGZ1bmN0aW9uICdmd19jZmdfYWRkX2FjcGlfZHNkdCcgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rp
b24tZGVjbGFyYXRpb25dCiAgICAgZndfY2ZnX2FkZF9hY3BpX2RzZHQoc2Jfc2NvcGUsIHg4Nm1z
LT5md19jZmcpOwogICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kzODYvYWNwaS1taWNyb3Zt
LmM6MTA5OjU6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdmd19jZmdfYWRk
X2FjcGlfZHNkdCcgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCmNjMTogYWxsIHdhcm5pbmdzIGJl
aW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbaHcvaTM4Ni9hY3BpLW1pY3Jvdm0u
b10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgog
IENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS9tYWluc3RvbmUubwogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L2h3L2FybS9taWNyb2JpdC5vCi0tLQogIENDICAgICAgYWFyY2g2NC1zb2Z0
bW11L3RhcmdldC9hcm0vZ2Ric3R1YjY0Lm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90YXJn
ZXQvYXJtL21hY2hpbmUubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vYXJj
aF9kdW1wLm8KbWFrZTogKioqIFt4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS90YXJnZXQvYXJtL21vbml0b3IubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L3RhcmdldC9h
cm0vYXJtLXBvd2VyY3RsLm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywg
Jy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlk
PTVjZmEwOTAwZmFkNzRkM2U5NmYwMjkzODY4OTZmNzUxJywgJy11JywgJzEwMDEnLCAnLS1zZWN1
cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJ
U1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9E
SVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9j
a2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtNjEyZ3gwcjAvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0yMC0xMS40My41Ni4zMjA5
NTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NWNmYTA5MDBmYWQ3NGQzZTk2
ZjAyOTM4Njg5NmY3NTEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNjEyZ3gwcjAv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpy
ZWFsICAgIDJtMzEuNTc4cwp1c2VyICAgIDBtOC42MjBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUyMDEzMjAwMy45NDkyLTEta3Jh
eGVsQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

