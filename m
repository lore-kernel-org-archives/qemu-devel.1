Received: from eggs.gnu.org ([2001:4830:134:3::10]:43288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gVE9H-0000kU-N8
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gVE9F-0003Az-Ty
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:18:23 -0500
References: <20181206151856.77503-1-eblake@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9c3877f7-6884-791d-b67b-7f32b8275470@vivier.eu>
Date: Fri, 7 Dec 2018 12:18:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181206151856.77503-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] cutils: Assert in-range
 base for string-to-integer conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com

Le 06/12/2018 à 16:18, Eric Blake a écrit :
> POSIX states that the value of endptr is unspecified if strtol()
> fails with EINVAL due to an invalid base argument.  Since none of
> the callers to check_strtox_error() initialized endptr, we could
> end up propagating uninitialized data back to a caller on error.
> However, passing an out-of-range base is already a sign of poor
> programming, so let's just assert that base is in range, at which
> point check_strtox_error() can be tightened to assert that it is
> receiving an initialized ep that points somewhere within the
> caller's original string, regardless of whether strto*() succeeded
> or failed with ERANGE.
> 
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Also tested that this does not negatively impact David's pending
> additions of qemu_strtod{,_finite}().  Thus:
> Based-on: <20181121164421.20780-1-david@redhat.com>
> 
>  util/cutils.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
