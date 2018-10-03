Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7i6p-0003cE-Fe
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7i6m-00038S-4X
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:26:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g7i6l-00036q-Qo
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE248C049E3A
	for <qemu-devel@nongnu.org>; Wed,  3 Oct 2018 14:26:33 +0000 (UTC)
References: <20181003104605.8477-1-kchamart@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71d08ec7-cf39-1fd8-141d-ea1eb7175cdb@redhat.com>
Date: Wed, 3 Oct 2018 09:26:26 -0500
MIME-Version: 1.0
In-Reply-To: <20181003104605.8477-1-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi/misc.json: Remove superfluous words
 in CpuModelExpansionType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, ehabkost@redhat.com

On 10/3/18 5:46 AM, Kashyap Chamarthy wrote:
> While at it, s/QMU/QEMU in @CpuDefinitionInfo.

Could mention that it was a repetition of 'independent of'.

> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>   qapi/misc.json | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index ada9af5add..f98de3a58c 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2017,7 +2017,7 @@
>   #
>   # @migration-safe: whether a CPU definition can be safely used for
>   #                  migration in combination with a QEMU compatibility machine
> -#                  when migrating between different QMU versions and between
> +#                  when migrating between different QEMU versions and between
>   #                  hosts with different sets of (hardware or software)
>   #                  capabilities. If not provided, information is not available
>   #                  and callers should not assume the CPU definition to be
> @@ -2126,11 +2126,11 @@
>   # @static: Expand to a static CPU model, a combination of a static base
>   #          model name and property delta changes. As the static base model will
>   #          never change, the expanded CPU model will be the same, independent of
> -#          independent of QEMU version, machine type, machine options, and
> -#          accelerator options. Therefore, the resulting model can be used by
> -#          tooling without having to specify a compatibility machine - e.g. when
> -#          displaying the "host" model. static CPU models are migration-safe.
> -#
> +#          QEMU version, machine type, machine options, and accelerator options.
> +#          Therefore, the resulting model can be used by tooling without having
> +#          to specify a compatibility machine - e.g. when displaying the "host"
> +#          model. The @static CPU models are migration-safe.
> +
>   # @full: Expand all properties. The produced model is not guaranteed to be
>   #        migration-safe, but allows tooling to get an insight and work with
>   #        model details.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
