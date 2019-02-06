Received: from eggs.gnu.org ([209.51.188.92]:46245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grJR6-00029x-Nv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grJR5-0006RA-HM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:24:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1grJR5-0006Py-9z
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:24:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id v16so4818165wrn.11
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 01:23:58 -0800 (PST)
Date: Wed, 6 Feb 2019 10:23:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190206092353.7tfo56bqasgg6vvo@steredhat>
References: <20190204204517.23698-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204204517.23698-1-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/input/tsc210x: Fix building with no
 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On Mon, Feb 04, 2019 at 09:45:17PM +0100, Philippe Mathieu-Daudé wrote:
> When building with TSC_VERBOSE not defined, we get:
>       CC      arm-softmmu/hw/input/tsc210x.o
>     hw/input/tsc210x.c: In function ‘tsc2102_data_register_write’:
>     hw/input/tsc210x.c:554:5: error: label at end of compound statement
>          default:
>          ^~~~~~~
>     hw/input/tsc210x.c: In function ‘tsc2102_control_register_write’:
>     hw/input/tsc210x.c:638:5: error: label at end of compound statement
>          bad_reg:
>          ^~~~~~~
>     hw/input/tsc210x.c: In function ‘tsc2102_audio_register_write’:
>     hw/input/tsc210x.c:766:5: error: label at end of compound statement
>          default:
>          ^~~~~~~
>     make[1]: *** [rules.mak:69: hw/input/tsc210x.o] Error 1
> 
> Fix this by replacing the culprit fprintf(stderr) calls by a more
> recent API: qemu_log_mask(LOG_GUEST_ERROR). Other fprintf() calls
> are left untouched.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/input/tsc210x.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
