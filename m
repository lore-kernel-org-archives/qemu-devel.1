Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF14CA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BC421929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BC421929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNp3W-0007YH-8R
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNp1z-0003HL-M2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNp1x-0001az-NK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:08:47 -0400
Resent-Date: Thu, 24 Oct 2019 22:08:47 -0400
Resent-Message-Id: <E1iNp1x-0001az-NK@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNp1x-0001aQ-CC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571969299; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OiG6qD12ni0xJ8c47g/QKyu1HsZ6lQFTn2d7tM9SFtE+SkMO4dDy5wD10D9CdQMADUBtZRuGL04AAaTq0h4AqxZXS7qn/nu055PmlaUIA8aTkGJj22pgAtOmcHAr2ZyarL/ffdOoWOVNn2VPP+RIuCWUh4AkdER0WT9VJdWNVFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571969299;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gUU1oFbUhxfET+AvkBLoPSbfX5x0wtyqsO50c2UUccs=; 
 b=M/FpXCualzZ9bnj5xWBhiVDRW18RieEDdmlBmY8kQKqFlnyqgnoUAmxCu8mO45Z8l0afy9KCd8VD2qg9ce8+h77w7nqdEtDYDu92nMo8yniXf1Ao/fBx6E+I4Y15HvJZy+97xhzAQPTsY00CzbHfhIn1lzxOreMoxC4HLCgyhR4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571969297043795.9460811785485;
 Thu, 24 Oct 2019 19:08:17 -0700 (PDT)
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu
Message-ID: <157196929460.8606.5955402798926945427@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jag.raman@oracle.com
Date: Thu, 24 Oct 2019 19:08:17 -0700 (PDT)
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTcxOTA1MzQ2Lmdp
dC5qYWcucmFtYW5Ab3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90ZXN0LXFj
b3cyOiAyNjgKRmFpbHVyZXM6IDA3MSAwOTkgMTIwIDE4NCAxODYKRmFpbGVkIDUgb2YgMTA5IGlv
dGVzdHMKbWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3IgMQptYWtl
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRl
c3QtYWFyY2g2NDogdGVzdHMvcW9zLXRlc3QKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9N2ZjZDUzN2QzMjRm
NGUyOTk3ZGQ1YTZlNzcyYmNlNTknLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9j
Y2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1rOXc1
cTdmbS9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTI0LTIxLjU0LjQ5LjE3OTkzOi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWlj
ayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFi
ZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD03ZmNkNTM3ZDMyNGY0ZTI5OTdkZDVhNmU3NzJiY2U1
OQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJl
Y3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1rOXc1cTdmbS9zcmMnCm1ha2U6ICoq
KiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTNtMjYu
NDc4cwp1c2VyICAgIDBtOC45NDdzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTcxOTA1MzQ2LmdpdC5qYWcucmFtYW5Ab3JhY2xl
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


