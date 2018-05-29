Received: from eggs.gnu.org ([2001:4830:134:3::10]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fNea9-0004eb-T1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fNea8-0006J5-Ps
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:22:33 -0400
Date: Tue, 29 May 2018 15:22:25 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180529132225.GQ20558@paraplu>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-22-kwolf@redhat.com>
	<26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
	<20180524082412.GC4008@localhost.localdomain>
	<1988292d-467a-9c63-e64d-035b0e93348a@redhat.com>
	<20180525080035.GA5562@localhost.localdomain>
	<20180529115907.GA1933@paraplu>
	<e380991d-dab8-1923-fb03-bab40e489f1f@redhat.com>
	<20180529131058.GP20558@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180529131058.GP20558@paraplu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 21/40] job: Convert
 block_job_cancel_async() to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On Tue, May 29, 2018 at 03:10:58PM +0200, Kashyap Chamarthy wrote:
> On Tue, May 29, 2018 at 02:30:47PM +0200, Max Reitz wrote:

[...]

> > The special behavior is that you can use block-job-cancel after
> > BLOCK_JOB_READY to complete the job, but not pivot to it.  I don't th=
ink
> > we have a real plan on how to represent that with the generic job
> > commands, we just know that we don't want to use job-cancel.
>=20
> Ah, thanks for clarifying.  Yes, what you say makes sense =E2=80=94  no=
t using
> 'job-cancel' to represent completion.
>=20
> > (Maybe we can add a flag to job-complete (which to me does not sound
> > like a good idea), or you could set flags on jobs while they are
> > running, so you can set a do-not-pivot flag on the mirror job before =
you
> > complete it.)
>=20
> Yeah, spelling that out, 'do-not-pivot' or something along those lines,
> as a flag makes it clearer.  "Implicit is better than explicit".

Oops, I got the quote reverse :P.  Correct: "Explicit is better than
implicit".  But you've auto-corrected in your head already...

--=20
/kashyap
