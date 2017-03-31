Received: from eggs.gnu.org ([2001:4830:134:3::10]:53130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctx0n-0000Aq-Tl
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctx0m-0002AT-Od
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:54:45 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctx0m-00029x-HW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:54:44 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k6so102009761wre.2
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 06:54:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
References: <1490968309-13672-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 14:54:22 +0100
Message-ID: <CAFEAcA_8ogigRq-x6EwaTqOCqe2kDP1p7c-AyOsB6_ndzB4YUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 31 March 2017 at 14:51, Peter Maydell <peter.maydell@linaro.org> wrote:
> In commit e330c118f2a5a the last usage of main_loop_wait() that cared
> about the return value was changed to no longer use it. Drop the
> now-useless return value and make the function return void.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Coverity complains (CID 1372464) about main_loop() calling
> main_loop_wait() and ignoring its return value. I suspect
> this change will just displace that to within main_loop_wait()
> itself since the underlying issue there is "the ppoll() that
> gets called to poll fds can return an error code, but what
> do we do if it does?". Suggestions on that point welcome.
>
> I guess this will make the compiler warn about ret being
> set and never used if CONFIG_SLIRP is not defined, which
> is irritating. I'm postponing messing about with fixing
> that in favour of seeing whether anybody has a good answer
> to the question above (which might make it moot).
> ---

...oops, I meant to tag this RFC; never mind.

thanks
-- PMM
