Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9ADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9938C206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9938C206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZcnt-0007r7-Qp
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZcme-0006Lq-Gl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:02:00 -0400
Resent-Date: Fri, 15 May 2020 12:02:00 -0400
Resent-Message-Id: <E1jZcme-0006Lq-Gl@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZcmc-0002d2-Fl
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589558462; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g3You+Ol7pyp0Sekawqx70nLLmB4N30mwZxdcb9jhRhSVSCNGJWLeyJiAxqRhAkYnT41Lh2XAW/niIw2ETlxVKHaDLlvGOPjlvcNfw3qBwd25bQqidpDXmkUpvSNlrk4nC3zDeZNq7BX5qaCvKfZ9GgyuY+0c8i+EtiHJB7OzHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589558462;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LEJtMnRyzULhqBJmpa91jaYGf6/eV6GuH5yI4ShblZg=; 
 b=TrQQMvrfq374RywwLi9pwtpf4HtJNgK0+kvqzJduNrJf+bmf1XI4k764x6PyPD8X4Ywd0qas6WdA2Apm9sJsyfHvjfCvWNou79sxGncRz+N2ZUqEMuG41fJnBvil4NW2GbkmuQZiQkOAxkQxT6xUCeN0+S2OBNHq1vzDG66gDaY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589558460128426.5606249580385;
 Fri, 15 May 2020 09:01:00 -0700 (PDT)
Message-ID: <158955845817.7125.10694849635338331640@45ef0f9c86ae>
In-Reply-To: <1589537195-31392-1-git-send-email-ani.sinha@nutanix.com>
Subject: Re: [PATCH] Add a new PIIX option to control global PCI hot-plugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ani.sinha@nutanix.com
Date: Fri, 15 May 2020 09:01:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 10:35:12
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
Cc: ani.sinha@nutanix.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, imammedo@redhat.com,
 ani@anisinha.ca, pbonzini@redhat.com, philmd@redhat.com, aurelien@aurel32.net,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5NTM3MTk1LTMxMzkyLTEt
Z2l0LXNlbmQtZW1haWwtYW5pLnNpbmhhQG51dGFuaXguY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQg
dGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUg
RG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2Ut
Y2VudG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3
IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgICAg
ICAgICAgICAgICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody9pMzg2L3BjLmg6
NiwKICAgICAgICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL3BpaXg0
LmM6MjM6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hY3BpL3BpaXg0LmM6IEluIGZ1bmN0aW9uICdw
aWl4NF9hY3BpX3N5c3RlbV9ob3RfYWRkX2luaXQnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNw
aS9waWl4NC5jOjU5ODo1MDogZXJyb3I6ICdkZXYnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0
aGlzIGZ1bmN0aW9uKQogICAgICAgICBxYnVzX3NldF9ob3RwbHVnX2hhbmRsZXIoQlVTKHBjaV9n
ZXRfYnVzKGRldikpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29iamVjdC5oOjUxMToxNzog
bm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAnT0JKRUNUJwotLS0KL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L2FjcGkvcGlpeDQuYzo1OTg6MzQ6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAn
QlVTJwogICAgICAgICBxYnVzX3NldF9ob3RwbHVnX2hhbmRsZXIoQlVTKHBjaV9nZXRfYnVzKGRl
dikpLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgptYWtlOiAqKiogW2h3L2Fj
cGkvcGlpeDQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9k
b2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2Fs
bGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJy
b3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAn
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01OTZkOWM0NjIyNmI0Y2Y4OTdkZGMyNjE5ZTVmZDQyYics
ICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICct
LXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0n
LCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19F
TlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9w
YXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12
JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1lZGRtazdlOC9zcmMvZG9ja2VyLXNyYy4y
MDIwLTA1LTE1LTExLjU4LjQyLjEyNTI2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRv
czcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD01OTZkOWM0NjIyNmI0Y2Y4OTdkZGMyNjE5ZTVmZDQyYgptYWtlWzFdOiAqKiogW2RvY2tl
ci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC1lZGRtazdlOC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1
aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMm0xNi40MDRzCnVzZXIgICAgMG04LjQzNXMK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1
ODk1MzcxOTUtMzEzOTItMS1naXQtc2VuZC1lbWFpbC1hbmkuc2luaGFAbnV0YW5peC5jb20vdGVz
dGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

