Received: from eggs.gnu.org ([2001:4830:134:3::10]:57969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQab8-0008EL-Dy
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 10:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQab4-00082o-Dv
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 10:11:26 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQab4-00082J-9n
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 10:11:22 -0500
Received: by mail-qt0-x242.google.com with SMTP id g10so17290884qtj.12
	for <qemu-devel@nongnu.org>; Sun, 17 Dec 2017 07:11:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171217052945.12782-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b9491b5d-452c-d26f-a2c7-992ab2852591@amsat.org>
Date: Sun, 17 Dec 2017 12:11:17 -0300
MIME-Version: 1.0
In-Reply-To: <20171217052945.12782-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] scsi: replace hex constants with #defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 12/17/2017 02:29 AM, Paolo Bonzini wrote:
> Sense keys have nice #defines in scsi/constants.h, use them.
> 
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scsi/utils.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/scsi/utils.c b/scsi/utils.c
> index 61bc1a8e2b..ddae650a99 100644
> --- a/scsi/utils.c
> +++ b/scsi/utils.c
> @@ -339,16 +339,16 @@ int scsi_convert_sense(uint8_t *in_buf, int in_len,
>  int scsi_sense_to_errno(int key, int asc, int ascq)
>  {
>      switch (key) {
> -    case 0x00: /* NO SENSE */
> -    case 0x01: /* RECOVERED ERROR */
> -    case 0x06: /* UNIT ATTENTION */
> +    case NO_SENSE:
> +    case RECOVERED_ERROR:
> +    case UNIT_ATTENTION:
>          /* These sense keys are not errors */
>          return 0;
> -    case 0x0b: /* COMMAND ABORTED */
> +    case ABORTED_COMMAND: /* COMMAND ABORTED */
>          return ECANCELED;
> -    case 0x02: /* NOT READY */
> -    case 0x05: /* ILLEGAL REQUEST */
> -    case 0x07: /* DATA PROTECTION */
> +    case NOT_READY:
> +    case ILLEGAL_REQUEST:
> +    case DATA_PROTECT:
>          /* Parse ASCQ */
>          break;
>      default:
> 
