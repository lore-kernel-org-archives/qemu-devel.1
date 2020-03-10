Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8E4C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 04:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1076724655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 04:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1076724655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBWW3-0006kd-8n
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 00:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jBWVV-0006MA-HZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 00:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jBWVU-0006Vc-HQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 00:28:41 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:42262)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jBWVU-0006Qg-9X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 00:28:40 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 66366E5A40;
 Tue, 10 Mar 2020 13:28:37 +0900 (JST)
Received: from www.ysato.name (localhost [IPv6:::1])
 by sakura.ysato.name (Postfix) with ESMTPA id EBDC41C0DCD;
 Tue, 10 Mar 2020 13:28:36 +0900 (JST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 10 Mar 2020 13:28:36 +0900
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] docs: Add RX target.
In-Reply-To: <e6ccf136-cf93-865d-31bb-4463b65416a9@redhat.com>
References: <20200308130637.37651-1-ysato@users.sourceforge.jp>
 <e6ccf136-cf93-865d-31bb-4463b65416a9@redhat.com>
Message-ID: <b075c69c2528772f9f047baba7adc368@users.sourceforge.jp>
X-Sender: ysato@users.sourceforge.jp
User-Agent: Roundcube Webmail/1.3.10
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.15
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

2020-03-10 00:07 =E3=81=AB Eric Blake =E3=81=95=E3=82=93=E3=81=AF=E6=9B=B8=
=E3=81=8D=E3=81=BE=E3=81=97=E3=81=9F:
> On 3/8/20 8:06 AM, Yoshinori Sato wrote:
>> Add rx-virt target specificaion document.
>=20
> specification
>=20
>>=20
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>> ---
>>   docs/system/target-rx.rst | 35 +++++++++++++++++++++++++++++++++++
>>   docs/system/targets.rst   |  1 +
>>   2 files changed, 36 insertions(+)
>>   create mode 100644 docs/system/target-rx.rst
>>=20
>> diff --git a/docs/system/target-rx.rst b/docs/system/target-rx.rst
>> new file mode 100644
>> index 0000000000..8540fd5218
>> --- /dev/null
>> +++ b/docs/system/target-rx.rst
>> @@ -0,0 +1,35 @@
>> +.. _RX-System-emulator:
>> +
>> +RX System emulator
>> +--------------------
>> +
>> +Use the executable ``qemu-system-rx`` to simulate a Virtual RX=20
>> target.
>> +This target emulated following devices.
>=20
> s/emulated/emulates the/
>=20

OK. I'll fix it.

>=20
>> +++ b/docs/system/targets.rst
>> @@ -17,3 +17,4 @@ Contents:
>>      target-arm
>>      target-m68k
>>      target-xtensa
>> +   target-rx
>=20
> Is it worth keeping this list alphabetically sorted?

It was not in alphabetical order, it was added at the last. Is it better=20
to arrange in alphabetical order?

---
Yoshinori Sato

