Received: from eggs.gnu.org ([209.51.188.92]:45806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0qOH-0005Js-4a
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0qOG-0001x4-Bq
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:24:33 -0500
Date: Mon, 4 Mar 2019 17:24:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190304172423.482162ab.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/16] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>

On Fri,  1 Mar 2019 13:59:20 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> This is to support booting from vfio-ccw dasd devices. We basically implement
> the real hardware ipl procedure. This allows for booting Linux guests on
> vfio-ccw devices.
> 
> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
> channel programs dynamically modify themselves. Details on the ipl process and
> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.
> 
> Note to Connie: In the v2 review you mentioned some issues with the error
> handling code involving printing of the eckd dasd sense data. I've addressed
> those concerns in a new patch just to make those changes clearly stand out from
> the rest of the code. I can squash them into patches 10, 11, and 15 if you
> prefer that to having it as a separate patch.

Whatever makes sense... but I'll let the s390 bios maintainers decide.

Speaking of which: Please do keep Thomas on cc:...

[This is probably a bit late for 4.0, as softfreeze is next Tuesday and
pull requests for master need to be on-list by then... speaking of pull
requests: I'd prefer to queue this via a pull request from the bios
maintainers rather than picking the patches myself, if possible.]
