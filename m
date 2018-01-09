Received: from eggs.gnu.org ([2001:4830:134:3::10]:53658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYt0m-0002MC-Hi
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYt0h-0001x6-Lb
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:12 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYt0h-0001w8-BZ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:28:07 -0500
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-3-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <034ef359-05f9-41e3-61b6-8b351ac9d452@vivier.eu>
Date: Tue, 9 Jan 2018 13:27:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/20] include/fpu/softfloat: remove
 USE_SOFTFLOAT_STRUCT_TYPES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, peter.maydell@linaro.org, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Le 09/01/2018 à 13:22, Alex Bennée a écrit :
> It's not actively built and when enabled things fail to compile. I'm
> not sure the type-checking is really helping here. Seeing as we "own"
> our softfloat now lets remove the cruft.

I think it would be better to fix the build break than to remove the
type-checking tool.

but that's only my opinion...

Thanks,
Laurent
