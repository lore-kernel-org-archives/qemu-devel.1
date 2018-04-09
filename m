Received: from eggs.gnu.org ([2001:4830:134:3::10]:44250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f5LFq-0005bJ-Bi
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f5LFp-0007Uu-Gd
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:05:54 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:44775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f5LFp-0007TN-9q
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 21:05:53 -0400
Received: by mail-io0-x243.google.com with SMTP id d7so7652129ioc.11
	for <qemu-devel@nongnu.org>; Sun, 08 Apr 2018 18:05:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 9 Apr 2018 09:05:51 +0800
Message-ID: <CAOGPPbeuVrgGxoyoFvY_v_zHDh1O1GvLdy1WSR+31Au374NVyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, licq@mellanox.com, Aviad Yehezkel <aviadye@mellanox.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>, adido@mellanox.com

ping.

On Sat, Apr 7, 2018 at 4:26 PM, Lidong Chen <jemmy858585@gmail.com> wrote:
> Current Qemu RDMA communication does not support send and receive
> data at the same time, so when RDMA live migration with postcopy
> enabled, the source qemu return path thread get qemu file error.
>
> Those patch add the postcopy support for RDMA live migration.
>
> Lidong Chen (5):
>   migration: create a dedicated connection for rdma return path
>   migration: add the interface to set get_return_path
>   migration: implement the get_return_path for RDMA iochannel
>   migration: fix qemu carsh when RDMA live migration
>   migration: disable RDMA WRITR after postcopy started.
>
>  migration/qemu-file-channel.c |  12 ++--
>  migration/qemu-file.c         |  13 +++-
>  migration/qemu-file.h         |   2 +-
>  migration/rdma.c              | 148 ++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 163 insertions(+), 12 deletions(-)
>
> --
> 1.8.3.1
>
