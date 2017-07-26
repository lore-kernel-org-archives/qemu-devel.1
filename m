Received: from eggs.gnu.org ([2001:4830:134:3::10]:53207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daUQq-00087Z-9j
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daUQn-0004KZ-1d
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:05:28 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daUQm-0004KH-TT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 18:05:24 -0400
Received: by mail-qt0-x244.google.com with SMTP id i19so8288417qte.1
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:05:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150110567183.114.17390976982809714249@5d477a5b5989>
	<6ccbdea1-be5e-2dbe-d84a-314fc2d6f666@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fbc58485-a450-e92c-70e2-7c993bc60c53@amsat.org>
Date: Wed, 26 Jul 2017 19:05:19 -0300
MIME-Version: 1.0
In-Reply-To: <6ccbdea1-be5e-2dbe-d84a-314fc2d6f666@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 0/4] check dtc submodule is
 outdated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, james.hogan@imgtec.com, quintela@redhat.com, crosthwaite.peter@gmail.com, programmingkidx@gmail.com, yongbok.kim@imgtec.com, pbonzini@redhat.com, aurelien@aurel32.net

On 07/26/2017 06:56 PM, Eric Blake wrote:
> On 07/26/2017 04:47 PM, no-reply@patchew.org wrote:
>> This series failed build test on s390x host. Please find the details below.
>>
[...]
>> === PACKAGES === >> dtc-1.4.2-1.fc25.s390x


>> === TEST BEGIN ===
>> Using CC: /home/fam/bin/cc
>>
>> ERROR: fdt disabled but some requested targets require it.
>>         You can turn off fdt only if you also disable all the system emulation
>>         targets which need it (by specifying a cut down --target-list).
> 
> Well, your new configure check certainly fired!  The question is whether
> it was supposed to (meaning patchew needs to tweak what it tries to
> configure), or whether there's a logic bug in your patch (meaning it
> fails when it shouldn't have).

It seems I missed something :(
