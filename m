Received: from eggs.gnu.org ([2001:4830:134:3::10]:36889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffSLX-0008UK-9g
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffSLU-0001Tn-76
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:57:03 -0400
Received: from smtp53.i.mail.ru ([94.100.177.113]:57854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1ffSLT-0001Sc-Rh
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:57:00 -0400
References: <20180713103059.12539-1-jusual@mail.ru>
	<CAFEAcA9zzSu86Ra3Cgs_V8NYnC+vYCujE5vBkqtnX6AWFk-+LQ@mail.gmail.com>
	<42c6cde3-2b82-f1e8-f893-ce19849f9e46@mail.ru>
	<CAFEAcA-1LHmcwQFy7tMEzVoNgELpuaJDPhOpi74h0=WyDeiqJQ@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <8f55a8de-1599-4567-6e63-f2c048eae894@mail.ru>
Date: Tue, 17 Jul 2018 18:56:49 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-1LHmcwQFy7tMEzVoNgELpuaJDPhOpi74h0=WyDeiqJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arm: Add ARMv6-M programmer's model support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 17.07.2018 16:49, Peter Maydell wrote:
> On 17 July 2018 at 14:42, Julia Suvorova <jusual@mail.ru> wrote:
>> On 17.07.2018 16:09, Peter Maydell wrote:
>>> This should be outside the "if v8" if(), because you also want it for v6M
>>> (giving you the v6M CCR value of STKALIGN and UNALIGN_TRP set and all
>>> other bits clear).
>>
>>
>> This is the main problem. If I understand correctly, bits[4:8] also
>> should be read-as-one (Table B3-4 ARMv6-M ARM). And I've already set them
>> (with UNALIGN_TRP) before for v6m.
> 
> That is very odd. In table B3-10 bits [8:4] are documented as
> "reserved" which usually means reads-as-zero. I wonder if table
> B3-4 has a docs error and should really be saying
> "bits [9,3] = 0b11" rather than specifying [9:3]" ?
> 
> Do you have access to a real hardware Cortex-M0 which you can read
> the CCR value from ?

It's a docs error. CCR is 520 (0b1000001000) on real micro:bit.

Best regards, Julia Suvorova.
