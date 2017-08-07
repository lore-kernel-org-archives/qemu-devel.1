Received: from eggs.gnu.org ([2001:4830:134:3::10]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedaK-0005Fk-GN
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dedaH-0005tH-CM
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:40:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dedaH-0005sj-5A
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 04:40:21 -0400
Date: Mon, 7 Aug 2017 09:40:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170807084008.GE18259@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.14d7e60ae019b1418a70bacc4e7d240fadf9c96c.1501362828.git-series.knut.omang@oracle.com>
	<76cb37b3decd6d6c1c9bac72e21a06fabf7579be.1501362828.git-series.knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76cb37b3decd6d6c1c9bac72e21a06fabf7579be.1501362828.git-series.knut.omang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/4] sockets: Handle race condition
 between binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Sat, Jul 29, 2017 at 11:18:18PM +0200, Knut Omang wrote:
> If an offset of ports is specified to the inet_listen_saddr function(),
> and two or more processes tries to bind from these ports at the same time,
> occasionally more than one process may be able to bind to the same
> port. The condition is detected by listen() but too late to avoid a failure.
> 
> This function is called by socket_listen() and used
> by all socket listening code in QEMU, so all cases where any form of dynamic
> port selection is used should be subject to this issue.
> 
> Add code to close and re-establish the socket when this
> condition is observed, hiding the race condition from the user.
> 
> Also clean up some issues with error handling to allow more
> accurate reporting of the cause of an error.
> 
> This has been developed and tested by means of the
> test-listen unit test in the previous commit.
> Enable the test for make check now that it passes.
> 
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  tests/Makefile.include |  2 +-
>  util/qemu-sockets.c    | 58 ++++++++++++++++++++++++++++++-------------
>  2 files changed, 42 insertions(+), 18 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
