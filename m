Received: from eggs.gnu.org ([2001:4830:134:3::10]:60934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdlWt-0001Kw-Qi
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdlWs-0007G6-Ql
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:24:59 -0500
References: <1202180823.778907.1487108292243.JavaMail.zimbra@research.iiit.ac.in>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6066bf52-d3d9-07d2-1e0f-118b8c19f3f4@redhat.com>
Date: Tue, 14 Feb 2017 23:24:49 +0100
MIME-Version: 1.0
In-Reply-To: <1202180823.778907.1487108292243.JavaMail.zimbra@research.iiit.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] regarding bug name : -hda FAT:. limited to
 504MBytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shubham Kumar <kumar.shubham@research.iiit.ac.in>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

 Hi,

On 14.02.2017 22:38, Shubham Kumar wrote:
> Since the problem seems like the used FAT-16 file system ,=20
> Will it solve the problem if I change the code of  vvfat.c for FAT-32 f=
ile system to increase acceptable file size ?

As far as I know, FAT16 can already support up to 4GB file systems, so
that limitation to 504 MB must be something different.
It's maybe best if you put the qemu-block mailing list on CC:, to get
the attention of the block/disk expert, too. Maybe there's someone
around who knows the vvfat code and its limitations and can give a good
answer here...

 Thomas
