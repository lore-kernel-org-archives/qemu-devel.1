Received: from eggs.gnu.org ([2001:4830:134:3::10]:41507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKLW-0007uD-Pg
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKLT-0002oN-KL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVKLT-0002nm-BL
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:18:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499866456.git.alistair.francis@xilinx.com>
	<e1cfa2cd47087c248dd24caca9c33d9af0c499b0.1499866456.git.alistair.francis@xilinx.com>
Date: Wed, 12 Jul 2017 18:18:22 +0200
In-Reply-To: <e1cfa2cd47087c248dd24caca9c33d9af0c499b0.1499866456.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Wed, 12 Jul 2017 06:57:41 -0700")
Message-ID: <87shi139yp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/7] Convert error_report() to
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
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Rob Herring <robh@kernel.org>, Josh Durgin <jdurgin@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, philippe@mathieu-daude.net, Peter Lieven <pl@kamp.de>, Greg Kurz <groug@kaod.org>, Peter Chubb <peter.chubb@nicta.com.au>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Igor Mammedov <imammedo@redhat.com>, alistair23@gmail.com, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Alistair Francis <alistair.francis@xilinx.com> writes:

> Convert all uses of error_report("warning:"... to use warn_report()
> instead. This helps standardise on a single method of printing warnings
> to the user.
>
> All of the warnings were changed using these two commands:
>     find ./* -type f -exec sed -i \
>       's|error_report(".*warning[,:] |warn_report("|Ig' {} +
>
> Indentation fixed up manually afterwards.
>
> The test-qdev-global-props test case was manually updated to ensure that
> this patch passes make check (as the test cases are case sensitive).
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Cc: Jeff Cody <jcody@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Lieven <pl@kamp.de>
> Cc: Josh Durgin <jdurgin@redhat.com>
> Cc: "Richard W.M. Jones" <rjones@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Greg Kurz <groug@kaod.org>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed by: Peter Chubb <peter.chubb@data61.csiro.au>
> Acked-by: Max Reitz <mreitz@redhat.com>
> Acked-by: Marcel Apfelbaum <marcel@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
