Received: from eggs.gnu.org ([2001:4830:134:3::10]:49442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVNtE-00015W-61
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVNtA-0007Im-3Y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:10:12 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVNt9-0007Ia-UT
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 17:10:08 -0400
Received: by mail-qt0-x244.google.com with SMTP id o9-v6so1156226qtp.3
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 14:10:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180619203918.65450-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c14e207-829c-f43d-5a97-ac83d4f4c5c4@amsat.org>
Date: Tue, 19 Jun 2018 18:10:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180619203918.65450-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: Simplify .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com

On 06/19/2018 05:39 PM, Eric Blake wrote:
> Commit 0bcc8e5b was yet another instance of 'git status' reporting
> dirty files after an in-tree build, thanks to the new binary
> tests/check-block-qdict.
> 
> Instead of piecemeal exemptions of each new binary as they are
> added, let's use git's negative globbing feature to exempt ALL
> files that have a 'test-' or 'check-' prefix, except for the ones
> ending in '.c' or '.sh'.  We still have a couple of generated
> files that then need (re-)exclusion, but the overall list is a
> LOT shorter, and less prone to needing future edits.

Finally :)

> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/.gitignore | 93 +++-----------------------------------------------------
>  1 file changed, 5 insertions(+), 88 deletions(-)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index 2bc61a9a58d..08e2df1ce1f 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -2,101 +2,18 @@ atomic_add-bench
>  benchmark-crypto-cipher
>  benchmark-crypto-hash
>  benchmark-crypto-hmac
> -check-qdict
> -check-qnum
> -check-qjson
> -check-qlist
> -check-qlit
> -check-qnull
> -check-qobject
> -check-qstring
> -check-qom-interface
> -check-qom-proplist
> +check-*
> +!check-*.c
> +!check-*.sh
>  qht-bench
>  rcutorture
> -test-aio
> -test-aio-multithread
> -test-arm-mptimer
> -test-base64
> -test-bdrv-drain
> -test-bitops
> -test-bitcnt
> -test-block-backend
> -test-blockjob
> -test-blockjob-txn
> -test-bufferiszero
> -test-char
> -test-clone-visitor
> -test-coroutine
> -test-crypto-afsplit
> -test-crypto-block
> -test-crypto-cipher
> -test-crypto-hash
> -test-crypto-hmac
> -test-crypto-ivgen
> -test-crypto-pbkdf
> -test-crypto-secret
> -test-crypto-tlscredsx509
> -test-crypto-tlscredsx509-work/
> -test-crypto-tlscredsx509-certs/
> -test-crypto-tlssession
> -test-crypto-tlssession-work/
> -test-crypto-tlssession-client/
> -test-crypto-tlssession-server/
> -test-crypto-xts
> -test-cutils
> -test-hbitmap
> -test-hmp
> -test-int128
> -test-iov
> -test-io-channel-buffer
> -test-io-channel-command
> -test-io-channel-command.fifo
> -test-io-channel-file
> -test-io-channel-file.txt
> -test-io-channel-socket
> -test-io-channel-tls
> -test-io-task
> -test-keyval
> -test-logging
> -test-mul64
> -test-opts-visitor
> +test-*
> +!test-*.c
>  test-qapi-commands.[ch]
>  test-qapi-events.[ch]
>  test-qapi-types.[ch]
> -test-qapi-util
>  test-qapi-visit.[ch]
> -test-qdev-global-props
> -test-qemu-opts
> -test-qdist
> -test-qga
> -test-qht
> -test-qht-par
> -test-qmp-cmds
> -test-qmp-event
> -test-qobject-input-strict
> -test-qobject-input-visitor
>  test-qapi-introspect.[ch]
> -test-qobject-output-visitor
> -test-rcu-list
> -test-replication
> -test-shift128
> -test-string-input-visitor
> -test-string-output-visitor
> -test-thread-pool
> -test-throttle
> -test-timed-average
> -test-uuid
> -test-util-sockets
> -test-visitor-serialization
> -test-vmstate
> -test-write-threshold
> -test-x86-cpuid
> -test-x86-cpuid-compat
> -test-xbzrle
> -test-netfilter
> -test-filter-mirror
> -test-filter-redirector
>  *-test
>  qapi-schema/*.test.*
>  vm/*.img
> 
