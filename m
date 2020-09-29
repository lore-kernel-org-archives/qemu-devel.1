Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D626DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56AA8208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AA8208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN5h8-00077w-BQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kN5g8-0006V7-6r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:47:44 -0400
Resent-Date: Mon, 28 Sep 2020 22:47:44 -0400
Resent-Message-Id: <E1kN5g8-0006V7-6r@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kN5g4-0003gk-49
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601347591; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W3/nsRKrPTGrOjSyK8bT9viIaZPqfqaynyS/52eR4CnJFncn84p8Rg92cfQFzBr9cjfXdCQ77m6OU5LEks/Ae0eAkDm3kAkQIXC/vK0DIq9TdWOSfnX6rtvTDx8r4tM7t7C0Qdp5jxtm6yEmH3NMoXgn05zajsNIa/U461CYHIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601347591;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=w9YsU8avDMJx6Is14jSeE3gki5K9yuKQIDCjl2DfTLQ=; 
 b=eBluQTcyWERCAVVzGFL8kgX/emyzshitiLSdAyfj9bqktiZ3IJ+LXdLCtbi9MMFyRM+DwOVpHUgT37pRstY3+ONnAekuup4sceYDmWyQRxepBOD8/baA2ZrFXWsmTsNqaAT9hXV6+Iy3abxMRf2Dvz28yBYT0VVhWIk7MTNwhPQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601347589489373.61698103479785;
 Mon, 28 Sep 2020 19:46:29 -0700 (PDT)
Subject: Re: [PATCH 00/16] hw/mips: Set CPU frequency
Message-ID: <160134758680.17704.16181427169478621258@66eaa9a8a123>
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Mon, 28 Sep 2020 19:46:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 21:12:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: damien.hedde@greensocs.com, zltjiangshi@gmail.com,
 aleksandar.rikalo@syrmia.com, ehabkost@redhat.com, paulburton@kernel.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 f4bug@amsat.org, aleksandar.qemu.devel@gmail.com, hpoussin@reactos.org,
 crosa@redhat.com, chenhc@lemote.com, philmd@redhat.com, aurelien@aurel32.net,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyODE3MTUzOS43ODgz
MDktMS1mNGJ1Z0BhbXNhdC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQyBsaW5rZXIgZm9yIHRoZSBob3N0
IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhvc3QgbWFjaGluZSBjcHUgZmFtaWx5OiB4ODZf
NjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWlsZDoxMDogV0FSTklO
RzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNv
bXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dy
YW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0
aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tCnFlbXUt
c3lzdGVtLWFhcmNoNjQ6IGZhbGxpbmcgYmFjayB0byB0Y2cKc29ja2V0X2FjY2VwdCBmYWlsZWQ6
IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlCioqCkVSUk9SOi4uL3NyYy90ZXN0cy9x
dGVzdC9saWJxdGVzdC5jOjMwMTpxdGVzdF9pbml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNz
ZXJ0aW9uIGZhaWxlZDogKHMtPmZkID49IDAgJiYgcy0+cW1wX2ZkID49IDApCi4uL3NyYy90ZXN0
cy9xdGVzdC9saWJxdGVzdC5jOjE2Njoga2lsbF9xZW11KCkgdHJpZWQgdG8gdGVybWluYXRlIFFF
TVUgcHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhwZWN0ZWQgMCkKICBU
RVNUICAgIGlvdGVzdC1xY293MjogMDEzCkVSUk9SIHF0ZXN0LXg4Nl82NDogcHhlLXRlc3QgLSBC
YWlsIG91dCEgRVJST1I6Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2lu
aXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAm
JiBzLT5xbXBfZmQgPj0gMCkKbWFrZTogKioqIFtydW4tdGVzdC0xMTBdIEVycm9yIDEKbWFrZTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KCkxvb2tpbmcgZm9yIGV4cGVjdGVk
IGZpbGUgJ3Rlc3RzL2RhdGEvYWNwaS92aXJ0L0ZBQ1AubnVtYW1lbScKLS0tCiAgICByYWlzZSBD
YWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NF
cnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1ybScsICct
LWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZTJjZGQ0NjNlZjhhNGMyZjliOTE0M2U2
OWQ4YWM0MzcnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29u
ZmluZWQnLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRT
PScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9X
X0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21l
L3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTlkbG43ZTB2L3NyYy9kb2NrZXItc3Jj
LjIwMjAtMDktMjgtMjIuMjcuMzYuMTEyNjk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2Vu
dG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16
ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5j
ZS51dWlkPWUyY2RkNDYzZWY4YTRjMmY5YjkxNDNlNjlkOGFjNDM3Cm1ha2VbMV06ICoqKiBbZG9j
a2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLTlkbG43ZTB2L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3Qt
cXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxOG00OS42NzhzCnVzZXIgICAgMG0xMy43
NTZzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDkyODE3MTUzOS43ODgzMDktMS1mNGJ1Z0BhbXNhdC5vcmcvdGVzdGluZy5kb2NrZXIt
cXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

