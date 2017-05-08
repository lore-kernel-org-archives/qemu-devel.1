Received: from eggs.gnu.org ([2001:4830:134:3::10]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7eDc-0002i1-Kc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d7eDX-0004m7-Pb
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:40:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d7eDX-0004lp-Ji
	for qemu-devel@nongnu.org; Mon, 08 May 2017 04:40:31 -0400
Date: Mon, 8 May 2017 09:40:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170508084026.GC2446@work-vm>
References: <CAGKXQye+CDzBrPkyswwbRshBhWHc_EPwFXNHfpsMnUHbwjF-7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKXQye+CDzBrPkyswwbRshBhWHc_EPwFXNHfpsMnUHbwjF-7Q@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu_savevm_state_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org

* ali saeedi (ali.saeedi56@gmail.com) wrote:
> Hi
> what is the difference between functions "qemu_savevm_state_begin" and
> "qemu_savevm_state_header" in migration_thread?

qemu_savevm_state_header just saves the file header.

qemu_savevm_state_begin iterates through the list of devices
calling the devices 'save_live_setup' method if they have one
and the 'set_params' method if they have one.  The 'save_line_setup'
is used for creating a section at the start of saving any iterative
device (e.g. RAM, block devices, etc)

Dave

> thanks a lot
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
