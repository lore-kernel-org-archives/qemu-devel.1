Received: from eggs.gnu.org ([2001:4830:134:3::10]:37144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1e7KPS-0007kH-QV
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1e7KPN-0006nc-6j
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27381)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1e7KPN-0006n2-0o
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 08:03:41 -0400
Date: Wed, 25 Oct 2017 14:03:23 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20171025120323.GB10290@vader>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
	<20171023151310.6462-5-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023151310.6462-5-vadim.galitsyn@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] tests: test-hmp: print command
 execution result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Mon, Oct 23, 2017 at 05:13:10PM +0200, Vadim Galitsyn wrote:
> Provide HMP monitor command execution result as it would be seen
> by user who established an HMP monitor session.
> 
> Currently many commands may silently fail without any sign of that.
> This patch let this info to be printed once test is running in
> verbose mode.
> 
> For the future it might be useful to fail the test if command has
> failed, however it would require a bit of rework inside test
> engine itself.
> 
> A simple example of silent failure without reporting it would to
> add some non-existent HMP command into 'hmp_cmds' list. In this case
> test will report it successfully passed without error.
> 
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  tests/test-hmp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 8e21eee61c..1fd8e44eff 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -79,10 +79,13 @@ static void test_commands(void)
>      int i;
>  
>      for (i = 0; hmp_cmds[i] != NULL; i++) {
> +        response = hmp("%s", hmp_cmds[i]);
>          if (verbose) {
> -            fprintf(stderr, "\t%s\n", hmp_cmds[i]);
> +            fprintf(stderr,
> +                    "\texecute HMP command: %s\n"
> +                    "\tresult             : %s\n",
> +                    hmp_cmds[i], response);
>          }
> -        response = hmp("%s", hmp_cmds[i]);
>          g_free(response);
>      }
>  
> -- 
> 2.13.1.394.g41dd433
> 
> 

Reviewed-by: Eduardo Otubo <otubo@redhat.com>

-- 
Eduardo Otubo
