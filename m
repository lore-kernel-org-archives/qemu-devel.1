Received: from eggs.gnu.org ([2001:4830:134:3::10]:36201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chFHo-0007cg-Ln
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chFHn-0007Dl-Lu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:47:48 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chFHn-0007B5-Em
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:47:47 -0500
Received: by mail-wm0-x231.google.com with SMTP id v77so13667034wmv.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:47:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 12:47:23 +0000
Message-ID: <CAFEAcA_xXVScYwPiQFORwcOw00Gbq800Ge9V14qK-427CSU6nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/43] ppc-for-2.9 queue 20170222
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>

On 22 February 2017 at 06:33, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170222
>
> for you to fetch changes up to fb6971c110387cf597b58c411658e3d15cc6c6fb:
>
>   hw/ppc/ppc405_uc.c: Avoid integer overflows (2017-02-22 14:28:53 +1100)
>
> NOTE: This pull request hasn't passed the full set of tests I usually
> run, because there seem to be problems with those on current master
> anyway: some of "make check" seems to wedge, and a number of travis
> builds timed out.  AFAICT this series doesn't cause any failures that
> aren't already present in upstream.
>
> ----------------------------------------------------------------
> ppc patch queue for 2017-02-22
>
> This pull request has:
>    * Yet more POWER9 instruction implementations
>    * Some extensions to the softfloat code which are necesssary for
>      some of those instructions
>    * Some preliminary patches in preparation for POWER9 softmmu
>      implementation
>    * Igor Mammedov's cleanups to unify hotplug cpu handling across
>      architectures
>    * Assorted bugfixes
>
> The softfloat and cpu hotplug changes aren't entirely ppc specific (in
> fact the hotplug stuff contains some pc specific patches).  However
> they're included here because ppc is one of the main beneficiaries,
> and the series depend on some ppc specific patches.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
