Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C00DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B432065D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B432065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVuH-0007kL-CL
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsVtZ-0007Kz-R3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:31:13 -0400
Resent-Date: Mon, 06 Jul 2020 14:31:13 -0400
Resent-Message-Id: <E1jsVtZ-0007Kz-R3@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsVtX-0005iJ-13
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594060263; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cT3Q5MjDr5yzJYaItYQI5BNBYwdOOhIixkVIY0r3NEya4e3GcnfOhqQ2ngEtwtM2fEKnHgHk73vx8FJb8av7vdGzuw8NdrRNoOi3RhOw5sfsUkIxj7jTtAILS2z2cTV+YErd+WV2k7clMIQ4LB7L8Tp+IPJWBN4XAgb6j7PIxQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594060263;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=z4YjojBbOgh1JoW/wR6ibfoaw476tMm2DVmjjJPGU1Y=; 
 b=LKREGiK7nENDNuY00lmRrs8sgdH8y0kHL9lzjkXbxIOQY1Y5GfKAkrUUaPO4uFscs0eo9dHozmPNSli071EUYKrIip38KgpPELE6sDj5O8/X65d/IfHfvmqaz91+3F1TkEpS1DIEH1kKetUBHHmHISGvxxJM8IdrUu6JQzPauco=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594060261187182.12789360186332;
 Mon, 6 Jul 2020 11:31:01 -0700 (PDT)
Message-ID: <159406026004.7847.7848259257282166125@d1fd068a5071>
Subject: Re: [PATCH] chardev: don't abort on attempt to add duplicated chardev
In-Reply-To: <20200706182156.334207-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Mon, 6 Jul 2020 11:31:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 13:19:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: eric.auger@redhat.com, qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwNjE4MjE1Ni4zMzQy
MDctMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50
b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hP
V19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IHRwbS5vCiAgQ0MgICAgICBkZXZpY2VfdHJlZS5vCi90bXAvcWVtdS10ZXN0L3NyYy9jaGFyZGV2
L2NoYXIuYzogSW4gZnVuY3Rpb24gJ2NoYXJkZXZfbmV3JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2No
YXJkZXYvY2hhci5jOjEwMDE6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0
aW9uICdvYmplY3RfcHJvcGVydHlfdHJ5X2FkZF9jaGlsZCcgWy1XZXJyb3I9aW1wbGljaXQtZnVu
Y3Rpb24tZGVjbGFyYXRpb25dCiAgICAgICAgIG9iamVjdF9wcm9wZXJ0eV90cnlfYWRkX2NoaWxk
KGdldF9jaGFyZGV2c19yb290KCksIGlkLCBvYmosICZsb2NhbF9lcnIpOwogICAgICAgICBeCi90
bXAvcWVtdS10ZXN0L3NyYy9jaGFyZGV2L2NoYXIuYzoxMDAxOjk6IGVycm9yOiBuZXN0ZWQgZXh0
ZXJuIGRlY2xhcmF0aW9uIG9mICdvYmplY3RfcHJvcGVydHlfdHJ5X2FkZF9jaGlsZCcgWy1XZXJy
b3I9bmVzdGVkLWV4dGVybnNdCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJy
b3JzCm1ha2U6ICoqKiBbY2hhcmRldi9jaGFyLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcg
Zm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGNwdXMtY29tbW9uLm8KICBDQyAgICAg
IGFjY2VsL2FjY2VsLm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwg
Y21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1u
JywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTlj
MmJkODI0YzZiMDQ0M2I5ZDc1YWUzZWQ2M2Y2OGFlJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0
eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9
JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0
JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9
L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tl
ci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLWllejVqMzBtL3NyYy9kb2NrZXItc3JjLjIwMjAtMDctMDYtMTQuMjguNDYuMTM1Njov
dmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywg
J3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0t
ZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OWMyYmQ4MjRjNmIwNDQzYjlkNzVh
ZTNlZDYzZjY4YWUKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExl
YXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaWV6NWozMG0vc3Jj
JwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFs
ICAgIDJtMTQuMTQ1cwp1c2VyICAgIDBtOC4xMjhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcwNjE4MjE1Ni4zMzQyMDctMS1tYXJj
YW5kcmUubHVyZWF1QHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

