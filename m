Received: from eggs.gnu.org ([2001:4830:134:3::10]:56007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWRV5-0006la-Ic
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWRV1-0006QH-JC
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:09:07 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWRV1-0006QA-C9
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 14:09:03 -0400
Received: by mail-pg0-x242.google.com with SMTP id y129so14394084pgy.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 11:09:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-15-git-send-email-imammedo@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
Date: Sat, 15 Jul 2017 08:08:58 -1000
MIME-Version: 1.0
In-Reply-To: <1500040339-119465-15-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/28] m68k: replace cpu_m68k_init() with
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
Cc: Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On 07/14/2017 03:52 AM, Igor Mammedov wrote:
> @@ -230,6 +230,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
>       M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
>       Error *local_err = NULL;
>   
> +    register_m68k_insns(&cpu->env);
> +

I think it would make more sense to do this during m68k_tcg_init.


r~
