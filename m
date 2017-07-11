Received: from eggs.gnu.org ([2001:4830:134:3::10]:46146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUyzN-0007zi-G4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dUyzM-0005eN-KM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:30:21 -0400
Date: Tue, 11 Jul 2017 13:30:06 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2146046377.49609243.1499794206964.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA9Hv_C-w9hVO2C5WYw7SFOerHPsGb1-B44fQiy2Ud+CCQ@mail.gmail.com>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-4-git-send-email-peter.maydell@linaro.org>
	<1572293529.49604420.1499793538326.JavaMail.zimbra@redhat.com>
	<CAFEAcA9Hv_C-w9hVO2C5WYw7SFOerHPsGb1-B44fQiy2Ud+CCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Make Cortex-M3 and M4
 default to 8 PMSA regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, patches@linaro.org, Markus Armbruster <armbru@redhat.com>

hi

----- Original Message -----
> On 11 July 2017 at 18:18, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat=
.com>
> wrote:
> > ----- Original Message -----
> >> The Cortex-M3 and M4 CPUs always have 8 PMSA MPU regions (this isn't
> >> a configurable option for the hardware).  Make the default value of
> >> the pmsav7-dregion property be set per-cpu, so we don't need to have
> >> every user of these CPUs set it manually.  (The existing default of
> >> 16 is correct for the other PMSAv7 core, the Cortex-R5.)
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > So until now that value was wrong for m3/m4 if I understand correctly.
>=20
> Correct. (It was too high, so didn't cause a problem for
> guests typically -- a guest assuming 8 memory regions would
> just not use the registers associated with the extra
> unexpected ones.)

Would be nice to add that to the commit message

in any case:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
