Received: from eggs.gnu.org ([2001:4830:134:3::10]:56267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSUG-0002hu-Hq
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSUD-0002ii-2r
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:22:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejSUC-0002iU-Tx
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:22:17 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-13-brijesh.singh@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a28048e-fed5-c197-05df-c1f14d6e2b5f@redhat.com>
Date: Wed, 7 Feb 2018 10:22:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180207160638.98872-13-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 13/26] qmp: add query-sev command
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
> The QMP query command can used to retrieve the SEV information when
> memory encryption is enabled on AMD platform.
>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---

> +##
> +# @SevInfo:
> +#
> +# Information about SEV support
> +#
> +# @enabled: true if SEV is active
> +#
> +# @api_major: SEV API major version

New QMP structures should prefer '-' over '_'; this should be 'api-major'=
.

> +#
> +# @api_minor: SEV API minor version
> +#
> +# @build_id: SEV FW build id

and so on.

> +#
> +# @policy: SEV policy value
> +#
> +# @state: SEV guest state
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'SevInfo',
> +    'data': { 'enabled': 'bool',
> +              'api_major': 'uint8',
> +              'api_minor' : 'uint8',
> +              'build_id' : 'uint8',
> +              'policy' : 'uint32',
> +              'state' : 'str'
> +            }
> +}
> +
> +##
> +# @query-sev:
> +#
> +# Returns information about SEV

It would be worth expanding the acronym here, for someone that is=20
reading the documentation but not familiar with the term.

> +#
> +# Returns: @SevInfo
> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "query-sev" }
> +# <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
> +#                  "build-id" : 0, "policy" : 0, "state" : "running" }=
 }

This example does not match the spelling you used in the struct above,=20
but DOES match what the spelling should be.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
