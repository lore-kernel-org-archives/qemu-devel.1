Received: from eggs.gnu.org ([2001:4830:134:3::10]:53698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY9V3-0002N8-EG
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY9V0-0006qZ-9e
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dY9V0-0006q8-3i
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:20:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 13:20:03 +0200
In-Reply-To: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
	(Peter Maydell's message of "Fri, 14 Jul 2017 09:33:42 +0100")
Message-ID: <87zibz2w4c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Kamil Rytarowski <n54@gmx.com>, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

> This patchset fixes the build on NetBSD by making sure we only
> build the ivshmem-client and ivshmem-server tools if the host OS
> actually supports ivshmem. (Previously we were only gating building
> of the within-QEMU ivshmem PCI device.)
>
> Most of this patchset is the work of Kamil Rytarowski; I just
> split it up into easily-reviewable patches and fixed a few bugs.
>
> Tested on Linux, on NetBSD, and on Linux with a '--disable-linux-user
> --disable-system' config (which was the one that was failing with
> our previous attempt to fix this bug).
>
> NB: we still have some things we need to fix to be able to put
> NetBSD into the build-test set. The next issue is that 'make check'
> fails with
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM % 255 + 1))} gtester -k --verbose -m=quick tests/check-qdict
> sh: arith: syntax error: "RANDOM % 255 + 1"
>
> likely because we're using a bashism there.

Regardless of my inability to find CONFIG_IVSHMEM confusing (see PATCH
1), series
Reviewed-by: Markus Armbruster <armbru@redhat.com>
