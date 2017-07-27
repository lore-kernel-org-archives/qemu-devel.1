Received: from eggs.gnu.org ([2001:4830:134:3::10]:53518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daaam-00072M-R0
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daaaj-0000hx-KA
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:40:08 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:38009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daaaj-0000hB-FU
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:40:05 -0400
Received: by mail-qt0-x22c.google.com with SMTP id t37so61572106qtg.5
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:40:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170726214010.420-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db600f68-d269-8ff2-96f0-0f41e8173b31@amsat.org>
Date: Thu, 27 Jul 2017 01:39:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170726214010.420-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: John Arbuckle <programmingkidx@gmail.com>, Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On 07/26/2017 06:40 PM, Philippe Mathieu-Daudé wrote:> patch 4: if no 
system libdtc and submodule present, compile the dtc submodule
> and verify it is at least v1.4.2. Prefixed RFC because I'm not sure about
> these 3 lines:
> 
> +    make -C dtc 1>/dev/null

which can leads to:

/bin/sh: 1: cannot create libfdt/fdt_sw.d: Read-only file system
	 DEP libfdt/fdt_wip.c

so the libdtc build should be handle more seriously :(

> 
> yes, we need to build the libdtc to be able to run the compile_prog link step
> 
> +    fdt_cflags="-I${source_path}/dtc/libfdt"
> 
> $source_path seems ok...
> 
> +    fdt_libs="-L$(pwd)/dtc/libfdt $fdt_libs"
> 
> maybe there is a better option than `pwd`
