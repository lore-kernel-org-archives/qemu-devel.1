Received: from eggs.gnu.org ([2001:4830:134:3::10]:40695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dIsH5-0001Xu-0e
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dIsH1-00080z-39
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:54:35 -0400
Received: from greensocs.com ([193.104.36.180]:51628)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dIsH0-00080Q-Lk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:54:31 -0400
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
From: KONRAD Frederic <fred.konrad@greensocs.com>
Message-ID: <1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
Date: Thu, 8 Jun 2017 09:54:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>



Le 06/06/2017 =C3=A0 17:18, Peter Maydell a =C3=A9crit :
> On 24 May 2017 at 08:35, KONRAD Frederic <fred.konrad@greensocs.com> wr=
ote:
>> Le 28/02/2017 =C3=A0 11:02, fred.konrad@greensocs.com a =C3=A9crit :
>>> This is the third version of the clock framework API it contains:
>>>
>>>   * The first 6 patches which introduce the framework.
>>>   * The 7th patch which introduces a fixed-clock model.
>>>   * The rest which gives an example how to model a PLL from the exist=
ing
>>>     zynqmp-crf extracted from the qemu xilinx tree.
>>>
>>> No specific behavior is expected yet when the CRF register set is acc=
essed
>>> but
>>> the user can see for example the dp_video_ref and vpll_to_lpd rate
>>> changing in
>>> the monitor with the "info qtree" command when the vpll_ctrl register=
 is
>>> modified.
>
> Some top-level review:
>
> * I like the documentation, this is very helpful
> * consider tracepoints rather than DPRINTF macro
> * qemu_clk_device_add_clock() does a g_strdup, but when is this freed?
>   (consider devices which are hot-unpluggable)
> * similarly, what if a device with a clock with a lot of child nodes
>   is destroyed? how are the ClkList structs freed?
> * interaction with migration -- how is the "this clock is at this rate"
>   state intended to be migrated?
> * I'll leave the review of the xilinx patches to the xilinx folk
> * the 'introduce zynqmp_crf' patch is missing any signoffs
>   (in particular if it's from the xilinx tree it will need
>   signoff from them)
>
> thanks
> -- PMM
>

Nice thanks for the feedback!

Actually the hot unpluggable is a good question what can we do for that?
Is that reasonable for a device which produce a clock to be hot
unpluggable?

For the migration maybe we can refresh the whole clock tree at the end
of the migration. Is that a good idea?

Fred
