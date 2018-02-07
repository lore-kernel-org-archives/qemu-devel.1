Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSbm-0006tB-MZ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSbi-0000kg-EA
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:30:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejSbi-0000kb-9F
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:30:02 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-26-brijesh.singh@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14588677-a845-be1e-449f-901ade4a8fe6@redhat.com>
Date: Wed, 7 Feb 2018 10:29:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180207160638.98872-26-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 26/26] qmp: add query-sev-launch-measure
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>

On 02/07/2018 10:06 AM, Brijesh Singh wrote:
> The command can be used by libvirt to retrieve the measurement of SEV g=
uest.
> This measurement is a signature of the memory contents that was encrypt=
ed
> through the LAUNCH_UPDATE_DATA.
>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>   qapi-schema.json | 30 ++++++++++++++++++++++++++++++
>   qmp.c            | 14 ++++++++++++++
>   2 files changed, 44 insertions(+)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 447ebb15266e..19331bff8883 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3236,3 +3236,33 @@
>   #
>   ##
>   { 'command': 'query-sev', 'returns': 'SevInfo' }
> +
> +##
> +# @SevLaunchMeasureInfo:
> +#
> +# SEV Guest Launch measurement information
> +#
> +# @data: the measurement value encoded in base64
> +#
> +# Since: 2.12
> +#
> +# Notes: If measurement is not available then a null measurement is re=
turned.

Null measurement, as in empty string?  Would it be better to have=20
query-sev-launch-measure return an error instead of an=20
SevLaunchMeasureInfo with a null measurement in that case?

> +##
> +{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'} }
> +
> +##
> +# @query-sev-launch-measure:
> +#
> +# Query the SEV guest launch information.
> +#
> +# Returns: The @SevLaunchMeasureInfo for the guest
> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "query-sev-launch-measure" }
> +# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
> +#


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
