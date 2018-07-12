Received: from eggs.gnu.org ([2001:4830:134:3::10]:54985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdVFK-0001K3-Bv
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 02:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdVFJ-0002cM-Gu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 02:38:34 -0400
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
Date: Thu, 12 Jul 2018 08:38:25 +0200
In-Reply-To: <20180710143807.GJ5852@localhost.localdomain> (Kevin Wolf's
	message of "Tue, 10 Jul 2018 16:38:07 +0200")
Message-ID: <871sc9gdr2.fsf@dusky.pond.sub.org>
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 10.07.2018 um 16:22 hat Cornelia Huck geschrieben:
>> On Tue, 10 Jul 2018 07:59:15 +0200
>> Markus Armbruster <armbru@redhat.com> wrote:
>> 
>> > In addition to actively pulling libvirt developers into review of
>> > deprecation patches, we should pursue the idea to optionally let QEMU
>> > fail on use of deprecated features, then have libvirt run its test suite
>> > that way.
>> 
>> What about the following:
>> 
>> qemu_deprecated_option("old_option", "modern_option");
>> 
>> Which would then print (in normal operation)
>> 
>> "WARNING: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
>> 
>> to the monitor (or to stderr? to both?).
>> 
>> If you start QEMU with a -no-deprecated-options switch, it would print
>> 
>> "ERROR: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
>> 
>> and do an exit(1).
>> 
>> Would that be workable?
>
> I think the function should just take a message:
>
>     /* Works like error_report(), except for the WARNING/ERROR prefix
>      * and exit(1) if -no-deprecated-options is set */
>     void deprecation_report(const char *fmt, ...);

I like it.  The contract could use a bit of polish, but that's detail.

> We don't necessarily deprecate only options, but we might also deprecate
> monitor commands, specific options values (while keeping other values of
> the same option) etc.

Exactly.
