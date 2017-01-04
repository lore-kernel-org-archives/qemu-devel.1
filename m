Received: from eggs.gnu.org ([2001:4830:134:3::10]:33090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cOrLO-0007x8-TC
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cOrLL-0004uy-Qp
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:35:30 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cOrLL-0004ud-N4
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:35:27 -0500
Received: by mail-qt0-x241.google.com with SMTP id j29so4112671qtc.1
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 11:35:26 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1482946636-3743-1-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5307cfdf-ced1-a2b3-4ebf-bedbe51a3e55@twiddle.net>
Date: Wed, 4 Jan 2017 11:35:15 -0800
MIME-Version: 1.0
In-Reply-To: <1482946636-3743-1-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

On 12/28/2016 09:37 AM, Laurent Vivier wrote:
> the use case is
>
>     mmap(...);
>     fork();

While true, we can notice that mmap contains MAP_SHARED, and trigger it then. 
Similarly for shmat.


r~
