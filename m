Received: from eggs.gnu.org ([2001:4830:134:3::10]:47759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gK3gH-0008AW-D5
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gK3gG-0008Mu-HR
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:54:17 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gK3gG-0008Lo-CF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:54:16 -0500
Received: by mail-qt1-x841.google.com with SMTP id u34-v6so3120216qth.3
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 07:54:16 -0800 (PST)
References: <20181029173437.32559-1-pbonzini@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <fa37541c-a2a8-8bbc-6114-e15b650da020@gmail.com>
Date: Tue, 6 Nov 2018 13:54:12 -0200
MIME-Version: 1.0
In-Reply-To: <20181029173437.32559-1-pbonzini@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/4] scsi-generic: fixes for Block Limits
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mreitz@redhat.com

Hi,

How did you find all those issues, Max? First patch is something that
I missed out from the SCSI spec (ordering of the VPD pages)
and could have been detected by code inspection,  but I am curious about
the other fixes.


Thanks,


Daniel

On 10/29/18 2:34 PM, Paolo Bonzini wrote:
> scsi-generic (pass through) devices are able to inject an artificial Block
> Limits VPD page in order to communicate host HBA limits to the guest.
> However, Max Reitz found a few issues with the implementation of this
> feature; this series should fix them all.
>
> Paolo
>
> Paolo Bonzini (4):
>    scsi-generic: keep VPD page list sorted
>    scsi-generic: avoid out-of-bounds access to VPD page list
>    scsi-generic: avoid invalid access to struct when emulating block
>      limits
>    scsi-generic: do not do VPD emulation for sense other than
>      ILLEGAL_REQUEST
>
>   hw/scsi/Makefile.objs       |  2 +-
>   hw/scsi/emulation.c         | 42 +++++++++++++++++
>   hw/scsi/scsi-disk.c         | 92 ++++++++-----------------------------
>   hw/scsi/scsi-generic.c      | 51 +++++++++++++++-----
>   include/hw/scsi/emulation.h | 16 +++++++
>   include/hw/scsi/scsi.h      |  1 -
>   6 files changed, 119 insertions(+), 85 deletions(-)
>   create mode 100644 hw/scsi/emulation.c
>   create mode 100644 include/hw/scsi/emulation.h
>
