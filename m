Received: from eggs.gnu.org ([2001:4830:134:3::10]:49020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdy30-00045A-2b
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdy2v-0002y6-73
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:46:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdy2v-0002x5-16
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 06:46:53 -0500
Date: Wed, 15 Feb 2017 11:46:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170215114646.GC2731@work-vm>
References: <20170203175217.45562-1-pasic@linux.vnet.ibm.com>
	<20170210152403.GH2568@work-vm>
	<273b267a-7458-2538-8a4b-a9f8ba6dfc5a@amsat.org>
	<34825483-e6c0-085b-bb85-4d54bad6e2b1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <34825483-e6c0-085b-bb85-4d54bad6e2b1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: consolidate VMStateField.start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>=20
>=20
> On 02/11/2017 05:26 AM, Philippe Mathieu-Daud=E9 wrote:
> > On 02/10/2017 12:24 PM, Dr. David Alan Gilbert wrote:
> >> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>> The member VMStateField.start is used for two things, partial data
> >>> migration for VBUFFER data (basically provide migration for a
> >>> sub-buffer) and for locating next in QTAILQ.
> >>>
> >>> The implementation of the VBUFFER feature is broken when VMSTATE_AL=
LOC
> >>> is used. This however goes unnoticed because actually partial migra=
tion
> >>> for VBUFFER is not used at all.
> >>>
> >>> Let's consolidate the usage of VMStateField.start by removing suppo=
rt
> >>> for partial migration for VBUFFER.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Thanks for the review Philippe!
>=20
> @Maintainers: Softfreeze is approaching, and I would like to try
> get my 'array of pointers with null pointers' (which is on top of
> this) in 2.9 too if possible. Anything I can do to speed things up?

It went in on Monday!

Dave

> Regards,
> Halil
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
