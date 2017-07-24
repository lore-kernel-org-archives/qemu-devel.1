Received: from eggs.gnu.org ([2001:4830:134:3::10]:48260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZcjn-0001Ve-EH
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZcjj-0000Vc-Id
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:45:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZcjj-0000UF-CQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:45:23 -0400
Message-ID: <1500900321.15837.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Jul 2017 14:45:21 +0200
In-Reply-To: <20170721110636.19412e6c@nial.brq.redhat.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

  Hi,

> > 2. Select FADT version with an option. This one is definitely safe,
> > but adds yet another option.
>=20
> the 3rd simpler option is:
> =C2=A0 force rev1 on old machine types (2.9 and older),
> =C2=A0 using machine compat machinery and use rev3 on newer machines

How about keeping rev1 for pc machine type and use rev3 on q35 only?

Old guests which might fall over new acpi stuff usually work better
with "pc" anyway ...

cheers,
  Gerd
