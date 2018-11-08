Received: from eggs.gnu.org ([2001:4830:134:3::10]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKk5V-0006Km-Nf
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gKk1M-00081K-SL
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:06:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gKk1M-00080y-MM
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:06:52 -0500
Date: Thu, 8 Nov 2018 11:06:48 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181108130648.GJ12503@habkost.net>
References: <87b22690-e39c-3b46-dcb4-f6abc3213142@redhat.com>
	<CAFEAcA8yHb4MdtsJuXcswQp93DN5tSeN9dn8AWWL9se0DKvdcg@mail.gmail.com>
	<41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<CAFEAcA9oCs+Y1fnY8dOR16n_Hn7PaHziL7K0HZK6=BAd_Gyecg@mail.gmail.com>
	<e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 08, 2018 at 10:55:21AM +0100, Paolo Bonzini wrote:
> On 07/11/2018 20:30, Thomas Huth wrote:
> > On 2018-11-07 20:24, Eduardo Habkost wrote:
> >> On Wed, Nov 07, 2018 at 06:39:54PM +0100, Paolo Bonzini wrote:
> >>> On 07/11/2018 16:41, Samuel Ortiz wrote:
> >>>> - The Kconfig parser would be used to generate the equivalent of w=
hat we
> >>>>   currently have under default-configs/
> >=20
> > I think we would still have something like default-configs - but ther=
e
> > would only be the bare minimum config switches in there, the rest wou=
ld
> > be pulled in by dependencies.
>=20
> Yes, in theory default-configs would end up empty, except for possibly
> some commented lines to show the "default y" symbols for the target.
>=20
> > We could then also even have multiple config directories:
> >=20
> > ./configs
> >  +-------/default-softmmu
> >  +-------/default-linux-user
> >  +-------/nemu (or lean-kvm or something similar)
> >  +...
> >=20
> > ... just my 0.02 =E2=82=AC, feel free to ignore that idea ;-)
>=20
> Yup, one can also think of a configure option like "./configure
> --with-device-config=3Dconfigs/nemu/" to pick up the alternative
> configurations.
>=20
> >> Also, I would like to eventually replace many ./configure options
> >> with options read from a build configuration file.
> >>
> >> Distributions often have huge ./configure command lines in their
> >> QEMU packages, and they could be replaced by simple build
> >> configuration files.
> >>
> >> Having a mode that requires all build options to be specified
> >> explicitly (instead of silently picking a default) would be
> >> useful for distributions, too.
> >=20
> > I think we should maybe not mix host configuration (via ./configure) =
and
> > the target configuration (via kconfig), should we?
>=20
> Yeah, the configure command line is a different story.  If there are
> suggestion on how to improve it, great, but let's not conflate it with
> Kconfig.

I believe we have many ./configure options that are supposed to
be target configuration.  e.g.: --enable-slirp, --eanble-kvm,
--enable-xen, etc.

--=20
Eduardo
