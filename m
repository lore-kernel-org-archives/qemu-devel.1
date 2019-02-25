Received: from eggs.gnu.org ([209.51.188.92]:54697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyIyH-00063h-BU
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyIyG-0000Kt-7i
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:19:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gyIyF-0000DC-U0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:19:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so10632720wrw.0
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:19:03 -0800 (PST)
References: <201902230335.59138.randrianasulu@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c9db8ef-a2a5-e634-7461-63fae4bba32d@redhat.com>
Date: Mon, 25 Feb 2019 17:19:01 +0100
MIME-Version: 1.0
In-Reply-To: <201902230335.59138.randrianasulu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>, qemu-devel@nongnu.org

Hi Andrew,

On 2/23/19 1:35 AM, Andrew Randrianasulu wrote:
> Hello!
> 
> I just pulled latest git
> 
[...]
> 
> and default build with simple ./configure on slackware 14.2 x86-64 box failed 
> like this:
> 
> root@slax:~/src/qemu# LANG=C make -j 5
>         CHK version_gen.h
>   CC      qobject/block-qdict.o
>   CC      util/thread-pool.o
>   CC      util/main-loop.o
>   CC      util/qemu-timer.o
>   CC      util/iohandler.o
>   CC      util/aio-posix.o
> qobject/block-qdict.c: In function 'qdict_array_split':
> qobject/block-qdict.c:259:9: error: 'subqdict' may be used uninitialized in this 
> function [-Werror=maybe-uninitialized]
>          qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
>          ^

That's odd, I can not reproduce with a simple ./configure:

$ cat /etc/slackware-version
Slackware 14.2

$ gcc --version
gcc (GCC) 5.5.0

>  LANG=C gcc --version
> gcc (GCC) 5.5.0
> Copyright (C) 2015 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
