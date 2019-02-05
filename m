Received: from eggs.gnu.org ([209.51.188.92]:57385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gr6DP-0002WK-Lb
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gr6DO-0002TW-SB
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:17:03 -0500
MIME-Version: 1.0
References: <1549371525-29899-1-git-send-email-thuth@redhat.com>
	<50ea8b3e-cd8e-c6e9-86dc-2e50b78646c5@greensocs.com>
In-Reply-To: <50ea8b3e-cd8e-c6e9-86dc-2e50b78646c5@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Feb 2019 11:16:22 -0800
Message-ID: <CAKmqyKNgj=u5vKgR1F_fMKs8NLq2ze1OamgUxZOqzN1jytF3qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/cpu/cluster: Mark the cpu-cluster
 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>

On Tue, Feb 5, 2019 at 7:22 AM Luc Michel <luc.michel@greensocs.com> wrote:
>
>
>
> On 2/5/19 1:58 PM, Thomas Huth wrote:
> > The device can not be instantiated by the user and QEMU currently
> > aborts when you try to use it:
> >
> > $ x86_64-softmmu/qemu-system-x86_64 -device cpu-cluster
> > qemu-system-x86_64: hw/cpu/cluster.c:73: cpu_cluster_realize:
> >  Assertion `cbdata.cpu_count > 0' failed.
> > Aborted (core dumped)
> >
> > Since this is an internal device only, mark it with user_creatable = false.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> > ---
> >  hw/cpu/cluster.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
> > index 25f9070..6f5f037 100644
> > --- a/hw/cpu/cluster.c
> > +++ b/hw/cpu/cluster.c
> > @@ -79,6 +79,9 @@ static void cpu_cluster_class_init(ObjectClass *klass, void *data)
> >
> >      dc->props = cpu_cluster_properties;
> >      dc->realize = cpu_cluster_realize;
> > +
> > +    /* This is not directly for users, CPU children must be attached by code */
> > +    dc->user_creatable = false;
> >  }
> >
> >  static const TypeInfo cpu_cluster_type_info = {
> >
>
