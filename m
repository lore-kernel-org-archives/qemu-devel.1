Received: from eggs.gnu.org ([2001:4830:134:3::10]:56500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTmKg-00066S-Rt
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTmKg-0007Zj-1V
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:24:10 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTmKf-0007Z2-SC
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 06:24:09 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so11218134oth.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 03:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20181123091729.29921-1-luc.michel@greensocs.com>
	<20181123091729.29921-2-luc.michel@greensocs.com>
	<20181123181059.GN18284@habkost.net>
	<65d3a572-9a80-f332-1f88-69e43e8a3663@redhat.com>
	<20181126132731.GJ18284@habkost.net>
	<CAFEAcA8D7ZjO059Sgrx-4i0iT+V3gxT4f=DvdmUAJS7KomtyOg@mail.gmail.com>
	<b8e20686-e5d1-a844-48f7-a4ae471e3fd5@greensocs.com>
In-Reply-To: <b8e20686-e5d1-a844-48f7-a4ae471e3fd5@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 11:23:56 +0000
Message-ID: <CAFEAcA8j4xTiS3_ktiA0hm2N4cu5RvxAtYqUHgvY-bUXgcwbjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 01/16] hw/cpu: introduce CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 3 Dec 2018 at 11:21, Luc Michel <luc.michel@greensocs.com> wrote:
>
> On 11/30/18 5:52 PM, Peter Maydell wrote:
> > Luc: what are the requirements on boards using CPU cluster
> > objects? I assume these are both OK:
> >  * does not use cluster objects at all
> >    (the gdbstub puts all the CPUs in one process?)
> Yes, when no clusters are found, a process with PID 1 is created and
> used for all CPUs.
> >  * all CPUs created are in some CPU cluster
> >    (the gdbstub uses one process per CPU cluster)
> > but what about
> >  * some CPUs are created in a CPU cluster, but some
> >    are "loose", not in any cluster at all> ?
> > Is that just invalid, or do the "loose" CPUs end up in
> > a default cluster (gdbstub process), or do they get
> > one cluster each?
> Currently this is valid and the "loose" CPUs end up in the first
> available process (which will be PID 1 if we are in your first case,
> i.e. no clusters in the machine).

So if there are some defined clusters 1 and 2, and some
loose CPUs, the clusters get PID 1 and PID 2, and the
loose CPUs end up in PID 3? That seems reasonable.

thanks
-- PMM
