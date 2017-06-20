Received: from eggs.gnu.org ([2001:4830:134:3::10]:37239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNN4Y-0003uJ-4G
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNN4T-000131-6o
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:36:14 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNN4T-00012t-1d
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:36:09 -0400
Received: by mail-qk0-x243.google.com with SMTP id d14so11863777qkb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:36:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <149797903302.31986.16832888531516351733@4a9a010726c0>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <17d26e57-bbe8-9a38-e34c-bc775204bebd@amsat.org>
Date: Tue, 20 Jun 2017 14:36:03 -0300
MIME-Version: 1.0
In-Reply-To: <149797903302.31986.16832888531516351733@4a9a010726c0>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: fix tcg-interpreter build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, famz@redhat.com, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, yang.zhong@intel.com, stefanha@redhat.com, eblake@redhat.com

On 06/20/2017 02:17 PM, no-reply@patchew.org wrote:
> === OUTPUT BEGIN ===
[...]
>   CC      aarch64-softmmu/target/arm/cpu64.o
> cc: Internal error: Killed (program cc1)

This is odd...

> Please submit a full bug report.
> See <http://bugzilla.redhat.com/bugzilla> for instructions.
> make[1]: *** [target/arm/translate.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [subdir-aarch64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
> tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-_mvb4mgh/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-quick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2
> === OUTPUT END ===
