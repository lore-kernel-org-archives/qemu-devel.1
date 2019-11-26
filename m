Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06616C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3B72075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3B72075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZX0u-0003Tg-TU
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iZX08-000313-Dx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iZX06-0004wO-Lh
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:19:16 -0500
Resent-Date: Tue, 26 Nov 2019 04:19:16 -0500
Resent-Message-Id: <E1iZX06-0004wO-Lh@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iZX06-0004vx-Ds
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:19:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574759947; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bbAMUGjHnqLvbI9H7CcQoCI+4NejHccw16yig7V6tY1qBe82b5HKHmEMRj+R66VlTLkMbk9edF5k2TU7vOpk5O9VOoKl4um1VVtvg1ecrnR/oP+MqUd1e2THucG9fWT7p7LuW0rCLl6PhbIsdt8aJm3X1U0ydly3K/J8viZA4rs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574759947;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4EqSbH7kYowDZ7O1nw8NCjcGIOsKF5fq4W1cBHHQseo=; 
 b=CQHjWKShte1cTu/KZoYEKJdVjKGfhALUDgJkRj1C1VVGJ3apxRzSLTeqkb44w0mYoINXVsNkP5mnqcPwIn5N6VaC/uCgIemSDpQxnVOWrP0d/KI7giBMdmGjmtI64ThFyjGziUqrsUV10oDLwbsV61O4UDNVQr/CxSJn/eEioK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574759945805587.4380374486793;
 Tue, 26 Nov 2019 01:19:05 -0800 (PST)
In-Reply-To: <20191126085936.1689-1-pbonzini@redhat.com>
Subject: Re: [PULL 0/5] i386 patches for QEMU 4.2-rc
Message-ID: <157475994490.31055.5778115059405326734@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 26 Nov 2019 01:19:05 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyNjA4NTkzNi4xNjg5
LTEtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2stdW5p
dDogdGVzdHMvdGVzdC10aHJlYWQtcG9vbAp3YWl0X2Zvcl9taWdyYXRpb25fZmFpbDogdW5leHBl
Y3RlZCBzdGF0dXMgc3RhdHVzPXdhaXQtdW5wbHVnIGFsbG93X2FjdGl2ZT0xCioqCkVSUk9SOi90
bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9taWdyYXRpb24tdGVzdC5jOjkwODp3YWl0X2Zvcl9taWdy
YXRpb25fZmFpbDogYXNzZXJ0aW9uIGZhaWxlZDogKHJlc3VsdCkKRVJST1IgLSBCYWlsIG91dCEg
RVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlvbi10ZXN0LmM6OTA4OndhaXRf
Zm9yX21pZ3JhdGlvbl9mYWlsOiBhc3NlcnRpb24gZmFpbGVkOiAocmVzdWx0KQptYWtlOiAqKiog
W2NoZWNrLXF0ZXN0LWFhcmNoNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtaGJpdG1hcAog
IFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1iZHJ2LWRyYWluCi0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0zZDE1ZTgzNjhiM2E0MmYzOWI0MjlhOGI0YWUyNmYy
OScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BU
Uz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hP
V19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWRkdXhrM2I4L3NyYy9kb2NrZXItc3Jj
LjIwMTktMTEtMjYtMDQuMDkuMzguMjAxNTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50
b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9M2QxNWU4MzY4YjNhNDJmMzliNDI5YThiNGFlMjZmMjkKbWFrZVsxXTogKioqIFtkb2Nr
ZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtZGR1eGszYjgvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1x
dWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDltMjYuNjEwcwp1c2VyICAgIDBtOC4zMjhz
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDE5MTEyNjA4NTkzNi4xNjg5LTEtcGJvbnppbmlAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1x
dWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


