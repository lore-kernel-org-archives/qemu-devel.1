Received: from eggs.gnu.org ([2001:4830:134:3::10]:50013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eykT5-0005mi-23
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eykT4-0005WK-3K
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:36:19 -0400
Date: Wed, 21 Mar 2018 21:36:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180321203609.GK3898@localhost.localdomain>
References: <20180321200114.10981-1-jsnow@redhat.com>
	<f4cdc7d0-0169-b814-1217-c4fe7931db41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4cdc7d0-0169-b814-1217-c4fe7931db41@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v5] file-posix: specify expected
 filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 21.03.2018 um 21:26 hat Eric Blake geschrieben:
> On 03/21/2018 03:01 PM, John Snow wrote:
> > Adjust each caller of raw_open_common to specify if they are expecting
> > host and character devices or not. Tighten expectations of file types upon
> > open in the common code and refuse types that are not expected.
> > 
> > This has two effects:
> > 
> > (1) Character and block devices are now considered deprecated for the
> >      'file' driver, which expects only S_IFREG, and
> 
> Which may have interesting effects on v2v's attempt to use qemu-img on
> /dev/null as a quick feature probe of qemu-img...
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05753.html
> 
> but we may want to special-case that one in a separate patch.

Do we know the exact check is performs? I doubt it explicitly specifies
the file driver, and the automatic detection already returned the right
protocol driver.

Kevin
