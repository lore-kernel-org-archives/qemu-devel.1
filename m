Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1595CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 20:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8754920659
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 20:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8754920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPusP-0004hg-L2
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 16:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iPsWK-0000g4-A1
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iPsWI-0005OA-Qa
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:16:36 -0400
Resent-Date: Wed, 30 Oct 2019 14:16:35 -0400
Resent-Message-Id: <E1iPsWI-0005OA-Qa@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iPsWI-0005AL-Gf; Wed, 30 Oct 2019 14:16:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572459362; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mOui3O2qENNfCiq1EKD0gjPVsjlM7kLnmKx76v8Fa779lKWz/ark9F380xljVzDMvrt0hRAr9S+qnr+AuPkNgDZcWnZj59aL5ygbjJiG4LxXUMVH51w26YugTYiUequzDJgxDjltiyW6zhYdRRFeVQ7p/W5x8blTdevIWbiqao0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572459362;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DGpW49Y3Z6FSmGuBbUXrJJ2aX3IcvtXzxxJlx8CSsUk=; 
 b=l3Fff+ftyLij503qtRhOZr+6JDwHN9+n0WkzVU274xaHUV/NL38wp1QeOBiHvsFdyL4BoSBfScC4zGGsZwCk9Zvo9Euk1NaTyCZe5DPbvDPerYvWP1y25Ty1Ul6itdU7ye2xG7vwz8KhisCgj9DxTj8bjXXZzwvMRI/nx61v/dU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572459360231820.7963289863864;
 Wed, 30 Oct 2019 11:16:00 -0700 (PDT)
In-Reply-To: <20191030163243.10644-1-david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <157245935866.32191.1330059175509539647@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@gibson.dropbear.id.au
Date: Wed, 30 Oct 2019 11:16:00 -0700 (PDT)
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
Cc: david@redhat.com, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, imammedo@redhat.com, jdenemar@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAzMDE2MzI0My4xMDY0
NC0xLWRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAg
Y2hlY2stdW5pdDogdGVzdHMvdGVzdC10aHJvdHRsZQogIFRFU1QgICAgY2hlY2stdW5pdDogdGVz
dHMvdGVzdC10aHJlYWQtcG9vbAoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvbWln
cmF0aW9uLXRlc3QuYzo5MDM6d2FpdF9mb3JfbWlncmF0aW9uX2ZhaWw6IGFzc2VydGlvbiBmYWls
ZWQ6ICghc3RyY21wKHN0YXR1cywgInNldHVwIikgfHwgIXN0cmNtcChzdGF0dXMsICJmYWlsZWQi
KSB8fCAoYWxsb3dfYWN0aXZlICYmICFzdHJjbXAoc3RhdHVzLCAiYWN0aXZlIikpKQpFUlJPUiAt
IEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvbWlncmF0aW9uLXRlc3Qu
Yzo5MDM6d2FpdF9mb3JfbWlncmF0aW9uX2ZhaWw6IGFzc2VydGlvbiBmYWlsZWQ6ICghc3RyY21w
KHN0YXR1cywgInNldHVwIikgfHwgIXN0cmNtcChzdGF0dXMsICJmYWlsZWQiKSB8fCAoYWxsb3df
YWN0aXZlICYmICFzdHJjbXAoc3RhdHVzLCAiYWN0aXZlIikpKQptYWtlOiAqKiogW2NoZWNrLXF0
ZXN0LWFhcmNoNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtaGJpdG1hcAogIFRFU1QgICAg
Y2hlY2stdW5pdDogdGVzdHMvdGVzdC1iZHJ2LWRyYWluCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD1mMzRlZTg2OWY5OGY0ZDhmYjg5ZjRjY2U0Y2RhY2EwNScsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC14aXFvOW5kbS9zcmMvZG9ja2VyLXNyYy4yMDE5LTEw
LTMwLTE0LjA2LjUwLjI1NjEzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1m
MzRlZTg2OWY5OGY0ZDhmYjg5ZjRjY2U0Y2RhY2EwNQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC14aXFvOW5kbS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgOW05LjI2OHMKdXNlciAgICAwbTguNjQ2cwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMzAx
NjMyNDMuMTA2NDQtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUvdGVzdGluZy5kb2NrZXIt
cXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


