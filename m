Received: from eggs.gnu.org ([2001:4830:134:3::10]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bXC-0007pE-0u
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9bXB-0007jz-Bj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:49:41 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-6-crosa@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <11027abb-cc36-8921-fec3-f310104ad8a2@redhat.com>
Date: Mon, 8 Oct 2018 15:49:34 -0400
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 05/10] docs/devel/testing.rst:
 add missing newlines after code block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>



On 10/04/2018 12:18 PM, Cleber Rosa wrote:
> The line immediate following a ".. code::" block is considered
> to contains arguments to the "code directive".  The lack of a
> new line gives me during at parse time:
> 
>    testing.rst:63: (ERROR/3) Error in "code" directive:
>    maximum 1 argument(s) allowed, 3 supplied.
> 
>    .. code::
>      make check-unit V=1
> 
>    testing.rst:120: (ERROR/3) Error in "code" directive:
>    maximum 1 argument(s) allowed, 3 supplied.
> 
>    .. code::
>      make check-qtest V=1
> 

pandoc doesn't complain, but rst.ninjs.org does. What tool did you use
to find these? we should formalize a formatting checker for rst files.

Actually, we should formalize building our RST docs at all...

--js

> Let's add the missing newlines, both for consistency and to
> avoid the parsing errors.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
