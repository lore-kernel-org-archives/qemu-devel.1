Received: from eggs.gnu.org ([2001:4830:134:3::10]:47813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dTWv3-000687-Bh
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dTWv1-0006Bm-Uq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:19:53 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dTWv1-0006B6-Lk
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:19:51 -0400
Received: by mail-wr0-x243.google.com with SMTP id k67so8963272wrc.1
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 10:19:51 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <84wp7layt8.wl-Peter.Chubb@data61.csiro.au>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
	<84wp7layt8.wl-Peter.Chubb@data61.csiro.au>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 7 Jul 2017 10:19:20 -0700
Message-ID: <CAKmqyKMBiWcauXq3RayRYrhgcL+D2y4522h8to7KsRuUw+a2Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 3/6] Convert error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter.Chubb@data61.csiro.au
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, philippe@mathieu-daude.net, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, ronniesahlberg@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, pl@kamp.de, jdurgin@redhat.com, rjones@redhat.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jul 6, 2017 at 5:14 PM,  <Peter.Chubb@data61.csiro.au> wrote:
>>>>>> "Alistair" == Alistair Francis <alistair.francis@xilinx.com> writes:
>
> Alistair> Convert all uses of error_report("[Ww]arning:"... to use
> Alistair> warn_report() instead. This helps standardise on a single
> Alistair> method of printing warnings to the user.
>
> In a number of cases the initial double quote has been removed as
> well.  This will have to be fixed.
> e.g.,
> -        error_report("Warning: 'filename' option specified. "
> +        warn_report('filename' option specified. "

Yeah, I thought I saw this when I was doing it, but then everything
compiled so I figured it was fine.

It must not all be included with the default ./configure, because I
just tried again and it all compiles for me.

I'll fix these up in the next version.

Thanks,
Alistair

>
> I'm surprised the result compiled cleanly.
>
> Peter C
>
>
> --
> Dr Peter Chubb         Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
> Trustworthy Systems Group                           Data61 (formerly NICTA)
