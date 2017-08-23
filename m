Received: from eggs.gnu.org ([2001:4830:134:3::10]:58233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dkS30-0007KK-3e
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dkS2w-0003sB-T4
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:34:02 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dkS2w-0003rf-Lh
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:33:58 -0400
Received: by mail-wm0-x241.google.com with SMTP id r187so1744965wma.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 02:33:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85908531-fc26-5647-9b62-38485f77d11c@redhat.com>
Date: Wed, 23 Aug 2017 11:33:55 +0200
MIME-Version: 1.0
In-Reply-To: <0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 23/08/2017 10:35, Thomas Huth wrote:
>> If you have a many-core machine, of course, there's no simpler solution
>> than throwing more CPUs at it. :)
> Is it safe nowadays to run "make check -j4" for example? Last time I
> tried (maybe 1 or 2 years ago), there were still issues since some tests
> were using hard-coded temporary file names, so the parallel tests were
> disturbing each other, for example...

I run -j18 all the time. :)

Paolo
