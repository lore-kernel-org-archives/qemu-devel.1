Received: from eggs.gnu.org ([2001:4830:134:3::10]:55897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <derrick.mckee@gmail.com>) id 1dnoF0-0004iU-5E
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <derrick.mckee@gmail.com>) id 1dnoEz-0007Zd-2t
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:52:18 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:36552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <derrick.mckee@gmail.com>)
	id 1dnoEy-0007Z8-UX
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:52:17 -0400
Received: by mail-oi0-x230.google.com with SMTP id t75so5122902oie.3
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 08:52:15 -0700 (PDT)
MIME-Version: 1.0
From: Derrick McKee <derrick.mckee@gmail.com>
Date: Fri, 01 Sep 2017 15:52:03 +0000
Message-ID: <CAJoBWHxiBU9bc-GMOxc9n=U6r3xbWQ=b7aeU0p5afhHZzm4RcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU simpletrace.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I am having trouble using the simpleparser.py script in QEMU.  Hopefully, I
am doing something incorrect and you can quickly set me back on course.

I have generated a trace file as per the instructions in
docs/devel/tracing.txt.  However, whenever I try to run the simpleparser.py
script I get a file not found error:

<QEMU source>/build/scripts/simpletrace.py trace-events-all trace-30218
Traceback (most recent call last):
  File "/home/derrick/code/qemu/build/scripts/simpletrace.py", line 262, in
<module>
    run(Formatter())
  File "/home/derrick/code/qemu/build/scripts/simpletrace.py", line 236, in
run
    events = read_events(open(sys.argv[1], 'r'))
IOError: [Errno 2] No such file or directory: 'trace-events-all'

It seems like the python script is considering 'trace-events-all' as a
file, but the directions don't make it seem like it should be a file.
Thoughts?  Thanks
-- 
Derrick McKee
Ph.D. Student at Purdue University
