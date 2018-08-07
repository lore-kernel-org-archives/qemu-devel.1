Received: from eggs.gnu.org ([2001:4830:134:3::10]:59042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3eP-00047S-9w
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3eO-0004yi-EZ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:11:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180628000745.4477-15-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-15-mreitz@redhat.com>
Date: Tue, 07 Aug 2018 17:11:49 +0200
Message-ID: <w51in4m8b4a.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 14/31] block: Add
 bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu 28 Jun 2018 02:07:28 AM CEST, Max Reitz wrote:
> This function may be implemented by block drivers to derive a directory
> name from a BDS. Concatenating this g_free()-able string with a relative
> filename must result in a valid (not necessarily existing) filename, so
> this is a function that should generally be not implemented by format
> drivers, because this is protocol-specific.
>
> If a BDS's driver does not implement this function, bdrv_dirname() will
> fall through to the BDS's file if it exists. If it does not, the
> exact_filename field will be used to generate a directory name.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
