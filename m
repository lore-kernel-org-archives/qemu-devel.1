Received: from eggs.gnu.org ([2001:4830:134:3::10]:38271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9Q8-0002Fw-Fz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9Q5-0003i6-8W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:37:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9Q5-0003fs-0l
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:37:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so521672wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:37:00 -0700 (PDT)
Received: from [192.168.10.165] (dynamic-adsl-78-12-231-174.clienti.tiscali.it.
	[78.12.231.174]) by smtp.gmail.com with ESMTPSA id
	l125-v6sm3606555wmb.1.2018.10.18.07.36.58 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Oct 2018 07:36:59 -0700 (PDT)
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
	<1b245c6c0803d4bf11dcbf9eb32f34af8c2bd0b4.1539846575.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <712ab847-303f-6535-1399-b1668cb6b5e4@redhat.com>
Date: Thu, 18 Oct 2018 16:36:57 +0200
MIME-Version: 1.0
In-Reply-To: <1b245c6c0803d4bf11dcbf9eb32f34af8c2bd0b4.1539846575.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] vl: improve/fix documentation
 related to RTC function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 18/10/2018 09:12, Artem Pisarenko wrote:
> +To even prevent it from progressing during suspension, you can set it to
> +@code{vm} (virtual clock). Virtual clock is the clock seen by guest,
> +In icount mode of emulation its (long term) speed will be different from
> +any host clock, when icount configured to non-auto value or virtual cpu sleeping
> +is off, and no synchronization algorithm is active.
>  

Slight rephrasing:

To even prevent the RTC from progressing during suspension, you can set
@option{clock} to @code{vm} (virtual clock). @samp{clock=vm} is
recommended especially in icount mode in order to preserve determinism;
however, note that in icount mode the speed of the virtual clock is
variable and can in general differ from the host clock.

(omitting the reference to -icount auto etc.)
Paolo
