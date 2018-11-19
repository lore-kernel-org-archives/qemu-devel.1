Received: from eggs.gnu.org ([2001:4830:134:3::10]:34715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gOhVs-0003WL-2y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gOhVn-00020S-72
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:14:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gOhVn-0001zw-0u
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:14:39 -0500
Date: Mon, 19 Nov 2018 16:44:29 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <54e1e662-5068-5110-755e-fbb381837218@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1811191640360.17923@xnncv>
References: <20181021175858.25886-1-ppandit@redhat.com>
	<54e1e662-5068-5110-755e-fbb381837218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] bt: use size_t type for length
 parameters instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Arash TC <tohidi.arash@gmail.com>, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <pmathieu@redhat.com>

+-- On Tue, 6 Nov 2018, Philippe Mathieu-Daud=C3=A9 wrote --+
| > @@ -113,6 +113,7 @@ static void vhci_host_send(void *opaque,
| >       static uint8_t buf[4096];
| >  =20
| >       buf[0] =3D type;
| > +    assert(len <=3D sizeof(buf) - 1);
|=20
| Why not simply "assert(len < sizeof(buf));"?

| >       for (;;) {
| >           int cnt =3D MIN(len, s->in_needed - s->in_len);
| > -        if (cnt) {
| > +        if (cnt > 0) {
|=20
| Shouldn't we assert here?

Yes, sent revised patch v2.=20

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
