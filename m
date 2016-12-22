Received: from eggs.gnu.org ([2001:4830:134:3::10]:57377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cK6Wg-0003XJ-QW
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 11:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cK6Wd-0006Ht-N0
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 11:47:30 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:35410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cK6Wd-0006HS-Gp
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 11:47:27 -0500
Received: by mail-wj0-x242.google.com with SMTP id hb5so3842127wjc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 08:47:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
	<20161220234738.GB2994@lemon>
	<3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
	<20161222062200.GB12950@lemon>
	<cbaa842d-d894-75f0-4cff-8030b317f2de@fam-schranz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b516cfe-7469-f429-c962-03459d76c3ed@redhat.com>
Date: Thu, 22 Dec 2016 17:47:23 +0100
MIME-Version: 1.0
In-Reply-To: <cbaa842d-d894-75f0-4cff-8030b317f2de@fam-schranz.de>
Content-Type: text/plain; charset=windows-1252
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
To: Holger Schranz <holger@fam-schranz.de>, Fam Zheng <famz@redhat.com>
Cc: mueller-ralf@t-online.de, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org



On 22/12/2016 13:33, Holger Schranz wrote:
> 
> 
> I have installed an RH 7.7 based on kernel 3.10 and a SuSE LEAP 42.2 which
> is based on kernel 4.4. Both system see the tape devices and can work.
> Than I restart in the same session the VM with SLES11 SP4 (kernel 3.0.101)
> and an older RH based on kernel 2.6. This both system can't see the tape
> drives.
> But all 5 VM guest systems are registered in iscsi and show the UUID of the
> guest system.

Does SLES11SP4 support virtio-scsi at all?  If they haven't backported
it, the first upstream Linux version with virtio-scsi was 3.4, I think.

Paolo
