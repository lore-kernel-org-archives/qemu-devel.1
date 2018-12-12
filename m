Received: from eggs.gnu.org ([2001:4830:134:3::10]:36041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0qT-0005nJ-Ea
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0qQ-0003YM-5H
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:30:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX0qP-0003WA-PC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:30:18 -0500
References: <20181211174253.10947-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <81aec30a-c599-9521-9571-c32de4087db4@redhat.com>
Date: Wed, 12 Dec 2018 10:30:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181211174253.10947-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: maxim.kuvyrkov@linaro.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>

On 2018-12-11 18:42, Alex Benn=C3=A9e wrote:
> This is a QEMU specific version of a gitdm config for generating
> reports on the contributor base of the project. I've added enough
> group maps and domain aliases to ensure the current top ten is as
> reflective as it can be. As of this commit running:
>=20
>   git log --numstat --since "Last Year" | gitdm -n -l 16
>=20
> Reports:
>=20
>   Top changeset contributors by employer
>   RedHat                    3116 (43.8%)
>   Linaro                    1166 (16.4%)
>   f4bug@amsat.org            384 (5.4%)
>   IBM                        170 (2.4%)
>   Virtuozzo                  168 (2.4%)
>   mark.cave-ayland@ilande.co.uk  161 (2.3%)
>   cota@braap.org             134 (1.9%)
>   Xilinx                     102 (1.4%)
>   clg@kaod.org               100 (1.4%)
>   Igalia                      93 (1.3%)
>   Cadence Design Systems      88 (1.2%)
>   groug@kaod.org              78 (1.1%)

You might also want to add a group-map-ibm file for groug and clg@kaod.or=
g ?

 Thomas
