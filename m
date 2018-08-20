Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1frqDV-0001NI-C3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1frqDR-0002zh-6V
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:51:57 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:41738 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1frqDL-0002u5-GI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:51:50 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180817150513.GT11124@redhat.com>
	<6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
	<20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
	<b91de5ea-7719-0301-7c7a-fb06785da0dc@ubuntu.com>
	<CAATJJ0Kui418HgNBCkY6nvCQXVujvm-HAv75wsi5XBqSA_s7aw@mail.gmail.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <9953aeaf-cb6c-0dba-a52c-97260728b530@ubuntu.com>
Date: Mon, 20 Aug 2018 15:51:41 -0400
MIME-Version: 1.0
In-Reply-To: <CAATJJ0Kui418HgNBCkY6nvCQXVujvm-HAv75wsi5XBqSA_s7aw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="en8p7nfawTPuGEglJUa7QmKNZYGLi9yBl"
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--en8p7nfawTPuGEglJUa7QmKNZYGLi9yBl
From: Phillip Susi <psusi@ubuntu.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <9953aeaf-cb6c-0dba-a52c-97260728b530@ubuntu.com>
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180817150513.GT11124@redhat.com>
 <6bf952d9-0269-c5df-6cac-70104ec88f81@ubuntu.com>
 <20180820084329.3uhnobuy5g52zqio@sirius.home.kraxel.org>
 <b91de5ea-7719-0301-7c7a-fb06785da0dc@ubuntu.com>
 <CAATJJ0Kui418HgNBCkY6nvCQXVujvm-HAv75wsi5XBqSA_s7aw@mail.gmail.com>
In-Reply-To: <CAATJJ0Kui418HgNBCkY6nvCQXVujvm-HAv75wsi5XBqSA_s7aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/20/2018 11:07 AM, Christian Ehrhardt wrote:
> What exactly would you need in Ubuntu Phillp?

It *looks* like this is fixed in 2.12, but Ubuntu has 2.11.

> Latest qemu would atm be on 2.12 with the git available here [1].
> Unfortunately mostly nobody cares about the git branches so I forgot to=

> push this one - shame on me :-/, it is ready now thou.

What did you forget to push?  Because the debian git repo already seemd
to have 2.12 last week.

> I couldn't follow all of the thread, do you need something else than qe=
mu
> code to be updated, if so which package would that be?

Nope; it's just qemu 2.11 seems to have had this bug.  It seems there
has been massive refactoring of the keyboard code since then so likely
this bug will forever remain in 18.04 unless someone wants to go through
the 2.11 code and figure out how to surgically fix it.  At this point I
think the path of least resistance for me is to get the newer version in
the debian git repo to build and install that.

What I can't figure out is how to get the pristine-tar for
dpkg-buildpackage.  The git repo doesn't contain the pristine-tar branch
that was required for pristine-tar to check out the original tar.



--en8p7nfawTPuGEglJUa7QmKNZYGLi9yBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbexvRAAoJENsuw7lhAP6ErDEIAJpgrbMwpzLliaP583hToGEj
A8pO/PcVmVqo7gJq3vB2g8c6KpgKlMm4K4hWMLAqsT1LDxxa+xKeYAwwE0hL3P8N
RVxh1SM4BQ6NXOTSetLYNZHOHbcrt9FkJ6xDgLE1ZLX2UoD4Rvqn1DjxA3TMhXn3
lSJ7TS2KerThEiYkpIU33xHmHOV05DfqDVSK+70mnb1H7bijcYACHzWyCBJ1pOes
9cuspPdJiSQvZwFYX+H6nX4FbYH+z4BbY1M9qWyJ5LhAswxWneoOsV64n1sea6Ox
PadJFT2qv4c/hVzMcc9fwh8TBJF+T1UU90c42Zk8qUFBBOVS6MtCDSZESnuXrdQ=
=TYdt
-----END PGP SIGNATURE-----

--en8p7nfawTPuGEglJUa7QmKNZYGLi9yBl--
