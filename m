Received: from eggs.gnu.org ([2001:4830:134:3::10]:39770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1donaP-0003w1-1i
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1donaK-0008D2-6k
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:22:29 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1donaK-0008Cn-0I
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:22:24 -0400
Received: by mail-wr0-x233.google.com with SMTP id y15so13066854wrc.2
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 02:22:23 -0700 (PDT)
Date: Mon, 4 Sep 2017 10:22:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170904092220.GC20713@stefanha-x1.localdomain>
References: <CAJoBWHxiBU9bc-GMOxc9n=U6r3xbWQ=b7aeU0p5afhHZzm4RcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJoBWHxiBU9bc-GMOxc9n=U6r3xbWQ=b7aeU0p5afhHZzm4RcA@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU simpletrace.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Derrick McKee <derrick.mckee@gmail.com>
Cc: qemu-devel@nongnu.org

On Fri, Sep 01, 2017 at 03:52:03PM +0000, Derrick McKee wrote:
> I am having trouble using the simpleparser.py script in QEMU.  Hopefully, I
> am doing something incorrect and you can quickly set me back on course.
> 
> I have generated a trace file as per the instructions in
> docs/devel/tracing.txt.  However, whenever I try to run the simpleparser.py
> script I get a file not found error:
> 
> <QEMU source>/build/scripts/simpletrace.py trace-events-all trace-30218
> Traceback (most recent call last):
>   File "/home/derrick/code/qemu/build/scripts/simpletrace.py", line 262, in
> <module>
>     run(Formatter())
>   File "/home/derrick/code/qemu/build/scripts/simpletrace.py", line 236, in
> run
>     events = read_events(open(sys.argv[1], 'r'))
> IOError: [Errno 2] No such file or directory: 'trace-events-all'
> 
> It seems like the python script is considering 'trace-events-all' as a
> file, but the directions don't make it seem like it should be a file.

trace-events-all is a file that is generated at build time.  It is
needed by simpletrace.py.

You can find the trace-events-all file in the root directory of your
QEMU build tree.

The documentation says:

  The individual "trace-events" files are merged into a "trace-events-all" file,
  which is also installed into "/usr/share/qemu" with the name "trace-events".

If you can think of a way to make the documentation clearer, please feel
free to send a patch.  Guidelines on submitting patches are here:
https://wiki.qemu.org/index.php/Contribute/SubmitAPatch

Stefan
