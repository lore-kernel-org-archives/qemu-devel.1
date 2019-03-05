Received: from eggs.gnu.org ([209.51.188.92]:38216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Fbt-0003mz-Sj
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Fbr-0008Gn-Vu
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:20:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1Fbr-0008EJ-Nf
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:20:15 -0500
References: <CAGZZdDHc12gHaNNisqqBek+2ox1BiuHhwR2k0Tavmt_t+x_D5A@mail.gmail.com>
	<0ac05885-96d6-9355-0333-31a909fd943b@redhat.com>
	<CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3249d2a0-f981-9da1-c4a0-f61dc0acd66d@redhat.com>
Date: Tue, 5 Mar 2019 13:20:11 -0600
MIME-Version: 1.0
In-Reply-To: <CAGZZdDEp7vxzxbWoHn5AF3g28FKSwka1WQB=U5MTv6X=XLeL7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset,
 make -p and -c boolean (no arg)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: unai.martinezcorral@ehu.eus
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu

On 3/5/19 1:15 PM, Unai Martinez Corral wrote:

>>> +      find /proc/sys/fs/binfmt_misc/ -type f -name 'qemu-*' -exec sh -c
>>> 'echo -1 > {}' \;
>>
>> echo -1 is not portable (you are not guaranteed that echo won't try to
>> treat it as an option); better would be using printf.
> 
> Incidentally, I tried with MSYS2 and fedora:29 docker container. On
> both of them , 'echo -1' works, while 'printf -1' does not. Anyway, I
> replaced it with 'printf %s -1'. Hope it is ok.

You are correct that 'printf -1' is likely to fail, 'printf -- -1' is 
portable but unusual, and 'printf %s\\n -1' is identical to the common 
(but non-portable) behavior of 'echo -1'. Is the newline important?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
