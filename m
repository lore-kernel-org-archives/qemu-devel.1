Received: from eggs.gnu.org ([2001:4830:134:3::10]:46762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL8om-00051h-CP
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gL8ol-0002Ut-AF
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:35:32 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gL8oe-0002Do-KE
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:35:26 -0500
Received: by mail-oi1-x243.google.com with SMTP id u130-v6so1775561oie.7
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:35:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181109153002.597-2-crosa@redhat.com>
References: <20181109153002.597-1-crosa@redhat.com>
	<20181109153002.597-2-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Nov 2018 15:34:42 +0000
Message-ID: <CAFEAcA8-Av_d7A0GEQGfkdC90N41or=vni480k=4dO2daXkdZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] tests/test-qht-par: test gets
 stuck intermittently on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, G 3 <programmingkidx@gmail.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 November 2018 at 15:30, Cleber Rosa <crosa@redhat.com> wrote:
> To be fully honest, this may not be a OSX (alone) condition, but may
> be a situation that only happens with OSX on Travis-CI, were resources
> are quite limited.
>
> I have personal experience with tests that exercise parallelism or
> depend on timing to fail on Travis.  Because I'm not 100% certain that
> this is a situation that only happens with OSX on Travis-CI, and
> because I'm not certain that we should be skipping tests because
> they're running on Travis-CI, let's disable them on OSX as a whole.

Does this test still get stuck in builds after a458774ad711bceabefb ?
That fixed an OSX-specific problem that caused hangs (notably
in test-bdrv-drain, but it could I guess also affect other tests).

thanks
-- PMM
