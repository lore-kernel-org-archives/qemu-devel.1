Received: from eggs.gnu.org ([2001:4830:134:3::10]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw1yd-0004rH-Tk
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw1yZ-0006YH-RC
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:37:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46663
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw1yZ-0006Y4-Kp
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:37:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v367YBiS028575
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 03:37:02 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29nereynwv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 03:37:02 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 08:37:00 +0100
Date: Thu, 6 Apr 2017 09:36:55 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170405194741.18956-4-eblake@redhat.com>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170406093655.0deaafe2.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/13] s390x: Drop useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, armbru@redhat.com, Richard Henderson <rth@twiddle.net>

On Wed,  5 Apr 2017 14:47:31 -0500
Eric Blake <eblake@redhat.com> wrote:

> An upcoming Coccinelle cleanup script wanted to reformat the casts
> present in this file - but on closer look, we don't need the casts
> at all because C automatically converts void* to any other pointer.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  target/s390x/cpu_models.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 1434d15..ce461cc 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -376,12 +376,12 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
> 
>  static void qdict_add_disabled_feat(const char *name, void *opaque)
>  {
> -    qdict_put((QDict *) opaque, name, qbool_from_bool(false));
> +    qdict_put(opaque, name, qbool_from_bool(false));
>  }
> 
>  static void qdict_add_enabled_feat(const char *name, void *opaque)
>  {
> -    qdict_put((QDict *) opaque, name, qbool_from_bool(true));
> +    qdict_put(opaque, name, qbool_from_bool(true));
>  }
> 
>  /* convert S390CPUDef into a static CpuModelInfo */

Do you prefer to keep this in this series, or should we just go ahead
and apply this via s390x?

In any case,

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
