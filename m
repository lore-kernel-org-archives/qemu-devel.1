Received: from eggs.gnu.org ([2001:4830:134:3::10]:59258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9ke-0001yB-5r
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9kd-0004tK-4G
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:55:44 -0500
Received: from mail-io0-x232.google.com ([2607:f8b0:4001:c06::232]:34594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9kd-0004sY-0G
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:55:43 -0500
Received: by mail-io0-x232.google.com with SMTP id f7so2277532ioh.1
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:55:42 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAFEAcA8MvShVAZf1+OOf2ZZnhD3sQ_jgED4NPWBOOySwJitD2Q@mail.gmail.com>
References: <20171221211103.30311-1-laurent@vivier.eu>
	<CAFEAcA8MvShVAZf1+OOf2ZZnhD3sQ_jgED4NPWBOOySwJitD2Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Dec 2017 19:55:41 -0300
Message-ID: <CAAdtpL46YjfBuH5XDAKYecGh0Va2bup7EVAGqT6jEO=Dwj_n5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/i386/vmport: fix missing definitions
 with x86_64-w64-mingw32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

>> Fixes: 7299e1a411
>>        ("hw/i386/vmport: replace fprintf() by trace events or LOG_UNIMP")
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>
> Looks to me like it'll be a bug for anything not configured
> using the 'log' trace backend, rather than win32 specific.

Sorry my bad, it seems I don't test enough lately, I'll try to do more
testing, and somehow to reduce CI build time, more they last, less we
rely on it, even with personal repositories.
