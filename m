Received: from eggs.gnu.org ([2001:4830:134:3::10]:47070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etymP-0000uq-1w
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etymL-0003Dc-AE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:52:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etymL-0003C7-4N
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:52:29 -0500
Date: Thu, 8 Mar 2018 16:52:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308165220.GG4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
	<20180308124901.83533-10-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308124901.83533-10-brijesh.singh@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 09/28] qmp: add query-sev command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

On Thu, Mar 08, 2018 at 06:48:42AM -0600, Brijesh Singh wrote:
> The QMP query command can used to retrieve the SEV information when
> memory encryption is enabled on AMD platform.
>=20
> Cc: Eric Blake <eblake@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  monitor.c             |  7 +++++
>  qapi/misc.json        | 76 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  target/i386/monitor.c |  8 ++++++
>  3 files changed, 91 insertions(+)

> diff --git a/qapi/misc.json b/qapi/misc.json
> index bd04469a4ba2..14681729f8fc 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3201,3 +3201,79 @@
>  # Since: 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
> +
> +##
> +# @SevState:
> +#
> +# An enumeration of SEV state information used during @query-sev.
> +#
> +# @uninit: The guest is uninitialized.
> +#
> +# @lupdate: The guest is currently being launched and plaintext and
> +#           reigster state is being imported.

Typo s/reigster/register/

> +#
> +# @lsecret: The guest is currently being launched and ciphertext data
> +#           are being imported.
> +#
> +# @running: The guest is fully launched or migrated in.
> +#
> +# @supdate: The guest is currently being migrated out to another machi=
ne.
> +#
> +# @rupdate: The guest is currently being migrated from another machine=
.
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'SevState',
> +  'data': ['uninit', 'lupdate', 'lsecret', 'running', 'supdate', 'rupd=
ate' ] }

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
