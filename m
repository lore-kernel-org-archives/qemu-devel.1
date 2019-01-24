Received: from eggs.gnu.org ([209.51.188.92]:49766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmayy-0006pt-N5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmamP-0007sh-Tv
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:54:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmamN-0007j4-VA
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 03:54:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190121144841.24467-1-anthony.perard@citrix.com>
	<CAFEAcA_ytAb-K-HB3wL5baMBDkY71ksBK8hsUSFxuUeqVDFyHQ@mail.gmail.com>
	<804f8429-d3f6-dc1a-4980-fc5a44a6b3c5@msgid.tls.msk.ru>
Date: Thu, 24 Jan 2019 09:45:17 +0100
In-Reply-To: <804f8429-d3f6-dc1a-4980-fc5a44a6b3c5@msgid.tls.msk.ru> (Michael
	Tokarev's message of "Tue, 22 Jan 2019 08:40:32 +0300")
Message-ID: <87fttijvfm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] configure: Don't add Xen's libs to LDFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, Paul Durrant <paul.durrant@citrix.com>

Michael Tokarev <mjt@tls.msk.ru> writes:

> 21.01.2019 18:17, Peter Maydell wrote:
>> On Mon, 21 Jan 2019 at 14:49, Anthony PERARD <anthony.perard@citrix.com> wrote:
>>>
>>> When Xen is detected via pkg-config, it isn't necessary to modify
>>> LDFLAGS as modifying libs_softmmu is enough.
>>>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
>>> ---
>>>   configure | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 12fd34f30b..98b270974d 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2355,7 +2355,6 @@ if test "$xen" != "no" ; then
>>>       fi
>>>       QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
>>>       libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
>>> -    LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
>>>     else
>>>
>>>       xen_libs="-lxenstore -lxenctrl -lxenguest"
>>> --
>>> Anthony PERARD
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Cc'ing MJT, who first pointed out to me that this bug
>> was resulting in various binaries like the linux-user ones
>> getting linked against the Xen libs unnecessarily.
>
> Well, at that time I confirmed the patch fixes this issue, and this
> is the same change I come across too, and it is already used on Debian.
> So
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Revieved-by: Michael Tokarev <mjt@tls.msk.ru>

Typo in Reviewed-by.
