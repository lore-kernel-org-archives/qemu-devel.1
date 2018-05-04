Received: from eggs.gnu.org ([2001:4830:134:3::10]:56545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEeX2-0002EL-Ux
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:30:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEeX0-0000qZ-BS
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:30:08 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEeX0-0000pr-4Q
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:30:06 -0400
Received: by mail-pf0-x243.google.com with SMTP id j5so17959446pfh.2
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 10:30:06 -0700 (PDT)
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
	<20180504132023.GA5098@localhost.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2207b0b-889a-e39f-2f55-640118e2d755@linaro.org>
Date: Fri, 4 May 2018 10:30:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180504132023.GA5098@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 05/04/2018 06:20 AM, Kevin Wolf wrote:
> I'm not sure what the exact systemd model is, but as we came to the
> conclusion that there is no semantic difference between major and minor
> version number for QEMU, I'd just merge them.
> 
> This would result in 3.0 for the next release, 3.1 etc. would be stable
> releases, and the December release would be 4.0.
> 
> It feels like the minimal change to fix our existing versioning scheme.

This is very similar to what GCC started to use at version 5.

    https://gcc.gnu.org/develop.html#num_scheme

I do think it makes sense to drop minor versions, leaving only major +
patchlevel (which then appears to be minor version).


r~
