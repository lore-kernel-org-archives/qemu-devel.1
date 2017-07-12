Received: from eggs.gnu.org ([2001:4830:134:3::10]:47007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPpA-0007na-Qs
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPp7-0002FR-LC
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:09:36 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPp7-0002F0-Hq
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:09:33 -0400
Received: by mail-qt0-x22d.google.com with SMTP id i2so24282739qta.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 15:09:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170712162550.8061-1-berrange@redhat.com>
	<bc2c99e9-3449-be02-bee1-b557e959fdb7@amsat.org>
Message-ID: <1f339196-57b3-3998-66f9-4aa0ec57c30c@amsat.org>
Date: Wed, 12 Jul 2017 19:09:29 -0300
MIME-Version: 1.0
In-Reply-To: <bc2c99e9-3449-be02-bee1-b557e959fdb7@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Don't enable networking as a side-effect
 of DEBUG=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/12/2017 06:46 PM, Philippe Mathieu-Daudé wrote:
> now trying old debian release:
> 
> $ docker run --rm -it debian:wheezy sh -c "cat /etc/debian_version"; 
> echo $?
> 7.11
> 0
> 
> $ docker run --rm -it debian:wheezy bash -c "cat /etc/debian_version"; 
> echo $?
> 139

Indeed using debian:wheezy based dockerfile:

$ make docker-test-quick@debian7
[...]
Step 4/14 : RUN apt-get update
  ---> Running in 305758a09ca4
E: Method http has died unexpectedly!
E: Sub-process http received a segmentation fault.
The command '/bin/sh -c apt-get update' returned a non-zero code: 100

$ dmesg
sh[25336] vsyscall attempted with vsyscall=none ip:ffffffffff600400 
cs:33 sp:7fffa210e208 ax:ffffffffff600400 si:7fffa210ef60 di:0
sh[25336]: segfault at ffffffffff600400 ip ffffffffff600400 sp 
00007fffa210e208 error 15

note, this does test Fam's "docker.py: Improve subprocess exit code 
handling" :P
