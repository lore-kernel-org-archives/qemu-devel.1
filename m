Received: from eggs.gnu.org ([2001:4830:134:3::10]:59981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBhkX-00049b-Tr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBhkU-0001Qq-P4
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:19:53 -0400
References: <20180426140253.3918-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4f0eec20-64a6-fb8f-58ae-1fab9ef34f53@redhat.com>
Date: Thu, 26 Apr 2018 16:19:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180426140253.3918-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: Don't zero-initialize statics for
 serial_hds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 26.04.2018 16:02, Peter Maydell wrote:
> checkpatch reminds us that statics shouldn't be zero-initialized:
> 
> ERROR: do not initialise statics to 0 or NULL
> #35: FILE: vl.c:157:
> +static int num_serial_hds = 0;
> 
> ERROR: do not initialise statics to 0 or NULL
> #36: FILE: vl.c:158:
> +static Chardev **serial_hds = NULL;
> 
> I forgot to fix this in 6af2692e86f9fdfb3d; do so now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I wouldn't bother with this except that I forgot to fold
> it in when applying the serial-limits patchset.
> 
>  vl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 616956adf1..6d8b869dad 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -154,8 +154,8 @@ QEMUClockType rtc_clock;
>  int vga_interface_type = VGA_NONE;
>  static DisplayOptions dpy;
>  int no_frame;
> -static int num_serial_hds = 0;
> -static Chardev **serial_hds = NULL;
> +static int num_serial_hds;
> +static Chardev **serial_hds;
>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>  Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
>  Chardev *sclp_hds[MAX_SCLP_CONSOLES];
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
