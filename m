Received: from eggs.gnu.org ([2001:4830:134:3::10]:37806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcXoM-0005dd-75
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcXoH-000104-VC
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:06:14 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dcXoH-0000xm-Pk
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:06:09 -0400
Received: by mail-pf0-x242.google.com with SMTP id t83so2647224pfj.3
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 07:06:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA_Kj8wCp-BLS45ds-RmZbp7UK_8oEBcEKgpP98CE0jNcA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <76660e09-cdf7-6069-e8c2-4facb4f0d2c3@twiddle.net>
Date: Tue, 1 Aug 2017 07:06:04 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Kj8wCp-BLS45ds-RmZbp7UK_8oEBcEKgpP98CE0jNcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Cleaning up handling of CPU exceptions accessing
 non-existent memory/devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

On 08/01/2017 03:50 AM, Peter Maydell wrote:
> Does this seem like a good plan?

Seems reasonable to me.

I'll warn you ahead of time that Alpha raises a machine-check exception for all 
of these, which qemu will dutifully raise.  But I never filled in those bits in 
the rom; the machine-check entry point will invoke qemu shutdown.


r~
