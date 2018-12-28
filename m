Received: from eggs.gnu.org ([208.118.235.92]:49870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fw@deneb.enyo.de>) id 1gcqyl-0008Sh-Bx
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 07:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fw@deneb.enyo.de>) id 1gcqkv-00064W-5R
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 06:56:48 -0500
Received: from albireo.enyo.de ([5.158.152.32]:33156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fw@deneb.enyo.de>) id 1gcqku-0005zW-UI
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 06:56:45 -0500
From: Florian Weimer <fw@deneb.enyo.de>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<957967d7-5717-8ada-fb30-dfdf19898b6b@linaro.org>
	<87pntmu9iw.fsf@mid.deneb.enyo.de>
	<ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org>
Date: Fri, 28 Dec 2018 12:56:33 +0100
In-Reply-To: <ae0530c9-5c46-5560-9734-1eacaf173b8d@linaro.org> (Adhemerval
	Zanella's message of "Fri, 28 Dec 2018 09:53:21 -0200")
Message-ID: <87k1jtvp8u.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, libc-alpha@sourceware.org, qemu-devel@nongnu.org, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, hpa@zytor.com, arnd@arndb.de

* Adhemerval Zanella:

> On 27/12/2018 16:09, Florian Weimer wrote:
>> * Adhemerval Zanella:
>> 
>>> Also for glibc standpoint, although reverting it back to use getdents 
>>> syscall for non-LFS mode might fix this issue for architectures that
>>> provides non-LFS getdents syscall it won't be a fix for architectures 
>>> that still provides off_t different than off64_t *and* only provides 
>>> getdents64 syscall.
>>>
>>> Currently we only have nios2 and csky (unfortunately).  But since generic 
>>> definition for off_t and off64_t still assumes non-LFS support, all new
>>> 32-bits ports potentially might carry the issue.
>> 
>> For csky, we could still change the type of the non-standard d_off
>> field to long long int.  This way, only telldir would have to fail
>> when truncation is necessary, as mentioned below:
>
> I think it makes no sense to continue making non-LFS as default for
> newer 32 bits ports, the support will be emulated with LFS syscalls.

Sorry, I don't see how this matters.  seekdir and telldir are NOT
affected by LFS.
