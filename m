Received: from eggs.gnu.org ([2001:4830:134:3::10]:56658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gianluca.cecchi@gmail.com>) id 1euGfG-0006l5-FA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gianluca.cecchi@gmail.com>) id 1euGfF-0007Bm-53
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:58:22 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:40100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gianluca.cecchi@gmail.com>)
	id 1euGfE-0007BM-UN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:58:21 -0500
Received: by mail-vk0-x22c.google.com with SMTP id n82so1922783vkf.7
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:58:20 -0800 (PST)
MIME-Version: 1.0
From: Gianluca Cecchi <gianluca.cecchi@gmail.com>
Date: Fri, 9 Mar 2018 12:58:18 +0100
Message-ID: <CAG2kNCw6-xSKGAY9P71teL0rOXY7-Yb=PX434UrfF_-LJV+XYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Chance to have fsfreeze-hook for WIndows?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,
currently I'm not a subscriber.
I tried but I got
"
The form is too old. Please GET it again.
"

Comparing commands-posix.c and commands-win32.c on master at
https://github.com/qemu/qemu/tree/master/qga
it seems to me that freeze-hook functionality is not present on Windows OS.
Could you confirm, please?

I would like to get it, because I think it could be useful in some scenarios

My use case is that I have an Oracle RDBMS used for BI and so it is not in
archivelog mode for perfomance reasons. So when I snapshot the WIndows 2008
R2 x64 VM at 22:00, just before the processing for the last day, I get the
app event

Oracle.VSSWriter with event id 44

VSS-00044: Database in NOARCHIVELOG mode must be in a consistent state for
backup.

Cause : The database was open read/write or mounted after a SHUTDOWN
IMMEDIATE or SHUTDOWN ABORT.

Action : Either mount the database in a consistent state or open it
read-only to back up the database files.

Additional info :
Oracle Database 11g Release 11.2.0.4.0 - 64bit Production
Oracle VSS writer version 11.2.0.2.0 Production
Error at line : 4576
Failure on PrepareForBackup event

I would like to save a consistent view of the database, right before the
next processing start.

I can setup an at job that some minutes before snapshot closes the rdbms
and some minutes after reopens it, but it would be useful to coordinate
with the snapshot command itself, if possible.

Thanks in advance,
Gianluca
