Received: from eggs.gnu.org ([2001:4830:134:3::10]:38055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv27r-0000IN-G3
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cv27n-0000J9-DO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:34:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cv27n-0000Iy-88
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:34:27 -0400
Date: Mon, 3 Apr 2017 10:34:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170403133416.GB1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Apr 03, 2017 at 01:57:06PM +0100, Peter Maydell wrote:
> On 1 April 2017 at 01:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > unimplemented-device needs to be created and mapped using
> > create_unimplemented_device()
> 
> This isn't correct -- create_unimplemented_device() is
> just a utility function; you can create, configure, initialize
> and map it "by hand" if you want.

OK, I will rewrite it.

> 
> > and won't work with -device.
> 
> This is true, though, as with any sysbus device that has
> a memory region.
> 
> > Remove the user_creatable flag from the device class.
> 
> I'm obviously missing context, because in master it doesn't
> have code to set the user_creatable flag in the first place.

This is in patch 01/19: cannot_instantiate_with_device_add_yet
was replaced with !user_creatable.

> Wouldn't it be better to just not add that, rather than
> add it and then delete it?

The device was already user-creatable, but it was not explicit in
the code. Patch 03/19 sets user_creatable=false on sysbus but
adds explicit user_creatable=true on the 20 devices that are
currently accepted by qemu-system-x86_64. The remaining patches
clear user_creatable on individual devices types.

-- 
Eduardo
