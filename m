Received: from eggs.gnu.org ([2001:4830:134:3::10]:47483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e73kT-0004wC-11
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 14:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1e73kP-0003fC-Sf
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 14:16:21 -0400
Message-ID: <1508869162.4025.1.camel@intel.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Reply-To: amarnath.valluri@intel.com
Date: Tue, 24 Oct 2017 21:19:22 +0300
In-Reply-To: <20171024122045.30072-1-f4bug@amsat.org>
References: <20171024122045.30072-1-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tpm: add stubs to fix compiling
 with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On Tue, 2017-10-24 at 09:20 -0300, Philippe Mathieu-Daudé wrote:
> This fixes building with --disable-tpm as reported by Zoltan:
>   http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg05369.html
> 
> Cc'ing Peter in case this enters as a build fix instead of via trivial.
> 
> v2:
> - added Richard W.M. Jones Tested-by tag
> - remove #ifdef CONFIG_TPM in tpm.c (Stefan Berger)
> 
> Regards,
> 
> Phil.
> 
> PD: I missed Amarnath Valluri in my first series, you might want to add yourself
>     a R: tag in MAINTAINTERS.
>     
> Philippe Mathieu-Daudé (4):
>   tpm: add missing include
>   tpm: add stubs
>   tpm: remove unnecessary #ifdef CONFIG_TPM
>   vl: remove unnecessary #ifdef CONFIG_TPM
> 
>  Makefile.objs        |  2 +-
>  include/sysemu/tpm.h |  1 +
>  stubs/tpm.c          | 33 +++++++++++++++++++++++++++++++++
>  tpm.c                |  4 ----
>  vl.c                 |  2 --
>  MAINTAINERS          |  1 +
>  stubs/Makefile.objs  |  1 +
>  7 files changed, 37 insertions(+), 7 deletions(-)
>  create mode 100644 stubs/tpm.c
> 
+1, Nice cleanup in my opinion, now it looks much cleaner.

- Amarnath
