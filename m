Received: from eggs.gnu.org ([209.51.188.92]:33495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmdqU-0001f3-LX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmdn0-0007lQ-9r
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:07:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmdmy-0007aF-GB
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:07:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A73DB13AC10
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:07:17 +0000 (UTC)
Date: Thu, 24 Jan 2019 12:07:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190124120713.GE7953@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
	<1548093980-43088-50-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548093980-43088-50-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 49/49] docker: disable Xen on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Jan 21, 2019 at 07:06:20PM +0100, Paolo Bonzini wrote:
> The Xen repository is failing to install, disable it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/centos7.docker | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
> index e0f18f5..e6fcbf4 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -1,5 +1,5 @@
>  FROM centos:7
> -RUN yum install -y epel-release centos-release-xen
> +RUN yum install -y epel-release

centos-release-xen points to the Xen 4.6 version only which is
now deleted for unknown reasons.

Strangely when they added Xen 4.8 support they introduced a
new centos-release-xen-48 package, leaving the existing
centos-release-xen broken :-(

IOW the proper fix here is likely to change to centos-release-xen-48

>  RUN yum -y update
>  ENV PACKAGES \
>      bison \
> @@ -8,7 +8,7 @@ ENV PACKAGES \
>      ccache \
>      csnappy-devel \
>      flex \
> -    g++ \
> +    gcc-c++ \
>      gcc \
>      gettext \
>      git \
> @@ -29,7 +29,6 @@ ENV PACKAGES \
>      spice-server-devel \
>      tar \
>      vte-devel \
> -    xen-devel \
>      zlib-devel
>  RUN yum install -y $PACKAGES
>  RUN rpm -q $PACKAGES | sort > /packages.txt
> -- 
> 1.8.3.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
