Received: from eggs.gnu.org ([2001:4830:134:3::10]:42885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diNkS-0002z1-5z
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diNkP-0002Yk-2O
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:34:20 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:34287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diNkO-0002YS-Tp
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:34:16 -0400
Received: by mail-qt0-x22a.google.com with SMTP id s6so40566205qtc.1
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 09:34:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150294568458.27.15059400979281725389@205a2245145f>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4479ec55-27d7-ee0f-c21c-28a8a0d10a81@amsat.org>
Date: Thu, 17 Aug 2017 13:34:11 -0300
MIME-Version: 1.0
In-Reply-To: <150294568458.27.15059400979281725389@205a2245145f>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, hpoussin@reactos.org, aurelien@aurel32.net, yongbok.kim@imgtec.com, peter.maydell@linaro.org, thuth@redhat.com, james.hogan@imgtec.com, ehabkost@redhat.com, Eric Blake <eblake@redhat.com>

On 08/17/2017 01:54 AM, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20170817043102.6322-1-f4bug@amsat.org
> Subject: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
> 
[...]
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 1557a1941b mips: update mips_cpu_list() to use object_class_get_list()
> fff05e4786 mips: replace cpu_mips_init() with cpu_generic_init()
> 78afa559f4 !fixup mips: now than MIPSCPU is QOMified, mark it abstract
> ff2926570c mips: MIPSCPU model subclasses
> 36f62a8a0b mips: call cpu_mips_realize_env() from mips_cpu_realizefn()
> 825094780c mips: split cpu_mips_realize_env() out of cpu_mips_init()
> 7339de695e mips: introduce internal.h and cleanup cpu.h
> 011150634e mips: move hw/mips/cputimer.c to target/mips/
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/8: mips: move hw/mips/cputimer.c to target/mips/...
> Checking PATCH 2/8: mips: introduce internal.h and cleanup cpu.h...
> ERROR: space prohibited after that '&' (ctx:WxW)
> #725: FILE: target/mips/internal.h:230:
> +    if ((env->CP0_VPControl >> CP0VPCtl_DIS) & 1) {
>                                                ^
> 

I doubt CHECKPATCH is correct here, removing the space it'd look like 
handling pointer address...

> ERROR: space prohibited after that '&' (ctx:WxW)
> #733: FILE: target/mips/internal.h:238:
> +            ((other_cpu->env.CP0_VPControl >> CP0VPCtl_DIS) & 1)) {
>                                                               ^
> 
> ERROR: space prohibited after that '&' (ctx:WxW)
> #753: FILE: target/mips/internal.h:258:
> +        env->hflags |= (env->CP0_Status >> CP0St_KSU) & MIPS_HFLAG_KSU;
>                                                         ^
> 
> total: 3 errors, 0 warnings, 842 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/8: mips: split cpu_mips_realize_env() out of cpu_mips_init()...
> Checking PATCH 4/8: mips: call cpu_mips_realize_env() from mips_cpu_realizefn()...
> Checking PATCH 5/8: mips: MIPSCPU model subclasses...
> Checking PATCH 6/8: !fixup mips: now than MIPSCPU is QOMified, mark it abstract...
> Checking PATCH 7/8: mips: replace cpu_mips_init() with cpu_generic_init()...
> Checking PATCH 8/8: mips: update mips_cpu_list() to use object_class_get_list()...
> === OUTPUT END ===
