Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 01:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0654F20673
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 01:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ui61B06t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0654F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCZOZ-0006a6-1I
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 21:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iCZNi-00064J-TD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iCZNd-0003Pq-Sv
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:12:41 -0400
Received: from smtpbg513.qq.com ([203.205.250.40]:47867 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iCZNa-0003IZ-LD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569287121;
 bh=6tx5P7ZwWuAUd4k5SsjMpR4U4XwANXvsB0cFnIPaGa0=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=Ui61B06t2OlK0EEPyqFoLqywE3MjseaH2vI55rU/yC9JawZ3c2lmQRkR1ryZwj7Vl
 2MwzeS/3YFcCGby4+V3E2JNNvWJVdlQiEcA6TpKc7V6vyMQ0ITZKew9jcshT9Dj0qB
 Oiq6E4koIJHfzWEOQfAjRfahD0b9A96GNcAEOBSA=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <CAFEAcA8+bK0UyUWbXOiutyQZkCMSB_0Be7pJLKONSpA3CV9Pbw@mail.gmail.com>
References: <tencent_28AAA62B694825C348B1DF49@qq.com>
 <CAFEAcA8+bK0UyUWbXOiutyQZkCMSB_0Be7pJLKONSpA3CV9Pbw@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569287121t643992
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?=" <peter.maydell@linaro.org>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 24 Sep 2019 09:05:20 +0800
X-Priority: 3
Message-ID: <tencent_0084E0586ADE9B2D30176A53@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 1964736263
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 24 Sep 2019 09:05:21 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.40
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
Cc: =?ISO-8859-1?B?UGhpbGlwcGUgTWF0aGlldS1EYXVk?= <philmd@redhat.com>,
 =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>,
 =?ISO-8859-1?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?= <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBDYW4geW91IHJ1biBRRU1VIHdpdGggc29tZSBkZWJ1Z2dpbmcgb3B0aW9uczoKCj4gcWVt
dS1taXBzZWwgLWQgaW5fYXNtLGV4ZWMsY3B1LHVuaW1wLGd1ZXN0X2Vycm9ycyxub2NoYWlu
IC1EIGRlYnVnLmxvZwo+IC1zaW5nbGVzdGVwIHRlc3QKCj4gYW5kIHRoZW4gcHV0IHRoZSBy
ZXN1bHRpbmcgZGVidWcubG9nIHNvbWV3aGVyZSB3ZSBjYW4gZ2V0IGl0Pwo+IChpdCdsbCBw
cm9iYWJseSBiZSBxdWl0ZSBsYXJnZSkKClRoZSBsb2dnaW5nIG9ubHkgc2hvd3MgdGhpcyBs
aXR0bGUgaW5mb3JtYXRpb24uIEl0IHNlZW1zIGxpa2Ugb25seSAtZCBjcHUgd29ya3MgZm9y
IGEgc2hvcnQgd2hpbGUuCgotLS0tLS0tLS0tLS0tLS0tCklOOiBtYWluCjB4MDA0MDAwOTA6
ICBib3ZjCXNwLHNwLDB4NDAwMDE0CgpUcmFjZSAwOiAweDU2M2I3NTBmNzEwMCBbMDAwMDAw
MDAvMDA0MDAwOTAvMHhlMl0gbWFpbgpwYz0weDAwNDAwMDkwIEhJPTB4MDAwMDAwMDAgTE89
MHgwMDAwMDAwMCBkcyAwMGUyIDAwMDAwMDAwIDAKR1BSMDA6IHIwIDAwMDAwMDAwIGF0IDAw
MDAwMDAwIHYwIDAwMDAwMDAwIHYxIDAwMDAwMDAwCkdQUjA0OiBhMCAwMDAwMDAwMCBhMSAw
MDAwMDAwMCBhMiAwMDAwMDAwMCBhMyAwMDAwMDAwMApHUFIwODogdDAgMDAwMDAwMDAgdDEg
MDAwMDAwMDAgdDIgMDAwMDAwMDAgdDMgMDAwMDAwMDAKR1BSMTI6IHQ0IDAwMDAwMDAwIHQ1
IDAwMDAwMDAwIHQ2IDAwMDAwMDAwIHQ3IDAwMDAwMDAwCkdQUjE2OiBzMCAwMDAwMDAwMCBz
MSAwMDAwMDAwMCBzMiAwMDAwMDAwMCBzMyAwMDAwMDAwMApHUFIyMDogczQgMDAwMDAwMDAg
czUgMDAwMDAwMDAgczYgMDAwMDAwMDAgczcgMDAwMDAwMDAKR1BSMjQ6IHQ4IDAwMDAwMDAw
IHQ5IDAwMDAwMDAwIGswIDAwMDAwMDAwIGsxIDAwMDAwMDAwCkdQUjI4OiBncCAwMDAwMDAw
MCBzcCA3ZmZmZjA5MCBzOCAwMDAwMDAwMCByYSAwMDAwMDAwMApDUDAgU3RhdHVzICAweDI0
MDAwMDEwIENhdXNlICAgMHgwMDAwMDAwMCBFUEMgICAgMHgwMDAwMDAwMAogICAgQ29uZmln
MCAweDgwMDAwNDgyIENvbmZpZzEgMHg5ZTE5MGM4ZiBMTEFkZHIgMHgwMDAwMDAwMDAwMDAw
MDAwCiAgICBDb25maWcyIDB4ODAwMDAwMDAgQ29uZmlnMyAweDAwMDAwMDAwCiAgICBDb25m
aWc0IDB4MDAwMDAwMDAgQ29uZmlnNSAweDAwMDAwMDAwCi0tLS0tLS0tLS0tLS0tLS0KSU46
IG1haW4KMHgwMDQwMDA5NDogIGRtdWx0LmcJemVybyxzcCxzOAoKVHJhY2UgMDogMHg1NjNi
NzUwZjcyNDAgWzAwMDAwMDAwLzAwNDAwMDk0LzB4ZTJdIG1haW4KcGM9MHgwMDQwMDA5NCBI
ST0weDAwMDAwMDAwIExPPTB4MDAwMDAwMDAgZHMgMDBlMiAwMDAwMDAwMCAwCkdQUjAwOiBy
MCAwMDAwMDAwMCBhdCAwMDAwMDAwMCB2MCAwMDAwMDAwMCB2MSAwMDAwMDAwMApHUFIwNDog
YTAgMDAwMDAwMDAgYTEgMDAwMDAwMDAgYTIgMDAwMDAwMDAgYTMgMDAwMDAwMDAKR1BSMDg6
IHQwIDAwMDAwMDAwIHQxIDAwMDAwMDAwIHQyIDAwMDAwMDAwIHQzIDAwMDAwMDAwCkdQUjEy
OiB0NCAwMDAwMDAwMCB0NSAwMDAwMDAwMCB0NiAwMDAwMDAwMCB0NyAwMDAwMDAwMApHUFIx
NjogczAgMDAwMDAwMDAgczEgMDAwMDAwMDAgczIgMDAwMDAwMDAgczMgMDAwMDAwMDAKR1BS
MjA6IHM0IDAwMDAwMDAwIHM1IDAwMDAwMDAwIHM2IDAwMDAwMDAwIHM3IDAwMDAwMDAwCkdQ
UjI0OiB0OCAwMDAwMDAwMCB0OSAwMDAwMDAwMCBrMCAwMDAwMDAwMCBrMSAwMDAwMDAwMApH
UFIyODogZ3AgMDAwMDAwMDAgc3AgN2ZmZmYwNzAgczggMDAwMDAwMDAgcmEgMDAwMDAwMDAK
Q1AwIFN0YXR1cyAgMHgyNDAwMDAxMCBDYXVzZSAgIDB4MDAwMDAwMDAgRVBDICAgIDB4MDAw
MDAwMDAKICAgIENvbmZpZzAgMHg4MDAwMDQ4MiBDb25maWcxIDB4OWUxOTBjOGYgTExBZGRy
IDB4MDAwMDAwMDAwMDAwMDAwMAogICAgQ29uZmlnMiAweDgwMDAwMDAwIENvbmZpZzMgMHgw
MDAwMDAwMAogICAgQ29uZmlnNCAweDAwMDAwMDAwIENvbmZpZzUgMHgwMDAwMDAwMA==


