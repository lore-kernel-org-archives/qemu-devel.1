Received: from eggs.gnu.org ([2001:4830:134:3::10]:36097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPBng-00075Z-Lk
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:35:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPBnb-0002Le-J7
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:35:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPBnb-0002Fq-9N
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:35:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181119154737.9840-1-liq3ea@163.com>
Date: Tue, 20 Nov 2018 20:34:53 +0100
In-Reply-To: <20181119154737.9840-1-liq3ea@163.com> (Li Qiang's message of
	"Mon, 19 Nov 2018 07:47:34 -0800")
Message-ID: <87bm6j8rvm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Li Qiang <liq3ea@163.com> writes:

> And also do some code cleanup.
> A lot of thanks to Markus's review and advice.
>
> Li Qiang (3):
>   fw_cfg: fix -boot bootsplash error checking
>   fw_cfg: fix -boot reboot-timeout error checking
>   fw_cfg: make qemu_extra_params_fw locally
>
>  hw/nvram/fw_cfg.c       | 68 ++++++++++++++++++-----------------------
>  include/sysemu/sysemu.h |  1 -
>  vl.c                    |  4 +--
>  3 files changed, 32 insertions(+), 41 deletions(-)

fw_cfg.c has no maintainer.  Who would be willing to merge this?
