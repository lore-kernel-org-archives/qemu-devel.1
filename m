Received: from eggs.gnu.org ([2001:4830:134:3::10]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpUvN-0003UD-AX
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpUvJ-0001QM-Di
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:39:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpUvJ-0001Q2-7f
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:38:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A7D2C0587D6
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 07:38:56 +0000 (UTC)
Received: from localhost (ovpn-12-90.pek2.redhat.com [10.72.12.90])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8B1F85C544
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 07:38:55 +0000 (UTC)
Date: Wed, 6 Sep 2017 15:38:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170906073853.GB19537@lemon.lan>
References: <20170906012715.31761-1-famz@redhat.com>
	<20170906012715.31761-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906012715.31761-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] buildsys: Move gnutls cflags/libs
 to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Wed, 09/06 09:27, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  configure              |  4 ++--
>  crypto/Makefile.objs   |  7 +++++++
>  tests/Makefile.include | 10 +++++-----
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/configure b/configure
> index 6a4cb3832b..d24a7eab37 100755
> --- a/configure
> +++ b/configure
> @@ -2472,8 +2472,6 @@ if test "$gnutls" != "no"; then
>      if gnutls_works; then
>          gnutls_cflags=$($pkg_config --cflags gnutls)
>          gnutls_libs=$($pkg_config --libs gnutls)
> -        libs_softmmu="$gnutls_libs $libs_softmmu"
> -        libs_tools="$gnutls_libs $libs_tools"
>  	QEMU_CFLAGS="$QEMU_CFLAGS $gnutls_cflags"

This line should be removed too.. Will send v3.

Fam
