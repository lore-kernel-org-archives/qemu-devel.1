Received: from eggs.gnu.org ([2001:4830:134:3::10]:33538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrewjameswood@ymail.com>) id 1fCYoq-0005Jh-GD
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 18:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrewjameswood@ymail.com>) id 1fCYon-0002m6-Ec
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 18:59:52 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com ([77.238.178.147]:38705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrewjameswood@ymail.com>)
	id 1fCYon-0002lu-73
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 18:59:49 -0400
Received: from host109-151-162-242.range109-151.btcentralplus.com (EHLO
	[192.168.253.68]) ([109.151.162.242])
	by smtp425.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	e104b822293fb193f564fa9f924952a0 for <qemu-devel@nongnu.org>;
	Sat, 28 Apr 2018 22:59:42 +0000 (UTC)
From: Andrew Wood <andrewjameswood@ymail.com>
Message-ID: <ba020090-1877-6b9a-891d-dbfbabf25c71@ymail.com>
Date: Sat, 28 Apr 2018 23:59:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Qemu-devel] Unix signal to send ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Ive been looking into the possibility of using a unix signal to send an 
acpi shutdown request to a VM, and came across a posting on this l in 
March 1. See 
https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04169.html


To summarise to refresh memories  there was a patch proposed using 
SIGINT followed by discussion as to why SIGINT wasnt ideal because it 
would cause regressions for anyone relying on the existing handling of 
SIGINT, and various other signals were considered including HUP & USR1 & 
USR2 all of which are already used for something else.

Is SIGPWR a suitable candidate, I have made a patch to use SIGPWR but as 
Im new to QEMUs internals Im not sure if there are any circumstances in 
which an alternative handler is registered for SIGPWR which might conflict?

Regards

Andrew
