Received: from eggs.gnu.org ([2001:4830:134:3::10]:50900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crPzh-0007Sc-Bu
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crPzd-00019P-Jr
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:15:09 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crPzd-00017o-Du
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:15:05 -0400
Received: by mail-wr0-x22a.google.com with SMTP id y90so2648701wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 07:15:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490361570-288658-1-git-send-email-borntraeger@de.ibm.com>
References: <1490361570-288658-1-git-send-email-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 14:14:43 +0000
Message-ID: <CAFEAcA_7NggYw6gATm_B7rKRJX-C9dU-dCv_NF_e_5WOP_rmdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] boot-serial-test: use -no-shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 24 March 2017 at 13:19, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> a qemu with an empty s390 guest will exit very quickly. This races
> against the testsuite reading from the console pipe leading to
> intermittent test suite failures. Using -no-shutdown will keep
> the guest running.
>
> Fixes: 864111f422ba (vl: exit qemu on guest panic if -no-shutdown is not set)
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  tests/boot-serial-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 57edf6a..11f48b0 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -79,8 +79,8 @@ static void test_machine(const void *data)
>      g_assert(fd != -1);
>
>      args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> -                           " -serial chardev:serial0 %s", test->machine,
> -                           tmpname, test->extra);
> +                           " -no-shutdown -serial chardev:serial0 %s",
> +                           test->machine, tmpname, test->extra);
>
>      qtest_start(args);
>      unlink(tmpname);

Applied to master, thanks. Let's see if this fixes the travis flapping...

-- PMM
