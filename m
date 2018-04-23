Received: from eggs.gnu.org ([2001:4830:134:3::10]:41905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAYji-0007Db-3D
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAYjh-0005r8-5h
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:30:18 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:44003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAYjg-0005pd-W3
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:30:17 -0400
Received: by mail-oi0-x22b.google.com with SMTP id p62-v6so13743565oie.10
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 03:30:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423101433.17759-1-clg@kaod.org>
References: <20180423101433.17759-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 11:29:55 +0100
Message-ID: <CAFEAcA_1q4+kKunX6_d9N3+6tUFGJRRc5biqn5TqDDmh09-kiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 23 April 2018 at 11:14, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> commit 1d3e65aa7ac5 ("hw/timer: Add value matching support to
> aspeed_timer") increased the vmstate version of aspeed.timer because
> the state had changed, but it also bumped the version of the
> VMSTATE_STRUCT_ARRAY under the aspeed.timerctrl which did not need to.
>
> Change back this version to fix migration.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks, applied to target-arm.next.

>  To test on a 'palmetto-bmc' board, download the latest built OpenBMC
>  flash image :
>
>    wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3D=
palmetto/lastSuccessfulBuild/artifact/deploy/images/palmetto/flash-palmetto
>
>  start two instances of QEMU with :
>
>    qemu-system-arm -m 512 -M palmetto-bmc -drive file=3D./flash-palmetto,=
format=3Draw,if=3Dmtd -serial mon:stdio -nographic -nodefaults

Thanks also for the test image -- I'll add it to the collection I have.

PS: there seems to be something odd up with the DNS for openpower.xyz:

$ host openpower.xyz
openpower.xyz has address 146.20.65.228
;; connection timed out; no servers could be reached

(also manifests as wget pausing for several seconds before starting
the download).

thanks
-- PMM
