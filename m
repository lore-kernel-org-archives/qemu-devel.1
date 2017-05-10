Received: from eggs.gnu.org ([2001:4830:134:3::10]:48258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8GsS-0000uk-66
	for qemu-devel@nongnu.org; Tue, 09 May 2017 21:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d8GsR-0005N4-A6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 21:57:20 -0400
Date: Wed, 10 May 2017 09:57:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170510015710.GC19890@lemon.lan>
References: <20170509094837.22852-1-berrange@redhat.com>
	<20170509094837.22852-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509094837.22852-4-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/4] qemu-img: introduce
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, 05/09 10:48, Daniel P. Berrange wrote:
> The '--image-opts' flag indicates whether the source filename
> includes options. The target filename has to remain in the
> plain filename format though, since it needs to be passed to
> bdrv_create().  When using --skip-create though, it would be
> possible to use image-opts syntax. This adds --target-image-opts
> to indicate that the target filename includes options. Currently
> this mandates use of the --skip-create flag too.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
