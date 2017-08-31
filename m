Received: from eggs.gnu.org ([2001:4830:134:3::10]:45865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnN3R-0006Lu-JC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnN3Q-0002rn-Ul
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:50:33 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnN3Q-0002qa-P0
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:50:32 -0400
Received: by mail-wr0-x22f.google.com with SMTP id z91so1060444wrc.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 03:50:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <655077175.310569.1504175675199@mail.yahoo.com>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
	<47171733.403781.1504103700042@mail.yahoo.com>
	<20170830192838.5bb5a45c@bahia>
	<655077175.310569.1504175675199@mail.yahoo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 11:50:10 +0100
Message-ID: <CAFEAcA-EhBOg55azXgQfgSf-6UEOpggntYGHq+YRaVACGe=8pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mahmood <nt_mahmood@yahoo.com>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <huth@tuxfamily.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Thomas Huth <th.huth@posteo.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

On 31 August 2017 at 11:34, Mahmood via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> Hello again,
> For the command
>
>     mount -t 9p -o trans=virtio Downloads /media/Downloads
>
> inside the Centos-7 guest, I get this error
>
> mount: unknown filesystem type '9p'
>
> Any thought?

That's an issue with your guest OS (probably it doesn't
have 9p support enabled in the kernel).

thanks
-- PMM
