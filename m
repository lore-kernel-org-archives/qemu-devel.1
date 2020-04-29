Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AAFC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 23:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE43620575
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 23:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE43620575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTwHq-0005DZ-Nd
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 19:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTwHF-0004k7-EE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 19:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTwHE-0003Rk-Rl
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 19:38:05 -0400
Resent-Date: Wed, 29 Apr 2020 19:38:05 -0400
Resent-Message-Id: <E1jTwHE-0003Rk-Rl@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTwHA-0003R4-HS; Wed, 29 Apr 2020 19:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588203472; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mEMTxfFzXl4f3hmuSpLnas+QLTmjXTB5bZeBPeHs+yWR5h5DgI3la2iHqOaCbCuhlDWeHJrQUJPp1ZaGFKJMZoUKoFVrKjvcK0saPZnGFGfakgauYka2B5f5wDaOfZO/vclyzTCw5xu4ImSkT1K00fp5UeLK5VsMkMYiGYXKYPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588203472;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=exCzEGo2Rd2EJXdpq3bLs1qNbU8+1WH0DUb7ShShjFI=; 
 b=M5ad1xOqWUBNEb1Kem8mwgozTM0UwNWDwZJxsPpvTXOoSWMqvc2OCE9Dyu+cvAqiPKSSeuLJat5vpqUJvTebBw7wN50uj6uabf+WC5e/D+2JwSBv7kE9wbztnm3GClsjRbmXDVZbbtVQYqNFl6RIXSgQUbIkRtcfSOVBeF/zdtQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588203470224484.74752167800807;
 Wed, 29 Apr 2020 16:37:50 -0700 (PDT)
Message-ID: <158820346890.4471.4153550164252988992@45ef0f9c86ae>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
Subject: Re: [PATCH v2 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Wed, 29 Apr 2020 16:37:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 19:37:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyOTE0MTEyNi44NTE1
OS0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQlVJTEQgICBwYy1iaW9zL29w
dGlvbnJvbS9wdmgucmF3CiAgU0lHTiAgICBwYy1iaW9zL29wdGlvbnJvbS9wdmguYmluCi90bXAv
cWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOiBJbiBmdW5jdGlvbiAnaW1nX2NvbW1pdCc6Ci90bXAv
cWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0
aW9uIG9mIGZ1bmN0aW9uICdibGtfbmV3X3dpdGhfYnMnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICBvbGRfYmFja2luZ19ibGsgPSBibGtfbmV3X3dpdGhf
YnMoYnMsIEJMS19QRVJNX1dSSVRFLCBCTEtfUEVSTV9BTEwsCiAgICAgICAgIF4KL3RtcC9xZW11
LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3MTo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJh
dGlvbiBvZiAnYmxrX25ld193aXRoX2JzJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9x
ZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3MToyNTogZXJyb3I6IGFzc2lnbm1lbnQgbWFrZXMg
cG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XZXJyb3JdCiAgICAgICAgIG9s
ZF9iYWNraW5nX2JsayA9IGJsa19uZXdfd2l0aF9icyhicywgQkxLX1BFUk1fV1JJVEUsIEJMS19Q
RVJNX0FMTCwKICAgICAgICAgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFtxZW11LWltZy5vXSBFcnJvciAxCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiB3YWl0OiBObyBj
aGlsZCBwcm9jZXNzZXMuICBTdG9wLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vz
cy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAn
cnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD03MGVhMGRhNTJjYTk0MWVj
YWZiNWVmZDJlMThkZmU2YScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2Nv
bXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRS
QV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJV
Rz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNo
ZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIv
dG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0yZmFhYXhs
Ny9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTI5LTE5LjM1LjI0LjU5OTg6L3Zhci90bXAvcWVtdTp6
LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10n
IHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1j
b20ucWVtdS5pbnN0YW5jZS51dWlkPTcwZWEwZGE1MmNhOTQxZWNhZmI1ZWZkMmUxOGRmZTZhCm1h
a2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9y
eSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTJmYWFheGw3L3NyYycKbWFrZTogKioqIFtk
b2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTI0LjY5N3MK
dXNlciAgICAwbTcuOTUzcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDA0MjkxNDExMjYuODUxNTktMS1tcmVpdHpAcmVkaGF0LmNvbS90
ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

