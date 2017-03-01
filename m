Received: from eggs.gnu.org ([2001:4830:134:3::10]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj9vd-0006Wl-Mb
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj9vc-0001NW-RP
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:28:49 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj9vc-0001Mt-Ju
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 14:28:48 -0500
Received: by mail-wm0-x234.google.com with SMTP id n11so7521636wma.0
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 11:28:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
References: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 19:28:25 +0000
Message-ID: <CAFEAcA9VV8d+DGx5qN38npAqve7o5+copu3FFvFF2dnrSRExTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2017 at 17:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> Second lot of ARM changes to sneak in before freeze:
>  * fixed version of the raspi2 sd controller patches
>  * GICv3 save/restore
>  * v7M QOMify
>
> I've also included the Linux header update patches stolen
> from Paolo's pullreq since it hasn't quite hit master yet.
>
> thanks
> -- PMM
>
> The following changes since commit 1bbe5dc66b770d7bedd1d51d7935da948a510dd6:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170228' into staging (2017-02-28 14:50:17 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170228-1
>
> for you to fetch changes up to 1eeb5c7deacbfb4d4cad17590a16a99f3d85eabb:
>
>   bcm2835: add sdhost and gpio controllers (2017-02-28 17:10:00 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * raspi2: add gpio controller and sdhost controller, with
>    the wiring so the guest can switch which controller the
>    SD card is attached to
>    (this is sufficient to get raspbian kernels to boot)
>  * GICv3: support state save/restore from KVM
>  * update Linux headers to 4.11
>  * refactor and QOMify the ARMv7M container object

Applied, thanks.

-- PMM
