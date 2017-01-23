Received: from eggs.gnu.org ([2001:4830:134:3::10]:34934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVdMS-0000AB-LM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVdMN-0001re-Pj
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:04:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cVdMN-0001rN-Ku
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 07:04:31 -0500
Message-ID: <1485173068.2149.20.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Jan 2017 13:04:28 +0100
In-Reply-To: <CAJ+F1CLeTaXgja-g_00LmxxiVSDZK5DeHStXPfgpcMNeLYX7Pw@mail.gmail.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170118160332.13390-24-marcandre.lureau@redhat.com>
	<1484814026.15364.15.camel@redhat.com>
	<CAJ+F1CLeTaXgja-g_00LmxxiVSDZK5DeHStXPfgpcMNeLYX7Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 23/25] console: make screendump async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

  Hi,
>=20
> If you only ref, you could have the image being modified while it is
> being saved asynchronously, this could result in tearing artefacts,
> no?

Yes, but you have that problem _anyway_.  screendump qmp command can run
in parallel to guest vcpu, so it can race with guest display updates
today.  Assuming they happen as simple framebuffer writes and therefore
don't involve vmexit + grabbing big qemu lock.

cheers,
  Gerd
