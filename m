Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8Ac-0006dD-Dt
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dp8AX-0004cJ-GK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dp8AX-0004bh-7u
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3B767CE04
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 07:21:07 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-3-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09983e6e-9506-ca02-a8ce-b1a1773d793c@redhat.com>
Date: Tue, 5 Sep 2017 09:20:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 02/29] tests: Sort .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 01.09.2017 20:03, Eric Blake wrote:
> It doesn't matter if things are unsorted, but finding stuff in a list
> is easier when it is sorted.  (Sorted under LC_ALL=3DC rules, rather th=
an
> en_US.UTF-8).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/.gitignore | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

BTW, did you note the patch "build-sys: generate tests/.gitignore" from
Marc-Andr=C3=A9 ? Maybe the list can be generated automatically, too...

> diff --git a/tests/.gitignore b/tests/.gitignore
> index 64ecd6683b..8d35a58751 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -1,25 +1,27 @@
> +*-test

... but looking at this wildcard, I wonder if we just named most of our
tests in a bad way. If we name the files something-test instead of
test-something, we maybe do not need the automatic generation from
Marc-Andr=C3=A9 (which is kind of ugly because it writes to the source
directory - and this should not happen when doing out of tree builds).

So what do you think about renaming our tests, so that the above
wildcard applies instead?

 Thomas

>  atomic_add-bench
>  benchmark-crypto-cipher
>  benchmark-crypto-hash
>  benchmark-crypto-hmac
>  check-qdict
> -check-qnum
>  check-qjson
>  check-qlist
>  check-qnull
> -check-qstring
> +check-qnum
>  check-qom-interface
>  check-qom-proplist
> -multiboot/test.out
> +check-qstring
>  multiboot/*.elf
> +multiboot/test.out
> +qapi-schema/*.test.*
>  qht-bench
>  rcutorture
>  test-aio
>  test-aio-multithread
>  test-arm-mptimer
>  test-base64
> -test-bitops
>  test-bitcnt
> +test-bitops
>  test-blockjob
>  test-blockjob-txn
>  test-bufferiszero
> @@ -35,18 +37,19 @@ test-crypto-ivgen
>  test-crypto-pbkdf
>  test-crypto-secret
>  test-crypto-tlscredsx509
> -test-crypto-tlscredsx509-work/
>  test-crypto-tlscredsx509-certs/
> +test-crypto-tlscredsx509-work/
>  test-crypto-tlssession
> -test-crypto-tlssession-work/
>  test-crypto-tlssession-client/
>  test-crypto-tlssession-server/
> +test-crypto-tlssession-work/
>  test-crypto-xts
>  test-cutils
> +test-filter-mirror
> +test-filter-redirector
>  test-hbitmap
>  test-hmp
>  test-int128
> -test-iov
>  test-io-channel-buffer
>  test-io-channel-command
>  test-io-channel-command.fifo
> @@ -55,27 +58,29 @@ test-io-channel-file.txt
>  test-io-channel-socket
>  test-io-channel-tls
>  test-io-task
> +test-iov
>  test-keyval
>  test-logging
>  test-mul64
> +test-netfilter
>  test-opts-visitor
>  test-qapi-event.[ch]
>  test-qapi-types.[ch]
>  test-qapi-util
>  test-qapi-visit.[ch]
>  test-qdev-global-props
> -test-qemu-opts
>  test-qdist
> +test-qemu-opts
>  test-qga
>  test-qht
>  test-qht-par
>  test-qmp-commands
>  test-qmp-commands.h
>  test-qmp-event
> -test-qobject-input-strict
> -test-qobject-input-visitor
>  test-qmp-introspect.[ch]
>  test-qmp-marshal.c
> +test-qobject-input-strict
> +test-qobject-input-visitor
>  test-qobject-output-visitor
>  test-rcu-list
>  test-replication
> @@ -92,8 +97,3 @@ test-write-threshold
>  test-x86-cpuid
>  test-x86-cpuid-compat
>  test-xbzrle
> -test-netfilter
> -test-filter-mirror
> -test-filter-redirector
> -*-test
> -qapi-schema/*.test.*
>=20
