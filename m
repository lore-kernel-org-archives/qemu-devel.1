Received: from eggs.gnu.org ([2001:4830:134:3::10]:38273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLThs-0005HR-Hg
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gLTho-0003Yy-2E
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:53:48 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gLThk-0003Re-RK
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:53:41 -0500
Date: Sat, 10 Nov 2018 14:53:35 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181110135335.pw35cgnbyuzgbecx@function>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
	<20181110134548.14741-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181110134548.14741-11-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 10/13] slirp: improve subprocess
 socket creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le sam. 10 nov. 2018 17:45:45 +0400, a ecrit:
> @@ -163,23 +183,14 @@ fork_exec(struct socket *so, const char *ex)
>  		exit(1);
> =20
>  	 default:
> -		qemu_add_child_watch(pid);
> -                /*
> -                 * XXX this could block us...
> -                 * XXX Should set a timer here, and if accept() doesn'=
t
> -                 * return after X seconds, declare it a failure
> -                 * The only reason this will block forever is if socke=
t()
> -                 * of connect() fail in the child process
> -                 */

At least this got fixed by Peter lately, so please rebase.

Samuel
