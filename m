Received: from eggs.gnu.org ([2001:4830:134:3::10]:38803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcbWm-0001Dz-Ni
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 14:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcbWi-0004Dp-PV
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 14:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcbWi-0004Bv-JN
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 14:04:16 -0400
Date: Tue, 1 Aug 2017 19:04:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170801180408.GC2471@work-vm>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
	<1501604245-33460-3-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8ArjNALptSYkR4T-SaejWPQxpazYjm-b_aCkGDFFXgnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ArjNALptSYkR4T-SaejWPQxpazYjm-b_aCkGDFFXgnw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/17]
 cpu_physical_memory_sync_dirty_bitmap: Fix alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org, QEMU Developers <qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 1 August 2017 at 17:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > This code has an optimised, word aligned version, and a boring
> > unaligned version.  Recently 084140bd498909 fixed a missing offset
> > addition from the core of both versions.  However, the offset isn't
> > necessarily aligned and thus the choice between the two versions
> > needs fixing up to also include the offset.
> >
> > Symptom:
> >   A few stuck unsent pages during migration; not normally noticed
> > unless under very low bandwidth in which case the migration may get
> > stuck never ending and never performing a 2nd sync; noticed by
> > a hanging postcopy-test on a very heavily loaded system.
> >
> > Fixes: 084140bd498909
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reported-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
> > Tested-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
> >
> > --
> > v2
> >   Move 'page' inside the if (Comment from Paolo)
> > Message-Id: <20170724165125.29887-1-dgilbert@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Something somewhere along the line seems to have mangled the
> unicode characters in Alex's name :-(
> Also, Alex's email address is typoed, and what should be the
> '---' marker has been written as '--' so the below-the-fold waffle
> is still hanging around in the commit.
>=20
> This doesn't seem worth rejecting the pull request on the
> eve of rc1 for, but it's still a bit sad :-(

Hmm yes, I think some of that's mine - the missing 'n' is certainly
my fault; and I may have got his two 'e's in the wrong order,
but I don't know what changed the encoding, that seems right on:
  https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07417.html

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
