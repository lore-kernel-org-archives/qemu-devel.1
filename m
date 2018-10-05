Received: from eggs.gnu.org ([2001:4830:134:3::10]:42337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1g8K8c-0007gG-Oy
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 03:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1g8K8Y-00009M-OT
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 03:03:02 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:40615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1g8K8Y-0008Vg-Fz
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 03:02:58 -0400
References: <20181003091344.24496-1-d.csapak@proxmox.com>
	<20181004135110.GQ3667@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <3672933a-18c4-8283-1318-c7b57fdf08d7@proxmox.com>
Date: Fri, 5 Oct 2018 08:56:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181004135110.GQ3667@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On 10/4/18 3:51 PM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Oct 03, 2018 at 11:13:43AM +0200, Dominik Csapak wrote:
>> this patch aims to execute a script when qemu exits
>> so that one can do cleanups when using --daemonize without
>> having to use the qmp monitor
>=20
> IMHO the idea of cleanup scripts run by QEMU itself is flawed.
> QEMU will inevitably crash before cleanup scripts can be run,
> so whatever mgmt app is using QEMU needs to be able to do
> cleanup without QEMU's help.
>=20
> I think this can be done more reliably with a wrapper script,
> that spawns QEMU, waits for it to exit and then calls the
> cleanup script. On Linux at least you can use prctl() with
> PR_SET_CHILD_SUBREAPER so you can detect exit'ing of QEMU
> even after it has daemonized.
>=20
> Perhaps we could have such a wrapper script put in the
> contrib directory
>=20
> Regards,
> Daniel
>=20
Hi,

for cleaning up after qemu crashes, you are completely right,
(ignoring that the downscript for tap devices also never gets executed
then), but this series has another use.

With it, a user can determine the reason of a graceful shutdown
(e.g., if it was by a signal, qmp or from inside) of qemu,
especially when using -no-reboot without using qmp

and using qmp for that is not very practical for everyone,
or is there another way for that which i am missing?

Regards,
Dominik
