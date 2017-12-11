Received: from eggs.gnu.org ([2001:4830:134:3::10]:34156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eORMT-00023L-BH
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eORMP-0003sZ-8i
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:55:25 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eORMP-0003rh-1B
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:55:21 -0500
Received: by mail-wm0-f48.google.com with SMTP id f206so15375131wmf.5
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 08:55:20 -0800 (PST)
References: <a2b410dd-1150-16a4-9376-069117a14c98@oracle.com>
	<5b24ac58-738a-ac39-f4ed-6cffb3727a26@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd3649e6-0268-7329-0574-0767fe04b3c9@redhat.com>
Date: Mon, 11 Dec 2017 17:55:12 +0100
MIME-Version: 1.0
In-Reply-To: <5b24ac58-738a-ac39-f4ed-6cffb3727a26@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] lsi_scsi: add support for
 PPR Extended Message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 11/12/2017 17:45, George Kennedy wrote:
> The LSI 53c895a code does not handle the PPR Extended Message. Add
> support to handle PPR Extended Message like SDTR and WDTR are handled.
> That is, to skip past the message bytes and ignore the message.
> 
> ---
>  hw/scsi/lsi53c895a.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 595c260..1e02a89 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -961,6 +961,10 @@ static void lsi_do_msgout(LSIState *s)
>                  DPRINTF("WDTR (ignored)\n");
>                  lsi_skip_msgbytes(s, 1);
>                  break;
> +            case 4:
> +                DPRINTF("PPR (ignored)\n");
> +                lsi_skip_msgbytes(s, 5);
> +                break;
>              default:
>                  goto bad;
>              }

Hi George,

for a patch to QEMU to be accepted, you need to confirm the origin of
your patch (according to the "Developer Certificate of Origin", see
https://developercertificate.org/).

In order to do this, it's enough to reply to this message with
"Signed-off-by: George Kennedy <george.kennedy@oracle.com>" in the reply.

Thanks,

Paolo
