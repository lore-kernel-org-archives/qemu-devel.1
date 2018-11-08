Received: from eggs.gnu.org ([2001:4830:134:3::10]:50856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gKhx4-0003Za-Qk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gKhx0-0000kE-0x
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:54:17 -0500
Received: from mail-yw1-f53.google.com ([209.85.161.53]:44607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gKhwz-0000jt-SQ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:54:13 -0500
Received: by mail-yw1-f53.google.com with SMTP id k6-v6so7812855ywa.11
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 02:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20180924092120.GA30163@caravaggio>
	<7c2b477e-bdac-c887-2510-82fe04acdcfe@redhat.com>
	<87b22690-e39c-3b46-dcb4-f6abc3213142@redhat.com>
	<CAFEAcA8yHb4MdtsJuXcswQp93DN5tSeN9dn8AWWL9se0DKvdcg@mail.gmail.com>
	<41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<CAFEAcA9oCs+Y1fnY8dOR16n_Hn7PaHziL7K0HZK6=BAd_Gyecg@mail.gmail.com>
	<e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<28af4bea-e017-cdab-e5e4-a9809cb2e409@redhat.com>
In-Reply-To: <28af4bea-e017-cdab-e5e4-a9809cb2e409@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 8 Nov 2018 11:53:08 +0100
Message-ID: <CAAdtpL4kzCkJ7MSCyXMwaBoiVfg1XVJH49bucQ-t5Mks85murw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, QEMU Developers <qemu-devel@nongnu.org>

Le jeu. 8 nov. 2018 11:30, Thomas Huth <thuth@redhat.com> a =C3=A9crit :

> On 2018-11-08 10:55, Paolo Bonzini wrote:
> > On 07/11/2018 20:30, Thomas Huth wrote:
> >> On 2018-11-07 20:24, Eduardo Habkost wrote:
> >>> On Wed, Nov 07, 2018 at 06:39:54PM +0100, Paolo Bonzini wrote:
> >>>> On 07/11/2018 16:41, Samuel Ortiz wrote:
> >>>>> - The Kconfig parser would be used to generate the equivalent of
> what we
> >>>>>   currently have under default-configs/
> >>
> >> I think we would still have something like default-configs - but there
> >> would only be the bare minimum config switches in there, the rest woul=
d
> >> be pulled in by dependencies.
> >
> > Yes, in theory default-configs would end up empty, except for possibly
> > some commented lines to show the "default y" symbols for the target.
>
> I think we should enable the machines in the default configs (and maybe
> optional devices that are not automatically selected by machines), e.g.:
>
> CONFIG_I440FX=3Dy
> CONFIG_Q35=3Dy
> CONFIG_VIRTPC=3Dy
> CONFIG_ISAPC=3Dy
> CONFIG_VIRTIO=3Dy
> CONFIG_PARALLEL=3Dy
>
> In configs/nemu (or configs/lean-kvm or however we'll call it), you will
> then only have:
>
> CONFIG_Q35=3Dy
> CONFIG_VIRTPC=3Dy
>

CONFIG_VIRTX86 seems more XXI century.

CONFIG_VIRTIO=3Dy
>
> Would that make sense?
>
>  Thomas
>
>
