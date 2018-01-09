Received: from eggs.gnu.org ([2001:4830:134:3::10]:40453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYsN2-00035x-Nu
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYsMw-0001rE-Pg
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:47:08 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:43351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYsMw-0001qk-Jb
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:47:02 -0500
Received: by mail-ot0-x22d.google.com with SMTP id t28so948369oti.10
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 03:47:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108055348.20444-1-david@gibson.dropbear.id.au>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 11:46:41 +0000
Message-ID: <CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On 8 January 2018 at 05:53, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180108
>
> for you to fetch changes up to 9f173585d3f35345b2facce50620ce2cdda05f2f:
>
>   spapr: Correct compatibility mode setting for hotplugged CPUs (2018-01-08 13:33:17 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-01-08
>
> This pull requests supersedes both ppc-for-2.12-20180103 and
> ppc-for-2.12-20171219.  We've discovered that some substantial
> extensions to the proposed capabilities infrastructure will be
> valuable, amongst other things for managing/advertising workarounds
> for the dreaded Meltdown/Spectre bugs.
>
> Although that could be done as follow on changes, since the caps
> infrastructure hasn't been merged yet, we might as well pull it out
> while we rework, and just merge the unrelated bugfixes.
>
> The last two pull requests apparently had problems on some arm32
> systems.  I haven't been able to reproduce those, so I have no idea
> which patch is causing them.  If we get lucky and it was one of the
> patches I've removed from this series, this may also serve to unjam
> the other fixes.

This still hangs on my arm32 setup in the migration test. I'll see
if I can identify what is going wrong.

thanks
-- PMM
