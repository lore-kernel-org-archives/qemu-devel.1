Received: from eggs.gnu.org ([2001:4830:134:3::10]:34525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foDJr-0003Tk-LU
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1foDJo-0006LS-IJ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:43:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1foDJo-0006Kf-7V
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:43:28 -0400
References: <20180810185321.20017-1-laurent@vivier.eu>
	<91c3c3ac-83f1-18e3-2fc2-c25d329c5414@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <347efd7c-80e8-daec-e2ca-c304182ed13a@vivier.eu>
Date: Fri, 10 Aug 2018 21:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <91c3c3ac-83f1-18e3-2fc2-c25d329c5414@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: cleanup msync output in
 strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>

Le 10/08/2018 à 21:28, Richard Henderson a écrit :
> On 08/10/2018 11:53 AM, Laurent Vivier wrote:
>> -{ TARGET_NR_msync, "msync" , NULL, NULL, NULL },
>> +{ TARGET_NR_msync, "msync" , "%s(%#x,%d,%x)", NULL, NULL },
> 
> Would you mind having a look at my linux-user reorg proposal?
> It would make this change redundant.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02935.html
> 

Yes, I know your series. I posted this patch because it helped me to
debug the patch 2/2. I can remove it for this series if you prefer.

Thanks,
Laurent
