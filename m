Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gOjsI-0006AF-28
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gOjsE-00051S-0x
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:46:02 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gOjsD-0004qK-PQ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:45:57 -0500
From: Dominik Csapak <d.csapak@proxmox.com>
References: <20181031115242.6558-1-d.csapak@proxmox.com>
Message-ID: <aafe8c68-b822-4098-2e38-5a5fc7c7c06c@proxmox.com>
Date: Mon, 19 Nov 2018 14:45:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181031115242.6558-1-d.csapak@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] qapi: return ShutdownCause for events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, armbru@redhat.com, mreitz@redhat.com

Hi,

i guess many of you are occupied with 3.1,
but had anyone time to look at this?

kind regards

On 10/31/18 12:52 PM, Dominik Csapak wrote:
> This series improves the QMP SHUTDOWN and RESET events by adding
> the ShutdownCause as additional parameter and splitting
> the HOST_QMP reason into HOST_QMP_QUIT and HOST_QMP_SYSTEM_RESET
> to be able to detect the difference between them when using '--no-reboot'
> 
> this is an alternative to my previous patches[1][2] which
> added an exit-script/added a 'reset' argument to the events
> 
>   1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00697.html
>   2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01271.html
> 
> Dominik Csapak (3):
>    qapi: move ShutdownCause to qapi/run-state.json
>    qapi: split host-qmp into quit and system-reset
>    qapi: add reason to SHUTDOWN and RESET events
> 
>   include/sysemu/sysemu.h    | 20 --------------------
>   qapi/run-state.json        | 39 +++++++++++++++++++++++++++++++++++++--
>   qmp.c                      |  4 ++--
>   tests/qemu-iotests/060.out |  4 ++--
>   tests/qemu-iotests/071.out |  4 ++--
>   tests/qemu-iotests/081.out |  2 +-
>   tests/qemu-iotests/087.out | 12 ++++++------
>   tests/qemu-iotests/094.out |  2 +-
>   tests/qemu-iotests/109.out | 44 ++++++++++++++++++++++----------------------
>   tests/qemu-iotests/117.out |  2 +-
>   tests/qemu-iotests/119.out |  2 +-
>   tests/qemu-iotests/120.out |  2 +-
>   tests/qemu-iotests/127.out |  2 +-
>   tests/qemu-iotests/140.out |  2 +-
>   tests/qemu-iotests/143.out |  2 +-
>   tests/qemu-iotests/156.out |  2 +-
>   tests/qemu-iotests/176.out | 16 ++++++++--------
>   tests/qemu-iotests/183.out |  4 ++--
>   tests/qemu-iotests/184.out | 12 ++++++++----
>   tests/qemu-iotests/185.out | 10 +++++-----
>   tests/qemu-iotests/191.out |  6 ++++--
>   tests/qemu-iotests/195.out |  6 ++++--
>   tests/qemu-iotests/223.out |  2 +-
>   tests/qemu-iotests/227.out | 12 ++++++++----
>   vl.c                       |  4 ++--
>   25 files changed, 122 insertions(+), 95 deletions(-)
> 
