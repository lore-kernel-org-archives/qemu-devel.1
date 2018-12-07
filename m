Received: from eggs.gnu.org ([2001:4830:134:3::10]:38565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJta-0001Xv-UJ
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJta-0006Sy-73
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:26:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gVJta-0006SE-10
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:26:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB4A030BA378
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 17:26:32 +0000 (UTC)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-6-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c1b508b-3b2f-e05d-4cb6-50ae2c701e3e@redhat.com>
Date: Fri, 7 Dec 2018 11:26:30 -0600
MIME-Version: 1.0
In-Reply-To: <20181207170400.5129-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/nvram/fw_cfg: Add HMP 'info fw_cfg'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 12/7/18 11:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> $ qemu-system-x86_64 -S -monitor stdio
> (qemu) info fw_cfg
>          Type    Perm    Size    Specific   Order   Info
>     signature      RO       4                       QEMU
>            id      RO       4                       0x00000003
>          uuid      RO      16                       00000000-0000-0000-=
0000-000000000000
>      ram_size      RO       8                       0x0000000008000000
>     nographic      RO       2                       0x0000
>       nb_cpus      RO       2                       0x0001
>          numa      RO      16
>     boot_menu      RO       2                       0x0000
>      max_cpus      RO       2                       0x0001
>      file_dir      RO    2052
>   file (id 1)      RO      36                 160   etc/acpi/rsdp
>   file (id 2)      RO  131072                 130   etc/acpi/tables
>   file (id 3)      RO       4                  15   etc/boot-fail-wait
>   file (id 4)      RO      20                  40   etc/e820
>   file (id 5)      RO      31                  30   etc/smbios/smbios-a=
nchor
>   file (id 6)      RO     320                  20   etc/smbios/smbios-t=
ables
>   file (id 7)      RO       6                  90   etc/system-states
>   file (id 8)      RO    4096                 140   etc/table-loader
> file (id 10)      RO    9216                  55   genroms/kvmvapic.bin
>          uuid      RO       4  (arch spec)          01000000-0000-0000-=
0000-000000000000
>      ram_size      RO     324  (arch spec)
>     nographic      RO     121  (arch spec)
> (qemu)
>=20

In general, when adding something to HMP but not QMP, it is worth a=20
comment explaining WHY we did not want QMP.  (Here, I think the reason=20
is that this is a debugging aid likely to be useful to developers but=20
unlikely to be needed by a management app, and matches similar other=20
HMP-only info commands, and is therefore not worth the effort of turning=20
it into QAPI).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
