Received: from eggs.gnu.org ([209.51.188.92]:60244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gtF9d-0002dR-0a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gtEvA-0007L3-EY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:59:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gtEvA-0007Fx-4d
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:59:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A69E4C058CA8
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 16:58:51 +0000 (UTC)
Date: Mon, 11 Feb 2019 17:58:48 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190211165848.GW5349@paraplu.home>
References: <20190211162052.13584-1-kchamart@redhat.com>
	<20190211162437.GI27585@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211162437.GI27585@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] [qemu-web] Put version numbering details
 in its own doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Feb 11, 2019 at 04:24:37PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Feb 11, 2019 at 05:20:52PM +0100, Kashyap Chamarthy wrote:
> > Instead of burying the version numbering details under "Download QEMU=
"
> > page, place it in its own document.  And highlight its presence in th=
e
> > website footer.
>=20
> I'm not sure I agree with saying it is "buried" on the download page.

True.  I exaggerated a bit there; sorry.

> It is pretty clearly visible, and it is relevant information at the
> time you are downloading. If anything, moving it off into a separate
> page /is/ burying it IMHO, as now its not visible at time of download

Your argument is valid, and at first I actually did think the way
describe.  Then I remembered how I recently was trying to look up the
versioning details of QEMU and not finding it.  Not sure what terms I
used at that time.

Right now, typing "qemu version numbering" (*without* quotes) does show
the "Download QEMU" page as third result.  And the first result points
to this page:

    https://www.qemu.org/2018/08/15/qemu-3-0-0/

Which does have:

    A note from the maintainer: Why 3.0? Well, we felt that our version
    numbers were getting a bit unwieldy, and since this year is QEMU=E2=80=
=99s
    15th birthday it seemed like a good excuse to roll over the major
    digit.  Going forward we plan to increment the major version once a
    year, for the first release of the year. Don=E2=80=99t read too much =
into
    it: it doesn=E2=80=99t imply a drastic compatibility break.=20

So, I tend to agree with what you said, so feel free to disregard this
change, then. :-)

[...]

--=20
/kashyap
