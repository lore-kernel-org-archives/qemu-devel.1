Received: from eggs.gnu.org ([2001:4830:134:3::10]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzmXO-0003ht-68
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzmXN-0006oJ-67
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzmXM-0006nZ-Vv
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 12:28:45 -0400
Date: Wed, 4 Oct 2017 17:28:33 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171004162833.GO17517@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171004154420.34596-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004154420.34596-1-vsementsov@virtuozzo.com>
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, alex.williamson@redhat.com

On Wed, Oct 04, 2017 at 06:44:20PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Do not use '/r' modifier which was introduced in perl 5.14.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
