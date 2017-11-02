Received: from eggs.gnu.org ([2001:4830:134:3::10]:42105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAGfU-00049T-G7
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAGfT-0003Ex-Ny
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:28 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170929165347.29658-17-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-17-mreitz@redhat.com>
Date: Thu, 02 Nov 2017 15:40:20 +0100
Message-ID: <w51shdwwxpn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 16/25] block: Add 'base-directory' BDS
 option
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

On Fri 29 Sep 2017 06:53:38 PM CEST, Max Reitz wrote:
> Using this option, one can directly override what bdrv_dirname() will
> return. This is useful if one uses e.g. qcow2 on top of quorum (with
> only protocol BDSs under the quorum BDS) and wants to be able to use
> relative backing filenames.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Who would be using this option in practice? I understand that management
tools should be using always absolute filenames, and this API doesn't
seem so convenient for humans.

Berto
