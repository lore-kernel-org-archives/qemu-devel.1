Received: from eggs.gnu.org ([2001:4830:134:3::10]:52354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsyEb-0000Jw-Jt
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsyEa-0008El-Ok
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:33:13 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:49974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsyEa-0008EP-Hh
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:33:12 -0400
Received: by mail-wm0-x22d.google.com with SMTP id e71so11275509wmg.4
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 14:33:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2017 22:32:50 +0100
Message-ID: <CAFEAcA9dHX1bv8ZuBBsvdkC21HuTirAaYPHXHUZkxP4GgROwjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Fixes and improvements for various
 qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

On 15 September 2017 at 09:02, Thomas Huth <thuth@redhat.com> wrote:
> The following changes since commit 3dabde1128b671f36ac6cb36b97b273139964420:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' into staging (2017-09-14 16:33:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/huth/qemu.git tags/check-20170915
>
> for you to fetch changes up to 7b899f4dd596dbb7d271f7fab36fbfffec84868e:
>
>   qtest: Avoid passing raw strings through hmp() (2017-09-15 09:05:19 +0200)
>
> ----------------------------------------------------------------
> Some fixes and improvements for various qtests by Eric and me.
>
> ----------------------------------------------------------------
> Eric Blake (5):
>       test-qga: Kill broken and dead QGA_TEST_SIDE_EFFECTING code
>       qtest: Don't perform side effects inside assertion
>       numa-test: Use hmp()
>       libqtest: Remove dead qtest_instances variable
>       qtest: Avoid passing raw strings through hmp()
>
> Thomas Huth (4):
>       tests: Introduce generic device hot-plug/hot-unplug functions
>       tests/test-hmp: Remove puv3 and tricore_testboard from the blacklist
>       tests/libqtest: Use a proper error message if QTEST_QEMU_BINARY is missing
>       tests: Fix broken ivshmem-server-msi/-irq tests

Applied, thanks.

-- PMM
