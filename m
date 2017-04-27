Received: from eggs.gnu.org ([2001:4830:134:3::10]:60139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3gY0-0002N6-36
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3gXz-0004lQ-Ao
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3gXz-0004kk-45
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 06:21:15 -0400
Date: Thu, 27 Apr 2017 11:21:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170427102110.GB2082@work-vm>
References: <CAGKXQyehD4w9o+nLWme85HEovR+=q=mRhm9CTp=f_5ZO4mLPVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKXQyehD4w9o+nLWme85HEovR+=q=mRhm9CTp=f_5ZO4mLPVw@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu_savevm_state_header(s->to_dst_file)
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
> does 'qemu_savevm_state_header(s->to_dst_file)' function in migration.c
> only stores header in qemu file and does not send it to destination? if it
> sends to destination  which function does that?

No, it saves it on the file descriptor 'to_dst_file' and that's normally
a socket connected to the destination.

Dave

> thanks alot
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
