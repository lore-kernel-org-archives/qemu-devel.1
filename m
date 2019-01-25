Received: from eggs.gnu.org ([209.51.188.92]:55890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gmyFY-000465-66
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gmyFW-00048s-Pp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:58:12 -0500
Received: from mail.ispras.ru ([83.149.199.45]:35364)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gmyFW-00047A-D6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:58:10 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
Date: Fri, 25 Jan 2019 12:58:04 +0300
Message-ID: <003301d4b494$775585c0$66009140$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Querying possible -cpu variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, eblake@redhat.com, =?koi8-r?B?J+bV0tPP18Eg7sHUwczJ0Sc=?= <Natalia.Fursova@ispras.ru>

Hello.

 

We are making GUI for QEMU (which also should allow convenient record/replay command line
generation): https://github.com/ispras/qemu-gui

 

To fill the combo box in CPU selection form we run QEMU with "-cpu help" command and parse its
output.

The format of this list depends on target. Therefore our parsing code does not look good (and also
may corrupt someday).

 

Is there a better way of requesting this information?

 

Or we should do one of the following:

1.       Patch all targets and make the uniform "-cpu help" output format

2.       Add QMP command for requesting this list.

 

Pavel Dovgalyuk

 
