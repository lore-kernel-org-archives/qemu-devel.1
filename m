Received: from eggs.gnu.org ([208.118.235.92]:51270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXmLZ-0004t1-9i
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXmLW-0004Mo-MR
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:13:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gXmLW-0004MI-Bf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:13:34 -0500
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <e30b0e93-fffc-4081-66e1-df257015d14d@redhat.com>
Date: Fri, 14 Dec 2018 10:13:26 -0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


On 12/13/2018 04:01 PM, Peter Maydell wrote:
> On Thu, 13 Dec 2018 at 17:57, Wainer dos Santos Moschetta
> <wainersm@redhat.com> wrote:
>> Eduardo Habkost pointed out a malformed block of comments on my
>> patch [1] that I had ran checkpatch.pl and no warn/error was
>> reported. Then I realized the script does not catch such as
>> case (or it had a bug).
>>
>> It turns out that checkpatch.pl does not parse comment blocks (If I understood
>> its code correctly...). So I implemented a checker that warns about:
>> 1. block doesn't begin on its own line.
>> Example:
>>    /* blah blah
>>     * and blah blah
>>     */
> I sent a patch to do this a little while back:
>   https://patchwork.kernel.org/patch/10561557/

Self-NACK my patch in favor of that, which has additional checks (e.g. * 
alignment).

>
> It didn't get applied because Paolo disagreed with having
> our tools enforcing what our style guide says.
>
> Personally I think we should just commit my patch, and then
> we can stop having people manually pointing out where
> submitters' patches don't match CODING_STYLE.

I am afraid that I can't give a firm option on this topic because it 
precedes my existence in this community, regardless I tend to agreed on 
Peter's reasoning.

Thanks!

- Wainer

T

>
> thanks
> -- PMM
