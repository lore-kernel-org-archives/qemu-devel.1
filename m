Received: from eggs.gnu.org ([2001:4830:134:3::10]:49341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwJln-0006lv-IJ
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwJlk-0004LI-E5
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:09:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwJlk-0004Kd-7P
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:09:16 -0400
Date: Mon, 25 Sep 2017 11:09:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170925030912.GC22980@lemon.lan>
References: <1506095371-23160-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506095371-23160-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] docker: add installation to build tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Fri, 09/22 17:49, Paolo Bonzini wrote:
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 6865689..1522aab 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -36,3 +36,11 @@ build_qemu()
>      $QEMU_SRC/configure $config_opts
>      make $MAKEFLAGS
>  }
> +
> +install_qemu()
> +{
> +    make install $MAKEFLAGS DESTDIR=$PWD/=destdir

Why provide DESTDIR? build_qemu already has "--prefix=$INSTALL_DIR", can a
simple "make install $MAKEFLAGS" work? Is there a permission problem?

> +    ret=$?
> +    rm -rf $PWD/=destdir

Why is this cleanup needed given the container will go away anyway?

Fam
