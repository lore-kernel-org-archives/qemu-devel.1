Received: from eggs.gnu.org ([2001:4830:134:3::10]:34785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cUAsS-0006Zz-Qz
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:27:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cUAsO-0005yL-Tw
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:27:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cUAsO-0005xb-NH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:27:32 -0500
References: <1484773521-16530-1-git-send-email-laurent@vivier.eu>
	<510d4403-7ca4-4536-8896-44835f253dc4@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <01027665-7e44-76bc-a15e-11492a7cef11@vivier.eu>
Date: Thu, 19 Jan 2017 12:27:13 +0100
MIME-Version: 1.0
In-Reply-To: <510d4403-7ca4-4536-8896-44835f253dc4@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/7] target-m68k: implement 680x0 FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

Le 18/01/2017 à 22:42, Richard Henderson a écrit :
> On 01/18/2017 01:05 PM, Laurent Vivier wrote:
>> This series modifies the original ColdFire FPU implementation
>> to use floatx80 instead of float64 internally as this
>> is the native datatype for 680x0. I didn't keep the float64
>> type for ColdFire, but if someone thinks it's required I
>> can update this series in this way.
> 
> I think at minimum you'll need to round to float64.  But this control is
> also needed for 68040 FPU, so probably you can use the same helpers.
> 
> I'm thinking something like
> 
> void helper_foo_d(args);
> {
>   ...
>   r80 = floatx80_foo(args);
>   r64 = floatx80_to_float64(r80, &env->fp_status);
>   r80 = float64_to_floatx80(r64, &env->fp_status);
>   [store r80]
>   ...
> }
> 
> since iirc 68040 has fadd.d, fadd.s to go with fadd.

OK, I will modify this part.

Thanks,
Laurent
