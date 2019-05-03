Received: from eggs.gnu.org ([209.51.188.92]:48099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMVHb-0006Rx-Gv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMVHa-0005wl-Ek
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMVHa-0005uE-8j
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:19:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so7178738wra.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 03:19:10 -0700 (PDT)
References: <20190503002206.9751-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39b71c2a-9630-5a56-17c7-d74625f97d55@redhat.com>
Date: Fri, 3 May 2019 12:19:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190503002206.9751-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Initial Windows on ARM (AArch64
 64-Bit) host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org

On 5/3/19 2:22 AM, Cao Jiaxi wrote:
> Initial Windows on ARM (AArch64 64-Bit) host support
> 
> This series of patches is for initial support of Windows 10 on ARM as a QEMU host.
> Currently only TCG intepreter is working correctly, it crashes when TCG JIT is enabled.
> 
> For now we assume it is built using the clang aarch64-w64-mingw32 toolchain,
> you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mingw.
> 

I'm a bit confused since those patches appear 2 times in my mailbox.
Assuming this is a git send-email setup mistake, please consider adding
my Reviewed-by/Tested-by here too.

These are:

> Cao Jiaxi (4):
>   QEMU_PACKED: Remove gcc_struct attribute in Windows non x86 targets

No tag.

>   qga: Fix mingw compilation warnings on enum conversion

Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   util/cacheinfo: Use uint64_t on LLP64 model to satisfy Windows ARM64

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   osdep: Fix mingw compilation regarding stdio formats

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks,

Phil.
