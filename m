Received: from eggs.gnu.org ([2001:4830:134:3::10]:47612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etEV3-0004tG-Bm
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etEUy-0001jL-OO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:27:33 -0500
Date: Tue, 6 Mar 2018 16:27:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180306162718.318ed9b6.cohuck@redhat.com>
In-Reply-To: <1519407778-23095-3-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-3-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] s390x/sclp: clean up sclp masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Fri, 23 Feb 2018 18:42:57 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> Introduce an sccb_mask_t to be used for SCLP event masks instead of just
> unsigned int or uint32_t. This will allow later to extend the mask with
> more ease.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/char/sclpconsole-lm.c          |  4 ++--
>  hw/char/sclpconsole.c             |  4 ++--
>  hw/s390x/event-facility.c         | 20 ++++++++++----------
>  hw/s390x/sclpcpu.c                |  4 ++--
>  hw/s390x/sclpquiesce.c            |  4 ++--
>  include/hw/s390x/event-facility.h | 22 +++++++++++++---------
>  6 files changed, 31 insertions(+), 27 deletions(-)
> 

> @@ -177,10 +181,10 @@ typedef struct SCLPEventClass {
>      int (*exit)(SCLPEvent *event);
>  
>      /* get SCLP's send mask */
> -    unsigned int (*get_send_mask)(void);
> +    sccb_mask_t (*get_send_mask)(void);
>  
>      /* get SCLP's receive mask */
> -    unsigned int (*get_receive_mask)(void);
> +    sccb_mask_t (*get_receive_mask)(void);
>  
>      int (*read_event_data)(SCLPEvent *event, EventBufferHeader *evt_buf_hdr,
>                             int *slen);

This gained a context conflict (trivial to fix, no need to resend.)
