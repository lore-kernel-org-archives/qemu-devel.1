Received: from eggs.gnu.org ([2001:4830:134:3::10]:57332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj79q-0004ju-MV
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj79p-00053b-Rv
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:31:18 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj79p-000535-Ls
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:31:17 -0500
Received: by mail-wm0-x22a.google.com with SMTP id n11so3670641wma.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 08:31:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228163436.31357-1-jcody@redhat.com>
References: <20170228163436.31357-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 16:30:55 +0000
Message-ID: <CAFEAcA_WQWnSTz8_oJ1qwGsVKKJtoQpyQXLYLEQFPNMEHp8ueg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/5] Block patches for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2017 at 16:34, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit c8c0a1a784cdf70ecea50e93213137c6c89337a7:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-28 13:41:03 +0000)
>
> are available in the git repository at:
>
>   git@github.com:codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 7a4bdbdd818fba3fb6c79d23baa3c7cb928be661:
>
>   block/rbd: add support for 'mon_host', 'auth_supported' via QAPI (2017-02-28 11:32:46 -0500)
>
> ----------------------------------------------------------------
> Block patches for 2.9 - rbd blockdev-add.  Added s-o-b's.
> ----------------------------------------------------------------

Doesn't build on some compilers:

/home/petmay01/qemu/block/rbd.c: In function 'qemu_rbd_array_opts':
/home/petmay01/qemu/block/rbd.c:605:5: error: 'for' loop initial
declarations are only allowed in C99 or C11 mode
     for (int i = 0; i < num_entries; i++) {
     ^
/home/petmay01/qemu/block/rbd.c:605:5: note: use option -std=c99,
-std=gnu99, -std=c11 or -std=gnu11 to compile your code

Variable declaration has to go at the top of a block,
not inside a for().

thanks
-- PMM
