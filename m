Received: from eggs.gnu.org ([2001:4830:134:3::10]:39886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzlv8-0000Oh-Gi
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzlv3-00038P-Vy
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dzlv3-00037b-PL
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:49:09 -0400
Date: Wed, 4 Oct 2017 09:49:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171004094902.7b3cf56c@t450s.home>
In-Reply-To: <20171004154420.34596-1-vsementsov@virtuozzo.com>
References: <20171004154420.34596-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] checkpatch: fix incompatibility with old
 perl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com

On Wed,  4 Oct 2017 18:44:20 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Do not use '/r' modifier which was introduced in perl 5.14.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Fixes: 3e5875afc0f ("checkpatch: check trace-events code style")
Tested-by: Alex Williamson <alex.williamson@redhat.com>

Thanks

>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3c0a28e644..0c41f1212f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1432,7 +1432,8 @@ sub process {
>  					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
>  
>  				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
> -				my $tmpline = $rawline =~ s/($hex[.:\/ ])+$hex//gr;
> +				my $tmpline = $rawline;
> +				$tmpline =~ s/($hex[.:\/ ])+$hex//g;
>  
>  				if ($tmpline =~ /(?<!0x)$hex/) {
>  					ERROR("Hex numbers must be prefixed with '0x'\n" .
