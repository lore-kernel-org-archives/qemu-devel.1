Received: from eggs.gnu.org ([2001:4830:134:3::10]:38569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKPr1-0003LM-4H
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKPqz-0000It-2t
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:34:51 -0500
Date: Wed, 7 Nov 2018 13:34:22 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181107153422.GY12503@habkost.net>
References: <20181031003120.26771-1-ehabkost@redhat.com>
	<20181031003120.26771-12-ehabkost@redhat.com>
	<CAFEAcA_ScL828ya7P_5=HMx=vbxo=jK4047nAbmb9Ep=6r=2og@mail.gmail.com>
	<f1bd429f-198a-ee27-9184-636692332816@redhat.com>
	<20181106141302.GP12503@habkost.net>
	<87efbxxw1c.fsf@dusky.pond.sub.org>
	<20181107124910.GX12503@habkost.net>
	<CAFEAcA_no6zJ0MG4Af-R0bTi5B9U1M+uArVtJUqkY89iuYgicQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_no6zJ0MG4Af-R0bTi5B9U1M+uArVtJUqkY89iuYgicQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Fix Python 3 detection
 on older GNU make versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Wed, Nov 07, 2018 at 01:45:35PM +0000, Peter Maydell wrote:
> On 7 November 2018 at 12:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Now, why do we need --with-python, and why do we need to use
> > $(PYTHON) when running tests?  If somebody wants to use a
> > different Python binary when running tests, they can already use
> > $PATH for that.
> >
> > (That's the same argument I used for iotests a while ago:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg566631.html)
> 
> I'm not a great fan of requiring the user to mess with their PATH
> to get configure to work. Also, the first python on the path
> might be the wrong one, and we don't pass PATH from configure
> to make so you end up having to make sure you specify it
> right in both places.

You're assuming that this will actually require some people to
mess with their $PATH because they currently don't have Python on
their $PATH.  I don't see any evidence that this is expected to
happen.  Do you?

> 
> Plus we already have --with-python, so if you want to drop
> it you need to deprecate it first, and you need a justification
> that's strong enough to outweigh breaking users' existing
> build/packaging setups and scripts...

I would really like to remove the option as soon as we start
requiring Python 3.  Let's stop reinventing solutions to problems
already addressed by PEP 394.

-- 
Eduardo
