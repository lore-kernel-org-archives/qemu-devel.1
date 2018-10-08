Received: from eggs.gnu.org ([2001:4830:134:3::10]:34450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g9MM0-0003Zg-QD
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g9MDo-0000xJ-2q
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:28:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1g9MDn-0000x3-Td
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:28:40 -0400
References: <20181004114312.27346-1-d.csapak@proxmox.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d2ef3fb3-80ba-6edc-46fb-fa9d73542bc3@redhat.com>
Date: Mon, 8 Oct 2018 11:28:31 +0800
MIME-Version: 1.0
In-Reply-To: <20181004114312.27346-1-d.csapak@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@redhat.com, thuth@redhat.com, sw@weilnetz.de



On 2018=E5=B9=B410=E6=9C=8804=E6=97=A5 19:43, Dominik Csapak wrote:
> this patch series aims to execute a script when qemu exits
> so that one can do cleanups when using --daemonize without
> having to use the qmp monitor

Hi:

Can you give a example of why it must be done through this way? It looks=20
to me that we can do this by monitor the pid and behave accordingly=20
through bash.

Thanks

>
> changes since v1:
>
> * refactored as qemu_launch_script, only for non-windows platforms
> * updated net/tap.c to use qemu_launch_script instead of launch_script
> * fixed a small error in the option description
>
> Dominik Csapak (3):
>    osdep: add qemu_launch_script for executing scripts
>    tap: use qemu_launch_script instead of launch_script
>    vl.c: call optional script when exiting
>
>   include/qemu/osdep.h | 12 +++++++++++
>   net/tap.c            | 56 ++++++++++---------------------------------=
---------
>   qemu-options.hx      | 20 +++++++++++++++++++
>   util/oslib-posix.c   | 34 +++++++++++++++++++++++++++++++
>   util/oslib-win32.c   |  8 ++++++++
>   vl.c                 | 29 +++++++++++++++++++++++++++
>   6 files changed, 113 insertions(+), 46 deletions(-)
>
