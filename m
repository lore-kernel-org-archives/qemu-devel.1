Received: from eggs.gnu.org ([2001:4830:134:3::10]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2ady-0003y0-Be
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2adx-00087e-N4
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:50:54 -0400
Date: Mon, 24 Apr 2017 17:50:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424095046.GD14416@lemon.lan>
References: <20170424091659.26708-1-berrange@redhat.com>
	<20170424091659.26708-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424091659.26708-5-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/4] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, 04/24 10:16, Daniel P. Berrange wrote:
> The qemu-img dd/convert commands will create a image file and

s/a image/an image/

> then try to open it. Historically it has been possible to open
> new files without passing any options. With encrypted files
> though, the *key-secret options are mandatory, so we need to
> provide those options when opening the newly created file.

Fam
