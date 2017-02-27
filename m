Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciHLf-0005wM-CF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ciHLc-0008Q9-85
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:12:03 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ciHLb-0008PS-W1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:12:00 -0500
Received: by mail-wr0-x22e.google.com with SMTP id u108so17656889wrb.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 01:11:58 -0800 (PST)
References: <20170224112109.3147-1-alex.bennee@linaro.org>
	<CAFEAcA8E6L7Ad1+P_YRJo4YMyQn=jGQRS6ybGMKjLS=vEHq0ZA@mail.gmail.com>
	<8e8e8536-8d01-7c26-ea0d-9d4b8ba5c42e@de.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8e8e8536-8d01-7c26-ea0d-9d4b8ba5c42e@de.ibm.com>
Date: Mon, 27 Feb 2017 09:11:55 +0000
Message-ID: <87zih880bo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/24] MTTCG Base enabling patches with ARM
 enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Christian Borntraeger <borntraeger@de.ibm.com> writes:

> On 02/25/2017 10:14 PM, Peter Maydell wrote:
>> On 24 February 2017 at 11:20, Alex Bennée <alex.bennee@linaro.org> wrote:
>>> The following changes since commit 2d896b454a0e19ec4c1ddbb0e0b65b7e54fcedf3:
>>>
>>>   Revert "hw/mips: MIPS Boston board support" (2017-02-23 18:04:45 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/stsquad/qemu.git tags/pull-mttcg-240217-1
>>>
>>> for you to fetch changes up to ca759f9e387db87e1719911f019bc60c74be9ed8:
>>>
>>>   tcg: enable MTTCG by default for ARM on x86 hosts (2017-02-24 10:32:46 +0000)
>>>
>>> ----------------------------------------------------------------
>>> This is the MTTCG pull-request as posted yesterday.
>>>
>>> ----------------------------------------------------------------
>>
>> Applied, thanks.
>>
>> -- PMM
>>
>
> This seems to trigger
>
> /home/cborntra/REPOS/qemu/vl.c: In function ‘main’:
> /home/cborntra/REPOS/qemu/vl.c:3700:18: error: ‘QEMU_OPTION_accel’ undeclared (first use in this function)
>              case QEMU_OPTION_accel:
>                   ^~~~~~~~~~~~~~~~~
> /home/cborntra/REPOS/qemu/vl.c:3700:18: note: each undeclared identifier is reported only once for each function it appears in
>
>
> on s390.

Is this for softmmu compilation? I'll have a look but I'll have to set
up some s390 images to test so you might beat me to it if you have real
hardware around.

--
Alex Bennée
