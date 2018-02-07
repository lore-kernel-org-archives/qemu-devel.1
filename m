Received: from eggs.gnu.org ([2001:4830:134:3::10]:35354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejPHo-0000mX-Bt
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ejPHk-0002VQ-FU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:57:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180207071758.6818-1-w.bumiller@proxmox.com>
References: <20180207071758.6818-1-w.bumiller@proxmox.com>
Date: Wed, 07 Feb 2018 13:57:07 +0100
Message-ID: <w51a7wlufdo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ratelimit: don't align wait time with
 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Wed 07 Feb 2018 08:17:58 AM CET, Wolfgang Bumiller wrote:
> It is possible for rate limited writes to keep overshooting a slice's
> quota by a tiny amount causing the slice-aligned waiting period to
> effectively halve the rate.
>
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
> Copied the Ccs from the discussion thread, hope that's fine, as I also
> just noticed that for my reply containing this snippet I had hit reply
> on the mail that did not contain those Ccs yet, sorry about that.

Stefan mentioned in another e-mail that someone proposed at some point
to unify this with the code in throttle.c. We can consider it but that
needs to be evaluated first. The other code is more complex and has
extra features (bursts) so it may not be worth the effort. Also the
algorithm is different. I can take a look in the future when I have some
time.

Otherwise, your patch looks good.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
