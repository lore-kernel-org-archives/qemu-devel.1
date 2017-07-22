Received: from eggs.gnu.org ([2001:4830:134:3::10]:59652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYm2P-0004VB-UV
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYm2M-0004xd-SL
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:29:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:13119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dYm2M-0004wE-HA
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:29:06 -0400
Message-ID: <1500697944.4962.44.camel@intel.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Reply-To: amarnath.valluri@intel.com
Date: Sat, 22 Jul 2017 07:32:24 +0300
In-Reply-To: <CAJ+F1CKjMFFBA-0W0QZPze5o5vd+rzFkMvF4oWYyfPWQQ-rXwA@mail.gmail.com>
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-5-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CKjMFFBA-0W0QZPze5o5vd+rzFkMvF4oWYyfPWQQ-rXwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 4/8] tpm-backend: Made few interface
 methods optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

On Tue, 2017-07-18 at 10:15 +0000, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 18, 2017 at 10:48 AM Amarnath Valluri
> <amarnath.valluri@intel.com> wrote:
> 
>         This allows backend implementations left optional interface
>         methods.
>         For mandatory methods assertion checks added.
>         
>         Took the opportunity to remove unused methods:
>           tpm_backend_get_type()
>           tpm_backend_get_desc()
>         
>         Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>         Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>         Reviewed-by: Stefan Berger<stefanb@linux.vnet.ibm.com>
>         ---
>          backends/tpm.c               | 36
>         +++++++++++++++++-------------------
>          hw/tpm/tpm_passthrough.c     | 23 +----------------------
>          include/sysemu/tpm_backend.h | 19 +------------------
>          tpm.c                        |  2 +-
>          4 files changed, 20 insertions(+), 60 deletions(-)
> 
>    LINK    x86_64-softmmu/qemu-system-x86_64
> ../tpm.o: In function `qmp_query_tpm_inst':
> /home/elmarco/src/qq/tpm.c:261: undefined reference to
> `tpm_backend_get_type'
> collect2: error: ld returned 1 exit status
Thanks Marc, for pointing it out, i will this patch.

- Amarnath
