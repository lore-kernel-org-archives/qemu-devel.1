Received: from eggs.gnu.org ([2001:4830:134:3::10]:55739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWRT0-0005du-Mx
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWRSu-0005N4-QD
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:06:58 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWRSu-0005Ms-Js
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:06:52 -0400
Received: by mail-pg0-x243.google.com with SMTP id v190so594411pgv.1
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 11:06:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-14-git-send-email-imammedo@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ed511a29-f7d9-d5bb-6940-0a7256879bdb@twiddle.net>
Date: Sat, 15 Jul 2017 08:06:48 -1000
MIME-Version: 1.0
In-Reply-To: <1500040339-119465-14-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/28] hppa: replace cpu_hppa_init() with
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
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 07/14/2017 03:52 AM, Igor Mammedov wrote:
> drop custom cpu_hppa_init() in favor of cpu_generic_init(),
> to make cpu_generic_init() work all we need is to provide
> cc->class_by_name callback that would resolve any cpu_model
> to the sole TYPE_HPPA_CPU to match current behaviour.
> 
> Signed-off-by: Igor Mammedov<imammedo@redhat.com>
> ---
> CC: Richard Henderson<rth@twiddle.net>
> 
> tested with linux-user
> ---
>   target/hppa/cpu.h |  4 +---
>   target/hppa/cpu.c | 11 +++--------
>   2 files changed, 4 insertions(+), 11 deletions(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
