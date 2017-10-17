Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1e4SxY-0007nN-14
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1e4SxW-0003Sf-Nz
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:35:08 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1e4SxW-0003SE-Ib
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:35:06 -0400
Received: by mail-wm0-x243.google.com with SMTP id q124so4338775wmb.0
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 07:35:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171016123250.GB1918@kos.to>
References: <20170925231924.31303-1-carenas@gmail.com>
	<CAPUEspg5AO_XzLa1n3cCTrz+22WYk5BZrE28ufDjPP7Y3KN2+Q@mail.gmail.com>
	<20171016123250.GB1918@kos.to>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 17 Oct 2017 07:35:03 -0700
Message-ID: <CAPUEspi530ypdV0ZrKJ5b8ZbZEm-LJCwvbFAUMOmcn_FFcRHSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] linux-user: refactor socket.h into architecture
 specific sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu

On Mon, Oct 16, 2017 at 5:32 AM, Riku Voipio <riku.voipio@iki.fi> wrote:
> On Wed, Oct 11, 2017 at 12:10:04AM -0700, Carlo Arenas wrote:
>> some of the patches already have a Reviewed-by as shown by :
>>
>>   http://patchwork.ozlabs.org/patch/818378/
>
> Can you send the series without the whitespace-only changes?

sure, but how would you suggest then to do the other changes which are
the overall objective for this?

* fix any incorrect values (mostly sparc, but there are also in all
other archs incorrect names)
* make sure that the arch specific file mirrors as much as possible
linux headers, so it will be straightforward to update them (even
possible through a script)
* update the arch specific files with latest bits from 4.14

should I send those as independent series?, or just as additional
patches in the series, so it is obvious what the dependency is.

there is also the problem with the enum and related defines which was
custom made and probably copy & pasted around

Carlo
