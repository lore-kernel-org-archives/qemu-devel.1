Received: from eggs.gnu.org ([2001:4830:134:3::10]:41506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cIuY5-0003ae-LN
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cIuY2-0007Wq-Im
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:48:01 -0500
Received: from mail.ispras.ru ([83.149.199.45]:51214)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cIuY2-0007W3-6X
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:47:58 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
Date: Mon, 19 Dec 2016 12:47:56 +0300
Message-ID: <000301d259dc$f9d097c0$ed71c740$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

Hi!

 

I encountered the following bug with the latest version of QEMU.

I use windows host and start qemu with the following command line:

qemu-system-i386.exe -soundhw ac97 -snapshot -hda disk.qcow2 -net none

 

Guest system is Windows XP 32-bit. It founds new hardware (including audio controller)

and I start playing mp3 file.

After seconds of playing qemu fails with an exception.

 

I tried to bisect between 2.7 and 2.8, but bug is not stable.

It manifested itself at commits "68701de1362b29fd6941a2021e9393ddbe60edd8" and
"6a928d25b6d8bc3729c3d28326c6db13b9481059".

 

Pavel Dovgalyuk

 
