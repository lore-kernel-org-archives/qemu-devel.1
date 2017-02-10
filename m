Received: from eggs.gnu.org ([2001:4830:134:3::10]:42747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccAfz-0006Zw-57
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccAfv-0000Ti-15
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:51:47 -0500
References: <1486649607-31248-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8U9Y9X87o_79ogmo7cY3-a3o=80GhtWyv74UkNE2MjSg@mail.gmail.com>
	<20170209231517.GA27610@umbus.fritz.box>
	<CAFEAcA8XvwRdYZp9v4radG2unWk3VAyuKL4asG+9BTVzU+=1vg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <405da0ee-6951-dc4c-be0d-dabcdf9c0cc5@redhat.com>
Date: Fri, 10 Feb 2017 13:51:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XvwRdYZp9v4radG2unWk3VAyuKL4asG+9BTVzU+=1vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/prom-env: Ease time-out problems on
 slow hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 10.02.2017 13:48, Peter Maydell wrote:
> On 9 February 2017 at 23:15, David Gibson <david@gibson.dropbear.id.au> wrote:
>> On Thu, Feb 09, 2017 at 02:37:26PM +0000, Peter Maydell wrote:
>>> On 9 February 2017 at 14:13, Thomas Huth <thuth@redhat.com> wrote:
>>>> Peter Maydell recently ran into time-out problems with the
>>>> prom-env test on a rather slow ARM board. To tackle this issue,
>>>> we can speed up the test by running QEMU with "-nodefaults" here,
>>>> so that SLOF has less devices to scan during boot, and by using
>>>> the "nvramrc" environment variable instead of "boot-command",
>>>> since this variable is evaluated earlier in the boot process.
>>>> And to be really sure that we do not face such time out problems
>>>> again, let's also increase the time out value from 100s to 120s
>>>> instead.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  tests/prom-env-test.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> Seems to cut the elapsed realtime for the pseries board
>>> down from about 90s to 55s. Hopefully that plus the
>>> boosted timeout will help.
>>>
>>> Tested-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Peter, will you merge this directly, or do you want me to take it
>> through my tree?
> 
> I just did a full test with the intention of merging it into
> master, and I noticed it causes new warnings on the sparc
> prom tests:
> 
> TEST: tests/prom-env-test... (pid=17171)
>   /sparc/prom-env/SPARCbook:
> Warning: nic
>  lance.0 has no peer
> OK
>   /sparc/prom-env/Voyager:
> Warning: nic
>  lance.0 has no peer
> OK
>   /sparc/prom-env/SS-20:
> Warning: nic
>  lance.0 has no peer
> OK
> PASS: tests/prom-env-test
> 
> So it needs some tweaking, I think.

D'oh, sorry, I should have checked that ... it's likely of the new
"-nodefaults" flag ... I'll have a look.

 Thomas
