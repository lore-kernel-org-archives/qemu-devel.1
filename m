Received: from eggs.gnu.org ([2001:4830:134:3::10]:57683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dhVwM-0007wk-Gf
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dhVwH-00006I-Ej
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:07:02 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dhVwH-000054-8E
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:06:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so2984437wmt.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 00:06:54 -0700 (PDT)
Date: Tue, 15 Aug 2017 09:06:50 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170815090650.0d1c1d40@fiorina>
In-Reply-To: <9E79D1C9A97CFD4097BCE431828FDD3115719A01@SHSMSX103.ccr.corp.intel.com>
References: <9E79D1C9A97CFD4097BCE431828FDD3115719A01@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu guest agent support 'guest-exec'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hu, Robert" <robert.hu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

On Mon, 31 Jul 2017 08:29:32 +0000
"Hu, Robert" <robert.hu@intel.com> wrote:

> Hi,
>=20
> From $qemu_src/qga/ code, guest-exec should be supported.
> But from $qemu_src/scripts/qmp/qemu-ga-client output, it is not supported=
, on client side. Why didn't implement on client side? or any configuration=
 I missed?

qemu-ga-client is rather minimalist example. If you want to talk to
QEMU GA I suggest you either use something that can connect to unix
socket (netcat, socat, ...) and send commands directly. Or write your
own client script.

    Tomas
>=20
> Best Regards,
> Robert Hoo
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
