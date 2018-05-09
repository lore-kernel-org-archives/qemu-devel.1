Received: from eggs.gnu.org ([2001:4830:134:3::10]:42294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fGK7y-0002uv-BQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fGK7x-00086F-K0
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:07:10 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180508233659.13973-1-jsnow@redhat.com>
References: <20180508233659.13973-1-jsnow@redhat.com>
Date: Wed, 09 May 2018 10:06:27 +0200
Message-ID: <w51vabxp81o.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: expose error string
 via query
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

On Wed 09 May 2018 01:36:59 AM CEST, John Snow wrote:
> When we've reached the concluded state, we need to expose the error
> state if applicable. Add the new field.
>
> This should be sufficient for determining if a job completed
> successfully or not after concluding; if we want to discriminate
> based on how it failed more mechanically, we can always add an
> explicit return code enumeration later.
>
> I didn't bother to make it only show up if we are in the concluded
> state; I don't think it's necessary.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
