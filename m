Received: from eggs.gnu.org ([2001:4830:134:3::10]:37298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejJWb-0008Ne-84
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejJWW-0001qh-Ez
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 01:48:07 -0500
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd122493-dd05-e5bd-abab-0955bc82b770@redhat.com>
Date: Wed, 7 Feb 2018 07:47:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/54] Patch Round-up for stable 2.11.1,
 freeze on 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

On 06.02.2018 20:14, Michael Roth wrote:
> Hi everyone,                                                           =
                                  =20
>=20
> The following new patches are queued for QEMU stable v2.11.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.11-staging
>=20
> The release is planned for 2017-02-14:
>=20
>   https://wiki.qemu.org/Planning/2.11
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

Looking for "CVE" in the changelog, these look like good candidates for
stable as well:

    191f59dc17396bb5a8da50f8c59b6e0a430711a4
    vga: check the validation of memory addr when draw text

    f887cf165db20f405cb8805c716bd363aaadf815
    ui: place a hard cap on VNC server output buffer size
    (and the preceding patches)

> Of particular importance would be any feedback on the various QEMU
> patches relating to Spectre/Meltdown mitigation. The current tree has
> what I understand to be the QEMU components required for x86, s390,
> and pseries, but feedback/confirmation from the various authors would
> be greatly appreciated.
[...]
> Christian Borntraeger (2):
>       s390x/kvm: Handle bpb feature
>       s390x/kvm: provide stfle.81

Confirmed, AFAIK that are the only two patches that are required for
Spectre on s390x (together with the linux-headers update).

 Thomas
