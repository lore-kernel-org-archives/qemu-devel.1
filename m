Received: from eggs.gnu.org ([209.51.188.92]:38174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGz4m-0006EZ-J6
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGz4i-0004o5-Er
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:55:08 -0400
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
	<20190417220147.67648-10-stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3dba706-c5c9-9cc5-8f00-0291ae630f65@redhat.com>
Date: Thu, 18 Apr 2019 06:54:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190417220147.67648-10-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/10] block/pflash_cfi02: Implement
 erase suspend/resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18/04/2019 00.01, Stephen Checkoway wrote:
> During a sector erase (but not a chip erase), the embeded erase program
> can be suspended. Once suspended, the sectors not selected for erasure
> may be read and programmed. Autoselect mode is allowed during erase
> suspend mode. Presumably, CFI queries are similarly allowed so this
> commit allows them as well.
> 
> Since guest firmware can use status bits DQ7, DQ6, DQ3, and DQ2 to
> determine the current state of sector erasure, these bits are properly
> implemented.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/block/pflash_cfi02.c   | 153 ++++++++++++++++++++++++++++++++++----
>  tests/pflash-cfi02-test.c | 112 ++++++++++++++++++++++++++++
>  2 files changed, 251 insertions(+), 14 deletions(-)

Acked-by: Thomas Huth <thuth@redhat.com>
