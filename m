Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA9BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AB2208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AB2208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46BV-0002y0-Mz
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j46Aw-0002Vf-9q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j46Au-0003U1-Nm
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:56:45 -0500
Resent-Date: Tue, 18 Feb 2020 11:56:45 -0500
Resent-Message-Id: <E1j46Au-0003U1-Nm@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j46Au-0003TC-Fy
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:56:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582044984; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B5WIwq8BMSN2XFAB6cj7t1cp9ThG8HcZOpulk/Lax9xlSYIpn1nQJXaCD+fjth5b19QQB1PCtqmwIsvzByU8yI4myW8q9yYEZ1q+AsmTJiqEeQ9Lw0sTOW0/x/tbXeeYXEZzGNUoRpoJ13norZW7V9hD1/HJvX9SqRIi66cGWnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582044984;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IWA3fRvBQd88MJbWury/cdTMguSSAhsrpbhrocUey24=; 
 b=Zw4dTU0YvFOJSG99IHtSp4z6kLjt6NgxbOFo2LV/0Zpd3dcJUFPBtEzBUpHm0+4FK0CsflOBhVQ0lzoKafaqbaeJ13Z4na+dPhg0HEbgBPpIpbkinwZDfAJ5iH6heUeurk2ZpGYqMPaIRQ4xREuOPO3i9IPIq3pRnykVfzs++wg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582044980660311.482906912614;
 Tue, 18 Feb 2020 08:56:20 -0800 (PST)
In-Reply-To: <20200218144415.94722-1-vkuznets@redhat.com>
Subject: Re: [PATCH RFC] target/i386: filter out VMX_PIN_BASED_POSTED_INTR
 when enabling SynIC
Message-ID: <158204497899.18888.4612758973157728331@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vkuznets@redhat.com
Date: Tue, 18 Feb 2020 08:56:20 -0800 (PST)
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, liran.alon@oracle.com, rkagan@virtuozzo.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxODE0NDQxNS45NDcy
Mi0xLXZrdXpuZXRzQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKLS4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4KKy4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi5FLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4KKz09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KK0VSUk9SOiB0ZXN0X3BhdXNlIChfX21haW5fXy5UZXN0U2luZ2xlQmxvY2tk
ZXYpCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCitUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Cisg
IEZpbGUgIjA0MSIsIGxpbmUgMTA2LCBpbiB0ZXN0X3BhdXNlCi0tLQogUmFuIDkxIHRlc3RzCiAK
LU9LCitGQUlMRUQgKGVycm9ycz0xKQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwNDIKICBURVNU
ICAgIGlvdGVzdC1xY293MjogMDQzCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0NgotLS0KICBU
RVNUICAgIGlvdGVzdC1xY293MjogMjgzCkZhaWx1cmVzOiAwNDEKRmFpbGVkIDEgb2YgMTE2IGlv
dGVzdHMKbWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3IgMQpUcmFj
ZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9j
a2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1kMTAyYzFjMjEzZjk0ODZkYWE0ZGRi
OWZmNjg2NDA0YicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICct
dicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2Nj
YWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13anR1dG9vNy9zcmMv
ZG9ja2VyLXNyYy4yMDIwLTAyLTE4LTExLjQzLjQxLjExMjIzOi92YXIvdG1wL3FlbXU6eixybycs
ICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFl
bXUuaW5zdGFuY2UudXVpZD1kMTAyYzFjMjEzZjk0ODZkYWE0ZGRiOWZmNjg2NDA0YgptYWtlWzFd
OiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13anR1dG9vNy9zcmMnCm1ha2U6ICoqKiBbZG9ja2Vy
LXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTJtMzguNjYycwp1c2Vy
ICAgIDBtOC44MjVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDIxODE0NDQxNS45NDcyMi0xLXZrdXpuZXRzQHJlZGhhdC5jb20vdGVz
dGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

