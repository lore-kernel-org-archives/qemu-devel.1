Received: from eggs.gnu.org ([209.51.188.92]:33692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvwfb-0005TL-5H
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvwfS-00035I-EI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:06:07 -0500
References: <d5dc1bda-6b43-cbd6-3faa-69bb0ae45af4@howtolinux.de>
	<2c817163-f940-98f9-ad6e-5da1f70baf99@redhat.com>
From: Alexander Marx <copymaster@howtolinux.de>
Message-ID: <2bfc52df-0126-21bf-769d-30101e1ccecc@howtolinux.de>
Date: Tue, 19 Feb 2019 05:05:25 +0100
MIME-Version: 1.0
In-Reply-To: <2c817163-f940-98f9-ad6e-5da1f70baf99@redhat.com>
Content-Language: de-DE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Please help corrupt filesystem image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Qemu-block <qemu-block@nongnu.org>

Thank you for replying.
Well i am using latest PROXMOX in a cluster of 4 physical servers.
during the weekend i had to stop all hosts because electricians had to
work on the fuse box.

i shutted down all vm's then powered off all physical hosts. One of them
took very long.
this host had a raid5 of 27 TB on it (XFS) where some vm images were save=
d.

i waited long time but i knew that at weekends the raid does a patrol
read. So i switched that host hard off.

After rebooting, all hosts and nearly all vms came back online without
problems. only these two images could not be started.
As i told before, they were not critical as they were part of a new
domain which was not used in productuction.

Then i found out that the XFS Filesystem has problems. i stopped all
vm's again and did a xfs_check on that storage.
Some Errors were correted which causes 2 other vm's to die.

These vm's i could restore from backup, so no problem. The other 2
Win216 servers i had to delete and install new.
Thank you very much for your interest on my problem.
It is solved.

Have a nice week and please go on developing that great piece of software=
!


Am 18.02.19 um 21:54 schrieb John Snow:
>
> On 2/16/19 10:54 PM, Alexander Marx wrote:
>> Dear List!
>>
>> I have a big problem and hope you can help me.
>> I built a new windows 2016 domain with virtual servers. 2 dc and 9 rds=

>> hosts.
>> I was nearly finished with the setup and ready to migrate the users fr=
om
>> old to new domain.
>>
>> Then i had to restart the physical servers. Unfortunately 1 dc and 2 r=
ds
>> hosts could not be startet anymore.
>> Error says:
>>
>> qemu-img: Could not open 'vm-150-disk-0.qcow2': Could not read qcow2
>> header: Input/output error
>>
>> Even worst, a qemu-img check=C2=A0 also gave that error. and i was not=
 able
>> to do anything i found in the internet to fix it.
>> always that error or the qemu-img could not determine the format.
>>
>> Is there a chance to fix these images? What can i do?
>>
>> I have no backup because the domain was not fully configured. But if i=

>> have to rebuild the whole domain, i will need several weeks for it.
>> Any help is appreciated.
>>
>> Thank you
>>
>> Alex
>>
> What versions of QEMU were you running?
> What filesystem were these images stored on?
> What happened at the time of the corruption, is there some detail that
> might help explain the nature of the corruption? Did you shut down the
> physical host while the VMs were still running?
>
> There may not be a way to recover these images, but we should probably
> make sure that your configuration isn't unsafe to prevent this kind of
> problem in the future.
