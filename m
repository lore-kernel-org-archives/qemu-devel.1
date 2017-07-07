Received: from eggs.gnu.org ([2001:4830:134:3::10]:40751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGj6-0004fQ-6s
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGj2-0007e4-4w
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:02:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dTGj1-0007dd-Ud
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:02:24 -0400
Date: Fri, 7 Jul 2017 08:02:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170707000219.GB5149@lemon.lan>
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<149938494275.27.2782722196835942653@7a482c8a7db2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149938494275.27.2782722196835942653@7a482c8a7db2>
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: raj.khem@gmail.com, riku.voipio@iki.fi, kamil@netbsd.org, pbonzini@redhat.com, laurent@vivier.eu

On Thu, 07/06 16:49, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Subject: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t type
> Message-id: 20170628204452.41230-1-raj.khem@gmail.com
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> time make docker-test-quick@centos6
> time make docker-test-build@min-glib
> time make docker-test-mingw@fedora
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: Cannot update paths and switch to branch 'test' at the same time.
> Did you intend to checkout 'origin/patchew/20170628204452.41230-1-raj.khem@gmail.com' which can not be resolved as commit?
> Traceback (most recent call last):
>   File "/home/fam/bin/patchew", line 440, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/home/fam/bin/patchew", line 53, in git_clone_repo
>     cwd=clone)
>   File "/usr/lib64/python3.5/subprocess.py", line 271, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'checkout', 'origin/patchew/20170628204452.41230-1-raj.khem@gmail.com', '-b', 'test']' returned non-zero exit status 128
> 
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

Ignore this please, patchew is recovering from a bad state.
