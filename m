Received: from eggs.gnu.org ([2001:4830:134:3::10]:46220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1vM7-0002xn-G0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1vM2-0005t4-EF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:17:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62936
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e1vM2-0005rL-3k
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:17:54 -0400
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
	<20171006152751.GR4015@localhost.localdomain>
	<CAFEAcA94pKm22fX1kCr72-SsM06Z2AMUZ65a7zJ_UPrarkBg1w@mail.gmail.com>
	<4479e30f-801d-0d8e-712d-06f2dd987528@cn.fujitsu.com>
	<20171010125231.GD4015@localhost.localdomain>
	<CAFEAcA_M-6yb1Vx0dT77zg8wUO+vNzawTNnubmd=OO_CB6t9vg@mail.gmail.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <d1d685cc-8434-a805-9113-e6db57aaf576@cn.fujitsu.com>
Date: Tue, 10 Oct 2017 22:17:30 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_M-6yb1Vx0dT77zg8wUO+vNzawTNnubmd=OO_CB6t9vg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

At 10/10/2017 08:56 PM, Peter Maydell wrote:
> On 10 October 2017 at 13:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> This shouldn't happen if CONFIG_IASL is not defined.  Did you run
>> configure again after removing iasl?
>
> I've neither added nor removed iasl from the build systems
> in question. Pull request tests just apply the pull and
> run make/make check.
>

Yes, Indeed.

now I can be sure that the problem is not related to iasl
installed or not. There are both OK in my host.

According to:
 >>> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-6QYK7Y.dsl,
 >>> aml:/tmp/aml-E8YK7Y], Expected [asl:/tmp/asl-1H1I7Y.dsl,
 >>> aml:tests/acpi-test-data/pc/DSDT.memhp].

May I resend the patch independently, and could you help me test it in
your machine. then, give me the output files, such as 
/tmp/asl-6QYK7Y.dsl and /tmp/asl-1H1I7Y.dsl file.

Thanks,
	dou.
> thanks
> -- PMM
>
>
>
