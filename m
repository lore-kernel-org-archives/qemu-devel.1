Received: from eggs.gnu.org ([209.51.188.92]:50000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGQfA-0007fN-5D
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hGQf9-0006iu-4K
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hGQf8-0006iG-SB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:10:23 -0400
From: Bandan Das <bsd@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<jpgk1fvp5wm.fsf@linux.bootlegged.copy>
	<20190415165426.GT5718@redhat.com> <20190416084059.GD31311@redhat.com>
Date: Tue, 16 Apr 2019 12:10:16 -0400
In-Reply-To: <20190416084059.GD31311@redhat.com> ("Daniel P.
	\=\?utf-8\?Q\?Ber\?\= \=\?utf-8\?Q\?rang\=C3\=A9\=22's\?\=
	message of "Tue, 16 Apr 2019 09:40:59 +0100")
Message-ID: <jpglg0a3p93.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
...
>> > The store is read only by default. Are you trying something like:
>> >  -device usb-mtp,rootdir=3D/code/mtpshare,readonly=3Dfalse ?
>>=20
>> Ah ha, I didn't realize I had to enable write support explicitly. Will
>> retry with that.
>
> Even after setting  readonly=3Dfalse, I still can't get "mtp-sendfile"
> to succeed in a guest.
>
I posted a patch for a bug introduced by a recent commit that made smaller
file sizes return back with a incomplete file transfer.

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02552.html

> Regards,
> Daniel
