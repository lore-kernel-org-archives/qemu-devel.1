Received: from eggs.gnu.org ([2001:4830:134:3::10]:48700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZYp-0000ry-G3
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdZYo-0001Gx-HT
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:14:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143807.GJ5852@localhost.localdomain>
	<871sc9gdr2.fsf@dusky.pond.sub.org>
	<8736wplzff.fsf@dusky.pond.sub.org>
	<20180712094834.78852622.cohuck@redhat.com>
Date: Thu, 12 Jul 2018 13:14:52 +0200
In-Reply-To: <20180712094834.78852622.cohuck@redhat.com> (Cornelia Huck's
	message of "Thu, 12 Jul 2018 09:48:34 +0200")
Message-ID: <87fu0or9hv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

Cornelia Huck <cohuck@redhat.com> writes:

> On Thu, 12 Jul 2018 08:51:16 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>> 
>> > Kevin Wolf <kwolf@redhat.com> writes:
>> >  
>> >> I think the function should just take a message:
>> >>
>> >>     /* Works like error_report(), except for the WARNING/ERROR prefix
>> >>      * and exit(1) if -no-deprecated-options is set */
>> >>     void deprecation_report(const char *fmt, ...);  
>> >
>> > I like it.  The contract could use a bit of polish, but that's detail.  
>> 
>> Suggest --deprecated={silent,warn,error}, default silent.
>
> I like that, but I'd prefer to default to warn (so that command line
> users have a better chance to notice it).

Fair enough.
