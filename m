Received: from eggs.gnu.org ([2001:4830:134:3::10]:53394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gAuxu-0008LI-Q8
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1gAuxq-0002ku-N3
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:46:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1gAuxq-0002kW-En
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:46:38 -0400
Date: Fri, 12 Oct 2018 06:46:37 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <1782383806.33244849.1539341197428.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181012104222.vzwu73lanjbelnbl@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
	<1539268208.16655.144.camel@redhat.com>
	<20181011150944.5qfaflgkcekdlz3o@sirius.home.kraxel.org>
	<1539272266.16655.154.camel@redhat.com>
	<20181012092700.np256rvz6octswia@sirius.home.kraxel.org>
	<2078529305.33241973.1539339318932.JavaMail.zimbra@redhat.com>
	<20181012104222.vzwu73lanjbelnbl@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org, =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, qemu-devel@nongnu.org

> 
> Hi,
> 
> > > When using qemu_console_get_head() it doesn't work correctly, it would
> > > use the qxl card's data.  It would work if spice-server would filter the
> > > list to only include the entries for the given display channel before
> > > calling the ->client_monitors_config() callback.  But it doesn't, we get
> > > the complete set.
> > 
> > That's why I said is a bug, IMHO it should.
> 
> Hmm, this should be easily detectable on qemu side I think.  If
> num_of_monitors (for a non-qxl card) is > 1, then we have an old,
> non-filtering spice-server.  If num_of_monitors == 1, then it is a new,
> filtering spice-server.  Or a single-head channel configuration, in
> which case it doesn't matter whenever it filters or not.
> 
> So this should be fixable without causing too much compatibility pain.
> 
> cheers,
>   Gerd
> 

Sorry, why fixing in Qemu is the bug is in spice-server?
I really don't follow your reasoning.
For me Qemu should not change at all and spice-server should
do the filtering. Is this not fixing everything?

Frediano
