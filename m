Received: from eggs.gnu.org ([2001:4830:134:3::10]:49142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1doryl-0005OM-9t
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1doryd-0005xu-N6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1doryd-0005xC-H3
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6981B40220
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 14:03:46 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-2-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f00ee153-b5e8-a95d-8d45-3ec9867dfb5d@redhat.com>
Date: Mon, 4 Sep 2017 16:03:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 01/29] tests: Improve .gitignore for
 tests/multiboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>

On 01.09.2017 20:03, Eric Blake wrote:
> Right now, tests/multiboot is not run by default during 'make check';
> but when it is run in-tree, it was leaving some junk behind that could
> accidentally get checked in with a careless 'git add tests'.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index fed0189a5a..64ecd6683b 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -10,6 +10,8 @@ check-qnull
>  check-qstring
>  check-qom-interface
>  check-qom-proplist
> +multiboot/test.out

Your patch is of course a good idea ... but that test.out smells quite
bad ... I guess it should (a) use mktemp for a better file name instead
so that we can run this in parallel and (b) clean up the temporary file
once the test has been done?

> +multiboot/*.elf
>  qht-bench
>  rcutorture
>  test-aio
> 

 Thomas
