Received: from eggs.gnu.org ([2001:4830:134:3::10]:34431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6EdF-0006jF-Ss
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6EdE-00047K-SA
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:13:45 -0400
References: <20180406164108.26118-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f7231c3f-af59-fc50-9cc6-1a2e103c79f5@redhat.com>
Date: Wed, 11 Apr 2018 14:13:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180406164108.26118-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Split 214 off of 122
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 2018-04-06 18:41, Max Reitz wrote:
> Commit abd3622cc03cf41ed542126a540385f30a4c0175 added a case to 122
> regarding how the qcow2 driver handles an incorrect compressed data
> length value.  This does not really fit into 122, as that file is
> supposed to contain qemu-img convert test cases, which this case is not.
> So this patch splits it off into its own file; maybe we will even get
> more qcow2-only compression tests in the future.
> 
> Also, that test case does not work with refcount_bits=1, so mark that
> option as unsupported.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Kind of a v2 for "iotests: 122 needs at least two refcount bits now"
> (fulfills the same purpose, but also splits the case into its own file
>  so you can still run 122 with refcount_bits=1 [Eric]).
> 
> I was a bit lost what to do about the copyright text, since this test
> case was written by Berto.  I figured I'd drop the "owner" variable (it
> isn't used anyway), but I put "Red Hat" into the copyright line --
> currently every test has copyright information, so I decided it'd be
> difficult to leave that out, and I figured I simply cannot claim
> copyright for Igalia.  So, here we go.
> ---
>  tests/qemu-iotests/122     | 47 -----------------------
>  tests/qemu-iotests/122.out | 33 ----------------
>  tests/qemu-iotests/214     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/214.out | 35 +++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  5 files changed, 132 insertions(+), 80 deletions(-)
>  create mode 100755 tests/qemu-iotests/214
>  create mode 100644 tests/qemu-iotests/214.out

Changed the copyright information, added Berto's S-o-b (and Eric's R-b)
and applied to my block-next branch.

Max
