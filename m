Received: from eggs.gnu.org ([2001:4830:134:3::10]:43777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1cfVxP-0005fc-O8
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 13:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1cfVxL-0007iB-N2
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 13:11:35 -0500
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
	<CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
	<CAFEAcA8X1qvweDHBWQjZwH68xWdn4K+Wfqv0yRhjM5QCxd=VBA@mail.gmail.com>
	<1e2962d7-1b50-9543-3e1d-9c388d4167c3@gmail.com>
	<CAFEAcA-9w-bKJY=gb9Bo9c45vLParh8zVwit3t4GPHqTJZxnJw@mail.gmail.com>
From: Michael Davidsaver <mdavidsaver@gmail.com>
Message-ID: <e4c435ec-a0fa-40a6-a20a-88ac2fa2cffa@gmail.com>
Date: Sun, 19 Feb 2017 13:10:44 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9w-bKJY=gb9Bo9c45vLParh8zVwit3t4GPHqTJZxnJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Liviu Ionescu <ilg@livius.net>

On 02/18/2017 01:38 PM, Peter Maydell wrote:
> On 18 February 2017 at 17:45, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
>> On 02/16/2017 09:11 AM, Peter Maydell wrote:
>>> I haven't actually checked real hardware behaviour, but I think
>>> we can fairly safely implement this as not checking the IPSR
>>> exception field. (We might as well go with the "reads 1 in
>>> handler mode" choice of UNKNOWN that the M3 documents, though.)
>>
>> For what it's worth, I dug up my TI TM4C1294 eval board and re-ran
>> test10.c [1] which is designed to probe this behavior by nesting
>> exceptions PendSV within SVC.  RETTOBASE is 0x800 in ICSR.
> 
> That's a Cortex-M4. From the test it looks like it
> has a different choice of UNKNOWN behaviour for
> the value in Handler mode, so real code in the field
> isn't going to be relying on that and it doesn't
> matter what we choose.

I've been away from arm/m for too long to claim any detailed knowledge
of the documentation.  My intent here is only to provide a data point w/
real hardware, not to interpret it.

> I don't think the test looks at the "what happens if the
> exception in the IPSR exception field isn't actually
> active" case, right?

Correct.
