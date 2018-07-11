Received: from eggs.gnu.org ([2001:4830:134:3::10]:43566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fd9U7-0006E5-MA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fd9U6-0005Gh-Qg
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:24:23 -0400
Date: Wed, 11 Jul 2018 09:24:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180711092411.0dbc9874.cohuck@redhat.com>
In-Reply-To: <28ef476f-7811-91ef-6c77-515f07235e7a@redhat.com>
References: <20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143931.GQ1148@andariel.pipo.sk>
	<20180710170122.427ce3a4.cohuck@redhat.com>
	<20180710152406.GS1148@andariel.pipo.sk>
	<28ef476f-7811-91ef-6c77-515f07235e7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On Wed, 11 Jul 2018 08:53:20 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 10.07.2018 17:24, Peter Krempa wrote:
> > On Tue, Jul 10, 2018 at 17:01:22 +0200, Cornelia Huck wrote:  

> >> So, from that I gather that a hard failure would be the easiest for
> >> libvirt to detect (and everything else would become complicated really
> >> quickly), right?  
> > 
> > People start complaining only when stuff breaks. If anything is optional
> > people will usually not enable it. That makes any non-mandatory option
> > not work in most cases.  
> 
> So would it help if we "invert" the logic, i.e. deprecated_report()
> would do exit(1) by default? Then, if the (human) users still want to
> continue with the deprecated option, they have to add a
> "--ignore-deprecation" command line switch to make QEMU start
> successfully...

That is sure to get the attention of even 'normal' users, but we'd have
to make it really, really obvious (1) how to get it working again and
(2) what other things we'd like them to do (like 'if you are using a
management tool, please let them know about it'). I'm fearing a lot of
'I followed that ancient guide, and it does not work' type of reports,
though.
