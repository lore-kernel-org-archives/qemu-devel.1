Received: from eggs.gnu.org ([2001:4830:134:3::10]:44184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dSNwi-0005D2-DI
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dSNwh-0000IG-GY
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:32:52 -0400
Date: Tue, 4 Jul 2017 14:14:48 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170704121447.2humqsbvy4zvmpkk@eukaryote>
References: <20170704103427.22791-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170704103427.22791-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: delete the -e and -6 options
 from the 'create' command
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

On Tue, Jul 04, 2017 at 11:34:27AM +0100, Daniel P. Berrange wrote:
> The '-e' and '-6' options to the 'create' command were "deprecated"
> in favour of the more generic '-o' option many years ago:
> 
>   commit eec77d9e712bd4157a4e1c0b5a9249d168add738
>   Author: Jes Sorensen <Jes.Sorensen@redhat.com>
>   Date:   Tue Dec 7 17:44:34 2010 +0100
> 
>     qemu-img: Deprecate obsolete -6 and -e options
> 
> Except this was never actually a deprecation, which would imply giving
> the user a warning while the functionality continues to work for a
> number of releases before eventual removal. Instead the options were
> immediately turned into an error + exit. Given that the functionality
> is already broken, there's no point in keeping these psuedo-deprecation
> messages around any longer.

Sounds and looks good.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

FWIW:

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

> diff --git a/qemu-img.c b/qemu-img.c
> index 91ad6be..a65239f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -464,7 +464,7 @@ static int img_create(int argc, char **argv)
>              {"object", required_argument, 0, OPTION_OBJECT},
>              {0, 0, 0, 0}
>          };
> -        c = getopt_long(argc, argv, ":F:b:f:he6o:q",
> +        c = getopt_long(argc, argv, ":F:b:f:ho:q",
>                          long_options, NULL);
>          if (c == -1) {
>              break;
> @@ -488,14 +488,6 @@ static int img_create(int argc, char **argv)
>          case 'f':
>              fmt = optarg;
>              break;
> -        case 'e':
> -            error_report("option -e is deprecated, please use \'-o "
> -                  "encryption\' instead!");
> -            goto fail;
> -        case '6':
> -            error_report("option -6 is deprecated, please use \'-o "
> -                  "compat6\' instead!");
> -            goto fail;
>          case 'o':
>              if (!is_valid_option_list(optarg)) {
>                  error_report("Invalid option list: %s", optarg);
> -- 
> 2.9.4
> 
> 

-- 
/kashyap
