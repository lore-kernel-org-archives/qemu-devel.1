Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHtI-0005c7-FD
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:27:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHtE-00075U-7d
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:27:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elHtE-00075E-3k
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:27:40 -0500
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-14-brijesh.singh@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4672dbf-4d1f-3950-aba8-9a52903f35cb@redhat.com>
Date: Mon, 12 Feb 2018 11:27:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180212153715.87555-14-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 13/28] qmp: add query-sev command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

On 02/12/2018 09:37 AM, Brijesh Singh wrote:
> The QMP query command can used to retrieve the SEV information when
> memory encryption is enabled on AMD platform.
>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---

> +# @SevInfo:
> +#
> +# Information about Secure Encrypted Virtualization (SEV) support
> +#
> +# @enabled: true if SEV is active
> +#
> +# @api-major: SEV API major version
> +#
> +# @api-minor: SEV API minor version
> +#
> +# @build-id: SEV FW build id
> +#
> +# @policy: SEV policy value
> +#
> +# @state: SEV guest state

Is there a finite list of guest states?

> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'SevInfo',
> +    'data': { 'enabled': 'bool',
> +              'api-major': 'uint8',
> +              'api-minor' : 'uint8',
> +              'build-id' : 'uint8',
> +              'policy' : 'uint32',
> +              'state' : 'str'

If so, this should be an enum type listing those possible states, rather=20
than an open-coded 'str' that can hold anything.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
