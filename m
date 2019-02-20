Received: from eggs.gnu.org ([209.51.188.92]:45449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwZ49-0006QW-8b
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 16:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwZ47-0000kk-7i
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 16:06:05 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gwZ42-0000GV-Bc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 16:05:58 -0500
Received: by mail-ot1-f43.google.com with SMTP id i5so42615503oto.9
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 13:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20190218140301.197408-1-sgarzare@redhat.com>
	<20190220163058.GH30403@stefanha-x1.localdomain>
In-Reply-To: <20190220163058.GH30403@stefanha-x1.localdomain>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 20 Feb 2019 22:05:40 +0100
Message-ID: <CAGxU2F6NNWLNPc1v3e4ymPDyPQwErAdWzhQpL3ck1GTv5FWVRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 00/10] virtio-blk: add
 DISCARD and WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Il giorno mer 20 feb 2019 alle 17:31 Stefan Hajnoczi <stefanha@gmail.com>
ha scritto:

> On Mon, Feb 18, 2019 at 03:02:51PM +0100, Stefano Garzarella wrote:
> > This series adds the support of DISCARD and WRITE_ZEROES commands
> > and extends the virtio-blk-test to test these new commands.
> >
> > v5:
> > - rebased on master
> > - handled the config size for DISCARD and WRITE_ZEROES features as in
> >   virtio-net (patches 4 and 5) [Michael, Stefan]
> > - fixed an endianness issues on the WRITE_ZEROES test (patches 8 and 9)
> > - added a test for DISCARD command to only test the status returned by
> the
> >   request (patch 10)
> > - others patches are unchanged (patches 1, 2, 3, 6, 7)
>
> Looks good.  Please fix the patchew failure and resend.


Thanks for the review!
I=E2=80=99ll send the new version with the fix.

Cheers,
Stefano
--=20
Stefano Garzarella
Software Engineer @ Red Hat
