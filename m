Received: from eggs.gnu.org ([2001:4830:134:3::10]:43810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1da732-0000Og-22
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1da72z-0000Cv-Da
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:07:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1da72z-0000Bp-74
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:07:17 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170724165125.29887-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 24 Jul 2017 17:51:25 +0100")
References: <20170724165125.29887-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 25 Jul 2017 23:07:13 +0200
Message-ID: <87379k8bum.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] cpu_physical_memory_sync_dirty_bitmap:
 Fix alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org, haozhong.zhang@intel.com, peterx@redhat.com, lvivier@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> This code has an optimised, word aligned version, and a boring
> unaligned version.  Recently 084140bd498909 fixed a missing offset
> addition from the core of both versions.  However, the offset isn't
> necessarily aligned and thus the choice between the two versions
> needs fixing up to also include the offset.
>
> Symptom:
>   A few stuck unsent pages during migration; not normally noticed
> unless under very low bandwidth in which case the migration may get
> stuck never ending and never performing a 2nd sync; noticed by
> a hanging postcopy-test on a very heavily loaded system.
>
> Fixes: 084140bd498909
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
> Tested-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
>

Reviewed-by: Juan Quintela <quintela@redhat.com>
