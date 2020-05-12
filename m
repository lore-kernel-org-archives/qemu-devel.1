Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2641C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B50206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B50206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVbe-00054p-1v
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYVb4-0004aF-Gc
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:09:26 -0400
Resent-Date: Tue, 12 May 2020 10:09:26 -0400
Resent-Message-Id: <E1jYVb4-0004aF-Gc@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYVb2-0000WF-Mm
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:09:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589292555; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mgxNzqlpof1fgGRS35RNlT8hPvj6hXMY2GNCfS3jEacCHnyn0brKKj+VId0CcrBd2/gSS7JEw17t6uI7nyT9ahXSvJV1dNG2/+i0YGNR9z2IiJLbOnNZTW0JE7iaUba60EbOHZL51hFn0feT3JXpjqsXeeByID676rykFt7r3D8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589292555;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=x7Kphq2rjjlO83CX61uAAYzKi1wsdR2D37s1V7COL9w=; 
 b=FOIm/BqF32FVHFLvQCNpsSREtEV37FBuZ/zVyFDmng4OjnU+KKf9cjg97z1oy2M6EA7XGEn5LUkHmvufmKzvsmuRFqg6YKMxWwmuwQ8OzV++rQAfLwEwVV7F0TYnJHn8mNwI1yWX+aB5+TCbMOUgkAS1Y5sOoh7uXao73FG30XU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589292553348682.0023420401637;
 Tue, 12 May 2020 07:09:13 -0700 (PDT)
Message-ID: <158929255225.4397.16995753557428414141@45ef0f9c86ae>
In-Reply-To: <20200512104338.27365-1-alex.bennee@linaro.org>
Subject: Re: [PATCH] tests/guest-debug: catch hanging guests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Tue, 12 May 2020 07:09:13 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 10:00:12
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMjEwNDMzOC4yNzM2
NS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKLS0tIC90bXAvcWVtdS10
ZXN0L3NyYy90ZXN0cy9xZW11LWlvdGVzdHMvMDQwLm91dCAgICAgICAyMDIwLTA1LTEyIDEwOjM1
OjI4LjAwMDAwMDAwMCArMDAwMAorKysgL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1p
b3Rlc3RzLzA0MC5vdXQuYmFkIDIwMjAtMDUtMTIgMTQ6MDE6MDUuMTEyNjEzOTM0ICswMDAwCkBA
IC0xLDMgKzEsNSBAQAorV0FSTklORzpxZW11Lm1hY2hpbmU6cWVtdSByZWNlaXZlZCBzaWduYWwg
OTogL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLy4uLy4uL3g4Nl82NC1z
b2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NCAtZGlzcGxheSBub25lIC12Z2Egbm9uZSAtY2hhcmRl
diBzb2NrZXQsaWQ9bW9uLHBhdGg9L3RtcC90bXAua0dZalVkTVpqSi9xZW11LTIwNjE0LW1vbml0
b3Iuc29jayAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAtcXRlc3QgdW5peDpwYXRoPS90
bXAvdG1wLmtHWWpVZE1aakovcWVtdS0yMDYxNC1xdGVzdC5zb2NrIC1hY2NlbCBxdGVzdCAtbm9k
ZWZhdWx0cyAtZGlzcGxheSBub25lIC1hY2NlbCBxdGVzdCAtZHJpdmUgaWY9bm9uZSxpZD1kcml2
ZTAsZmlsZT0vdG1wL3FlbXUtdGVzdC90ZXN0LmltZyxmb3JtYXQ9cWNvdzIsY2FjaGU9d3JpdGVi
YWNrLGFpbz10aHJlYWRzLG5vZGUtbmFtZT10b3AsYmFja2luZy5ub2RlLW5hbWU9bWlkLGJhY2tp
bmcuYmFja2luZy5ub2RlLW5hbWU9YmFzZSAtZGV2aWNlIHZpcnRpby1zY3NpLXBjaSAtZGV2aWNl
IHNjc2ktaGQsaWQ9c2NzaTAsZHJpdmU9ZHJpdmUwCitXQVJOSU5HOnFlbXUubWFjaGluZTpxZW11
IHJlY2VpdmVkIHNpZ25hbCA5OiAvdG1wL3FlbXUtdGVzdC9idWlsZC90ZXN0cy9xZW11LWlvdGVz
dHMvLi4vLi4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0IC1kaXNwbGF5IG5vbmUg
LXZnYSBub25lIC1jaGFyZGV2IHNvY2tldCxpZD1tb24scGF0aD0vdG1wL3RtcC5rR1lqVWRNWmpK
L3FlbXUtMjA2MTQtbW9uaXRvci5zb2NrIC1tb24gY2hhcmRldj1tb24sbW9kZT1jb250cm9sIC1x
dGVzdCB1bml4OnBhdGg9L3RtcC90bXAua0dZalVkTVpqSi9xZW11LTIwNjE0LXF0ZXN0LnNvY2sg
LWFjY2VsIHF0ZXN0IC1ub2RlZmF1bHRzIC1kaXNwbGF5IG5vbmUgLWFjY2VsIHF0ZXN0IC1kcml2
ZSBpZj1ub25lLGlkPWRyaXZlMCxmaWxlPS90bXAvcWVtdS10ZXN0L3Rlc3QuaW1nLGZvcm1hdD1x
Y293MixjYWNoZT13cml0ZWJhY2ssYWlvPXRocmVhZHMsbm9kZS1uYW1lPXRvcCxiYWNraW5nLm5v
ZGUtbmFtZT1taWQsYmFja2luZy5iYWNraW5nLm5vZGUtbmFtZT1iYXNlIC1kZXZpY2UgdmlydGlv
LXNjc2ktcGNpIC1kZXZpY2Ugc2NzaS1oZCxpZD1zY3NpMCxkcml2ZT1kcml2ZTAKIC4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uCiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiBSYW4gNTkgdGVzdHMKLS0tCk5vdCBydW46IDI1OQpGYWlsdXJlczogMDQwCkZh
aWxlZCAxIG9mIDExOCBpb3Rlc3RzCm1ha2U6ICoqKiBbY2hlY2stdGVzdHMvY2hlY2stYmxvY2su
c2hdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBU
RVNUICAgIGNoZWNrLXF0ZXN0LWFhcmNoNjQ6IHRlc3RzL3F0ZXN0L3Fvcy10ZXN0ClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPTA0OTZhNzk0OTNiODQzNGU5YjUzZjgzZjQ1MjZhMzAzJywgJy11JywgJzEwMDEn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtY281dm45cnYvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0xMi0wOS41
NS4wNi4xOTQ3NzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDQ5NmE3OTQ5
M2I4NDM0ZTliNTNmODNmNDUyNmEzMDMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
Y281dm45cnYvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDE0bTYuMDQzcwp1c2VyICAgIDBtOC44MzJzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUxMjEwNDMzOC4y
NzM2NS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9z
Ny8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

