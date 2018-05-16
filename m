Received: from eggs.gnu.org ([2001:4830:134:3::10]:48913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIzbx-0003sQ-Bu
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIzbs-0002kG-HP
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:49:09 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:33929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=667e0e3bc=anthony.perard@citrix.com>)
	id 1fIzbs-0002jX-77
	for qemu-devel@nongnu.org; Wed, 16 May 2018 12:49:04 -0400
Date: Wed, 16 May 2018 17:49:00 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180516164900.GA32582@perard.uk.xensource.com>
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<1525453270-23074-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525453270-23074-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] qemu-options: Bail out on
 unsupported options instead of silently ignoring them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, May 04, 2018 at 07:01:07PM +0200, Thomas Huth wrote:
> diff --git a/vl.c b/vl.c
> index 806eec2..457e93b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4042,7 +4042,10 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              default:
> -                os_parse_cmd_args(popt->index, optarg);
> +                if (os_parse_cmd_args(popt->index, optarg)) {
> +                    error_report("Option not supported in this build");
> +                    exit(1);
> +                }

I think that report false errors, I've got:
qemu-system-i386: -no-user-config: Option not supported in this build

Regards,

-- 
Anthony PERARD
