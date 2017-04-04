Received: from eggs.gnu.org ([2001:4830:134:3::10]:38216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvHiu-00041c-31
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvHir-0005Hg-0Z
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:13:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvHiq-0005HL-Qy
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:13:44 -0400
Message-ID: <1491286422.1455.23.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 04 Apr 2017 08:13:42 +0200
In-Reply-To: <5e1fc0b8-188c-28e8-7a4a-9f0388790219@redhat.com>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
	<1491221026.17505.39.camel@redhat.com>
	<5e1fc0b8-188c-28e8-7a4a-9f0388790219@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Mo, 2017-04-03 at 19:02 +0200, Paolo Bonzini wrote:
>=20
> On 03/04/2017 14:03, Gerd Hoffmann wrote:
> > We might clear some more bits, but these are
> > outsize the visible area so they should cause visible corruption (and i=
f
> > the visible area changes the display code needs to do a full refresh
> > anyway).
>=20
> True, though this makes the snapshot abstraction a little more
> specialized.  Please add a FIXME comment with the explanation, at least.

Sure, I'll add a note to the (to be written) docs.

cheers,
  Gerd
