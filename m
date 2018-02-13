Received: from eggs.gnu.org ([2001:4830:134:3::10]:46417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eldgr-0008Vo-0L
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eldgn-00081Z-Tk
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:44:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eldgn-00080c-PI
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:44:17 -0500
Date: Tue, 13 Feb 2018 16:44:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180213164401.GO2378@work-vm>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
	<20180212153715.87555-28-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180212153715.87555-28-brijesh.singh@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 27/28] tests/qmp-test: blacklist
 query-sev-launch-measure command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> The query-sev-launch-measure command returns a measurement of encrypted
> memory when SEV is enabled otherwise it returns an error. Blacklist the
> command in qmp-test to fix the 'make check' failure.
>=20
> Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/qmp-test.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index 908f9b981f6e..d8720798ad0b 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -202,6 +202,8 @@ static bool query_is_blacklisted(const char *cmd)
>          "query-gic-capabilities", /* arm */
>          /* Success depends on target-specific build configuration: */
>          "query-pci",              /* CONFIG_PCI */
> +        /* Success depends on launching SEV guest */
> +        "query-sev-launch-measure",
>          NULL
>      };
>      int i;
> --=20
> 2.14.3
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
