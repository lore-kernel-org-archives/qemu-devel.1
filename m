Received: from eggs.gnu.org ([2001:4830:134:3::10]:42324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIxPZ-0001lG-24
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIxPV-0005NN-OV
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:23:41 -0400
References: <1496926799-13040-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <151f982c-8e35-5dba-e40c-5b1c5d76b6d1@redhat.com>
Date: Thu, 8 Jun 2017 15:23:32 +0200
MIME-Version: 1.0
In-Reply-To: <1496926799-13040-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] Makefile: Do not generate files if
 "configure" has not been run yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>



On 08/06/2017 14:59, Thomas Huth wrote:
> When doing a "make -j10" in the vanilla QEMU source tree (without
> running "configure" first), the Makefile currently generates two
> files already, qemu-version.h and qemu-options.def. This should not
> happen, so let's only build the generated files if config-host.mak
> is available (i.e. "configure" has been run already).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3:
>  - Check for config-host.mak at the place where we add the dependencies
>    for $(GENERATED_FILES) instead of adding single dependencies all over
>    the place
> 
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index c830d7a..32d4441 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -791,9 +791,11 @@ endif # CONFIG_WIN
>  
>  # Add a dependency on the generated files, so that they are always
>  # rebuilt before other object files
> +ifneq ($(wildcard config-host.mak),)
>  ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
>  Makefile: $(GENERATED_FILES)
>  endif
> +endif
>  
>  .SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
>  	$(TRACE_SOURCES) $(TRACE_SOURCES:%=%-timestamp) \
> 

Thanks, queued.

Paolo
