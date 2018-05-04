Received: from eggs.gnu.org ([2001:4830:134:3::10]:52652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1fEVpv-0003VG-Et
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1fEVps-0002AI-BK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:13:03 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:55503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1fEVps-0001pq-1P
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:13:00 -0400
References: <1524153386-3550-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<87zi1g8qrd.fsf@linaro.org>
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <21a8cd56-b57a-31d9-36ac-131bd5996be0@lauterbach.com>
Date: Fri, 4 May 2018 09:12:42 +0100
MIME-Version: 1.0
In-Reply-To: <87zi1g8qrd.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v6 0/3] target/arm: Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, khaled.jmal@lauterbach.com


> Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:
>
>> The previous version:
>> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=33714
> I was trying to do some testing but I was finding it very hard to do at
> gdb kept throwing up errors like:
>
> (gdb) x/10i $pc
> => 0xffffff8008097760 <check_and_switch_context>:       Cannot access memory at address 0xffffff8008097760
> Detaching from program: /home/alex/lsrc/qemu/kernel-v8-plain.build/vmlinux, Remote target
> Ending remote debugging.
>
> However this seems to be the same on master as well so I wonder there is
> a regression somewhere.
>
> What was the last QEMU master commit you've tested these patches on?
> I'll do some more digging tomorrow.
It was:
    commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d
    Author: Peter Maydell <peter.maydell@linaro.org>
    Date:   Wed Apr 4 20:37:20 2018 +0100
        Update version for v2.12.0-rc2 release

Best regards,
Abdallah
