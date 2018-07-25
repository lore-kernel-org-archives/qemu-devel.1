Received: from eggs.gnu.org ([2001:4830:134:3::10]:55725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiFwf-0005u5-MC
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiFwc-0006SA-Lb
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:18:57 -0400
Date: Wed, 25 Jul 2018 10:18:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180725091837.GB12855@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725084824.GA12855@redhat.com>
	<CAHmQWvDtNQsPDy1tCnsy9JbGzMxLAik5S0bBfpCj_0ig8=iZdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmQWvDtNQsPDy1tCnsy9JbGzMxLAik5S0bBfpCj_0ig8=iZdA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Wed, Jul 25, 2018 at 05:05:06PM +0800, Hongbo Zhang wrote:
> On 25 July 2018 at 16:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> > On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
> >> For the Aarch64, there is one machine 'virt', it is primarily meant =
to
> >> run on KVM and execute virtualization workloads, but we need an
> >> environment as faithful as possible to physical hardware, for suppor=
ting
> >> firmware and OS development for pysical Aarch64 machines.
> >>
> >> This patch introduces new machine type 'Enterprise' with main featur=
es:
> >
> > The 'enterprise' name is really awful - this is essentially a marketi=
ng
> > term completely devoid of any useful meaning.
> >
> > You had previously called this "sbsa" which IIUC was related to a rea=
l
> > world hardware specification that it was based on. IOW, I think this =
old
> > name was preferrable to calling it "enterprise".
> >
> Thanks for your comments.
> Frankly, I myself prefer to 'sbsa' too, in fact, at the early stage of
> developing, we called this 'enterprise', but later I changed it to
> 'sbsa' until I sent out v1 patch.
>=20
> The work Arm TF and EDK2 porting to this platform needs this name to
> be defined finally.

Why should EDK2 care what the QEMU machine type name is. The machine type
name is purely a QEMU internal tag and shouldn't be visible in the guest
ABI at all IIUC.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
