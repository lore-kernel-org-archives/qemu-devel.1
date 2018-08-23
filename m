Received: from eggs.gnu.org ([2001:4830:134:3::10]:56733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fssQO-0005ME-Cm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fssQK-0004CL-6k
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:25:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fssQJ-0004B7-QX
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:25:28 -0400
References: <20180823133540.12973-1-pbonzini@redhat.com>
	<CAFEAcA_GidqNpjz+xV0Rix7YbZToZT8t+=dQ-+UxBLo3cbbfMw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <959d62e8-6a27-c115-01e7-88b0fbe5a7aa@redhat.com>
Date: Thu, 23 Aug 2018 18:25:24 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_GidqNpjz+xV0Rix7YbZToZT8t+=dQ-+UxBLo3cbbfMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/69] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23/08/2018 18:16, Peter Maydell wrote:
> 
> tests/libqtest.c: In function 'qtest_is_old_versioned_machine':
> tests/libqtest.c:1019:13: warning: array subscript has type 'char'
> [-Wchar-subscripts]
>              if (!isdigit(*chr) && *chr != '.') {
>              ^
> 
> Code should be using qemu_isdigit(). We don't enforce -Werror
> on NetBSD, though, so we could let this through and fix it up
> later...

As you prefer.  I can send a v4 too.

> Test failure on x86-64 Linux (debug build):
> 
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> gtester -k --verbose -m=qui
> ck tests/test-replication
> TEST: tests/test-replication... (pid=6535)
>   /replication/primary/read:                                           OK
>   /replication/primary/write:                                          OK
>   /replication/primary/start:                                          OK
>   /replication/primary/stop:                                           OK
>   /replication/primary/do_checkpoint:                                  OK
>   /replication/primary/get_error_all:                                  OK
>   /replication/secondary/read:                                         OK
>   /replication/secondary/write:                                        OK
>   /replication/secondary/start:                                        **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:120:test_blk_write:
> assertion failed: (async_ret == 0)
> FAIL
> GTester: last random seed: R02Sb173bafaddab398fce3309452c295220
> (pid=6688)
>   /replication/secondary/stop:                                         OK
>   /replication/secondary/do_checkpoint:                                OK
>   /replication/secondary/get_error_all:                                OK
> FAIL: tests/test-replication
> 
> I'm just checking whether that fails consistently or if it's a random/
> intermittent.

That would be strange, since I'm not touching the block layer at all
(not my turf!)...

Paolo
