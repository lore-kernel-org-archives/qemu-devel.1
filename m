Received: from eggs.gnu.org ([209.51.188.92]:41388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0o3w-0000dW-EI
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0o3v-0001wc-L1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:55:24 -0500
Date: Mon, 4 Mar 2019 14:55:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190304145510.57c73177@redhat.com>
In-Reply-To: <15464582-e8a6-6654-7679-15d87c10af38@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<15464582-e8a6-6654-7679-15d87c10af38@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [libvirt] [PATCH 1/2] numa: deprecate
 'mem' parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, 4 Mar 2019 09:11:19 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 01/03/2019 18.48, Daniel P. Berrang=C3=A9 wrote:
> [...]
> > So I think this patch has to be dropped & replaced with one that
> > simply documents that memdev syntax is preferred. =20
>=20
> That's definitely not enough. I've had a couple of cases already where
> we documented that certain options should not be used anymore, and
> people simply ignored it (aka. if it ain't broken, don't do any change).
> Then they just started to complain when I really tried to remove the
> option after the deprecation period.

> So Igor, if you can not officially deprecate these things here yet, you
> should at least make sure that they can not be used with new machine
> types anymore. Then, after a couple of years, when we feel sure that
> there are only some few or no people left who still use it with the old
> machine types, we can start to discuss the deprecation process again, I
> think.
Is it acceptable to silently disable CLI options (even if they are broken
like in this case) for new machine types?
I was under impression that it should go through deprecation first.

>=20
>  Thomas
>=20
