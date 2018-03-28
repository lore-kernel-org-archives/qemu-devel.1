Received: from eggs.gnu.org ([2001:4830:134:3::10]:43098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1CG1-0003f2-LX
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1CG0-0003QZ-Tk
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:40:57 -0400
References: <20180323225739.17329-1-laurent@vivier.eu>
	<20180323225739.17329-4-laurent@vivier.eu> <87bmf88dz6.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <04f81658-6c49-9846-4b0e-42f4f19607c8@vivier.eu>
Date: Wed, 28 Mar 2018 16:40:25 +0200
MIME-Version: 1.0
In-Reply-To: <87bmf88dz6.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 03/20] linux-user: move arm
 signal.c parts to arm directory
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

Le 28/03/2018 à 16:35, Alex Bennée a écrit :
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> No code change, only move code from signal.c to
>> arm/signal.c, except adding includes and
>> exporting setup_frame() and setup_rt_frame().
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Apparently there are some tabs in the old code, could you de-tabify on
> the next iteration please?

I don't want to change the code, just to move it.

If you look at the patchew report, you can see there are too many
changes to do...

Thanks,
Laurent
