Received: from eggs.gnu.org ([2001:4830:134:3::10]:41310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqO02-0004U2-MI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqNzy-0006N3-8g
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:27:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqNzy-0006LS-2v
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:27:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504815384-8490-1-git-send-email-stefanb@linux.vnet.ibm.com>
Date: Fri, 08 Sep 2017 20:27:21 +0200
In-Reply-To: <1504815384-8490-1-git-send-email-stefanb@linux.vnet.ibm.com>
	(Stefan Berger's message of "Thu, 7 Sep 2017 16:16:24 -0400")
Message-ID: <87ingtrqpi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] Add myself as maintainer for TPM code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> Also add backends/tpm.c to the list of files.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index caf7e8a..c434a09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1487,12 +1487,14 @@ F: docs/tracing.txt
>  T: git git://github.com/stefanha/qemu.git tracing
>  
>  TPM
> -S: Orphan
> +M: Stefan Berger <stefanb@linux.vnet.ibm.com>
> +S: Maintained
>  F: tpm.c
>  F: hw/tpm/*
>  F: include/hw/acpi/tpm.h
>  F: include/sysemu/tpm*
>  F: qapi/tpm.json
> +F: backends/tpm.c
>  
>  Checkpatch
>  S: Odd Fixes

Acked-by: Markus Armbruster <armbru@redhat.com>
