Received: from eggs.gnu.org ([2001:4830:134:3::10]:52860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXKdX-00031b-He
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 01:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXKdN-0002Xv-MT
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 01:38:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXKdM-0002TE-UE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 01:38:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46A54308A973
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 06:38:05 +0000 (UTC)
References: <20181030123526.26415-1-kchamart@redhat.com>
	<20181030123526.26415-2-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <db1d11e0-ea3d-cb52-ee35-67ac473b1dee@redhat.com>
Date: Thu, 13 Dec 2018 07:38:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181030123526.26415-2-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Deprecate QMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, imammedo@redhat.com

On 2018-10-30 13:35, Kashyap Chamarthy wrote:
> The intended functionality of QMP `cpu-add` is replaced with
> `device_add` (and `query-hotpluggable-cpus`).  So let's deprecate
> `cpu-add`.
> 
> A complete example of vCPU hotplug with the recommended way (using
> `device_add`) is provided as part of a seperate docs patch.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
[...]
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 1b9c007f12..c86924ad9a 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -155,6 +155,11 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
>  The ``arch'' output member of the ``query-cpus-fast'' command is
>  replaced by the ``target'' output member.
>  
> +@subsection cpu-add (since 3.1)

 Hi Kashyap,

could you please send a follow-up patch to change this into 4.0 now?

Please also provide a patch to add the HMP command to
qemu-deprecated.texi, too.

 Thanks,
  Thomas
