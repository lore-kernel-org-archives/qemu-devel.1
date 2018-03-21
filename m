Received: from eggs.gnu.org ([2001:4830:134:3::10]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eyenk-00021g-00
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eyeng-0006bI-Q5
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:33:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eyeng-0006Za-Mx
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:33:12 -0400
Date: Wed, 21 Mar 2018 15:33:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180321153309.0c36cb07@redhat.com>
In-Reply-To: <4c7b83ad-8306-5c52-22e9-044a9f926a56@amsat.org>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<4c7b83ad-8306-5c52-22e9-044a9f926a56@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/6] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, alistair23@gmail.com, Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, marcel@redhat.com

On Wed, 14 Mar 2018 00:13:40 +0100
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 02/02/2018 01:42 AM, Alistair Francis wrote:
> >=20
> > There are numorous QEMU machines that only have a single or a handful of
> > valid CPU options. To simplyfy the management of specificying which CPU
> > is/isn't valid let's create a property that can be set in the machine
> > init. We can then check to see if the user supplied CPU is in that list
> > or not. =20
>=20
> Sadly this series missed the 2.12 train.
problematic part here is 'cpu_type -> cpu_model' conversion
without introducing back cpu model names in boards code.

Each target sort of already has this code 'cpu_list' for
printing supported CPU models. What we need is to generalize
it as most of the targets implement it the same way.
And then reuse generic code for 'cpu_type -> cpu_model'
so that boards won't have to be involved in it.

So currently cpu_list needs a volunteer who would be able
to generalize it and cleanup all targets across the the tree.
