Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5nW-0003mc-Dm
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:28:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5nQ-0003yl-RU
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:28:18 -0500
Received: from xes-mad.com ([216.165.139.220]:11021 helo=mail.xes-mad.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asierra@xes-inc.com>) id 1eC5nQ-0003yY-Mx
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:28:12 -0500
Date: Tue, 7 Nov 2017 09:28:12 -0600 (CST)
From: Aaron Sierra <asierra@xes-inc.com>
Message-ID: <1772594370.198661.1510068492369.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <CAFEAcA_keEj29AzE9BbnRqXORuwSdSQ4M=0hoUfzPdHwiiWBrA@mail.gmail.com>
References: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
	<c97adeea-32ee-269c-2a88-b011e8a294fa@vivier.eu>
	<1997067362.187762.1510068032954.JavaMail.zimbra@xes-inc.com>
	<CAFEAcA_keEj29AzE9BbnRqXORuwSdSQ4M=0hoUfzPdHwiiWBrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support explicit targets for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>

----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> Sent: Tuesday, November 7, 2017 9:24:35 AM

> On 7 November 2017 at 15:20, Aaron Sierra <asierra@xes-inc.com> wrote:
>> I had that thought, too, as being the cleanest and simplest to implement,
>> but it didn't work out as a practical solution. Having execution depend
>> on the name of the file would require a lot of tuning of magics, masks,
>> and interpreters in /proc/sys/fs/binfmt_misc to get the behavior that I
>> depend on. It would require one entry per binary.
>>
>> With the implementation that I've proposed, I only need two fairly generic
>> entries (ppc and ppc64) stock from Ubuntu's qemu-user-static package.
>> With Docker it's trivial to bind <any_path>/qemu-ppc.e500mc to
>> /usr/bin/qemu-ppc-static within the container. Which gives me complete
>> control over how the container is emulated.
> 
> If you don't need the binfmt-invokes-the-right-QEMU magic to work
> out of the box, why can't you just use a wrapper script here?

Because there is no mechanism to evaluate a script within the fully PowerPC
container without emulation being available right from the very first
instruction.

I _do_ depend on the right QEMU binary being correctly mapped before
launching the container.

-Aaron S.

> thanks
> -- PMM
