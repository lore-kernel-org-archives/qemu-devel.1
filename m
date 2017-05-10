Received: from eggs.gnu.org ([2001:4830:134:3::10]:42344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8OUq-0007hV-T7
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d8OUm-0005Uk-LT
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:05:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d8OUm-0005UV-Cf
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:05:24 -0400
References: <1494398933-8366-1-git-send-email-thuth@redhat.com>
	<20170510090841.GF31558@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e8f7410f-98d9-2e0e-b75d-0ff38fd81b35@redhat.com>
Date: Wed, 10 May 2017 12:05:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170510090841.GF31558@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com

On 10.05.2017 11:08, Daniel P. Berrange wrote:
> On Wed, May 10, 2017 at 08:48:53AM +0200, Thomas Huth wrote:
>> We don't want to carry along old machine types forever. If we are able=
 to
>> remove the pc machines up to 0.13 one day for example, this would allo=
w
>> us to eventually kill the code for rombar=3D0 (i.e. where QEMU copies =
ROM
>> BARs directly to low memory). So let's start with a deprecation messag=
e
>> for the old 0.xx machine types so that the (hopefully) few users of th=
ese
>> old systems start switching over to newer machine types instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Note: I've decided to print the warning for all pc-0.* machine types,
>>  but that of course doesn't mean that we also have to remove them all =
at
>>  once when we decide to finally really remove some. We could then also
>>  start by removing 0.10 and 0.11 only, for example (since there should
>>  really be no users left for these), or only up to 0.13 (to be able to
>>  kill rombar=3D0), as discussed in the "Deprecating old machine types"
>>  mail thread recently.
>=20
>=20
> As a point of reference here are the release dates:
>=20
> v0.10.0: Mar 2009
> v0.11.0: Sep 2009
> v0.12.0: Dec 2009
> v0.13.0: Oct 2010
> v0.14.0: Feb 2011
> v0.15.0: Aug 2011
>    v1.0: Dec 2011
>  v1.1.0: Jun 2012
>  v1.2.0: Sep 2012
>  v1.3.0: Dec 2012
>  v1.4.0: Feb 2013
>  v1.5.0: May 2013
>  v1.6.0: Aug 2013
>  v1.7.0: Nov 2013
>  v2.0.0: Apr 2014
>  v2.1.0: Aug 2014
>  v2.2.0: Dec 2014
>  v2.3.0: Apr 2015
>  v2.4.0: Aug 2015
>  v2.5.0: Dec 2015
>  v2.6.0: May 2016
>  v2.7.0: Sep 2016
>  v2.8.0: Dec 2016
>  v2.9.0: Apr 2017
>=20
> If we deprecate in this release (~Aug/Sep 2017), and kill in the next
> release  (Dec 2017)

There was kind of a consensus in the last thread in march that we should
print out the deprecation message for at least two releases, so that
users have at least one release cycle to object before a feature gets
really removed.

> that means our oldest machine type pc-1.0 is still
> going to be 6 years, or 18 major releases, old. This raises some questi=
ons
>=20
>   - Do we really think that we still have users with VMs that are
>     stuck on a 6 year old machine type from 18 major releases ago ?
>
>   - Is 6 years / 18 major releases going to be our cutoff point for
>     machine types going forward ?
>=20
>   - Do we have any confidence that pc-1.0 in QEMU 2.9.0 really is
>     migration compatible with pc-1.0 from QEMU 1.0 ? I'm doubtful
>     unless someone can show automated testing results that confirm
>     it is compatible.

See https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05837.html
... there might be still users of 0.12  and 1.0 (though I don't hope
so), and everything before QEMU 1.2 can't be (life-)migrated anymore, so
we can nuke 0.10 and 0.11 for sure, maybe also the others up to 1.2.
So starting with a deprecation warning for 0.xx sounded like a good idea
to me.

> FYI, I'm in favour of culling old machine types, but I think when we do
> this it should not be a one-off ad-hoc culling.
>=20
> It should be accompanied by changes to the documentation that clearly
> state our official support policy for machine type lifetimes, so that
> users know what to expect for future releases.

Sounds like an idea, could you please propose such a patch to the
documentation?

> Also unless we're going to get more serious about automated testing to
> validate machine type compatibility between *all* previously releases,
> I think that 6 years / 18 releases is too long a time to have any
> confidence in migration compatibility between versions.

Distro vendors often offer 5 - 10 years support for certain versions of
their Linux distros, so I think we should at least support 5 years, too.

> IOW, I think you should be more aggressive in culling old machine types
> that this patch is...

Actually, I like the idea of using the major release versions for
defining the set of removal - hoping that we will do a v3.0 next year
which then would support the previous two major release versions 1.x and
2.x, but drops support for the 0.xx versions completely ...

 Thomas
