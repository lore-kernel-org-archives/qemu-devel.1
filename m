Received: from eggs.gnu.org ([2001:4830:134:3::10]:41998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ftCVK-0000ws-Ps
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ftCVH-00082f-Kh
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:51:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ftCVH-000824-FJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:51:55 -0400
Date: Fri, 24 Aug 2018 21:51:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180824135151.GH31581@lemon.usersys.redhat.com>
References: <20180823112153.15279-1-peter.maydell@linaro.org>
	<20180823141155.GD6960@lemon.usersys.redhat.com>
	<CAFEAcA8okRmYDDAW2D_dq_VfQLowM1Uzhfm6KafeJFzLXBvt9A@mail.gmail.com>
	<CAFEAcA82wxTeHiPkMKnO9XCDGYbtP1B9_HgZxJu+d6=XKdx+iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA82wxTeHiPkMKnO9XCDGYbtP1B9_HgZxJu+d6=XKdx+iw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Increase timeout waiting for VM
 to boot to 5 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, 08/24 13:45, Peter Maydell wrote:
> On 24 August 2018 at 13:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 23 August 2018 at 15:11, Fam Zheng <famz@redhat.com> wrote:
> >> On Thu, 08/23 12:21, Peter Maydell wrote:
> >>> The VM tests currently have a timeout of 2 minutes for trying
> >>> to connect to ssh. Since the guest VM has to boot from cold
> >>> to the point of accepting inbound ssh during this time, if the
> >>> host machine is heavily loaded it can spuriously time out.
> >>> Increase the timeout from 2 to 5 minutes.
> >>>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> Acked-by: Fam Zheng <famz@redhat.com>
> >>
> >> Again, please apply this yourself. :)
> >
> > Applied, thanks.
> 
> I'm still seeing the ssh login for a netbsd VM sometimes
> sit there apparently indefinitely. Is there some way to
> debug what the guest VM is actually doing when the
> log just sits there doing
> DEBUG:root:ssh_cmd: ssh -q -o StrictHostKeyChecking=no -o
> UserKnownHostsFile=/dev/null -o ConnectTimeout=1 -p 36947 -i
> /home/peter.maydell/qemu-netbsd/build/vm-test-g0SkVX.tmp/id_rsa
> qemu@127.0.0.1 exit 0
> DEBUG:root:ssh_cmd: ssh -q -o StrictHostKeyChecking=no -o
> UserKnownHostsFile=/dev/null -o ConnectTimeout=1 -p 36947 -i
> /home/peter.maydell/qemu-netbsd/build/vm-test-g0SkVX.tmp/id_rsa
> qemu@127.0.0.1 exit 0
> 
> (eg a capture of its terminal output) ?

I need to investigate into it. Sometimes I see the timeout too with V=1, but not
if I omit it (i.e. on DEBUG: lines are echoed).

Fam
