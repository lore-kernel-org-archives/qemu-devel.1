Received: from eggs.gnu.org ([2001:4830:134:3::10]:52046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcswb-0001yJ-Ca
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcswO-0002Yx-47
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcswN-0002Y3-Tu
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:39:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D89C061467
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 12:39:54 +0000 (UTC)
Date: Wed, 2 Aug 2017 13:39:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170802123948.GL4098@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-7-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728121040.631-7-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/6] seccomp: adding documentation to
 new seccomp model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com

On Fri, Jul 28, 2017 at 02:10:40PM +0200, Eduardo Otubo wrote:
> Adding new documention under docs/ to describe every one and each new
> option added by the seccomp refactoring patchset.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  docs/seccomp.txt | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 docs/seccomp.txt
> 
> diff --git a/docs/seccomp.txt b/docs/seccomp.txt
> new file mode 100644
> index 0000000000..4b7edba312
> --- /dev/null
> +++ b/docs/seccomp.txt
> @@ -0,0 +1,31 @@
> +QEMU Seccomp system call filter
> +===============================
> +
> +Starting from Qemu version 2.10, the seccomp filter does not work as a
> +whitelist but as a blacklist instead. This method allows safer deploys since
> +only the strictly forbidden system calls will be black-listed and the
> +possibility of breaking any workload is close to zero.
> +
> +The default option (-sandbox on) has a slightly looser security though and the
> +reason is that it shouldn't break any backwards compatibility with previous
> +deploys and command lines already running. But if the intent is to have a
> +better security from this version on, one should make use of the following
> +additional options properly:
> +
> +* [,obsolete=allow]: It allows Qemu to run safely on old system that still
> +  relies on old system calls.

We should support 'allow' and 'deny' for all of the options. THis allows
the callers to be explicit about the state, if they don't wish to rely on
the QEMU defaults

> +
> +* [,elevateprivileges=deny|allow|children]: It allows or denies Qemu process
> +  to elevate its privileges by blacklisting all set*uid|gid system calls. The
> +  'children' option sets the PR_SET_NO_NEW_PRIVS to 1 which allows helpers
> +  (forls and execs) to run unprivileged.
> +
> +* [,spawn=deny]: It blacklists fork and execve syste calls, avoiding Qemu to
> +  spawn new threads or processes.
> +
> +* [,resourcecontrol=deny]: It blacklists all process affinity and scheduler
> +  priority system calls to avoid any bigger of the process.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
