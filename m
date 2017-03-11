Received: from eggs.gnu.org ([2001:4830:134:3::10]:55434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmpgA-0006L8-VH
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 17:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmpg7-0008Hg-Tc
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 17:40:03 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cmpg7-0008Ha-Mr
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 17:39:59 -0500
Received: by mail-pf0-x243.google.com with SMTP id j5so14816767pfb.3
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 14:39:59 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170311034232.14213-1-rth@twiddle.net>
	<20170311034232.14213-2-rth@twiddle.net>
	<926aa266-5def-c638-e155-7ac335d02785@vivier.eu>
	<916c3939-a6c1-91ec-ea9f-4a59cbb82a59@twiddle.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3766d549-6e52-969f-9dc7-e9cc96d08e24@twiddle.net>
Date: Sun, 12 Mar 2017 08:39:51 +1000
MIME-Version: 1.0
In-Reply-To: <916c3939-a6c1-91ec-ea9f-4a59cbb82a59@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] linux-user: Restrict usage of
 sa_restorer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, deller@gmx.de, riku.voipio@iki.fi

On 03/12/2017 07:02 AM, Richard Henderson wrote:
> TARGET_ALPHA has KA_RESTORER, not sa_restorer.  The restorer value is passed to
> sigaction in a 5th register argument.  Less than handy that qemu doesn't
> distinguish the two structs...

I beg your pardon, we do -- they're just named confusingly.

target_old_sigaction/target_rt_sigaction vs target_sigaction.  The latter 
corresponds to the kernel's k_sigaction.


r~
