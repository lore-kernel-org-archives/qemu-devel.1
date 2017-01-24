Received: from eggs.gnu.org ([2001:4830:134:3::10]:39914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cW7ls-0005hM-O1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cW7ln-0004V6-OY
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 15:32:52 -0500
References: <Pine.NEB.4.64.1701241855380.2138@sdf.lonestar.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4b93a2b8-097e-a502-875e-21ea394c617a@redhat.com>
Date: Tue, 24 Jan 2017 21:32:44 +0100
MIME-Version: 1.0
In-Reply-To: <Pine.NEB.4.64.1701241855380.2138@sdf.lonestar.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] PPC: MMU compatibility check.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Valentin Plotkin <caliborn@SDF.ORG>, qemu-trivial@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 24.01.2017 19:56, Valentin Plotkin wrote:
> 
> Hi everyone,
> 
> I looked at the "qemu-system-ppc -nographic -cpu G2leGP3 -M ppce500" on
> the BiteSizedTasks page. The segfault was caused by machine
> initialization code which expected a certain MMU model, checked, so
> unused SPR were read, returning zeros. bamboo and virtex machines are
> affected as well, but it doesn't always cause segfault, usually running
> into unmapped memory and failing somewhat more nicely.
> 
> I added the checks. It would be possible to add support for other MMU
> models, but I'm not sure if there is any point (would any guest OS
> support mutually exclusive CPU and machine)?

 Hi,

great to have a fix for this crash! I don't think it make much sense to
add support for other MMU models here, so the simple checks should be
good enough.
However, your new code obviously does not follow the QEMU coding style.
Could you please run your patch through scripts/checkpatch.pl and fix
all issues that it reports? And when you resubmit, please make sure to
copy the maintainers on CC: as well (scripts/get_maintainers.pl is your
friend here).

 Thanks,
  Thomas
