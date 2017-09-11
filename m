Received: from eggs.gnu.org ([2001:4830:134:3::10]:60958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drXFO-0000ZM-Af
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drXFN-0000m5-6J
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:32:06 -0400
Date: Mon, 11 Sep 2017 18:31:55 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <595628230.5112107.1505169115739.JavaMail.zimbra@redhat.com>
In-Reply-To: <a96ce163-a7ff-3aa2-866d-22d3bc2735ff@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<a96ce163-a7ff-3aa2-866d-22d3bc2735ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/12] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org



----- Original Message -----
> From: "John Snow" <jsnow@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, qemu-devel@nongnu.org
> Cc: kwolf@redhat.com, qemu-block@nongnu.org
> Sent: Tuesday, September 12, 2017 12:22:26 AM
> Subject: Re: [Qemu-block] [PATCH 00/12] cleanup qemu-iotests
> 
> 
> 
> On 08/09/2017 05:54 PM, Paolo Bonzini wrote:
> > The purpose of this series is to separate the "check" sources from
> > the tests.  After these patches, common.config is reduced to simple
> > shell initialization, and common.rc is only included by the tests.
> > 
> > Along the way, a lot of dead code is removed too.
> > 
> > Paolo
> > 
> > Paolo Bonzini (12):
> >   qemu-iotests: remove dead code
> >   qemu-iotests: get rid of AWK_PROG
> >   qemu-iotests: move "check" code out of common.rc
> >   qemu-iotests: limit non-_PROG-suffixed variables to common.rc
> >   qemu-iotests: do not include common.rc in "check"
> >   qemu-iotests: do not do useless search for QEMU_*_PROG
> >   qemu-iotests: disintegrate more parts of common.config
> >   qemu-iotests: fix uninitialized variable
> >   qemu-iotests: do not search for binaries in the current directory
> >   qemu-iotests: get rid of $iam
> >   qemu-iotests: include common.env and common.config early
> >   qemu-iotests: merge "check" and "common"
> > 
> >  tests/qemu-iotests/039.out       |  10 +-
> >  tests/qemu-iotests/061.out       |   4 +-
> >  tests/qemu-iotests/137.out       |   2 +-
> >  tests/qemu-iotests/check         | 551
> >  ++++++++++++++++++++++++++++++++++-----
> >  tests/qemu-iotests/common        | 459 --------------------------------
> >  tests/qemu-iotests/common.config | 205 +--------------
> >  tests/qemu-iotests/common.qemu   |   1 +
> >  tests/qemu-iotests/common.rc     | 225 ++++++++--------
> >  8 files changed, 615 insertions(+), 842 deletions(-)
> >  delete mode 100644 tests/qemu-iotests/common
> > 
> 
> Stale? Patchset is >1 month old now, doesn't look like it got merged.

Yup, didn't get reviewed by Kevin either...  I was waiting for that
before sending v2.

Paolo
