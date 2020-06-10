Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4961FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E64206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E64206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8LU-0000lH-C5
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 17:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj8K8-0008IO-Vo
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 17:31:53 -0400
Resent-Date: Wed, 10 Jun 2020 17:31:52 -0400
Resent-Message-Id: <E1jj8K8-0008IO-Vo@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj8K6-00013t-9F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 17:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591824695; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WBCNh1ZI7nYptBn/FonyVQYKeYvZblcurdBj9ZoeSMOB49ay3wS2Frf2Sv3d0edrTESF9NIT/2VRrEj7sQafb7T4rlR8JcLdu+Da3Qcu6v+TyuSVOuBz7CjdRL2sHXCjQ+TbeEXI8nwHaEhV2N72WQlnAMyTOesROsaqHBODIDg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591824695;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=eN7HQ0Tatrfyu9mZlh6aA+vwubWdq3wZzZrR8dIwKRo=; 
 b=lTsF4/ECJl+AUYYthItAFZ1EJDZdVdePjhmTxtH+L4oy0PfDvp9XwFij+a0w6WAh/ShCK5dl1FICWmQ7/FrabX5RpsX8FIz83P/yL61PaSr66H2GKxDnAowr0J7pEohmY0Guskam4OytfvonHaySMFS3a6i1VluDUwmchvO0teI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591824692378129.85227276142837;
 Wed, 10 Jun 2020 14:31:32 -0700 (PDT)
Message-ID: <159182469091.21115.6955040214270832177@45ef0f9c86ae>
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
Subject: Re: [PATCH 0/8] tpm: Split hw/ vs backends/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Wed, 10 Jun 2020 14:31:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 16:25:39
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au,
 philmd@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMDIwMDI0Ny4yMTM3
OC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIHg4Nl82NC1zb2Z0bW11L3FhcGkvcWFwaS12aXNpdC5vCiAgQ0MgICAgICB4ODZfNjQt
c29mdG1tdS9xYXBpL3FhcGktZXZlbnRzLW1hY2hpbmUtdGFyZ2V0Lm8KICBDQyAgICAgIHg4Nl82
NC1zb2Z0bW11L3FhcGkvcWFwaS1ldmVudHMtbWlzYy10YXJnZXQubwovdG1wL3FlbXUtdGVzdC9z
cmMvaHcvdHBtL3RwbV9wcGkuYzo0Nzo0OTogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50
aWZpZXIgJ1RQTV9QUElfQUREUl9TSVpFJwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEhPU1RfUEFHRV9BTElHTihUUE1fUFBJX0FERFJfU0laRSkpOwogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody90cG0v
dHBtX3BwaS5jOjQ3OjQ5OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnVFBN
X1BQSV9BRERSX1NJWkUnCi90bXAvcWVtdS10ZXN0L3NyYy9ody90cG0vdHBtX3BwaS5jOjQ5OjM5
OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnVFBNX1BQSV9BRERSX1NJWkUn
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFBNX1BQSV9BRERSX1NJWkUs
IHRwbXBwaS0+YnVmKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCjMg
ZXJyb3JzIGdlbmVyYXRlZC4KbWFrZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMu
bWFrOjY5OiBody90cG0vdHBtX3BwaS5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbTWFrZWZpbGU6NTI3OiB4ODZfNjQtc29m
dG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZp
bGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY1LCBpbiA8bW9kdWxlPgogICAg
c3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2Rl
LCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAn
LW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
ZjY2ZmU2NDU5ZjU2NDIyMTg1OTk5ZTQwYmNiZTJhYmInLCAnLXUnLCAnMTAwMycsICctLXNlY3Vy
aXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAn
Vj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1l
JywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWI0dnFvdGR0L3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMTAt
MTcuMjcuMzUuNTE0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWY2NmZlNjQ1
OWY1NjQyMjE4NTk5OWU0MGJjYmUyYWJiCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWI0dnFvdGR0L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVkb3JhXSBF
cnJvciAyCgpyZWFsICAgIDNtNTUuNzUwcwp1c2VyICAgIDBtNy44OTNzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYxMDIwMDI0Ny4y
MTM3OC0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

