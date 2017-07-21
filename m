Received: from eggs.gnu.org ([2001:4830:134:3::10]:46890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYWUW-00072N-Fx
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dYWUT-0006A8-FT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dYWUT-00069V-8l
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:53:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17BB5368E5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 11:53:04 +0000 (UTC)
Date: Fri, 21 Jul 2017 12:53:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170721115300.GE2133@work-vm>
References: <20170721114917.3706-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170721114917.3706-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: fix temp directory used by
 test-io-channel-tls test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

* Daniel P. Berrange (berrange@redhat.com) wrote:
> The test-io-channel-tls test was mistakenly using two of the
> same directories as test-crypto-tlssession. This causes a
> sporadic failure when using make -j$BIGNUM.
> 
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/test-io-channel-tls.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
> index 8eaa208e1b..ff96877323 100644
> --- a/tests/test-io-channel-tls.c
> +++ b/tests/test-io-channel-tls.c
> @@ -127,8 +127,8 @@ static void test_io_channel_tls(const void *opaque)
>      /* We'll use this for our fake client-server connection */
>      g_assert(socketpair(AF_UNIX, SOCK_STREAM, 0, channel) == 0);
>  
> -#define CLIENT_CERT_DIR "tests/test-crypto-tlssession-client/"
> -#define SERVER_CERT_DIR "tests/test-crypto-tlssession-server/"
> +#define CLIENT_CERT_DIR "tests/test-io-channel-tls-client/"
> +#define SERVER_CERT_DIR "tests/test-io-channel-tls-server/"

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      mkdir(CLIENT_CERT_DIR, 0700);
>      mkdir(SERVER_CERT_DIR, 0700);
>  
> -- 
> 2.13.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
