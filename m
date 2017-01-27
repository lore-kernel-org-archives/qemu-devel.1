Received: from eggs.gnu.org ([2001:4830:134:3::10]:53293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jakub@jermar.eu>) id 1cX88J-0007eS-G6
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jakub@jermar.eu>) id 1cX889-000610-L5
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:08:11 -0500
Received: from tmave.modry.cz ([82.208.58.129]:42370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jakub@jermar.eu>) id 1cX889-0005zV-Dz
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:08:01 -0500
Received: from 93-153-64-87.tmcz.cz ([93.153.64.87] helo=[10.0.0.144])
	by tmave.modry.cz with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.86_2)
	(envelope-from <jakub@jermar.eu>) id 1cX87o-0006iv-7a
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 16:07:59 +0100
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
	<1484779123-18968-31-git-send-email-atar4qemu@gmail.com>
	<CAFEAcA8=gKjbo9YaRAzGHi-tP6AWY08ps_tEPOSzpNFXBC6M+Q@mail.gmail.com>
	<CACXAS8COsHWMAqoQTDqs6zh=-f0_u7posLQ1nUe6TKRfBaBSEg@mail.gmail.com>
From: =?UTF-8?B?SmFrdWIgSmVybcOhxZk=?= <jakub@jermar.eu>
Message-ID: <820bf3b1-e5bf-aade-d80d-5a19bd8b2f59@jermar.eu>
Date: Fri, 27 Jan 2017 16:07:40 +0100
MIME-Version: 1.0
In-Reply-To: <CACXAS8COsHWMAqoQTDqs6zh=-f0_u7posLQ1nUe6TKRfBaBSEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 30/30] target-sparc: fix up niagara machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Artyom,

On 01/23/2017 03:10 PM, Artyom Tarasenko wrote:
> On Mon, Jan 23, 2017 at 1:40 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 18 January 2017 at 22:38, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
>>> Remove the Niagara stub implementation from sun4u.c and add a machine,
>>> compatible with Legion simulator from the OpenSPARC T1 project.
>>>
>>> The machine uses the firmware supplied with the OpenSPARC T1 project,
>>> http://download.oracle.com/technetwork/systems/opensparc/OpenSPARCT1_Arch.1.5.tar.bz2
>>> in the directory S10image/, and is able to boot the supplied Solaris 10 image.
>>>
>>> Note that for compatibility with the naming conventions for SPARC machines
>>> the new machine name is lowercase niagara.
>>>
>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>>
>> I see that 'make check' now warns:
>>   GTESTER check-qtest-sparc64
>> Could not open option rom 'nvram1': No such file or directory
>> Could not open option rom '1up-md.bin': No such file or directory
>> Could not open option rom '1up-hv.bin': No such file or directory
>> Could not open option rom 'reset.bin': No such file or directory
>> Could not open option rom 'q.bin': No such file or directory
>> Could not open option rom 'openboot.bin': No such file or directory
>>
>> (though the tests still pass).
>>
>> Could we either ship these images in pc-bios if they're
>> necessary, or not complain that they don't exist if they're
>> not necessary, please?
> 
> I wonder what would be the best option  here. The images are
> necessary, so the last option - not complaining - can be misleading
> for a user.
> 
> Concerning shipping them.
> Pros:
> - the images are obviously freely distributable (the link above).
> - the corresponding source code was open-sourced by Sun under various
> licenses (GPL for hypervisor, BSD for openboot).
> Cons:
> - there is no exact tag the the OpenSPARC source tree which would
> correspond to the binaries.
> - building them is tricky, because it requires Solaris 9 / SPARC.
> 
> What do you think would be a better option?

I'd strongly prefer the option to build QEMU's own binaries and
distribute them in pc-bios/. Downloading this 190M tarball is a nuisance
and depending on their continued existence on the Oracle server is a risk.

Where does the dependency on Solaris 9 come from? You should be able to
run unmodified Solaris 9 binaries on eg. Solaris 10...

Best,
Jakub
