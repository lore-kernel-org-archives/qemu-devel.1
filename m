Received: from eggs.gnu.org ([2001:4830:134:3::10]:58636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTa2m-00039j-96
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTa2i-0007XT-Ea
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:07:48 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTa2i-0007XE-AZ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 15:07:44 -0500
Received: by mail-qt0-x241.google.com with SMTP id a29so24019315qtb.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:07:44 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-9-git-send-email-batuzovk@ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f0064823-5190-c3ab-444c-8e8229b36fdb@twiddle.net>
Date: Tue, 17 Jan 2017 12:07:40 -0800
MIME-Version: 1.0
In-Reply-To: <1484644078-21312-9-git-send-email-batuzovk@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/18] target/arm: support access to vector
 guest registers as globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>

On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
> +    for (i = 0; i < 16; i++) {
> +        overlap_temps[i][0] = GET_TCGV_V128(cpu_Q[i]);
> +        overlap_temps[i][1] = (TCGArg)-1;
> +        sub_temps[i][0] = GET_TCGV_V64(cpu_D[i * 2]);
> +        sub_temps[i][1] = GET_TCGV_V64(cpu_D[i * 2 + 1]);
> +        sub_temps[i][2] = (TCGArg)-1;
> +        tcg_temp_set_overlap_temps(GET_TCGV_V64(cpu_D[i * 2]),
> +                                   overlap_temps[i]);
> +        tcg_temp_set_overlap_temps(GET_TCGV_V64(cpu_D[i * 2 + 1]),
> +                                   overlap_temps[i]);
> +        tcg_temp_set_sub_temps(GET_TCGV_V128(cpu_Q[i]), sub_temps[i]);
>      }

Should we simply detect this generically as the registers are declared?  This 
seems tedious to do for each target.


r~
