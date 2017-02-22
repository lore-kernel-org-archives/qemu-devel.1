Received: from eggs.gnu.org ([2001:4830:134:3::10]:48016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgUj1-0006xf-03
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgUj0-00014X-35
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:04:47 -0500
Date: Wed, 22 Feb 2017 12:04:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222110436.GG4112@noname.str.redhat.com>
References: <20170220151921.22842-1-berrange@redhat.com>
	<20170220151921.22842-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170220151921.22842-4-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qemu-img: introduce
 --target-image-opts for 'convert' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

Am 20.02.2017 um 16:19 hat Daniel P. Berrange geschrieben:
> The '--image-opts' flags indicates whether the source filename
> includes options. The target filename has to remain in the
> plain filename format though, since it needs to be passed to
> bdrv_create().  When using --skip-create though, it would be
> possible to use image-opts syntax. This adds --target-image-opts
> to indicate that the target filename includes options. Currently
> this mandates use of the --skip-create flag too.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Hm, okay, with a separate --target-image-opts here, too, I guess the
'qemu-img dd' interface would be consistent after all.

Kevin
