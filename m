Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2f7a-00034P-Tw
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2f7V-00058J-1C
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:37:46 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2f7U-00056s-R2
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 10:37:40 -0400
Received: by mail-wm0-x235.google.com with SMTP id u65so24983885wmu.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:37:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 15:37:19 +0100
Message-ID: <CAFEAcA_65Vxn=sm7U_BLHiUwUk59Juy7jqLnBiDjU6DDr8xMvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/15] Error reporting patches for 2017-04-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 April 2017 at 08:26, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-04-24
>
> for you to fetch changes up to 021c9d25b30f53f3e97ed3198f0a85c7db025174:
>
>   error: Apply error_propagate_null.cocci again (2017-04-24 09:13:45 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2017-04-24
>
> ----------------------------------------------------------------
> Fam Zheng (14):
>       socket: Make errp the last parameter of socket_connect
>       socket: Make errp the last parameter of inet_connect_saddr
>       socket: Make errp the last parameter of unix_connect_saddr
>       socket: Make errp the last parameter of vsock_connect_saddr
>       block: Make errp the last parameter of bdrv_img_create
>       crypto: Make errp the last parameter of functions
>       mirror: Make errp the last parameter of mirror_start_job
>       block: Make errp the last parameter of commit_active_start
>       nfs: Make errp the last parameter of nfs_client_open
>       fdc: Make errp the last parameter of fdctrl_connect_drives
>       scsi: Make errp the last parameter of virtio_scsi_common_realize
>       migration: Make errp the last parameter of local functions
>       qga: Make errp the last parameter of qga_vss_fsfreeze
>       error: Apply error_propagate_null.cocci again
>
> Max Reitz (1):
>       util/error: Fix leak in error_vprepend()

Applied, thanks.

-- PMM
