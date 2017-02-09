Received: from eggs.gnu.org ([2001:4830:134:3::10]:34622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbpw6-0002ZE-7c
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cbpw5-0004Eg-24
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:43:02 -0500
Date: Thu, 9 Feb 2017 14:42:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170209144253.GA26192@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170124115748.21473-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124115748.21473-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Improve I/O tests coverage of LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

ping ?

On Tue, Jan 24, 2017 at 11:57:43AM +0000, Daniel P. Berrange wrote:
> The main goal of this series is to get the I/O tests passing
> 100% with LUKS when run with './check -luks'. It also adds a
> few more combinations to the LUKS/dmcrypt interoperability
> test.
> 
> To make LUKS testing not quite as slow, we drop the PBKDF
> iteration count down to a very small value. This doesn't
> remove all overhead, as formatting the volume will always
> measure PBKDF timing over a 1 second interval.
> 
> Changed in v3:
> 
>  - Fix some typos in commit message(s) (Eric)
> 
> Changed in v2:
> 
>  - Split off patch that change check.time recording since
>    it was not a direct dependancy
>  - Skip new 159 & 170 tests which don't work due to qemu-img
>    dd limitations
> 
> Daniel P. Berrange (5):
>   iotests: skip 159 & 170 with luks format
>   iotests: fix remainining tests to work with LUKS
>   iotests: reduce PBKDF iterations when testing LUKS
>   iotests: add more LUKS hash combination tests
>   iotests: chown LUKS device before qemu-io launches
> 
>  tests/qemu-iotests/033           |   16 +-
>  tests/qemu-iotests/120           |   25 +-
>  tests/qemu-iotests/140           |   15 +-
>  tests/qemu-iotests/145           |   18 +-
>  tests/qemu-iotests/149           |   26 +-
>  tests/qemu-iotests/149.out       | 1002 ++++++++++++++++++++++++++++----------
>  tests/qemu-iotests/157           |   17 +-
>  tests/qemu-iotests/157.out       |   16 +-
>  tests/qemu-iotests/159           |    2 +-
>  tests/qemu-iotests/170           |    2 +-
>  tests/qemu-iotests/common.filter |    3 +-
>  tests/qemu-iotests/common.rc     |    3 +
>  12 files changed, 847 insertions(+), 298 deletions(-)
> 
> -- 
> 2.9.3
> 

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
