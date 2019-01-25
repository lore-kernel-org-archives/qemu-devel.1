Received: from eggs.gnu.org ([209.51.188.92]:41231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gmysO-00072r-Vv
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gmysM-0003xG-VP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:38:20 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39418)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gmysK-0003vT-Ve
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:38:18 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <003301d4b494$775585c0$66009140$@ru>
	<20190125101032.GA4498@redhat.com>
In-Reply-To: <20190125101032.GA4498@redhat.com>
Date: Fri, 25 Jan 2019 13:38:09 +0300
Message-ID: <003801d4b49a$10b9ead0$322dc070$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] Querying possible -cpu variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?'Daniel_P._Berrang=C3=A9'?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, =?UTF-8?B?J9Ck0YPRgNGB0L7QstCwINCd0LDRgtCw0LvQuNGPJw==?= <Natalia.Fursova@ispras.ru>, mdroth@linux.vnet.ibm.com

> From: Daniel P. Berrang=C3=A9 [mailto:berrange@redhat.com]
> On Fri, Jan 25, 2019 at 12:58:04PM +0300, Pavel Dovgalyuk wrote:
> >
> > We are making GUI for QEMU (which also should allow convenient =
record/replay command line
> > generation): https://github.com/ispras/qemu-gui
> >
> >
> >
> > To fill the combo box in CPU selection form we run QEMU with "-cpu =
help" command and parse
> its
> > output.
> >
> > The format of this list depends on target. Therefore our parsing =
code does not look good
> (and also
> > may corrupt someday).
> >


> > 2.       Add QMP command for requesting this list.
>=20
> This already exists as the 'query-cpu-definitions' command

Thank you!

Pavel Dovgalyuk
