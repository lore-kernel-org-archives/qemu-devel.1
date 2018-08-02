Received: from eggs.gnu.org ([2001:4830:134:3::10]:53806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flJ2g-0006D3-NK
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flJ2b-00009t-Is
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:13:46 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:40915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flJ2b-00009f-Cm
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 15:13:41 -0400
Received: by mail-vk0-x241.google.com with SMTP id q184-v6so1578422vke.7
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 12:13:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af0a868b-20d8-a02f-f6c3-eb0d9a56b5ab@amsat.org>
Date: Thu, 2 Aug 2018 16:13:36 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] 'make vm-build-freebsd' &c don't work if KVM isn't
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

Hi Peter,

On 07/30/2018 10:23 AM, Peter Maydell wrote:
> The tests in tests/vm/ seem to make some attempt to cope with the
> host system not allowing the user to use KVM, but it doesn't quite
> work. The problem is that tests/vm/basevm.py always uses "-cpu host"
> in the QEMU options it uses to run the VM, and that only works if
> KVM is enabled. If the user can't run KVM then we correctly avoid
> passing it "-enable-kvm" but then QEMU doesn't run because "-cpu host"
> isn't supported...
> 
> I guess the right fix here is to use "-cpu max" ?

I think this is the issue I intended to address in this series:

http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03411.html
"tests/vm: Improvements when KVM is not available"
->
"tests/vm: Use 'host' cpu when KVM is available, else default to 'max'"
