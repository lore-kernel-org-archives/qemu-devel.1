Received: from eggs.gnu.org ([2001:4830:134:3::10]:40192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFgAs-0001QM-JX
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFgAr-0001D7-NP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:59:46 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-6-crosa@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <620802c3-e3e9-f89d-63dc-07928dc0cd85@vivier.eu>
Date: Thu, 25 Oct 2018 14:59:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 05/10]
 docs/devel/testing.rst: add missing newlines after code block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 17:18, Cleber Rosa wrote:
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
> Let's add the missing newlines, both for consistency and to
> avoid the parsing errors.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/testing.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 727c4019b5..9355ad49f2 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -61,6 +61,7 @@ variable (which affects memory reclamation and catches invalid pointers better)
>  and gtester options. If necessary, you can run
>  
>  .. code::
> +
>    make check-unit V=1
>  
>  and copy the actual command line which executes the unit test, then run
> @@ -118,6 +119,7 @@ and using gdb on the test is still simple to do: find out the actual command
>  from the output of
>  
>  .. code::
> +
>    make check-qtest V=1
>  
>  which you can run manually.
> 

Applied

Thanks,
Laurent
