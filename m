Received: from eggs.gnu.org ([2001:4830:134:3::10]:42804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gX1Bn-0003eb-64
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gX1Bh-0002vW-QC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:52:21 -0500
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:46108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gX1Bf-0002sW-Fy
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:52:16 -0500
Received: from player797.ha.ovh.net (unknown [10.109.160.93])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id EE78E37CAF
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:52:10 +0100 (CET)
Date: Wed, 12 Dec 2018 10:52:04 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181212105204.64b1e917@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <81aec30a-c599-9521-9571-c32de4087db4@redhat.com>
References: <20181211174253.10947-1-alex.bennee@linaro.org>
	<81aec30a-c599-9521-9571-c32de4087db4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, maxim.kuvyrkov@linaro.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

On Wed, 12 Dec 2018 10:30:13 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 2018-12-11 18:42, Alex Benn=C3=A9e wrote:
> > This is a QEMU specific version of a gitdm config for generating
> > reports on the contributor base of the project. I've added enough
> > group maps and domain aliases to ensure the current top ten is as
> > reflective as it can be. As of this commit running:
> >=20
> >   git log --numstat --since "Last Year" | gitdm -n -l 16
> >=20
> > Reports:
> >=20
> >   Top changeset contributors by employer
> >   RedHat                    3116 (43.8%)
> >   Linaro                    1166 (16.4%)
> >   f4bug@amsat.org            384 (5.4%)
> >   IBM                        170 (2.4%)
> >   Virtuozzo                  168 (2.4%)
> >   mark.cave-ayland@ilande.co.uk  161 (2.3%)
> >   cota@braap.org             134 (1.9%)
> >   Xilinx                     102 (1.4%)
> >   clg@kaod.org               100 (1.4%)
> >   Igalia                      93 (1.3%)
> >   Cadence Design Systems      88 (1.2%)
> >   groug@kaod.org              78 (1.1%) =20
>=20
> You might also want to add a group-map-ibm file for groug and clg@kaod.or=
g ?
>=20

+1

Thanks Thomas for pointing that out.

Cheers,

--
Greg

>  Thomas
