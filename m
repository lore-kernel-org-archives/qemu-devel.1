Received: from eggs.gnu.org ([2001:4830:134:3::10]:51366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZAOi-0005Zh-UH
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gZAOd-0002eT-Lw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:06:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gZAOc-0002d6-Ny
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 03:06:31 -0500
References: <1545065857-31164-1-git-send-email-thuth@redhat.com>
	<20181217193522.GK7141@habkost.net>
	<20181217175701-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6c52d22d-1fc6-3365-5194-25ea886228d6@redhat.com>
Date: Tue, 18 Dec 2018 09:06:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181217175701-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH] hw/i386: Remove deprecated machines
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, libvir-list@redhat.com

On 2018-12-17 23:57, Michael S. Tsirkin wrote:
> On Mon, Dec 17, 2018 at 05:35:22PM -0200, Eduardo Habkost wrote:
>> On Mon, Dec 17, 2018 at 05:57:37PM +0100, Thomas Huth wrote:
>>> They've been deprecated for two releases and nobody complained that t=
hey
>>> are still required anymore, so it's time to remove these now.
>>> And while we're at it, mark the other remaining old 0.x machine types
>>> as deprecated (since they can not properly be used for live-migration
>>> anyway).
>>
>> Do you know why exactly they can't be used for live-migration?

I don't remember the gory details, but IIRC Paolo once said that when
you live-migrate from a QEMU version < 1.3 and then reboot the guest, it
crashes, ... or something similar. Maybe Paolo can give some details agai=
n?

>> Maybe we should split the removal of pc <=3D 0.10 and deprecation
>> of pc <=3D 0.15 into separate patches?

In that case I'd need to remove the text from qemu-deprecated.texi
first, just to immediately add it afterwards again ... so I'd prefer to
keep this in one patch.

>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>> Michael, should I queue this, or should it go through your tree?
>=20
> I'll queue it.

Thanks to both of you!

 Thomas
