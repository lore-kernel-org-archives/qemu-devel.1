Received: from eggs.gnu.org ([2001:4830:134:3::10]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKKQ6-0005SB-2S
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKKPo-0003LS-H4
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:46:36 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKKPh-0003Fe-9v
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:46:18 -0500
Received: by mail-wr1-f49.google.com with SMTP id z13-v6so14267814wrs.3
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 01:46:14 -0800 (PST)
References: <1e2ba070.db56.166ed56f891.Coremail.wj193102@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43dd7761-47ef-bbf5-ad6b-e7db5da3c91b@redhat.com>
Date: Wed, 7 Nov 2018 10:46:10 +0100
MIME-Version: 1.0
In-Reply-To: <1e2ba070.db56.166ed56f891.Coremail.wj193102@163.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] The error from compiling QEMU statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wj193102 <wj193102@163.com>, qemu-devel@nongnu.org

Hi,

On 7/11/18 9:43, wj193102 wrote:
> Hi, everybody.
> I want to compile QEMU statically. But when I make the soure files, I get the error messages. Please help me to resolve them.
> Now I will tell you the steps what I do.
> (1)$ cd qemu-3.0.0
> (2)$ ./configure --prefix=/usr --static

Can you share the output of the configure script?

> (3)$ make
> When I input the "make" command, and  run it, then I get the error messages.
> (1)/block/file-posix.c:1945: Error: There is an unknown field 'prealloc' in the initializer;
> (2)/block/file-posix.c:1946: Error: There is an unknown field 'errp' in the initializer.
> How to resolve these problems, please help me, thanks.

What is your distribution?

I can not reproduce your problem (using Fedora).

Regards,

Phil.
