Received: from eggs.gnu.org ([209.51.188.92]:58201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnVCe-0005dj-7Y
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnVCX-0007aI-GZ
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:09:19 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:60618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnVCW-0007XQ-PF
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:09:17 -0500
Date: Sat, 26 Jan 2019 22:09:12 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190126210912.ktxrjcaw2cmexub4@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6415e48b-ae20-2be7-590e-bd79142620b8@redhat.com>
	<20190122181822.1505-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] slirp: fix -Waddress-of-packed-member
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Hello,

Peter Maydell, le mar. 22 janv. 2019 18:18:20 +0000, a ecrit:
> These patches fix the clang -Waddress-of-packed-member warnings
> in the slirp code.

Applied to my tree, thanks!

Eric Blake, le mar. 22 janv. 2019 13:27:32 -0600, a ecrit:
> How does this series play with the ongoing effort to make libslirp an
> independent project?  I'm assuming your use of QEMU_BUILD_BUG_ON() will
> have to be translated into whatever libslirp-specific mechanism we want
> to split off into that project.

Indeed, but I guess libslirp will want to have such kind of macro
anyway, so I don't see a reason to hold this change.

Samuel
