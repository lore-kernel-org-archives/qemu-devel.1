Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F52AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA267206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA267206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XoR-00063p-Hd
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1i2XnV-0005To-7B
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1i2XnT-0008AL-UL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:29:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37136)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1i2XnT-00086M-NX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:29:51 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id CE11454006A;
 Tue, 27 Aug 2019 12:29:45 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>,
 "'Richard Henderson'" <richard.henderson@linaro.org>
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-9-mrolnik@gmail.com> <87mufwz3e0.fsf@linaro.org>
 <6c7f5897-e7ed-b5f3-f167-78073a9e5b67@linaro.org> <87r25755a7.fsf@linaro.org>
In-Reply-To: <87r25755a7.fsf@linaro.org>
Date: Tue, 27 Aug 2019 12:29:43 +0300
Message-ID: <001b01d55cb9$f5f88df0$e1e9a9d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: ru
Thread-Index: AdVcuVo9Scz5SpLqTYKLFOUrX20piAAAHIhA
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [PATCH v29 8/8] target/avr: Add tests
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
Cc: imammedo@redhat.com, thuth@redhat.com, 'Michael Rolnik' <mrolnik@gmail.com>,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Richard Henderson <richard.henderson@linaro.org> writes:
>=20
> > On 8/26/19 2:23 AM, Alex Benn=C3=A9e wrote:
> >> Are there any compilers available so we can add the multiarch tests =
to "check-tcg"?
> >
> > Debian has a gcc-avr package.
>=20
> Looking at the bios "bytes" it should be easy enough to do a simple
> serial based test. We can add it after it's merged though... is it =
ready
> to go yet?

I tried running this series with ASCIITable example from Arduino IDE.
Everything worked and I've got an ASCII table in the console.

Pavel Dovgalyuk


