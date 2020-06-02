Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F155C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29707206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29707206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1jZ-0004M8-Rh
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1j0-0003vC-N9
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:52:42 -0400
Resent-Date: Tue, 02 Jun 2020 03:52:42 -0400
Resent-Message-Id: <E1jg1j0-0003vC-N9@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1iz-00025z-7T
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:52:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591084349; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T1xmeiUxJ6bAPOgdCjfATRI1U6PQ7+EUIMpbHjTPa+Bov1Cz1V15IuYq+pK0TvmUtzj55ol85IaQTi/AdKnlYhHSpeLI82jWdAKR5QCM/PMLEl8+b5fElJQFpC6JBRpE0qInfSLjCHRtNiQfRZxYmlNlMeUQchOUbhjfRjicP64=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591084349;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=EnAo1Z4eH9F2ASiZtX3IPHO5cXYw3dRCBSkt8+vvyjE=; 
 b=bHtpCImvOOjLVRmuRFMB3FypvvOfEAkEpAChdf3G5XFu8stGtPLrO62ACH3Z/1FKsnOHUgfqYuH/znw4wS02/Y8PGbwKtx6e7EuVR6ioysw/OhxQGAyOTiLdKa89nqw/KPv7NjRot0Y62cuLa0ukGhs7ANq+xKfwrKcv+lR5f50=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591084348439231.1673474743809;
 Tue, 2 Jun 2020 00:52:28 -0700 (PDT)
Message-ID: <159108434720.18153.6978200107243538786@45ef0f9c86ae>
In-Reply-To: <20200602074201.10879-1-lma@suse.com>
Subject: Re: [PATCH 0/4] Add Support for GET LBA STATUS 16 command in scsi
 emulation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lma@suse.com
Date: Tue, 2 Jun 2020 00:52:28 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:52:38
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 lma@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMjA3NDIwMS4xMDg3
OS0xLWxtYUBzdXNlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tlci1x
dWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRz
IGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlv
dSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdPUks9
MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQgTkVU
V09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYmxvY2svbnZtZS5vCiAg
Q0MgICAgICBibG9jay90aHJvdHRsZS1ncm91cHMubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
YmxvY2stYmFja2VuZC5jOiBJbiBmdW5jdGlvbiAnYmxrX2RvX2dldF9sYmFfc3RhdHVzJzoKL3Rt
cC9xZW11LXRlc3Qvc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNjY2OjU6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYmRydl9jb19nZXRfbGJhX3N0YXR1cycgWy1X
ZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgcmV0dXJuIGJkcnZfY29f
Z2V0X2xiYV9zdGF0dXMoYmxrLT5yb290LCBvZmZzZXQsIGJ5dGVzLCBudW1fYmxvY2tzLAogICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNjY2OjU6IGVycm9y
OiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdiZHJ2X2NvX2dldF9sYmFfc3RhdHVzJyBb
LVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL2Jsb2NrLWJh
Y2tlbmQuYzogSW4gZnVuY3Rpb24gJ2Jsa19haW9fZ2V0X2xiYV9zdGF0dXNfZW50cnknOgovdG1w
L3FlbXUtdGVzdC9zcmMvYmxvY2svYmxvY2stYmFja2VuZC5jOjE2NzY6MzM6IGVycm9yOiBkZXJl
ZmVyZW5jaW5nICd2b2lkIConIHBvaW50ZXIgWy1XZXJyb3JdCiAgICAgdWludDMyX3QgKm51bV9i
bG9ja3MgPSAmZGF0YVswXTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1w
L3FlbXUtdGVzdC9zcmMvYmxvY2svYmxvY2stYmFja2VuZC5jOjE2Nzc6Mzc6IGVycm9yOiBkZXJl
ZmVyZW5jaW5nICd2b2lkIConIHBvaW50ZXIgWy1XZXJyb3JdCiAgICAgdWludDMyX3QgKmlzX2Rl
YWxsb2NhdGVkID0gJmRhdGFbc2l6ZW9mKHVpbnQzMl90KV07CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJy
b3JzCm1ha2U6ICoqKiBbYmxvY2svYmxvY2stYmFja2VuZC5vXSBFcnJvciAxCm1ha2U6ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9p
by5jOjIxOTA6MTogZXJyb3I6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3IgJ2JkcnZfY29fZ2V0
X2xiYV9zdGF0dXMnIFstV2Vycm9yPW1pc3NpbmctcHJvdG90eXBlc10KIGJkcnZfY29fZ2V0X2xi
YV9zdGF0dXMoQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBvZmZzZXQsIGludDY0X3QgYnl0ZXMs
CiBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBb
YmxvY2svaW8ub10gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAg
RmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjUsIGluIDxtb2R1bGU+CiAg
ICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD1lMGJlYjI4ZjMyNTY0OTM5YjUxNzgyYTNhNWZjNGI4ZScsICctdScsICcxMDAxJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAn
Sj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTNhY3J3ZGNsL3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMDItMDMuNTAuMTEuMTE3
MzQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWUwYmViMjhmMzI1NjQ5Mzli
NTE3ODJhM2E1ZmM0YjhlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTNhY3J3ZGNs
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoK
cmVhbCAgICAybTE3LjA1OHMKdXNlciAgICAwbTguNTAycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MDIwNzQyMDEuMTA4NzktMS1s
bWFAc3VzZS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

