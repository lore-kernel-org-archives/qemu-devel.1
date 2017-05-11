Received: from eggs.gnu.org ([2001:4830:134:3::10]:48049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8iUf-0005ct-VV
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8iUZ-0006t2-Sm
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:26:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8iUZ-0006rn-MP
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:26:31 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com> <20170510145125.GE4230@work-vm>
	<20170510150452.GV31558@redhat.com> <20170510151404.GF4230@work-vm>
Date: Thu, 11 May 2017 09:26:22 +0200
In-Reply-To: <20170510151404.GF4230@work-vm> (David Alan Gilbert's message of
	"Wed, 10 May 2017 16:14:05 +0100")
Message-ID: <87h90rluqp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Deprecate the machines pc-0.10 to
 pc-0.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Daniel P. Berrange (berrange@redhat.com) wrote:
>> On Wed, May 10, 2017 at 03:51:25PM +0100, Dr. David Alan Gilbert wrote:
>> > * Daniel P. Berrange (berrange@redhat.com) wrote:
>> > > If we deprecate in this release (~Aug/Sep 2017), and kill in the next
>> > > release  (Dec 2017), that means our oldest machine type pc-1.0 is still
>> > > going to be 6 years, or 18 major releases, old. This raises some questions
>> > > 
>> > >   - Do we really think that we still have users with VMs that are
>> > >     stuck on a 6 year old machine type from 18 major releases ago ?
>> > 
>> > Our RHEL6 users are still on a 0.12 derivative.
>> 
>> Yep, but not using upstream machine types. So we can kill machine
>> types without affecting RHEL-6.  The separate question is whether
>> we can kill the associated features that are needed for RHEL to
>> create its legacy machine types (eg the rombar setting mentioned)
>
> Right, it just felt a bit odd to kill it off upstream if we know
> of users ourselves who use old versions like that.
>
> Also remember machine types are not just about migration compatibility;
> if we kill a machine type then:
>   a) The users will need to modify their libvirt xml for each VM to
> change machine type

Point taken.  But if this inconvenience is unacceptable, consider an
enterprise distribution, or maybe CentOS.

>   b) That change in guest view of the machine might upset the OS
> installed.

Unlikely, unless you migrate without a reboot.  Guests almost always
adapt to minor hardware changes on reboot just fine.

> I've certainly got VMs that were installed ages ago and are still using
> the XML from the old installation; so that probably means using an old
> machine type on a modern QEMU.

Eventually, that becomes as likely to actually work as rebooting with a
newer machine type :)
