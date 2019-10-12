Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C5C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 14:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB272087E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 14:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB272087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJI88-0002Dn-Te
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iJI7D-0001bf-G7
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iJI7C-0001Mu-EQ
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:11:27 -0400
Received: from mail.ispras.ru ([83.149.199.45]:59938)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iJI7C-0001Lv-7O
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:11:26 -0400
Received: from [192.168.43.94] (unknown [83.220.227.50])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0AE0D54006A;
 Sat, 12 Oct 2019 17:11:21 +0300 (MSK)
Subject: Re: [Qemu-devel] [PATCH v29 8/8] target/avr: Add tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?B?J0FsZXggQmVubsOpZSc=?= <alex.bennee@linaro.org>,
 'Richard Henderson' <richard.henderson@linaro.org>
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-9-mrolnik@gmail.com> <87mufwz3e0.fsf@linaro.org>
 <6c7f5897-e7ed-b5f3-f167-78073a9e5b67@linaro.org> <87r25755a7.fsf@linaro.org>
 <001b01d55cb9$f5f88df0$e1e9a9d0$@ru>
 <0e57fb85-200d-de10-331f-977c9f4246ed@redhat.com>
From: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <8c52a0a1-3595-f48c-f64c-21ab3b18b471@ispras.ru>
Date: Sat, 12 Oct 2019 17:11:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0e57fb85-200d-de10-331f-977c9f4246ed@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12.10.2019 10:17, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Pavel,
>
> On 8/27/19 11:29 AM, Pavel Dovgalyuk wrote:
>>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> On 8/26/19 2:23 AM, Alex Benn=C3=A9e wrote:
>>>>> Are there any compilers available so we can add the multiarch=20
>>>>> tests to "check-tcg"?
>>>>
>>>> Debian has a gcc-avr package.
>>>
>>> Looking at the bios "bytes" it should be easy enough to do a simple
>>> serial based test. We can add it after it's merged though... is it=20
>>> ready
>>> to go yet?
>>
>> I tried running this series with ASCIITable example from Arduino IDE.
>> Everything worked and I've got an ASCII table in the console.
>
> Does that mean we can add your Tested-by tag?


Right.


Pavel Dovgalyuk


