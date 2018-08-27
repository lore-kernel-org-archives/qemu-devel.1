Received: from eggs.gnu.org ([2001:4830:134:3::10]:38670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fuDtz-0007yl-34
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fuDfe-0002QI-RB
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:18:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fuDfe-0002Pu-MQ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:18:50 -0400
Date: Mon, 27 Aug 2018 17:18:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180827091845.GD19413@lemon.usersys.redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, 08/24 10:36, Brad Smith wrote:
> I very much appreciate the effort to bump up to 6.3 as I was going
> to suggest doing that at some point. But bumping up to 6.3 at the
> moment will fail with the configure script. We've switched from GCC 4.2
> to Clang. The TLS check will fail with Clang's emulated TLS. We've
> had a local patch for awhile to fix the test but I don't think it is
> appropriate to upstream as is.
> 
> Index: configure
> --- configure.orig
> +++ configure
> @@ -1876,7 +1876,7 @@ static __thread int tls_var;
>  int main(void) { return tls_var; }
>  EOF
> -if ! compile_prog "-Werror" "" ; then
> +if ! compile_prog "-Werror" "-pthread" ; then
>      error_exit "Your compiler does not support the __thread specifier for " \
>  	"Thread-Local Storage (TLS). Please upgrade to a version that does."
>  fi

Are you suggesting we use 6.2 for now?

Fam

> 
> On 8/23/2018 9:21 PM, Fam Zheng wrote:
> > Upgrade OpenBSD to 6.3 using auto_install. Especially, drop SDL1,
> > include SDL2.
> > 
> > One limitation of this patch is that we need a temporary HTTP server on
> > host 80 port for auto_install, because slirp cannot do guest forward on
> > "host addr".
