Received: from eggs.gnu.org ([2001:4830:134:3::10]:41995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Taimoor_Mirza@mentor.com>) id 1gI8rR-0003pi-L4
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 05:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Taimoor_Mirza@mentor.com>) id 1gI8rM-0002oV-3a
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 05:01:53 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:62093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Taimoor_Mirza@mentor.com>)
	id 1gI8rL-0002iN-T1
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 05:01:48 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1gI8rA-0003tZ-A0 from Taimoor_Mirza@mentor.com
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:01:36 -0700
From: "Mirza, Taimoor" <Taimoor_Mirza@mentor.com>
Date: Thu, 1 Nov 2018 09:01:32 +0000
Message-ID: <1541062892376.47634@mentor.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Running application on R5 of xilinx zcu102 QEMU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi Guys,

I have built my application to run on Cortex-R5 ZCU-102. I can successfully=
 run my application on target but I am now trying to run it on QEMU zcu-102=
 model and facing some problems. Below is the command that I am using:

~/qemu_oss/qemu/aarch64-softmmu/qemu-system-aarch64 -M xlnx-zcu102 -serial =
stdio -serial /dev/null -display none -device loader,file=3D<out_file_path>=
,cpu-num=3D5 -monitor telnet:127.0.0.1:1234,server,nowait

It gives me following error:
qemu-system-aarch64: -device loader,file=3D<my_out_file>,cpu-num=3D5: Speci=
fied boot CPU#5 is nonexistent

Also when I check cpus from monitor, it only shows 4 CPUs.

Thanks,
Taimoor
