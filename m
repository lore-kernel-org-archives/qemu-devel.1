Received: from eggs.gnu.org ([2001:4830:134:3::10]:48251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3bP-00012R-LN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3bO-0005xu-Vz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:50:11 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX3bO-0005xN-Pa
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:50:10 -0400
Received: by mail-wr0-x231.google.com with SMTP id w4so20415779wrb.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:50:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717103937.GD5301@noname.redhat.com>
References: <20170717063521.GA7393@lemon>
	<20170717103937.GD5301@noname.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 11:49:49 +0100
Message-ID: <CAFEAcA9zoauJw-CnNxtec48VOr6onXiCZ8BV8JJwk7ZeOLxnUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 11:39, Kevin Wolf <kwolf@redhat.com> wrote:
> Only today I noticed again that two recently merged pull requests broke
> qemu-iotests cases, so I must assume that apart from some block
> maintainers, nobody runs it regularly.

If "make check" doesn't run it, it doesn't get run :-)
I actually looked into trying to run qemu-iotests tests
for the recent patches I sent for vpc and vmdk image format
handler fixes, but I couldn't get it to do anything sensible
and I couldn't find any documentation, so I gave up and
assumed that "make check" plus manual testing was good enough...

thanks
-- PMM
