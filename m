Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B631C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39186214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39186214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSpoE-000285-E9
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 16:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSpmp-00019F-Ed
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSpmn-0005fj-Tm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:57:51 -0500
Resent-Date: Thu, 07 Nov 2019 16:57:51 -0500
Resent-Message-Id: <E1iSpmn-0005fj-Tm@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSpmn-0005e1-La
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:57:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573163861; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VV+DY3Ooq0Mg0GSuUUsSO+wa/CId5yRSwxdsc15DfPFlRsEfKxqauAODQ8iUTUIZEHM5iRNQKzGWCjpUfFyYqwqyXpmRir3VOo10ezadpHa4bd/1QX0cUZsxpOUaYEZpx8wrwmMmLvIqe4MJRSxw0Qnj0GC1mrgPTuzCOzqbgKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573163861;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=pz7ONEgoH2sjobn2bUTdA/DVkNXhFd3jMiZhkZhWYbs=; 
 b=Jdenf1NUbc1UxS1Te/jbP0xAmE6eiOKQjIMeNdDCpXxnytw7KrTgf15crAkx0XHnHTSL+dgI+98aKltSAJ3HzW/T16zf+NgjO/LFZYhFjW8sAKhWk4HBZ/A+HBDJFZ0ls00Xl8UYxyp2vnck5+iVY4WIt7sRNkF+UMnBpXJaTxE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573163859586319.69896167976026;
 Thu, 7 Nov 2019 13:57:39 -0800 (PST)
In-Reply-To: <20191107192731.17330-1-marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/3] Some memory leak fixes
Message-ID: <157316385831.31898.8575258200533586465@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Thu, 7 Nov 2019 13:57:39 -0800 (PST)
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
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNzE5MjczMS4xNzMz
MC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAg
Y2hlY2stdW5pdDogdGVzdHMvdGVzdC10aHJlYWQtcG9vbAogIFRFU1QgICAgY2hlY2stdW5pdDog
dGVzdHMvdGVzdC1oYml0bWFwCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9taWdy
YXRpb24tdGVzdC5jOjkwMzp3YWl0X2Zvcl9taWdyYXRpb25fZmFpbDogYXNzZXJ0aW9uIGZhaWxl
ZDogKCFzdHJjbXAoc3RhdHVzLCAic2V0dXAiKSB8fCAhc3RyY21wKHN0YXR1cywgImZhaWxlZCIp
IHx8IChhbGxvd19hY3RpdmUgJiYgIXN0cmNtcChzdGF0dXMsICJhY3RpdmUiKSkpCkVSUk9SIC0g
QmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9taWdyYXRpb24tdGVzdC5j
OjkwMzp3YWl0X2Zvcl9taWdyYXRpb25fZmFpbDogYXNzZXJ0aW9uIGZhaWxlZDogKCFzdHJjbXAo
c3RhdHVzLCAic2V0dXAiKSB8fCAhc3RyY21wKHN0YXR1cywgImZhaWxlZCIpIHx8IChhbGxvd19h
Y3RpdmUgJiYgIXN0cmNtcChzdGF0dXMsICJhY3RpdmUiKSkpCm1ha2U6ICoqKiBbY2hlY2stcXRl
c3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMTMKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRl
c3RzL3Rlc3QtYmRydi1kcmFpbgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9NzA5OWJhNjM2NWRiNGZjMGIwNzFlMmZhYzg3YjVjNTUnLCAnLXUnLCAnMTAwMycsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hF
X0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUt
ZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtc29mdGRib3ovc3JjL2RvY2tlci1zcmMuMjAxOS0xMS0wNy0xNi40NC4xMi40
Mzk1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9y
dW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0
ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD03MDk5YmE2MzY1ZGI0ZmMw
YjA3MWUyZmFjODdiNWM1NQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsx
XTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1zb2Z0ZGJv
ei9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIK
CnJlYWwgICAgMTNtMjcuMDEycwp1c2VyICAgIDBtOC4yOTVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTEwNzE5MjczMS4xNzMzMC0x
LW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


