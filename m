Received: from eggs.gnu.org ([2001:4830:134:3::10]:52565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyl9-0004s0-LH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyl4-0004mO-O3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPyl4-0004lj-Hv
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:14:54 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<1498564100-10045-2-git-send-email-thuth@redhat.com>
	<9526df82-1ad5-8947-0643-7c99e215ed5a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2316bc59-1566-07ca-cdf0-d541b1960a82@redhat.com>
Date: Wed, 28 Jun 2017 00:14:48 +0200
MIME-Version: 1.0
In-Reply-To: <9526df82-1ad5-8947-0643-7c99e215ed5a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 01/14] pc-bios/s390-ccw: Add the libc
 from the SLOF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

On 27.06.2017 17:32, David Hildenbrand wrote:
> On 27.06.2017 13:48, Thomas Huth wrote:
>> To be able to use some more advanced libc functions in the s390-ccw
>> firmware, like printf() and malloc(), we need a better libc here.
>> This patch adds the C library from the SLOF firmware (taken from
>> the SLOF commit ID 62674aabe20612a9786fa03e87cf6916ba97a99a). The
>> files are copied without modifications here and will be adapted for
>> the s390-ccw firmware by the next patch. I just removed the getopt()
>> and scanf()-like functions from the libc since we likely do not need
>> them in the s390-ccw firmware.
>>
>=20
> We have SLOF as a git submodule in roms/SLOF.
>=20
> I wonder if there would a way to avoid duplicating files.
>=20
> E.g. build s390x-ccw.img only if roms/SLOF is checked out and link/copy
> the right folder.
>=20
> Then, also the question regarding coding style is gone.
>=20
> Would something like that work?

Cool idea, I like it at a first glance. It might be possible ... but
that also creates a lot of dependencies, e.g. each time there is a
related change in the SLOF repository, you run into the problem that it
might affect the s390-ccw firmware, too. Not sure whether we really
always want to deal with that situation...

 Thomas
