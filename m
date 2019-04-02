Received: from eggs.gnu.org ([209.51.188.92]:41292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBOOc-0005la-7d
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 14:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBOOb-0001ou-AO
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 14:44:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBOOb-0001mQ-2C
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 14:44:29 -0400
Date: Tue, 2 Apr 2019 19:44:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190402184423.GJ2861@work-vm>
References: <20190402025728.5636-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402025728.5636-1-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] vmstate: check subsection_found is enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> subsection_found is true implies vmdesc is not NULL.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/vmstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index e2bbb7b5f7..8327179eea 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -533,7 +533,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>          sub++;
>      }
>  
> -    if (vmdesc && subsection_found) {
> +    if (subsection_found) {

That's true, however it's not obvious from the names; I think
we should probably rename 'subsection_found' to something like
'vmdesc_has_subsections'  then it's more obvious that subsection_found
is more specialised in this routine.

Dave


>          json_end_array(vmdesc);
>      }
>  
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
