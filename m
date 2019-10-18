Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7C8CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 23:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F02222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 23:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F02222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLbju-0000zm-0e
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 19:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iLbj4-0000X1-VC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 19:32:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iLbj2-0002Ze-6s
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 19:32:06 -0400
Resent-Date: Fri, 18 Oct 2019 19:32:05 -0400
Resent-Message-Id: <E1iLbj2-0002Ze-6s@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iLbj1-0002Wx-AF; Fri, 18 Oct 2019 19:32:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571441517; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TpUpwsv9Yvh7tFiy0//M7qrDInItb6MHhY3IjiYaX7svyoHQjVbhC9Zzf/JsV4SPTFf7d7WQYASlf8/sHI4B4TRBRbShGQT6TjK8OG1ZLgqecdG5V1DGA/wU/sda+6b8T03vFTWTsDMVTLJT6uLwqASjPmYqsrQFxdaQeqG2K38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571441517;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=XijMrrdhkQBWm6z8FnqmY6tkhDF/j2J2ruuQjoP4pE8=; 
 b=J+GKAKz/z6AxtyigKA7zNta9LQXFJzrxtac6quHoDTd+PrPGY9KsmbS8rjT8SLXSYHX37lux1PSVmhrLIwyYEWzANxGa1f8pfvTQOrJ0jlLufyxnzD+LLkqPSsfZ6YG97DwVmaZ6nbMRct7zX/mEcB6t9QfL7FRkBeIOJkoxkU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571441515944113.37549211069802;
 Fri, 18 Oct 2019 16:31:55 -0700 (PDT)
In-Reply-To: <20191018104438.6158-1-thuth@redhat.com>
Subject: Re: [PATCH] Do not use %m in common code to print error messages
Message-ID: <157144151476.24734.10331298410326065510@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Fri, 18 Oct 2019 16:31:55 -0700 (PDT)
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, kamil@netbsd.org,
 berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxODEwNDQzOC42MTU4
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcvc3Np
L3BsMDIyLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9ody9taXNj
L3RtcDQyMS5jOjMwOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbWlzYy90bXA0MjEuYzogSW4gZnVu
Y3Rpb24gJ3RtcDQyMV9zZXRfdGVtcGVyYXR1cmUnOgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVk
ZS9xYXBpL2Vycm9yLmg6MTY2OjI1OiBlcnJvcjogZm9ybWF0ICclcycgZXhwZWN0cyBhIG1hdGNo
aW5nICdjaGFyIConIGFyZ3VtZW50IFstV2Vycm9yPWZvcm1hdD1dCiAgICAgICAgICAgICAgICAg
ICAgICAgICAoZm10KSwgIyMgX19WQV9BUkdTX18pCiAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbWlzYy90bXA0MjEuYzoxNjY6OTogbm90ZTogaW4g
ZXhwYW5zaW9uIG9mIG1hY3JvICdlcnJvcl9zZXRnJwogICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJlcnJvciByZWFkaW5nICVzOiAlcyIsIGVycm1zZyk7CiAgICAgICAgIF5+fn5+fn5+fn4KY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFsvdG1wL3Fl
bXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9taXNjL3RtcDQyMS5vXSBFcnJvciAxCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNl
bnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2
MiwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwg
Y21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1u
JywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWFl
ZWZmYTc3OTk2MzQyMjdiYTcwZTk4YjRkMDhkNzk5JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0
eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9
JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0
JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0v
dmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2Vy
LWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtNHp1ZHB4NHEvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0xOC0xOS4yOS41My4xODgwMDov
dmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAn
dGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1m
aWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hZWVmZmE3Nzk5NjM0MjI3YmE3MGU5
OGI0ZDA4ZDc5OQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVh
dmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC00enVkcHg0cS9zcmMn
Cm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAg
ICAybTEuNjk3cwp1c2VyICAgIDBtNy4yODRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAxODEwNDQzOC42MTU4LTEtdGh1dGhAcmVk
aGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


