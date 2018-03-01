Received: from eggs.gnu.org ([2001:4830:134:3::10]:53688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUWG-00070k-Je
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUWC-0001V0-Gu
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:09:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erUWC-0001TZ-CM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:09:32 -0500
References: <20180228211028.83970-1-brijesh.singh@amd.com>
	<20180228211028.83970-10-brijesh.singh@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <056098e9-43a8-222b-f265-e746c3ae00c5@redhat.com>
Date: Thu, 1 Mar 2018 14:09:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180228211028.83970-10-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 09/28] qmp: add query-sev command
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

On 02/28/2018 03:10 PM, Brijesh Singh wrote:
> The QMP query command can used to retrieve the SEV information when
> memory encryption is enabled on AMD platform.
>=20
> Cc: Eric Blake <eblake@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>   monitor.c             |  7 ++++++
>   qapi-schema.json      | 61 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++

Based on the pull request I just sent:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00394.html
you will have to rebase this to stick things in qapi/misc.json instead.

>   target/i386/monitor.c |  8 +++++++
>   3 files changed, 76 insertions(+)
>=20

> +++ b/qapi-schema.json
> @@ -3189,3 +3189,64 @@
>   # Since: 2.11
>   ##
>   { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogActi=
on'} }
> +
> +##
> +# @SevState:
> +#
> +# An enumeration of SEV state information used during @query-sev.
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'SevState',
> +  'data': ['uninit', 'lupdate', 'lsecret', 'running', 'supdate', 'rupd=
ate' ] }

Could perhaps give more details about the meaning of each state.  But=20
I'm not seeing anything blatantly wrong with the UI changes.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
