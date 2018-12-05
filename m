Received: from eggs.gnu.org ([2001:4830:134:3::10]:50455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gUZxO-0004f5-2n
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gUZxJ-0008LK-Fn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:23:26 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:33451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gUZxJ-0008Jz-6m
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:23:21 -0500
Received: by mail-io1-f54.google.com with SMTP id t24so17182793ioi.0
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 08:23:21 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
	<938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
	<CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
	<a1ca57134a970fb3282afb36c0e3b5647b104ff8.camel@intel.com>
	<CAGxU2F7Sg0JaxyPQw_FhSc6MzYu+YzZpv9=VHp8qvwfTWpf_MQ@mail.gmail.com>
	<51ea7a7e-964a-0f05-75f2-11d6acd9ab77@redhat.com>
In-Reply-To: <51ea7a7e-964a-0f05-75f2-11d6acd9ab77@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 5 Dec 2018 17:23:08 +0100
Message-ID: <CAGxU2F6EYdbmhSr8_vQNMf--FLDGrgSCrYR2TJzx4jkbE0J=fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: Rob Bradford <robert.bradford@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

Hi Philippe,

On Wed, Dec 5, 2018 at 1:26 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Stefano,
>
> On 3/12/18 17:35, Stefano Garzarella wrote:
> > On Mon, Dec 3, 2018 at 4:44 PM Rob Bradford <robert.bradford@intel.com>=
 wrote:
> >>
> >> Hi Stefano, thanks for capturing all these numbers,
> >>
> >> On Mon, 2018-12-03 at 15:27 +0100, Stefano Garzarella wrote:
> >>> Hi Rob,
> >>> I continued to investigate the boot time, and as you suggested I
> >>> looked also at qemu-lite 2.11.2
> >>> (https://github.com/kata-containers/qemu) and NEMU "virt" machine. I
> >>> did the following tests using the Kata kernel configuration
> >>> (
> >>> https://github.com/kata-containers/packaging/blob/master/kernel/confi=
gs/x86_64_kata_kvm_4.14.x
> >>> )
> >>>
> >>> To compare the results with qemu-lite direct kernel load, I added
> >>> another tracepoint:
> >>> - linux_start_kernel: first entry of the Linux kernel
> >>> (start_kernel())
> >>>
> >>
> >> Great, do you have a set of patches available that all these trace
> >> points. It would be great for reproduction.
> >
> > For sure! I'm attaching a set of patches for qboot, seabios, ovmf,
> > nemu/qemu/qemu-lite and linux 4.14 whit the tracepoints.
> > I'm also sharing a python script that I'm using with perf to extract
> > the numbers in this way:
> >
> > $ perf record -a -e kvm:kvm_entry -e kvm:kvm_pio -e
> > sched:sched_process_exec -o /tmp/qemu_perf.data &
> > $ # start qemu/nemu multiple times
> > $ killall perf
> > $ perf script -s qemu-perf-script.py -i /tmp/qemu_perf.data
> [...]
> Good stuff. At some point I'd like to have such scripts in the QEMU
> repository to run perf tests on a regular basis (eventually keep those
> metrics somewhere) to be able to catch when we add code that add
> timeoutes and increase boot time.

Thanks for your feedback, maybe we need a version of SeaBIOS and Linux
kernel compiled with the probes.
I'll keep you update.

Cheers,
Stefano

>
> Regards,
>
> Phil.



--
Stefano Garzarella
Red Hat
