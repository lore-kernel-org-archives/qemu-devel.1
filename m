Received: from eggs.gnu.org ([2001:4830:134:3::10]:53278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dmNWt-0003Rb-TL
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dmNWo-0001Pl-Ud
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:08:51 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dmNWo-0001Lw-P2
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:08:46 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so7471267wmt.1
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 10:08:46 -0700 (PDT)
Date: Mon, 28 Aug 2017 19:08:40 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170828190840.67a394f5@fiorina>
In-Reply-To: <CAOE=1Z0s6Z8c_Nd4_ZO+6E3PfK7mODRFVL5LbFr3cPvXcHmLDg@mail.gmail.com>
References: <CAOE=1Z0s6Z8c_Nd4_ZO+6E3PfK7mODRFVL5LbFr3cPvXcHmLDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to detect qga socket available?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

On Thu, 10 Aug 2017 20:04:32 +0800
Sam <batmanustc@gmail.com> wrote:

> Hi all,
>=20
> I want to send command through qga socket, but sometimes it will hanged
> there. So I want to test qga socket available first, then send qga comman=
d.
>=20
> So my question is how to test qga socket available, which is not taken by
> others? By timeout?
>=20

I am not aware of any fast and reliable way. I'd suggest sending the
"guest-sync" command and wait for response with a timeout.

    Tomas

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
