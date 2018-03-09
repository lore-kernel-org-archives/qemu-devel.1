Received: from eggs.gnu.org ([2001:4830:134:3::10]:43773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1euFmN-0001ds-Nv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1euFmJ-0002m6-Qj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:01:39 -0500
Date: Fri, 9 Mar 2018 12:01:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_64nFSt3+0-BAyaZZ+yBQFiFTRTK88xWb5eE7yYJnCKw@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1803091200050.92955@zero.eik.bme.hu>
References: <20180308111305.C9F56745707@zero.eik.bme.hu>
	<20180308144845.0D7647456CD@zero.eik.bme.hu>
	<20180308234446.GQ3083@umbus.fritz.box>
	<20180309030541.GU3083@umbus.fritz.box>
	<CAFEAcA_64nFSt3+0-BAyaZZ+yBQFiFTRTK88xWb5eE7yYJnCKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2] ppc440_pcix: Change some error_report
 to qemu_log_mask(LOG_UNIMP, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 9 Mar 2018, Peter Maydell wrote:
> On 9 March 2018 at 03:05, David Gibson <david@gibson.dropbear.id.au> wrote:
>> On Fri, Mar 09, 2018 at 10:44:46AM +1100, David Gibson wrote:
>>> On Thu, Mar 08, 2018 at 12:08:08PM +0100, BALATON Zoltan wrote:
>>>> Using log unimp is more appropriate for these messages and this also
>>>> silences them by default so they won't clobber make check output when
>>>> tests are added for this board.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Applied, thanks.
>>
>> Wait.. I've taken it out again.  Under some configurations (exercised
>> by Travis) qemu_log_mask() is undeclared here you're using it.  See
>> https://travis-ci.org/dgibson/qemu/jobs/351093986 for some more
>> information.
>
> Ah, that one again. There's a patch in Stefan's tracing tree
> that makes that a fails-everywhere rather than only-some-configs,
> but he hasn't done the pullreq for 2.12 yet I think.
>
> You need a #include "qemu/log.h".

OK, thanks. Should I send a v3 with this or can you patch up when applying 
v2?

Regards,
BALATON Zoltan
