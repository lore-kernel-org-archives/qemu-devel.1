Received: from eggs.gnu.org ([2001:4830:134:3::10]:51971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHrtz-0008Pa-Pt
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHrty-0000BO-RT
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:18:35 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dHrty-00009d-Kx
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:18:34 -0400
Received: by mail-wr0-x22a.google.com with SMTP id v104so38180403wrb.0
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 06:18:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <A9hzOiFaZeLEyppxRerpySXW6-0fsnzeNJlP_Ddv8ZFUd3Ppx5RTL-UPQBDbYfUXns4LETYIlV0oqIAWmgt0GgBa3312R2hMK9hizPKEHu4=@protonmail.ch>
References: <A9hzOiFaZeLEyppxRerpySXW6-0fsnzeNJlP_Ddv8ZFUd3Ppx5RTL-UPQBDbYfUXns4LETYIlV0oqIAWmgt0GgBa3312R2hMK9hizPKEHu4=@protonmail.ch>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2017 14:18:12 +0100
Message-ID: <CAFEAcA8yP400txMPqzwxa0qdt8JLtk1f4FHwYfdASAgDbT0DyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Target AVR (patch)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anichang <anichang@protonmail.ch>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 2 June 2017 at 11:22, Anichang via Qemu-devel <qemu-devel@nongnu.org> wrote:
> Attached patch since
>
> git://git.qemu.org/qemu.git 43771d5d92312504305c19abe29ec5bfabd55f01

> Running the sample board outputs:
>
> $ ./qemu-system-avr
> Unexpected error in object_property_add() at qom/object.c:940:
> qemu-system-avr: attempt to add duplicate property 'memory' to object (type 'avr5-avr')
> Aborted (core dumped)
> $

Providing a backtrace might help figuring this out.

Your patch attached to this mail appears to be a merge commit
of some kind. You don't want that -- you need to rebase the
AVR patches on current master, rather than merging anything.

thanks
-- PMM
