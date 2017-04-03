Received: from eggs.gnu.org ([2001:4830:134:3::10]:55391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv1Y1-0001gb-CA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv1Y0-0005mq-Nc
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:57:29 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:32923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv1Y0-0005mA-H4
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:57:28 -0400
Received: by mail-lf0-x22d.google.com with SMTP id h125so72648607lfe.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:57:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170401004624.30886-14-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 13:57:06 +0100
Message-ID: <CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 1 April 2017 at 01:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
> unimplemented-device needs to be created and mapped using
> create_unimplemented_device()

This isn't correct -- create_unimplemented_device() is
just a utility function; you can create, configure, initialize
and map it "by hand" if you want.

> and won't work with -device.

This is true, though, as with any sysbus device that has
a memory region.

> Remove the user_creatable flag from the device class.

I'm obviously missing context, because in master it doesn't
have code to set the user_creatable flag in the first place.
Wouldn't it be better to just not add that, rather than
add it and then delete it?

thanks
-- PMM
