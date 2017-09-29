Received: from eggs.gnu.org ([2001:4830:134:3::10]:33494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dy2sY-0000sq-U1
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dy2sU-0007tM-W6
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:31:26 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dy2sU-0007sm-PV
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 17:31:22 -0400
Received: by mail-wm0-f52.google.com with SMTP id i131so1714846wma.0
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 14:31:21 -0700 (PDT)
Date: Fri, 29 Sep 2017 23:31:02 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170929233102.4b068e2f@fiorina>
In-Reply-To: <20170929091122.22726-1-chen_han_xiao@126.com>
References: <20170929091122.22726-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga-win: fall back to hardcoded user and
 group names if LookupAccountSidW failed
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Fri, 29 Sep 2017 17:11:22 +0800
Chen Hanxiao <chen_han_xiao@126.com> wrote:

> From: Chen Hanxiao <chenhanxiao@gmail.com>
>=20
> On some of windows (win08 sp2),
> it doesn't work by calling LookupAccountSidW with
> well-known SIDs,
> We got an error:
>     error 997 overlapped I/O operation is in progress
>=20
> But hardcoded names work.
>=20
> This patch introduces a workaroud for this issue:
> if LookupAccountSidW failed, try hardcoded one.
>=20
> Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> ---
>  qga/vss-win32/install.cpp | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20

I wonder if it's caused by qga itself or a race/conflict with some other
app. But still...


Reviewed-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
