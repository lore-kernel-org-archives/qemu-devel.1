Received: from eggs.gnu.org ([2001:4830:134:3::10]:55408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csto7-0002HZ-SU
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csto6-0002x7-Uq
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:17:19 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csto6-0002wg-NL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:17:18 -0400
Received: by mail-wm0-x22d.google.com with SMTP id x124so3087896wmf.0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 09:17:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328140555.3001-1-jcody@redhat.com>
References: <20170328140555.3001-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 17:16:57 +0100
Message-ID: <CAFEAcA_NaUXJu_PeVUUoUtb=pYGXWqw_diPVV3Pg1o+QcqY-ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 00/10] Block patches for -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 28 March 2017 at 15:05, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 142b9ca51d7260d20f6e87bd7f2020ac0a7d95d9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-03-28 11:10:36 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 2836284db603775af557e969d5a800efb0190324:
>
>   rbd: Fix bugs around -drive parameter "server" (2017-03-28 10:01:21 -0400)
>
> ----------------------------------------------------------------
> Block patches for 2.9-rc2
> ----------------------------------------------------------------
>
> Markus Armbruster (10):
>   rbd: Reject -blockdev server.*.{numeric, to, ipv4, ipv6}
>   rbd: Fix to cleanly reject -drive without pool or image
>   rbd: Don't limit length of parameter values
>   rbd: Clean up after the previous commit
>   rbd: Don't accept -drive driver=rbd, keyvalue-pairs=...
>   rbd: Clean up runtime_opts, fix -drive to reject filename
>   rbd: Clean up qemu_rbd_create()'s detour through QemuOpts
>   rbd: Revert -blockdev and -drive parameter auth-supported
>   rbd: Revert -blockdev parameter password-secret
>   rbd: Fix bugs around -drive parameter "server"
>
>  block/rbd.c          | 319 ++++++++++++++-------------------------------------
>  qapi-schema.json     |  21 ++--
>  qapi/block-core.json |  30 +----
>  3 files changed, 100 insertions(+), 270 deletions(-)

Applied, thanks.

-- PMM
