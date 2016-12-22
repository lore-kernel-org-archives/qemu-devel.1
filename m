Received: from eggs.gnu.org ([2001:4830:134:3::10]:40243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cK80I-0002AY-6S
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cK80F-0001nr-1q
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:22:10 -0500
Received: from smtp3.goneo.de ([85.220.129.37]:51086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <holger@fam-schranz.de>)
	id 1cK80E-0001nJ-Ri
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 13:22:06 -0500
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
	<20161220234738.GB2994@lemon>
	<3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
	<20161222062200.GB12950@lemon>
	<cbaa842d-d894-75f0-4cff-8030b317f2de@fam-schranz.de>
	<7b516cfe-7469-f429-c962-03459d76c3ed@redhat.com>
From: Holger Schranz <holger@fam-schranz.de>
Message-ID: <e16139e3-32f2-b84b-5432-e81afb79b249@fam-schranz.de>
Date: Thu, 22 Dec 2016 19:21:52 +0100
MIME-Version: 1.0
In-Reply-To: <7b516cfe-7469-f429-c962-03459d76c3ed@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: mueller-ralf@t-online.de, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

Hi Paolo,

thanks for the hint. In the SLES11 SP4 documentation
virtio-scsi is implemented, but this described SLES11SP4
as a host system not as a VM guest.

I'm totally confused. Why does the guest VM's runs until
version 2.7.0 without any problems (with older and newer
kernel versions)?

May be we have clear the configuration:
The host system we use is a SUSE LEAP 42.2. together with QEMU
2.8.0.

The guest systems are SLES10 - SLES12, RH 2.6.32-504 el6 up to 7.2,
and a lot of others (Debian, Fedora, ...).

Best regards

Holger

Am 22.12.2016 um 17:47 schrieb Paolo Bonzini:
>
> On 22/12/2016 13:33, Holger Schranz wrote:
>>
>> I have installed an RH 7.7 based on kernel 3.10 and a SuSE LEAP 42.2 which
>> is based on kernel 4.4. Both system see the tape devices and can work.
>> Than I restart in the same session the VM with SLES11 SP4 (kernel 3.0.101)
>> and an older RH based on kernel 2.6. This both system can't see the tape
>> drives.
>> But all 5 VM guest systems are registered in iscsi and show the UUID of the
>> guest system.
> Does SLES11SP4 support virtio-scsi at all?  If they haven't backported
> it, the first upstream Linux version with virtio-scsi was 3.4, I think.
>
> Paolo
