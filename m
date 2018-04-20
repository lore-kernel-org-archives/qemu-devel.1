Received: from eggs.gnu.org ([2001:4830:134:3::10]:38770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9Yh9-0000Hs-Vj
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9Yh9-0001fv-2V
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:15:31 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<87d0ywv9j0.fsf@dusky.pond.sub.org>
	<20180418162823.GH4971@localhost.localdomain>
	<20180418163458.GB27579@redhat.com>
	<20180418165208.GI4971@localhost.localdomain>
	<20180418170457.GC27579@redhat.com>
	<87y3hixaql.fsf@dusky.pond.sub.org>
	<20180420135529.GL21035@redhat.com>
	<877ep2szi9.fsf@dusky.pond.sub.org>
	<20180420145322.GN21035@redhat.com>
Date: Fri, 20 Apr 2018 18:15:14 +0200
In-Reply-To: <20180420145322.GN21035@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Fri, 20 Apr 2018 15:53:22 +0100")
Message-ID: <87po2tsvl9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, jdurgin@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Apr 20, 2018 at 04:50:38PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Fri, Apr 20, 2018 at 03:34:26PM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > Yeah this is a mess - I wish we had never allowed users to pass a c=
onfig
>> >> > file, and had used /dev/null all the time. Unfortunately changing e=
ither
>> >> > of these aspects would cause backcompat problems for existing deplo=
yments
>> >> > now :-( So we just have to accept that the global config file is al=
ways
>> >> > in present, but none the less libvirt should try to specify things =
as
>> >> > fully as possible.
>> >>=20
>> >> I'm afraid you get backward compatibility problems no matter what.
>> >> Whenever you extend libvirt to pass configuration C "via normal per-d=
isk
>> >> setup for blockdev", it breaks user config files containing C, doesn't
>> >> it?
>> >
>> > That's not actually a problem here. We are only passing things to QEMU
>> > that the user already provided us in the XML file. If we gain support
>> > for passing a new item via the blockdev schema, then we'd only be
>> > passing that to QEMU if the user actually provided that item in the
>> > XML too.  We're not likely to pass a new config field without the
>> > user having asked us to first.
>>=20
>> What made me guess otherwise: "to properly protect against compromised
>> QEMU, ideally every QEMU would use a completely separate RBD
>> user+password, so that compromised QEMU can't then access RBD disks
>> belonging to a different user" led me to assume libvirt would do this
>> automatically.
>
> No, a mgmt app like OpenStack would have to take care of that, as it
> needs the ability to manage the RBD user accounts & volume ACLs, to
> match the VMs you're creating.
>
> I just meant that even if you have auth info in the global RBD file,
> we shouldn't assume that auth info is desirable to use with QEMU. The
> global auth config file may be an administrative account, while each
> QEMU has its own restricted account.

I understand now, thanks.
