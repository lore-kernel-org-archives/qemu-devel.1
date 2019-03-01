Received: from eggs.gnu.org ([209.51.188.92]:40816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gzjI9-0002pp-HG
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gzjI8-00079O-Rk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 09:37:37 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190301141809.GD5861@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<61bbfa3721938326edb03db58a6a246b384f3260.1547739122.git.berto@igalia.com>
	<20190212180231.GJ5283@localhost.localdomain>
	<w51zhqe7q01.fsf@maestria.local.igalia.com>
	<20190301123608.GB5861@localhost.localdomain>
	<w51woli7oma.fsf@maestria.local.igalia.com>
	<20190301125642.GC5861@localhost.localdomain>
	<w51tvgm7nim.fsf@maestria.local.igalia.com>
	<20190301141809.GD5861@localhost.localdomain>
Date: Fri, 01 Mar 2019 15:37:31 +0100
Message-ID: <w51r2bq7j9w.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/13] block: Add 'runtime_opts' and
 'mutable_opts' fields to BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 01 Mar 2019 03:18:09 PM CET, Kevin Wolf wrote:
> Hm, actually, do you even need the runtime_opts list?
>
> You use it in bdrv_reset_options_allowed() to iterate through each
> option and then check whether it was present in the old set of
> options, but not in the new set of options.
>
> In order to achieve this, you can just iterate the old options dict
> because you don't do anything with options that are present in the
> QemuOptsList, but not the old options dict.

Hmm, that could work, I'll give it a try.

Berto
