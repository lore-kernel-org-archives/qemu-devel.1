Received: from eggs.gnu.org ([2001:4830:134:3::10]:57286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elzFl-0006PF-SQ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elzFk-0001uC-Vw
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:45:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45712 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elz3x-0004iE-QL
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:33:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B54040201A1
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 15:21:38 +0000 (UTC)
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
	<20180213180918.GY573@redhat.com>
	<20180214010111.GB15103@lemon.usersys.redhat.com>
	<20180214133434.GB7545@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4966cb6-577e-22c9-641d-3f7ed1f0ce72@redhat.com>
Date: Wed, 14 Feb 2018 09:21:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180214133434.GB7545@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On 02/14/2018 07:34 AM, Stefan Hajnoczi wrote:
> On Wed, Feb 14, 2018 at 09:01:11AM +0800, Fam Zheng wrote:
>> On Tue, 02/13 18:09, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Feb 13, 2018 at 05:34:25PM +0000, Stefan Hajnoczi wrote:
>>>> +[gitpublishprofile "block"]
>>>> +base =3D master
>>>> +prefix =3D PATCH
>>>> +to =3D qemu-devel@nongnu.org
>>>> +cc =3D qemu-block@nongnu.org
>>>> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit=
 --nogit-fallback 2>/dev/null
>>>
>>> Why is a custom entry needed for block here (and other things
>>> below).   Won't running get_maintainer.pl already correctly
>>> report when a patch needs cc'ing to qemu-block@nongnu.org
>>> based on MAINTAINER rules ?
>>
>> Yeah, dropping them should be fine. What do you think, Stefan?
>=20
> scripts/get_maintainer.pl only works when patches touch files associate=
d
> with qemu-block@nongnu.org in MAINTAINERS.  It would be
> counter-intuitive for --profile block to not include
> qemu-block@nongnu.org, so I think these entries do serve a purpose.

More precisely, the cover letter does not touch any files, and git=20
doesn't know how to automatically cc the cover letter to any recipient=20
of any of the rest of the series.  Having these entries ensures that the=20
cover letter goes to the right list (on the other hand, git publish=20
itself could be taught to be smarter about cc'ing the cover letter to=20
every email scraped from later in the series, even if git send-email=20
can't do that yet).

>=20
> On the other hand, I personally just use --cc qemu-block instead of a
> profile for this.  I'll probably only use the default profile.
>=20
> Fam, if you want it dropped, let me know.  Otherwise, we can leave it
> in if there is no further discussion.
>=20
> Stefan
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
