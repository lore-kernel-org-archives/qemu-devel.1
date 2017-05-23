Received: from eggs.gnu.org ([2001:4830:134:3::10]:54310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dD6ex-000824-QB
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dD6eu-0006ra-JG
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:03:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dD6eu-0006qv-Cr
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:03:20 -0400
Message-ID: <1495533796.30747.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 23 May 2017 12:03:16 +0200
In-Reply-To: <20170522180217.18234-1-ianloic@google.com>
References: <20170522180217.18234-1-ianloic@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/1] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian McKellar <ianloic@google.com>, qemu-devel@nongnu.org

  Hi,

> looked at the keyCode to determine what modifier key changed. This
> usually works fine but sometimes the keyCode is 0 and the app should
> instead be looking at the modifierFlags bitmask. Key code 0 is the
> 'a'
> key.
>=20
> I added code that handles keyCode =3D=3D 0 differently. It checks the
> modifierFlags and if they differ from QEMU's idea of which modifier
> keys are currently pressed it toggles those changed keys.

Sounds like this happens in case there is a modifier state change
without linked key event, such as state change while qemu did not have
the keyboard focus.  Nice that macos sends notifications in that case.

I'm wondering whenever we should just use modifierFlags all the time.

cheers,
  Gerd
