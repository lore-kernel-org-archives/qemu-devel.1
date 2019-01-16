Received: from eggs.gnu.org ([209.51.188.92]:37979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjjOy-0003RJ-Am
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjjOk-0003za-Fx
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:30:25 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gjjOj-0003az-QR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:30:18 -0500
Received: by mail-ot1-f43.google.com with SMTP id e12so6637793otl.5
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 03:30:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<9c9dc5f205c0e37ed622388327c10f361353de6e.1547624239.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <9c9dc5f205c0e37ed622388327c10f361353de6e.1547624239.git.yi.z.zhang@linux.intel.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 16 Jan 2019 12:30:02 +0100
Message-ID: <CAGxU2F7S6y_GBzRPoAc9RACZHGRKA4AXHWO+CrNA2jHWHqCPFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V9 5/6] hostmem: add more information in
 error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, pagupta@redhat.com, yu.c.zhang@linux.intel.com, Michael Tsirkin <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, qemu-devel@nongnu.org

On Wed, Jan 16, 2019 at 9:17 AM Zhang Yi <yi.z.zhang@linux.intel.com> wrote:
>
> When there are multiple memory backends in use, including the object type
> name and the property name in the error message can help users to locate
> the error.
>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  backends/hostmem-file.c | 6 ++++--
>  backends/hostmem.c      | 8 +++++---
>  2 files changed, 9 insertions(+), 5 deletions(-)
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
