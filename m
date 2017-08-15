Received: from eggs.gnu.org ([2001:4830:134:3::10]:59333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dheW9-0002jh-9F
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dheW4-0005gs-Gt
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:16:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dheW4-0005gK-Ae
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:16:28 -0400
References: <1502807418-9994-1-git-send-email-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a7372d5b-5826-7a50-20ca-73081f1bb4c6@redhat.com>
Date: Tue, 15 Aug 2017 18:16:22 +0200
MIME-Version: 1.0
In-Reply-To: <1502807418-9994-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] mmio-interface: Mark as not user
 creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, KONRAD Frederic <frederic.konrad@adacore.com>, edgar.iglesias@gmail.com

On 15.08.2017 16:30, Peter Maydell wrote:
> The mmio-interface device is not something we want to allow
> users to create on the command line:
>  * it is intended as an implementation detail of the memory
>    subsystem, which gets created and deleted by that
>    subsystem on demand; it makes no sense to create it
>    by hand on the command line
>  * it uses a pointer property 'host_ptr' which can't be
>    set on the command line
> 
> Mark the device as not user_creatable to avoid confusion.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/mmio_interface.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
> index da154e5..894e980 100644
> --- a/hw/misc/mmio_interface.c
> +++ b/hw/misc/mmio_interface.c
> @@ -111,6 +111,11 @@ static void mmio_interface_class_init(ObjectClass *oc, void *data)
>      dc->realize = mmio_interface_realize;
>      dc->unrealize = mmio_interface_unrealize;
>      dc->props = mmio_interface_properties;
> +    /* Reason: pointer property "host_ptr", and this device
> +     * is an implementation detail of the memory subsystem,
> +     * not intended to be created directly by the user.
> +     */
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo mmio_interface_info = {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
