Received: from eggs.gnu.org ([2001:4830:134:3::10]:51822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fcwuR-0000IF-EW
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fcwuM-0007MY-Jz
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:58:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fcwuM-0007M0-Cy
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:58:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so15531604wra.13
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 10:58:37 -0700 (PDT)
Date: Tue, 10 Jul 2018 19:58:34 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20180710195834.6d8b3f06@fiorina>
In-Reply-To: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
References: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: report disk size and free space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue,  3 Jul 2018 10:31:20 +0200
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com> wrote:

> Report total file system size and free space in output of command
> "guest-get-fsinfo". Values are optional and it is not an error if they ca=
nnot
> be retrieved for some reason.
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
>  qga/commands-posix.c | 18 ++++++++++++++++++
>  qga/commands-win32.c | 16 ++++++++++++++++
>  qga/qapi-schema.json |  5 ++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)

Ignore the patch. I see that similar change was already applied by the
following patches:

https://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01004.html
https://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg00995.html

    Tomas
