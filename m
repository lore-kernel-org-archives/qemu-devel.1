Received: from eggs.gnu.org ([2001:4830:134:3::10]:55199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coafU-0002XQ-PB
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 15:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coafQ-0000TE-PH
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 15:02:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coafQ-0000T7-JW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 15:02:32 -0400
Date: Thu, 16 Mar 2017 19:02:28 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316190227.GO2567@work-vm>
References: <8fb8ed45-6de3-2b74-f5ea-44b374cabcbd@gmail.com>
	<87ziglnof9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87ziglnof9.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Make qemu_thread_create return a flag to indicate
 if it succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Achilles Benetopoulos <abenetopoulos@gmail.com>, qemu-devel@nongnu.org

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
>=20
> Achilles Benetopoulos <abenetopoulos@gmail.com> writes:
>=20
> > I am interested in working on the BiteSized Task mentioned in the
> > subject line. However, I have a question: Since the current behaviour
> > of qemu_thread_create is to fail in the case of an error, then it
> > seems logical to make the caller exit (in the patched version) if the
> > return value of the call to qemu_thread_create indicates an error. Is
> > this desirable? If so, how detailed should the error messages reporte=
d
> > be? If not, then I'm guessing that the desired behaviour is a more
> > graceful handling of the error on a case-by-case basis?
>=20
> It will depend on a case-by-case basis. For example failing to create
> threads for a TCG vCPU don't really leave much for you to do expect
> complain loudly and exit. I assume the more graceful handling is for
> things like thread-pools where you can continue to run even without a
> fully populated pool.

Or on migration we can fail the migration but still leave the guest
running in no worse state than it was before.

Dave

> --
> Alex Benn=E9e
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
