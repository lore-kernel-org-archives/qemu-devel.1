Received: from eggs.gnu.org ([2001:4830:134:3::10]:51835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9pap-0000zu-U5
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 05:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9pai-0007wy-04
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 05:45:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9pah-0007vU-LP
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 05:45:43 -0400
Date: Wed, 1 Nov 2017 09:45:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171101094537.GA2786@work-vm>
References: <CADak6y5eSo9=C2FJx+cTdqxArWeQqNDAvVgY+vS7H-9yGeuZvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADak6y5eSo9=C2FJx+cTdqxArWeQqNDAvVgY+vS7H-9yGeuZvw@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu disk use writeback don't take effect in
 centos 7.2 1511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Schlacter <wlfightup@gmail.com>
Cc: qemu-devel@nongnu.org

* Paul Schlacter (wlfightup@gmail.com) wrote:
> qemu version:  2.9.0
> image: centos 7.2 1511 raw
> cache mode: writeback
> 
> 
> In centos7.2 time, the use of writeback and none, the result of dd disk is
> the same io, no change
> 
> But I replaced centos7.1 centos7.3 centos7.4 when writeback was
> significantly faster than none
> 
> Would like to ask what is going on, how to solve ?

Hi Paul,
  Can you just clarify your setup please;  do you mean that
with the same qemu setup but a 7.2 guest rather than a 7.1/7.3 guest
the behaviour changes?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
