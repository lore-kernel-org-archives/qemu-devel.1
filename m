Received: from eggs.gnu.org ([2001:4830:134:3::10]:56713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cOsIJ-0001Wu-Ji
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cOsIG-0000Zi-H1
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:36:23 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cOsIG-0000Yw-CX
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:36:20 -0500
Received: by mail-oi0-x241.google.com with SMTP id 3so47404291oih.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 12:36:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1482946636-3743-1-git-send-email-laurent@vivier.eu>
	<5307cfdf-ced1-a2b3-4ebf-bedbe51a3e55@twiddle.net>
	<d098e9e9-8499-386f-1661-1410a8e10455@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d46f2d82-ad23-305a-ced8-4b3035fba2d1@twiddle.net>
Date: Wed, 4 Jan 2017 12:36:08 -0800
MIME-Version: 1.0
In-Reply-To: <d098e9e9-8499-386f-1661-1410a8e10455@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: always start with
 parallel_cpus set to true
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 01/04/2017 12:22 PM, Laurent Vivier wrote:
> Yes, it's a good idea, but is it really expensive to always enable the
> parallel_cpus flag?

It is somewhat expensive when the host does support the atomics being used; it 
is very expensive if the host does not.  Of course the common case is x86_64 
host, which does, so perhaps we don't really care.


r~
