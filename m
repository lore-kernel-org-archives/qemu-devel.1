Received: from eggs.gnu.org ([2001:4830:134:3::10]:46095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1CR9-0001GM-MQ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1CR5-0008VY-NK
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:52:27 -0400
References: <20180323225739.17329-1-laurent@vivier.eu>
	<87a7us8dov.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0eda03dd-309c-9662-347c-d1c02686df34@vivier.eu>
Date: Wed, 28 Mar 2018 16:52:05 +0200
MIME-Version: 1.0
In-Reply-To: <87a7us8dov.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 00/20] linux-user: move arch
 specific parts to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org

Le 28/03/2018 à 16:41, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Some files like signal.c are really hard to read
>> because all architectures are mixed in the same
>> file.
>>
>> This series moves from signal.c these parts to
>> the architecture dedicated directories in linux-user.
>> Moreover, this allows to compare easier functions
>> between architectures (it helps to debug problems).
>> Adding new functions for a new architecture will
>> be facilitated too.
>>
>> checkpatch.pl is not happy... but I only want to
>> move code from a file to another. I don't want
>> to change the content of the parts I move.
> 
> I think de-tabifying is worth it as it's a whitespace fix. Sure you can
> leave everything else.
> 
> Anyway for the rest of the series it looks good to me (although I only
> tested ARM).
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thank you,

For testing, I have "debootstrap"ed the following architectures:

stretch: s390x ppc64le mipsel mips64el mips arm aarch64
jessie:  ppc
lenny:   hppa
sid:     m68k ppc64 sh4

I've tried sparc32plus, sparc64 and alpha but they are already broken
without this patch series.

For the other architectures, I rely only on the results of "make check".
(microblaze, cris, nios2, openrisc, tilegx, riscv, xtensa).

If someone has pointers to debian repo for these archs, please share.

Thanks,
Laurent
