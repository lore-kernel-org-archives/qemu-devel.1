Received: from eggs.gnu.org ([2001:4830:134:3::10]:48057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBDT-0006Jz-CJ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBDO-0004Fk-Bi
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:19:59 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCBDO-0004EI-09
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:19:54 -0400
Received: by mail-wm1-f41.google.com with SMTP id y144-v6so21107425wmd.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 15:19:52 -0700 (PDT)
References: <20181015141453.32632-1-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6be3d69f-1bb4-04c2-c1af-9afb8122753d@redhat.com>
Date: Tue, 16 Oct 2018 00:19:50 +0200
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9] iotests: Make them work for both
 Python 2 and 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

Hi Max,

On 15/10/2018 16:14, Max Reitz wrote:
> This series prepares the iotests to work with both Python 2 and 3.  In
> some places, it adds version-specific code and decides what to do based
> on the version (for instance, whether to import the StringIO class from
> the 'io' or the 'StringIO' module), but most of the time, it just makes
> code work for both versions in general.
> 
> And when we make the switch to make Python 3 mandatory, we can simply
> drop the Python 2 branches.
> 
> 
> Max Reitz (9):
>   iotests: Make nbd-fault-injector flush
>   iotests: Flush in iotests.py's QemuIoInteractive
>   iotests: Use Python byte strings where appropriate
>   iotests: Use // for Python integer division
>   iotests: Different iterator behavior in Python 3
>   iotests: Explicitly inherit FDs in Python
>   iotests: 'new' module replacement in 169
>   iotests: Modify imports for Python 3
>   iotests: Unify log outputs between Python 2 and 3

You forgot:

    MAINTAINERS: Add myself in the Python scripts section

;)

> 
>  scripts/qemu.py                          |  13 +-
>  scripts/qmp/qmp.py                       |   7 +
>  scripts/qtest.py                         |   2 +-
>  tests/qemu-iotests/040                   |   4 +-
>  tests/qemu-iotests/044                   |  20 +-
>  tests/qemu-iotests/056                   |   2 +-
>  tests/qemu-iotests/065                   |   4 +-
>  tests/qemu-iotests/083.out               |   9 +
>  tests/qemu-iotests/093                   |  18 +-
>  tests/qemu-iotests/124                   |   4 +-
>  tests/qemu-iotests/139                   |   2 +-
>  tests/qemu-iotests/147                   |   7 +
>  tests/qemu-iotests/149                   |  14 +-
>  tests/qemu-iotests/151                   |  12 +-
>  tests/qemu-iotests/163                   |   8 +-
>  tests/qemu-iotests/169                   |   3 +-
>  tests/qemu-iotests/194.out               |  22 +-
>  tests/qemu-iotests/202.out               |  12 +-
>  tests/qemu-iotests/203.out               |  14 +-
>  tests/qemu-iotests/206.out               | 144 +++----
>  tests/qemu-iotests/207                   |   4 +-
>  tests/qemu-iotests/207.out               |  52 +--
>  tests/qemu-iotests/208.out               |   8 +-
>  tests/qemu-iotests/210.out               |  72 ++--
>  tests/qemu-iotests/211.out               |  66 +--
>  tests/qemu-iotests/212.out               | 102 ++---
>  tests/qemu-iotests/213.out               | 124 +++---
>  tests/qemu-iotests/216.out               |   4 +-
>  tests/qemu-iotests/218.out               |  20 +-
>  tests/qemu-iotests/219.out               | 526 +++++++++++------------
>  tests/qemu-iotests/222.out               |  24 +-
>  tests/qemu-iotests/iotests.py            |  64 ++-
>  tests/qemu-iotests/nbd-fault-injector.py |  12 +-
>  tests/qemu-iotests/qcow2.py              |  10 +-
>  34 files changed, 745 insertions(+), 664 deletions(-)
> 
