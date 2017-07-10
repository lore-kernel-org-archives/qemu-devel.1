Received: from eggs.gnu.org ([2001:4830:134:3::10]:44737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUTiG-0001im-Na
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUTiD-0006vq-J0
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:06:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dUTiD-0006uw-9f
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:06:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
	<0a1d5638543965d532284bdc6fce391cf9f509d0.1499381754.git.alistair.francis@xilinx.com>
	<84wp7layt8.wl-Peter.Chubb@data61.csiro.au>
	<CAKmqyKMBiWcauXq3RayRYrhgcL+D2y4522h8to7KsRuUw+a2Ew@mail.gmail.com>
Date: Mon, 10 Jul 2017 10:06:18 +0200
In-Reply-To: <CAKmqyKMBiWcauXq3RayRYrhgcL+D2y4522h8to7KsRuUw+a2Ew@mail.gmail.com>
	(Alistair Francis's message of "Fri, 7 Jul 2017 10:19:20 -0700")
Message-ID: <87d1987m2t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter.Chubb@data61.csiro.au, Peter Maydell <peter.maydell@linaro.org>, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, jcody@redhat.com, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Rob Herring <robh@kernel.org>, jdurgin@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, philippe@mathieu-daude.net, pl@kamp.de, groug@kaod.org, Peter Chubb <peter.chubb@nicta.com.au>, ronniesahlberg@gmail.com, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, aneesh.kumar@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

Alistair Francis <alistair.francis@xilinx.com> writes:

> On Thu, Jul 6, 2017 at 5:14 PM,  <Peter.Chubb@data61.csiro.au> wrote:
>>>>>>> "Alistair" == Alistair Francis <alistair.francis@xilinx.com> writes:
>>
>> Alistair> Convert all uses of error_report("[Ww]arning:"... to use
>> Alistair> warn_report() instead. This helps standardise on a single
>> Alistair> method of printing warnings to the user.
>>
>> In a number of cases the initial double quote has been removed as
>> well.  This will have to be fixed.
>> e.g.,
>> -        error_report("Warning: 'filename' option specified. "
>> +        warn_report('filename' option specified. "
>
> Yeah, I thought I saw this when I was doing it, but then everything
> compiled so I figured it was fine.
>
> It must not all be included with the default ./configure, because I
> just tried again and it all compiles for me.

The result of ./configure depends on the packages you got installed.
You need quite a few development packages to get anywhere near a full
compile.  For a first step, you could do worse than installing your
distribution's QEMU package's build dependencies.

[...]
