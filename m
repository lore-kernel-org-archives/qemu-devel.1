Received: from eggs.gnu.org ([209.51.188.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZoD-0007oj-02
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZoB-0004pa-PA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:32:44 -0400
Date: Thu, 25 Apr 2019 09:32:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190425083239.GD30231@stefanha-x1.localdomain>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
	<20190423135635.GL32465@stefanha-x1.localdomain>
	<0259E1C966E8C54AA93AA2B1240828E65D0BE6FB@DGGEML529-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <0259E1C966E8C54AA93AA2B1240828E65D0BE6FB@DGGEML529-MBS.china.huawei.com>
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
To: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
Cc: "wangjie (P)" <wangjie88@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Fangyi (C)" <eric.fangyi@huawei.com>, "Wangjing (King)" <king.wang@huawei.com>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 02:37:36AM +0000, Zhangbo (Oscar) wrote:
> >From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> >Sent: Tuesday, April 23, 2019 9:57 PM
> >On Tue, Apr 23, 2019 at 11:12:40AM +0800, Jie Wang wrote:
> >> =C2=A0Does qemu-pr-helper have its own log files=EF=BC=9F
> >
> >No, it does not.  qemu-pr-helper uses stderr for errors and there is not
> >much output during normal operation.
> >
> >Check journalctl(1) for errors if you are launching it as a systemd
> >service.
> >
> >Stefan
>=20
> The error messages that sent to *stderr* are *not* captured by anyone, th=
en
> these error messages seems helpless.

This depends on how qemu-pr-helper was launched.

Daniel Berrange mentioned that stderr is not captured when libvirt
launches qemu-pr-helper.  So in this case there is a problem.

> It's different form qemu's log,  qemu's stderr logs are transferred to vi=
rtlogd,
> that means these logs are finally written into disk.
> Any further development plan?
>=20
> We thought of:
> 1 logging into syslog, but the malicious guest may cause large amount of =
error
>   messages to overflow the message log.
> 2 or, let virtlogd to redirect its logs. But if virtlogd get restarted, t=
he helper's log would
>   no longer be logged, because, unlike qemu, there's no qmp socket betwee=
n=20
>   libvirtd and the helper, the channel between the helper and virtlogd co=
uld not be
>   re-established.
> 3 or, let qemu to log the helper's log, seems a little odd and complex.
> 4 or, let the helper realize its own logging scheme and log into itself's=
 logfile ?

Perhaps libvirt should be modified to handle stderr.

Stefan

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwXCnAAoJEJykq7OBq3PI0p4H/0eotECdLXd992aTU3WnqVmT
7+FvRrQRyORu8P6gPaJPEIRGD5mQSL8Py+L8EyaIP52hw+LkTzpAkVWOldFS9ix/
asTP9i9WC0s9WUl+023ja9JntQcg0Xog3i7tFCCtcp1FS2EXp5J4pFEyh8e31Uzt
5Vq/eq6dAQYpA9d05kplop3nTevZokVva6cbkTMXM95HGmlK80r0hHz6x+I5ehZG
VVQEppiMLnPUD0YzimAfwLyEoStJw0CrT89DrUJ5+ep6YmRIIMOLu8kD/bW6YswF
HyAiuNGpw4XDMSh32e/k+k/sH0sEalfx1QhOS/8c2zhdbVZe0cNbPPLxgOuzDi4=
=bRO/
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
