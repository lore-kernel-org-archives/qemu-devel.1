Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec5MK-000072-Ki
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec5MF-0000eO-Ej
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:15:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ec5MF-0000e0-7m
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:15:35 -0500
References: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
	<1728988755.33187824.1515790085358.JavaMail.zimbra@redhat.com>
	<CY4PR2101MB0866DEFFAF6DB80EBA4CFBF3B6E90@CY4PR2101MB0866.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27541c43-e2a7-923b-afae-15336997e4ef@redhat.com>
Date: Thu, 18 Jan 2018 09:15:31 +0100
MIME-Version: 1.0
In-Reply-To: <CY4PR2101MB0866DEFFAF6DB80EBA4CFBF3B6E90@CY4PR2101MB0866.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Implements the Windows Hypervisor
 Platform accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 18/01/2018 00:41, Justin Terry (VM) wrote:
>=20
> Thanks for all the feedback. After talking with various members of
> the team around these scenarios I think its best we add the migration
> blockers for all of your comments unfortunately. The answers to your
> question are below:
>=20
> 1. For CPUID. The API has support for an "EXTENDED_VM_EXITS" of type
> WHvRunVpExitReasonX64Cpuid after a call to WHvRunVirtualProcessor.
> This will one day allow for the CPUID instruction to be resolved
> however it is not currently implemented in the platform. So for right
> now we will have to block on CPUID.
>=20
> 2. For dirty memory tracking. We currently don=E2=80=99t have support i=
n the
> platform or API for this. I have added that to the feature backlog
> and will update QEMU as that gets implemented in the platform.
> However, VGA does indeed work with the current impl of log_sync.
>=20
> 3. Also, for XSAVE/RSTOR we again don=E2=80=99t have platform support f=
or the
> required registers. I have added this to the feature platform backlog
> to gain access for that functionality as well.
>=20
> 4. This will be supported on Windows 10 hosts (I don=E2=80=99t have the
> insider build number yet) and it will require an Intel processor with
> VT-x and Unrestricted Guest support. Will update the qemu-devel list
> once we have an insider build that is public that has the platform
> bits.
>=20
> So, if your ok with it I will block on CPUID, Memory Tracking, and
> XSAVE/RSTOR functionality and send out the updated PR.

Yes, thanks.  Of course just one migration blocker is enough.  Add a
comment like the above 1-3 bullet points above it.

Thanks,

Paolo
