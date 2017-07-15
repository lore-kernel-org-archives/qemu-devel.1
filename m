Received: from eggs.gnu.org ([2001:4830:134:3::10]:55545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWRRl-000572-Nw
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWRRh-0004eq-EW
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:05:41 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWRRh-0004e1-8K
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:05:37 -0400
Received: by mail-pg0-x243.google.com with SMTP id 123so2687879pgd.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 11:05:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-13-git-send-email-imammedo@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b0c4a3f8-fa31-97c6-e54c-d7755bfe8973@twiddle.net>
Date: Sat, 15 Jul 2017 08:05:31 -1000
MIME-Version: 1.0
In-Reply-To: <1500040339-119465-13-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/28] alpha: replace cpu_alpha_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 07/14/2017 03:52 AM, Igor Mammedov wrote:
> cpu_alpha_init() used to provide default fallback if invalid
> (i.e. non existent) cpu_model were provided.
> 
> dp264 machine provides its own default so sole user of fallback
> is [bsd|linux]-user targets which specifies 'any' cpu model that
> fallbacks to "ev67" in cpu_alpha_init(). Push fallback handling
> into alpha_cpu_class_by_name() and replace cpu_alpha_init() with
> cpu_generic_init().
> 
> Signed-off-by: Igor Mammedov<imammedo@redhat.com>
> ---
> PS:
>    tested only linux-user as I don't have bsd box to test on
> 
> CC: Richard Henderson<rth@twiddle.net>
> CC: Riku Voipio<riku.voipio@iki.fi>
> CC: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/alpha/cpu.h |  4 +---
>   hw/alpha/dp264.c   |  8 ++++++--
>   target/alpha/cpu.c | 20 +++++---------------
>   3 files changed, 12 insertions(+), 20 deletions(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r
