Received: from eggs.gnu.org ([2001:4830:134:3::10]:58528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqF1-0003VE-1y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqEw-0006Mc-6N
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:45:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etqEv-0006MQ-Qi
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:45:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D81414040073
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 07:45:14 +0000 (UTC)
Date: Thu, 8 Mar 2018 08:45:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180308074507.nwho4tddsoxb3b7v@sirius.home.kraxel.org>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, lersek@redhat.com, berrange@redhat.com

> Suggested approach
> ------------------
>=20
> Based on an upstream discussion on 'virt-tools'[1] mailing list and som=
e
> Bugzillas, Gerd Hoffmann, Laszlo Ersek and Dan Berrang=E9 had a suggest=
ion
> to define a firmware metadata format and file (example in [1]):
>=20
>   - For each firmware file we need a metadata file in a well defined
>     location, e.g. /usr/share/qemu/bios/ that lists stuff like:
>=20
>       - Path to the firmware binary
>       - Path to the pre-built OVMF 'vars' file (if any)

How to load the binary (using -bios, -pflash, possibly also -kernel, for
uboot @ arm).

>       - Support architectures - associated QEMU feature flags (Secure
>         Boot)

Also machine types.  ovmf builds with smm don't boot on pc.  coreboot
has hardware-specific roms too, so the pc build wouldn't boot on q35 and
visa versa.  Same on arm, where the firmware typically is board-specific.

>       - If the binary provides / requires SMM (System Management Mode)

Possibly a more generic "flags" or "properties" thing, I can easily
imagine that simliar requirements show up on other platforms too.

Also a "name" and a "description" field would be useful.

cheers,
  Gerd
