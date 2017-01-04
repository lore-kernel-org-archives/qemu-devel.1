Received: from eggs.gnu.org ([2001:4830:134:3::10]:46626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cOs5M-00033l-EV
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cOs5J-0000vB-9Y
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:23:00 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:50942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cOs5I-0000uR-VY
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 15:22:57 -0500
References: <1482946636-3743-1-git-send-email-laurent@vivier.eu>
	<5307cfdf-ced1-a2b3-4ebf-bedbe51a3e55@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d098e9e9-8499-386f-1661-1410a8e10455@vivier.eu>
Date: Wed, 4 Jan 2017 21:22:39 +0100
MIME-Version: 1.0
In-Reply-To: <5307cfdf-ced1-a2b3-4ebf-bedbe51a3e55@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Le 04/01/2017 à 20:35, Richard Henderson a écrit :
> On 12/28/2016 09:37 AM, Laurent Vivier wrote:
>> the use case is
>>
>>     mmap(...);
>>     fork();
> 
> While true, we can notice that mmap contains MAP_SHARED, and trigger it
> then. Similarly for shmat.

Yes, it's a good idea, but is it really expensive to always enable the
parallel_cpus flag?

Laurent
