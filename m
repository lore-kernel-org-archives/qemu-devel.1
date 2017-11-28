Received: from eggs.gnu.org ([2001:4830:134:3::10]:55807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJcJq-0003gG-80
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJcJm-0006F7-96
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:36:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eJcJm-0006Ef-2q
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:36:42 -0500
Date: Tue, 28 Nov 2017 10:36:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128103632.48f11fba.cohuck@redhat.com>
In-Reply-To: <75400a80-c90c-8d8f-7823-f87c6e8a32d8@redhat.com>
References: <CAFEAcA-b9oDkPfZbntWfhWSv1HOnbUf75p_xB_tF74h_NBGPmw@mail.gmail.com>
	<791b0b92-a232-bf63-bd12-0e663c19175c@redhat.com>
	<75400a80-c90c-8d8f-7823-f87c6e8a32d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU Summit 2017: minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 28 Nov 2017 09:33:52 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 27.11.2017 23:03, John Snow wrote:
> > 
> > On 11/23/2017 11:31 AM, Peter Maydell wrote:  
> [...]
> >> Continuous Integration:
> >>  * Christian Borntraeger: qemu-iotests have broken a lot, they should be
> >>    run before patches are merged  
> > 
> > This, rather unfortunately, is a huge testing burden. I try to make sure
> > I do it for everything I submit, but for the volume of block patches it
> > really does rely CI. The more we add (to our pitifully sparse iotesting,
> > I might add) the longer it takes. Ensuring per-patch testing begins to
> > take prohibitively long.
> > 
> > Perhaps per-pull or per-merge becomes more feasible. Maybe if we do
> > implement a block-next amalgam we'd be able to batch our testing on a
> > weekly basis.  
> 
> I think you block-layer folks should do at least run the qemu-iotests
> before sending a pull request to Peter. The iotests should really not be
> broken in upstream master.

This is unlikely to cover the iotest failures on s390 (due to usage of
ccw, strange backing devices, etc.), though. We have basically two
options here:
- Continue to rely on the IBM folks finding those problems (which will
  likely be post-merge, but better than nothing.)
- Have patchew (which has a bot on s390) execute the iotests - which is
  time-consuming.

> 
> >>  * Peter Maydell: If it isn't tested by "make check" then it isn't tested:
> >>    so if something is regularly regressing then it needs to be added to
> >>    "make check".  
> > 
> > Is this tenable long term? We can't conceivably state that we will never
> > test things that aren't in "make check" -- we ought to have different
> > tiers, at least. The full testing suite should run for RC tags at least,
> > but it's not feasible (I think?) to run the entire battery of tests on
> > every commit... but that shouldn't stop us from running them /sometimes/...  
> 
> We've already got "make check SPEED=slow" for running tests that take a
> lot of time. So maybe you could do that in the iotests as well, so that
> the normal, quick tests can be run during "make check" and the full
> iotest suite is only run during "make check SPEED=slow" ?

+1 to that. Having a subset covered by default is better than nothing
at all.
