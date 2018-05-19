Received: from eggs.gnu.org ([2001:4830:134:3::10]:51400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fJv9M-0006E6-2B
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fJv9H-0007Zq-JZ
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:15:27 -0400
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
	<3db651e3-a237-fbaa-6ffe-ecc5db43ad0f@tuxfamily.org>
	<E9FA9AA6-FDA6-467F-9B72-B331756464A7@xenosoft.de>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <ccaa7d46-79d4-c223-3828-ae22a59392db@tuxfamily.org>
Date: Sat, 19 May 2018 08:15:20 +0200
MIME-Version: 1.0
In-Reply-To: <E9FA9AA6-FDA6-467F-9B72-B331756464A7@xenosoft.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PPC64] P5020DS: Booting from img
 possible (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, qemu-devel@nongnu.org

On 19.05.2018 06:58, Christian Zigotzky wrote:
> Thomas wrote:
> 
> > No clue, so just a blind guess: Is "CoreNet Generic" the right machine?
> > What happens if you set "CONFIG_CORENET_GENERIC=n" in your kernel config?
> 
> I think it‘s the right machine.

It's likely the right selection for the real hardware, but it's maybe
the wrong machine type for the QEMU ppce500 machine.

 Thomas
