Received: from eggs.gnu.org ([2001:4830:134:3::10]:51672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dI9h8-0006hR-3c
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dI9h7-0003Wl-Br
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:18:30 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:35316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dI9h7-0003WF-5X
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:18:29 -0400
Received: by mail-pf0-x22c.google.com with SMTP id l89so20925049pfi.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 01:18:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-2-git-send-email-cota@braap.org>
	<CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8a4bac1c-9c7e-5f60-ac1c-c5aced0f8dbc@twiddle.net>
Date: Tue, 6 Jun 2017 01:18:23 -0700
MIME-Version: 1.0
In-Reply-To: <CAJhHMCDHLrU5NEuZGJqkVcJyQnXYsrdcYbNiNw4DAgiT=0R9pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] compiler: define QEMU_CACHELINE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06/05/2017 10:39 PM, Pranith Kumar wrote:
> Is there any reason not to use sysconf(_SC_LEVEL1_DCACHE_LINESIZE)?

That's an excellent idea.  In fact... see reply to 3/3.


r~
