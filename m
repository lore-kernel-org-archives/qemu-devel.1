Received: from eggs.gnu.org ([2001:4830:134:3::10]:56361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYuW4-0000tf-BY
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYuW1-0003v6-6J
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:36:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYuW0-0003sd-Vb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:36:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id c13-v6so9071771wrq.2
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:36:48 -0700 (PDT)
References: <20180226130452.21309-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1229716d-6293-1cc6-8531-8a22e8c757dd@redhat.com>
Date: Fri, 29 Jun 2018 16:36:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180226130452.21309-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] serial: Open non-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com

On 26/02/2018 14:04, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> On a real serial device, the open can block if the handshake
> lines are in a particular state.  If a QEMU is passing the serial
> device to the guest, the QEMU startup is blocked opening the device
> (with a symptom seen as a timeout from libvirt).
> 
> Open the serial port with O_NONBLOCK.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  chardev/char-serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index feb52e559d..97be5d4a63 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -265,7 +265,8 @@ static void qmp_chardev_open_serial(Chardev *chr,
>      ChardevHostdev *serial = backend->u.serial.data;
>      int fd;
>  
> -    fd = qmp_chardev_open_file_source(serial->device, O_RDWR, errp);
> +    fd = qmp_chardev_open_file_source(serial->device, O_RDWR | O_NONBLOCK,
> +                                      errp);
>      if (fd < 0) {
>          return;
>      }
> 

Queued, thanks.

Paolo
