Received: from eggs.gnu.org ([208.118.235.92]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darkbasic@linuxsystems.it>) id 1gcX1n-0005vY-7c
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darkbasic@linuxsystems.it>) id 1gcX1j-0000U2-19
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:52:51 -0500
Received: from mail.linuxsystems.it ([79.7.78.67]:51316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darkbasic@linuxsystems.it>)
	id 1gcX1i-00079J-M4
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:52:46 -0500
From: =?iso-8859-1?Q?Niccol=F2_Belli?= <darkbasic@linuxsystems.it>
Date: Thu, 27 Dec 2018 15:51:40 +0100
MIME-Version: 1.0
Message-ID: <04864360-b345-4d49-a842-8cde724b3c94@linuxsystems.it>
In-Reply-To: <254296205.54150897.1545827908434.JavaMail.zimbra@redhat.com>
References: <110999ea-0ab9-49cb-915f-6d08cccdea3c@linuxsystems.it>
	<47cfb9f8-5957-7935-063b-304e3c53c268@redhat.com>
	<9de9afbe-fc7b-48a0-9b2d-b756f146303d@linuxsystems.it>
	<254296205.54150897.1545827908434.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?iso-8859-1?q?=5BSpice-devel=5D_Always_get_Invalid?=
 =?iso-8859-1?q?_password_while_trying_to_connect_to_spice_server?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: armbru@redhat.com, secalert@redhat.com, mst@redhat.com, Uri Lublin <uril@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On mercoled=C3=AC 26 dicembre 2018 13:38:28 CET, Frediano Ziglio wrote:
> Yes, this looks like a format string error in the upper (not=20
> into spice) layer.
>
> This potentially is a security problem.

Considering the spice server is exposed to the internet this is definitely=20=

worth investigating.

> The specific '%' character could be the issue, can you try=20
> others ('!', '@' and
> so on) ?

I tried several other special characters and they all seems to work, expect=20=

for "Password&&" which gets converted to "Password&amp;&amp;" (if I type=20
"Password&amp;&amp;" it works).

Niccolo'
