Received: from eggs.gnu.org ([2001:4830:134:3::10]:40217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dae7G-0003xs-7P
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dae7D-00052f-Is
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dae7D-00052R-CN
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 04:25:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
	<1499952476-3454-7-git-send-email-armbru@redhat.com>
	<20170717101906.GC5301@noname.redhat.com>
	<87a842b9yo.fsf@dusky.pond.sub.org>
	<87bmoauz2s.fsf@dusky.pond.sub.org>
	<5b194736-15ba-7f62-cc8b-46cf03777644@redhat.com>
Date: Thu, 27 Jul 2017 10:25:38 +0200
In-Reply-To: <5b194736-15ba-7f62-cc8b-46cf03777644@redhat.com> (Paolo
	Bonzini's message of "Mon, 24 Jul 2017 09:30:06 +0200")
Message-ID: <87k22uffr1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 6/9] Convert error_report() to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Rob Herring <robh@kernel.org>, Josh Durgin <jdurgin@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>, Jeff Cody <jcody@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Lieven <pl@kamp.de>, Greg Kurz <groug@kaod.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Chubb <peter.chubb@nicta.com.au>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, "An eesh
	Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 24/07/2017 08:30, Markus Armbruster wrote:
[...]
>> What's the recommended way to run all iotests a build of QEMU can run?
>
> I use "path-to-srcdir/tests/check-block.sh".  It takes about 20 minutes.
>
> There are two issues with check-block:
>
> * tests that require QEMU are skipped (rationale: you might be building
> without the x86_64-softmmu target).
>
> * it only runs the "quick" group, but I think we should reverse the
> direction and mark slow tests specifically (that would cut about 10
> minutes out of the 20).
>
> It's a pity that qemu-iotests doesn't parallelize.

Indeed.

>                                                     Maybe the harness
> could be changed to something more standard.

Certainly not a "bite-sized task".  Could it be a fit for GSOC or
Outreachy?
