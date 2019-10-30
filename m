Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BEACA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6EF20679
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6EF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpqz-0008KW-UI
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iPppN-0006KK-T9
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 11:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iPppM-0003Hn-Au
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 11:24:05 -0400
Resent-Date: Wed, 30 Oct 2019 11:24:05 -0400
Resent-Message-Id: <E1iPppM-0003Hn-Au@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iPppM-0003Bt-33
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 11:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572449038; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CyL+ool45wiJimqrAzA7Xa8KkTBCbALVgFHr2rUfyPEnkQXNq/JJn33wi+/yMNToRdN03ixxAUhufeu8r6pDcAEwUi3xNWYi5rVE6A73oQYTL1YVGoDo7rsTck7IsBVz/8Fy1WPAR4zefFFk/SZH3f3UnPo+JRzQkmKMPfihQX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572449038;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=OBG8R8v4QZKgOmc7NLR8S1eK71Gmv413MvHJB4fba7E=; 
 b=goAUXE+lzwZmEpEATgNUWRf4qokDuez8IozP//jKL5RdE+vNr+knUov/IDhLMwUXSCEqVGAK1Xs3sorSzN5wiumOWfatQqxACd3dLBmuGDQxL/YcUnxc1gsS77G5tJemefC8cTWKJ/vFy64Ir+DMMYWsH1B5wnmSpZ9NjSc/Mq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572449037241282.7117458795559;
 Wed, 30 Oct 2019 08:23:57 -0700 (PDT)
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Subject: Re: [PATCH v4 00/20] Add virtual device fuzzing support
Message-ID: <157244903636.32191.2954681158974218419@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Wed, 30 Oct 2019 08:23:57 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: alxndr@bu.edu, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAzMDE0NDkyNi4xMTg3
My0xLWFseG5kckBidS5lZHUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXIt
cXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5F
VFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHRlc3RzL3Rlc3QtcWFw
aS10eXBlcy1zdWItc3ViLW1vZHVsZS5vCiAgQ0MgICAgICB0ZXN0cy90ZXN0LXFhcGktdmlzaXQu
bwogIENDICAgICAgdGVzdHMvaW5jbHVkZS90ZXN0LXFhcGktdmlzaXQtc3ViLW1vZHVsZS5vCi90
bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWNoYXIuYzozMToxMzogZXJyb3I6IHN0YXRpYyBk
ZWNsYXJhdGlvbiBvZiAnbWFpbl9sb29wJyBmb2xsb3dzIG5vbi1zdGF0aWMgZGVjbGFyYXRpb24K
IHN0YXRpYyB2b2lkIG1haW5fbG9vcCh2b2lkKQogICAgICAgICAgICAgXgpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtY2hhci5jOjEwOjA6Ci90bXAv
cWVtdS10ZXN0L3NyYy9pbmNsdWRlL3N5c2VtdS9zeXNlbXUuaDoxMTc6Njogbm90ZTogcHJldmlv
dXMgZGVjbGFyYXRpb24gb2YgJ21haW5fbG9vcCcgd2FzIGhlcmUKIHZvaWQgbWFpbl9sb29wKHZv
aWQpOwogICAgICBeCm1ha2U6ICoqKiBbdGVzdHMvdGVzdC1jaGFyLm9dIEVycm9yIDEKbWFrZTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2Vu
dCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYy
LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBj
bWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4n
LCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MjRj
MGNmNWFiNWEyNGJmOTljM2UwMDIzMDYzYzczZTAnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5
LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0n
LCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQn
LCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0v
dmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC05cWRxX3BtNy9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTMwLTExLjE5LjI2LjMyNTA1Oi92
YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAn
dGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1m
aWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0yNGMwY2Y1YWI1YTI0YmY5OWMzZTAw
MjMwNjNjNzNlMAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVh
dmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC05cWRxX3BtNy9zcmMn
Cm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwg
ICAgNG0zMC43NTBzCnVzZXIgICAgMG04Ljc0MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDMwMTQ0OTI2LjExODczLTEtYWx4bmRy
QGJ1LmVkdS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


