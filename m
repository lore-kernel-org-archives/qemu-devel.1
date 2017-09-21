Received: from eggs.gnu.org ([2001:4830:134:3::10]:44152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1duvJH-0003Dq-8L
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1duvJC-00080j-92
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:50:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1duvJC-0007zY-35
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:50:02 -0400
Message-ID: <1505976596.7353.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 21 Sep 2017 08:49:56 +0200
In-Reply-To: <20170920145025.19403-1-david@redhat.com>
References: <20170920145025.19403-1-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] kvm: drop wrong assertion creating
 problems with pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, kvm@vger.kernel.org

On Wed, 2017-09-20 at 16:50 +0200, David Hildenbrand wrote:
> pflash toggles mr->romd_mode. So this assert does not always hold.
>=20
> 1) a device was added with !mr->romd_mode, therefore effectively not
> =C2=A0=C2=A0=C2=A0creating a kvm slot as we want to trap every access (=
add =3D false).
> 2) mr->romd_mode was toggled on before remove it. There is now
> =C2=A0=C2=A0=C2=A0actually no slot to remove and the asser is wrong.
>=20
> So let's just drop the assert.

Works without any obvious bad side effects.

Tested-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
