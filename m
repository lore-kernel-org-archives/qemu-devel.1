Received: from eggs.gnu.org ([2001:4830:134:3::10]:47732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjSGm-0001Eg-9M
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjSGl-0005iz-9P
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:03:52 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjSGl-0005iD-3E
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:03:51 -0500
Received: by mail-wr0-x22f.google.com with SMTP id u48so54277980wrc.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 07:03:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 15:03:29 +0000
Message-ID: <CAFEAcA9cge3Zf735EBcbXwOmwoGVmYZPduJE0m+nepXRJs5S4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/50] ppc-for-2.9 queue 20170301
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 1 March 2017 at 04:43, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:
>
>   vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170301
>
> for you to fetch changes up to 356bb70ed1a8a741413d55e3dbc5ccd02c53d794:
>
>   Add PowerPC 32-bit guest memory dump support (2017-03-01 11:53:58 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2017-03-01
>
> I was hoping to get this pull request squeezed in before the soft
> freeze, but I ran into some difficulties during testing.  Everything
> here was at least posted before the soft freeze, so I'm hoping we can
> still merge it for 2.9.
>
> The biggest things here are:
>     * Cleanups to handling of hashed page tables, that will make
>       adding support for the POWER9 MMU easier
>     * Cleanups to the XICS interrupt controller that will make
>       implementing the powernv machine easier
>     * TCG implementation of extended overflow and carry handling for
>       POWER9
>
> It also includes:
>     * Increasing the CPU limit for pseries to 1024 vCPUs
>     * Generating proper OF node names in qemu (making hotplug and
>       coldplug logic closer together)
>

Applied, thanks.

-- PMM
