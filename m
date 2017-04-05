Received: from eggs.gnu.org ([2001:4830:134:3::10]:55764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvsWH-0008Rc-48
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvsWG-0005l7-Do
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:31:13 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvsWG-0005kn-76
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:31:12 -0400
Received: by mail-wr0-x234.google.com with SMTP id t20so33899954wra.1
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 14:31:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170405212512.GB15566@thinpad.lan.raisama.net>
References: <20170404202429.14643-1-ehabkost@redhat.com>
	<20170404202429.14643-2-ehabkost@redhat.com>
	<9ae31b10-0f8c-69fc-c53b-089f89beda3e@redhat.com>
	<20170405212512.GB15566@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Apr 2017 22:30:50 +0100
Message-ID: <CAFEAcA89c4AmEyVyTPZ+NjFKvy3wG-J2875=rO=Wok5NOdc46A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 01/21] qdev: Replace
 cannot_instantiate_with_device_add_yet with !user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>

On 5 April 2017 at 22:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
> It's true that q35 wouldn't break if it simply used
> user_creatable after applying this series. But it will break if
> one day we link code that registers a user-creatable non-x86
> device inside the qemu-system-x86_64 binary (even if by
> accident), or if we add a new user-creatable sysbus device for
> other x86 machines (e.g. isapc, xenfv, xenpv, pc-i440fx).

I would some day like us to be able to move towards
multiple-architectures-one-qemu-binary, so yes, we
should not assume that no non-x86 devices or CPUs
could ever be linked in.

thanks
-- PMM
