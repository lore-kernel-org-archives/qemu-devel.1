Received: from eggs.gnu.org ([2001:4830:134:3::10]:34351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etO2U-0002Th-Ba
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etO2P-0000tV-Fw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:38:42 -0500
Date: Wed, 7 Mar 2018 09:38:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180307013831.GF13844@lemon.usersys.redhat.com>
References: <20180306161728.20890-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180306161728.20890-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: make help could have 'modules'
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Tue, 03/06 17:17, Marc-Andr=E9 Lureau wrote:
> Available when configure --enable-modules.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 9a75c48ae0..5d9ef3b8fd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1046,6 +1046,9 @@ include $(SRC_PATH)/tests/vm/Makefile.include
>  help:
>  	@echo  'Generic targets:'
>  	@echo  '  all             - Build all'
> +ifdef CONFIG_MODULES
> +	@echo  '  modules         - Build all modules'
> +endif

Hi Marc-Andr=E9,

I'd just remove the 'ifdef' condition and include the line everywhere, si=
nce
this is the help. The behavior is fine even without running ./configure:

$ make modules
make: Nothing to be done for 'modules'.
$ make all
make: Nothing to be done for 'all'.

Fam
