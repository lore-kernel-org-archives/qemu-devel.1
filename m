Received: from eggs.gnu.org ([2001:4830:134:3::10]:49931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cof94-0001IQ-DB
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 19:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cof93-0003Sj-Bj
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 19:49:26 -0400
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:35214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cof93-0003Sa-6q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 19:49:25 -0400
Received: by mail-ua0-x22e.google.com with SMTP id q7so35729895uaf.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 16:49:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314153626.16989-3-famz@redhat.com>
References: <20170314153626.16989-1-famz@redhat.com>
	<20170314153626.16989-3-famz@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 16 Mar 2017 16:48:43 -0700
Message-ID: <CAO_EM_k2FRArLndbSQnzbqkkmB6wRvcHCHsWbf1QRn=G=WHvZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-scsi: Fix acquire/release in
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Mar 14, 2017 at 8:36 AM, Fam Zheng <famz@redhat.com> wrote:
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index e7466d3..4939f1f 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> ...
>  bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
>  {
> -    virtio_scsi_acquire(s);
>      if (s->events_dropped) {
>          virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
>          virtio_scsi_release(s);

Did you intend to leave this virtio_scsi_release() call?

>          return true;
>      }
> -    virtio_scsi_release(s);
>      return false;
>  }
