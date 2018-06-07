Received: from eggs.gnu.org ([2001:4830:134:3::10]:56737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQr9u-0001SS-Es
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQr9t-0008Qh-3J
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:24:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fQr9s-0008QN-U0
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:24:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83A8E859AE
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 09:24:40 +0000 (UTC)
Date: Thu, 7 Jun 2018 17:24:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180607092437.GA14550@lemon.usersys.redhat.com>
References: <20180605200425.24323.56023.stgit@gimli.home>
	<152828099311.435.14096853919877213743@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152828099311.435.14096853919877213743@d39dc562802a>
Subject: Re: [Qemu-devel] [PULL 0/6] VFIO updates 2018-06-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com

On Wed, 06/06 03:29, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20180605200425.24323.56023.stgit@gimli.home
> Subject: [Qemu-devel] [PULL 0/6] VFIO updates 2018-06-05
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> time make docker-test-mingw@fedora
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: unable to access 'https://github.com/patchew-project/qemu/': Empty reply from server
> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>   File "/usr/bin/patchew", line 442, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/usr/bin/patchew", line 48, in git_clone_repo
>     stdout=logf, stderr=logf)
>   File "/usr/lib64/python3.6/subprocess.py", line 291, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1.

Can we blame this for M$? :D

Fam
