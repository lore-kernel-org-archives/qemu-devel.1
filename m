Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cK2ZX-0000tU-Gb
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cK2ZU-0001WU-Bc
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:34:11 -0500
Received: from smtp3.goneo.de ([85.220.129.37]:32906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <holger@fam-schranz.de>)
	id 1cK2ZU-0001VD-5S
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:34:08 -0500
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
	<20161220234738.GB2994@lemon>
	<3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
	<20161222062200.GB12950@lemon>
From: Holger Schranz <holger@fam-schranz.de>
Message-ID: <cbaa842d-d894-75f0-4cff-8030b317f2de@fam-schranz.de>
Date: Thu, 22 Dec 2016 13:33:26 +0100
MIME-Version: 1.0
In-Reply-To: <20161222062200.GB12950@lemon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Strange/wrong behavior with iSCSI Tape devices in
 QEMU 2.8.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: mueller-ralf@t-online.de, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

Hi Fam,

You win !!!

I have installed an RH 7.7 based on kernel 3.10 and a SuSE LEAP 42.2 which
is based on kernel 4.4. Both system see the tape devices and can work.
Than I restart in the same session the VM with SLES11 SP4 (kernel 3.0.101)
and an older RH based on kernel 2.6. This both system can't see the tape 
drives.
But all 5 VM guest systems are registered in iscsi and show the UUID of the
guest system.

Please, what should I do as a next step please?

Best regards

Holger

Am 22.12.2016 um 07:22 schrieb Fam Zheng:
> On Wed, 12/21 05:44, Holger Schranz wrote:
>> Hi Fam,
>>
>> meanwhile I have sent the requested QEMU CLI direct to John. Your request
>> I will try after the reinstall with the released version.So please wait
>> for a while.
> I don't see the command line, but looking at the other info, the question to ask
> is why guest cannot see the controller.. Maybe it's a driver issue? Do other
> types of guest work for you?
>
> Fam
>
