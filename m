Received: from eggs.gnu.org ([2001:4830:134:3::10]:48870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g02Eq-0007n1-EN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 06:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g02Em-0000LA-TG
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 06:19:12 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g02Em-0000Kv-CQ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 06:19:08 -0400
Received: by mail-wm0-x243.google.com with SMTP id j192-v6so1765027wmj.1
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 03:19:07 -0700 (PDT)
References: <20180911140631.18481-1-alex.bennee@linaro.org>
	<20180911140631.18481-4-alex.bennee@linaro.org>
	<8346c1bb-9cb6-4c08-66a2-b5e5a31903d4@vivier.eu>
	<f28e18ac-b883-e97e-1c0a-599dd154cf60@denx.de>
	<87tvmwax7m.fsf@linaro.org>
	<8c9a56ac-5b3f-cbe3-49ce-e79314b1c4db@denx.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8c9a56ac-5b3f-cbe3-49ce-e79314b1c4db@denx.de>
Date: Wed, 12 Sep 2018 11:19:05 +0100
Message-ID: <87pnxjauhy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] linux-user/nios2: bump min uname
 to 4.16.0 [!HACK]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, 1791796@bugs.launchpad.net, thuth@redhat.com, Riku Voipio <riku.voipio@iki.fi>, Chris Wulff <crwulff@gmail.com>


Marek Vasut <marex@denx.de> writes:

> On 09/11/2018 05:08 PM, Alex Benn=C3=A9e wrote:
>>
>> Marek Vasut <marex@denx.de> writes:
>>
>>> On 09/11/2018 04:14 PM, Laurent Vivier wrote:
>>>> Le 11/09/2018 =C3=A0 16:06, Alex Benn=C3=A9e a =C3=A9crit:
<snip>
>>
>> I don't think so - it's an artefact of the way the buildroot toolchain
>> is built. But the real question which I address in the cover letter is
>> does nios2-linux-user get much use? I tried enabled tests/tcg for it and
>> it fails rather badly.
>
> I used it around 2.10 and it worked for me.

I've just build 2.10.2 (with a patch for memfd and this one) and get the
same failures on the tcg/tests tests. What testing where you running?

--
Alex Benn=C3=A9e
