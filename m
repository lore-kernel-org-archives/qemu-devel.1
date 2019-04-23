Received: from eggs.gnu.org ([209.51.188.92]:40483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hIw2V-00074I-Ur
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hIvuZ-0000iZ-VR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:56:40 -0400
Date: Tue, 23 Apr 2019 14:56:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190423135635.GL32465@stefanha-x1.localdomain>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline
In-Reply-To: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BQemu-block=5D_question=EF=BC=9A_Does_q?=
 =?utf-8?q?emu-pr-helper_have_its_own_log_files=EF=BC=9F?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jie Wang <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>, "Fangyi (C)" <eric.fangyi@huawei.com>


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F

No, it does not.  qemu-pr-helper uses stderr for errors and there is not
much output during normal operation.

Check journalctl(1) for errors if you are launching it as a systemd
service.

Stefan

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvxmTAAoJEJykq7OBq3PI6QUIAMiYRUcvsCI5IZ3WKTnXeJFw
31XmCdsP8k8VO4c9FCN+pwSNhJg4jDZO7vbREKbOu1AYSdCY7c6NfAQKAswu/5hF
LFsXPoH4SST8qu7cmykmPmebgdAv34P0jjdpqhWhNHBlPrp+TgcD9QJVSsRG3pZq
I1TtNp3HpKeVXiRWg+C8fSTqaEnl+fQEvCA9TCustcwTgm3JqRZbueNU/tD5vht2
74/XZpz5MHIydh/jNEf/CRwDHIvejERL+XPOg784eZW1J6EP6qMIqcry0pTFT0JP
xOOF4/xI5V/0sDSXfvj/RuQQJgxtKhlcpIGbYxbRWuHmyHg4erm6BPtD+Mtwfc4=
=RyMb
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--
