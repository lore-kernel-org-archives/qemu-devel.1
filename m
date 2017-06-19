Received: from eggs.gnu.org ([2001:4830:134:3::10]:36531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMxNn-0007J4-JY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMxNi-0001Yf-0z
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:10:23 -0400
Date: Mon, 19 Jun 2017 16:10:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170619141010.GH6113@noname.redhat.com>
References: <20170614153102.9077-1-mreitz@redhat.com>
	<20170614153102.9077-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614153102.9077-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 14.06.2017 um 17:31 hat Max Reitz geschrieben:
> Currently, bdrv_reopen_prepare() assumes that all BDS options are
> strings. However, this is not the case if the BDS has been created
> through the json: pseudo-protocol or blockdev-add.
> 
> Note that the user-invokable reopen command is an HMP command, so you
> can only specify strings there. Therefore, specifying a non-string
> option with the "same" value as it was when originally created will now
> return an error because the values are supposedly similar (and there is
> no way for the user to circumvent this but to just not specify the
> option again -- however, this is still strictly better than just
> crashing).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
