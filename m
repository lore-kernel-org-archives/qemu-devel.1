Received: from eggs.gnu.org ([2001:4830:134:3::10]:38272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9UMC-0002pE-5K
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e9UM9-0004u6-0X
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:05:20 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-11-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-11-mreitz@redhat.com>
Date: Tue, 31 Oct 2017 12:05:01 +0100
Message-ID: <w51po93lgrm.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 10/25] block: Add bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 29 Sep 2017 06:53:32 PM CEST, Max Reitz wrote:
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
