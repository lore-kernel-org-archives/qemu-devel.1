Received: from eggs.gnu.org ([2001:4830:134:3::10]:33668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eS9nk-0004M2-Ro
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eS9nk-00070O-2z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:58:56 -0500
References: <CACaajQsL3e+XWR0hBDLThmG_fd=ih-n+HJVz++XcnwLhhVstgg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <56c5bcbb-02c0-a3f7-4363-e3141476b2f8@redhat.com>
Date: Thu, 21 Dec 2017 17:58:47 -0500
MIME-Version: 1.0
In-Reply-To: <CACaajQsL3e+XWR0hBDLThmG_fd=ih-n+HJVz++XcnwLhhVstgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu 2.9.0 qcow2 file failed to open after hard
 server reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vasiliy Tolstov <v.tolstov@selfip.ru>, qemu-devel <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>



On 12/21/2017 05:13 PM, Vasiliy Tolstov wrote:
> Hi! Today my server have forced reboot and one of my vm can't start
> with message:
> qcow2: Marking image as corrupt: L2 table offset 0x3f786d6c207600
> unaligned (L1 index: 0); further corruption events will be suppressed
> 
> i'm use debian jessie with hand builded qemu 2.9.0, i'm try to
> qemu-img check but it not helps. How can i recover data inside qcow2
> file? (i'm not use compression or encryption inside it).
> 

Not looking good if you're missing the very first L2 table in its entirety.

You might be able to go through this thing by hand and learn for
yourself where the L2 table is (it will be a 64KiB region, aligned to a
64KiB boundary, that all contain 64bit, 64KiB aligned pointers that will
be less than the size of the file. the offset of this missing region is
not likely to be referenced elsewhere in your file.)

and then, once you've found it, you can update the pointer that's wrong.
However, where there's smoke there's often fire, so...

best of luck.

--js
