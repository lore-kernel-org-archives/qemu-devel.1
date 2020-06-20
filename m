Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D08C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 00:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F8B246DD
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 00:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F8B246DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmnP3-0005qr-Li
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 20:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmnOK-0004qr-7a; Sat, 20 Jun 2020 19:59:20 -0400
Resent-Date: Sat, 20 Jun 2020 19:59:20 -0400
Resent-Message-Id: <E1jmnOK-0004qr-7a@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmnOH-00015y-Gq; Sat, 20 Jun 2020 19:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592697528; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hps8WbHRMg2VHzJOeBCusuHFDRzM41q5fvYtwaDLYwtaEfLrVkHEEU7ImzlkButtlZU6D7gN+a3clv7FMD3NxAuKVfaB0DbOgsKeaUS+tsN4qzUVfGpCt2Ltwj6XuDDBPLy8fdNSUHeJ3O1pRFqYCWAof2To8WPGzpGO0dCWhyc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592697528;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dt3lJQrZ3lri6EhmckJ1D3wYvnNpMOW6AxtmRw4Q6mI=; 
 b=PkDUFryZv3p9d1mFL180qieCPNpAWyIO6+UsFl+Eog/2Wmz7rqpJu6XGMuDYXpQcRp5iNVFgyTjEozAQMK0IW32iklyo3PxTmf4tbM+Tbi7v3HmgOmOelfbcTHtuF1Ws4vttr9MlykoMuY5dPMak7YuHWbHvEcgtgNtHEoLdwQY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159269752732183.24782271345964;
 Sat, 20 Jun 2020 16:58:47 -0700 (PDT)
Message-ID: <159269752550.8692.10359734241994023212@d1fd068a5071>
Subject: Re: [PATCH v3 0/7] hw/misc: Add LED device
In-Reply-To: <20200620230719.32139-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sat, 20 Jun 2020 16:58:47 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 19:59:13
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, qemu-devel@nongnu.org,
 f4bug@amsat.org, qemu-arm@nongnu.org, joel@jms.id.au, philmd@redhat.com,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyMDIzMDcxOS4zMjEz
OS0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90ZXN0LXFjb3cy
OiAxNDMKICBURVNUICAgIGlvdGVzdC1xY293MjogMTUwCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0
L3NyYy9ody9jb3JlL3FkZXYuYzoxMDc0OmRldmljZV9maW5hbGl6ZTogYXNzZXJ0aW9uIGZhaWxl
ZDogKGRldi0+Y2Fub25pY2FsX3BhdGgpCkJyb2tlbiBwaXBlCi90bXAvcWVtdS10ZXN0L3NyYy90
ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0ZWN0ZWQgUUVNVSBkZWF0
aCBmcm9tIHNpZ25hbCA2IChBYm9ydGVkKSAoY29yZSBkdW1wZWQpCkVSUk9SIC0gdG9vIGZldyB0
ZXN0cyBydW4gKGV4cGVjdGVkIDYsIGdvdCA1KQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LWFhcmNo
NjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBU
RVNUICAgIGlvdGVzdC1xY293MjogMTU0CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE1NgotLS0K
ICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2Fs
bGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bics
ICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzM1OTBlYjYxNDIyNDFiMjhiMGQz
MjM3MzdkOTlkYTInLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVu
Y29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09O
RklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9Jywg
Jy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAn
LXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9j
Y2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMHV3cXVkcWkvc3Jj
L2RvY2tlci1zcmMuMjAyMC0wNi0yMC0xOS40Ni4wNi4yNjEyOTovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9MzM1OTBlYjYxNDIyNDFiMjhiMGQzMjM3MzdkOTlkYTIKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMHV3cXVkcWkvc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEybTM4LjkxOXMKdXNl
ciAgICAwbTguMTQycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAyMDA2MjAyMzA3MTkuMzIxMzktMS1mNGJ1Z0BhbXNhdC5vcmcvdGVzdGlu
Zy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

