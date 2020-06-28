Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B58C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955DF2076E
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 11:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955DF2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpVqN-0001UM-RV
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 07:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpVpe-0000sV-M5; Sun, 28 Jun 2020 07:50:46 -0400
Resent-Date: Sun, 28 Jun 2020 07:50:46 -0400
Resent-Message-Id: <E1jpVpe-0000sV-M5@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jpVpc-0001US-Eb; Sun, 28 Jun 2020 07:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593345010; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eZgRvXZ2E5z5zNCL6yX1SFYlRYa02pcFCcQmwZ1Y++1d0myD5eO8PefnBghsJGG1U4d1AROUWWLMCJIj0787rGXnawXWSxZVZxSuc5aOTXJ6Ij0uslP91K84thOAkOf8XMFcjp268ampsrwy+Sxncc+7ohC80Xo90qLbFvOUuv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593345010;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TUgZg1GIz6Fdi7kl+PZSvAwZYzmNNO76a/FaCQsAdjs=; 
 b=LTNN13fk3ws44MX+FdWq9sXhqsquGQAgFFjRk8sc/1YcALsVN7glGdRNJWu1Ut/jos83MbGqFfmWjCZ0TkQ5+Sl7lnmc43JSJnKvlkq9dIbA0TKEysnVcBnNhXHcoi/CAYg8l8se+NGD32P6UdiApVcyjXuN5kNar52bQQ29IEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593345008257600.7650374699741;
 Sun, 28 Jun 2020 04:50:08 -0700 (PDT)
Message-ID: <159334500651.3056.152792702009140286@d1fd068a5071>
Subject: Re: [PATCH] ftgmac100: fix dblac write test
In-Reply-To: <20200628114057.6666-1-erik.lucas.smit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: erik.lucas.smit@gmail.com
Date: Sun, 28 Jun 2020 04:50:08 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 07:50:39
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, jasowang@redhat.com,
 qemu-devel@nongnu.org, erik.lucas.smit@gmail.com, qemu-arm@nongnu.org,
 clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyODExNDA1Ny42NjY2
LTEtZXJpay5sdWNhcy5zbWl0QGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEJVSUxE
ICAgcGMtYmlvcy9vcHRpb25yb20vbGludXhib290LnJhdwpJbiBmaWxlIGluY2x1ZGVkIGZyb20g
L3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC9mdGdtYWMxMDAuYzoxOToKL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L25ldC9mdGdtYWMxMDAuYzogSW4gZnVuY3Rpb24gJ2Z0Z21hYzEwMF93cml0ZSc6Ci90
bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvZnRnbWFjMTAwLmM6ODE1OjI3OiBlcnJvcjogZm9ybWF0
ICclbGQnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAnbG9uZyBpbnQnLCBidXQgYXJndW1lbnQg
MyBoYXMgdHlwZSAndWludDY0X3QnIHtha2EgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQnfSBbLVdl
cnJvcj1mb3JtYXQ9XQogIDgxNSB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiB0cmFu
c21pdCBkZXNjcmlwdG9yIHRvbyBzbWFsbCA6ICVsZCBieXRlc1xuIiwKICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9sb2cuaDoxMjA6MjI6
IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8gJ3FlbXVfbG9nX21hc2snCi0tLQogICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbG9uZyBpbnQKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlbGxkCkluIGZpbGUgaW5jbHVkZWQgZnJv
bSAvdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L2Z0Z21hYzEwMC5jOjE5OgovdG1wL3FlbXUtdGVz
dC9zcmMvaHcvbmV0L2Z0Z21hYzEwMC5jOjgyMToyNzogZXJyb3I6IGZvcm1hdCAnJWxkJyBleHBl
Y3RzIGFyZ3VtZW50IG9mIHR5cGUgJ2xvbmcgaW50JywgYnV0IGFyZ3VtZW50IDMgaGFzIHR5cGUg
J3VpbnQ2NF90JyB7YWthICdsb25nIGxvbmcgdW5zaWduZWQgaW50J30gWy1XZXJyb3I9Zm9ybWF0
PV0KICA4MjEgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICIlczogcmVjZWl2ZSBkZXNjcmlw
dG9yIHRvbyBzbWFsbCA6ICVsZCBieXRlc1xuIiwKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgov
dG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2xvZy5oOjEyMDoyMjogbm90ZTogaW4gZGVm
aW5pdGlvbiBvZiBtYWNybyAncWVtdV9sb2dfbWFzaycKLS0tCiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvbmcg
aW50CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAlbGxkCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvbmV0
L2Z0Z21hYzEwMC5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCiAgQlVJTEQgICBwYy1iaW9zL29wdGlvbnJvbS9saW51eGJvb3RfZG1hLnJhdwogIEJV
SUxEICAgcGMtYmlvcy9vcHRpb25yb20va3ZtdmFwaWMucmF3Ci0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD0yZGQwM2ExMDY4Zjc0ZGEwOGM3YWJkNDI2NzlmMGYyNycsICct
dScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtamdid2Y3d3ovc3JjL2RvY2tlci1zcmMuMjAyMC0w
Ni0yOC0wNy40Ni4xNi4yMTAyNjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0y
ZGQwM2ExMDY4Zjc0ZGEwOGM3YWJkNDI2NzlmMGYyNwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1qZ2J3Zjd3ei9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZl
ZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTUxLjM1MXMKdXNlciAgICAwbTguODM2cwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2Mjgx
MTQwNTcuNjY2Ni0xLWVyaWsubHVjYXMuc21pdEBnbWFpbC5jb20vdGVzdGluZy5kb2NrZXItbWlu
Z3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

