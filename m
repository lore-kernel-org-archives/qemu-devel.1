Received: from eggs.gnu.org ([2001:4830:134:3::10]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsxbA-0004GB-Gz
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsxb5-000635-M0
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dsxb5-00062b-Fh
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 16:52:23 -0400
Date: Sat, 16 Sep 2017 04:52:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915205217.GC21852@lemon.lan>
References: <20170915090253.12201-1-famz@redhat.com>
	<CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
	<20170915114001.GG13610@redhat.com>
	<af84a70f-13a5-8c5d-48bb-ba62f57d24b8@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <af84a70f-13a5-8c5d-48bb-ba62f57d24b8@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/38] Test and build patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 09/15 11:47, Philippe Mathieu-Daud=E9 wrote:
> why not generate 1 key in
> tests/vm/ (or clever ~/.cache/qemu-vm/ already used by those scripts) o=
nce
> when the make vm-test rule is called, that would be 1 key per repositor=
y
> clone (or 1 per user using ~/.cache).

Like I explained elsewhere, the BSD images must be generated after the ke=
ys in
order for the pub key to be added to the guest authorized_keys. And there=
 is no
automatic way to do so. That's why the keys are committed to the repo, no=
t
generated (otherwise we'd just use ~/.ssh pub keys).

Fam
