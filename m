Received: from eggs.gnu.org ([2001:4830:134:3::10]:56799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dONni-00048v-Ni
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dONnf-0007Lj-K4
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:35:02 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:35963
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dONnf-0007LL-An
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 08:34:59 -0400
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA9OibH=kz7iTc95YBgHM1WGOdHRYSsudx=OfaBHHZbJrg@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <2126be25-144e-f4a6-ef50-a053f905ab62@adacore.com>
Date: Fri, 23 Jun 2017 14:34:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9OibH=kz7iTc95YBgHM1WGOdHRYSsudx=OfaBHHZbJrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>



Le 06/23/2017 =C3=A0 12:54 PM, Peter Maydell a =C3=A9crit :
> On 14 June 2017 at 18:45, Edgar E. Iglesias <edgar.iglesias@gmail.com> =
wrote:
>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>
>> Hi,
>>
>> Paolo suggested offline that we send a pull request for this series.
>> Here it is, I've run it through my testsuite + tested the LQSPI testca=
se
>> on Zynq.
>>
>> Cheers,
>> Edgar
>>
>> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b=
3ae91:
>>
>>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm=
-20170613' into staging (2017-06-13 15:49:07 +0100)
>>
>> are available in the git repository at:
>>
>>    git@github.com:edgarigl/qemu.git tags/edgar/mmio-exec.for-upstream
>>
>> for you to fetch changes up to 63ef40dd6bc6cfdae5fa67ccac1cb11e7a5161b=
0:
>>
>>    xilinx_spips: allow mmio execution (2017-06-14 17:31:08 +0200)
>>
>> ----------------------------------------------------------------
>> mmio-exec.for-upstream
>>
>> ----------------------------------------------------------------
>> KONRAD Frederic (7):
>>        cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
>>        cputlb: move get_page_addr_code
>>        cputlb: fix the way get_page_addr_code fills the tlb
>>        qdev: add MemoryRegion property
>>        introduce mmio_interface
>>        exec: allow to get a pointer for some mmio memory region
>>        xilinx_spips: allow mmio execution
>=20
> Hi Edgar -- since these patches have come via your tree they should
> have your signed-off-by line, not just Fred's. They also seem to
> still have all the V1->V2->V3 revision notes in the commit logs.
>=20
> I'd be happier with a reviewed-by: from somebody for the exec:
> patch, if possible...
>=20
> thanks
> -- PMM
>=20

Hi Peter,

Actually if I remember right Edgar reviewed them but put the
review-by tag in the cover letter.

Thanks,
Fred
