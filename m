Received: from eggs.gnu.org ([2001:4830:134:3::10]:60257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1faiCs-0005yP-F7
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1faiCp-0007lX-8z
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:52:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33352
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1faiCp-0007lB-2y
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 09:52:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w64DnhcD013226
	for <qemu-devel@nongnu.org>; Wed, 4 Jul 2018 09:52:25 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k0vm5fd2d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 09:52:25 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 4 Jul 2018 14:52:23 +0100
References: <20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com> <20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Jul 2018 15:52:18 +0200
In-Reply-To: <20180704133440.GE4334@localhost.localdomain>
Content-Language: en-US
Message-Id: <32724a61-71de-7abc-9394-fb2a4c1cdc51@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org, Peter Krempa <pkrempa@redhat.com>



On 07/04/2018 03:34 PM, Kevin Wolf wrote:
> Am 04.07.2018 um 15:02 hat Cornelia Huck geschrieben:
>> On Tue, 3 Jul 2018 13:32:29 +0200
>> Kevin Wolf <kwolf@redhat.com> wrote:
>>
>>>>>> Has serial/gemoetry been fixed meanwhile and will it make it into the
>>>>>> next release?=20=20
>>>>>
>>>>> I cannot find an archive that has it, but it is on the libvirt mailing
>>>>> list as "[libvirt] [PATCH v3] qemu: format serial and geometry on fro=
ntend disk device".
>>>>> Review seems done, but it has missed libvirt 4.5 which was released t=
oday.=20=20
>>>>
>>>> Just posted latest version here:
>>>>
>>>>   https://www.redhat.com/archives/libvir-list/2018-July/msg00130.html
>>>>
>>>> It will be in the next release on ~ Aug 1st=20=20
>>>
>>> It would have been a lot nicer to have it the July release because this
>>> means that we'll have the released libvirt broken during almost the
>>> whole rc phase of QEMU 3.0, but the release is planned for Aug 8th the
>>> earliest, so I guess we're still okay. People using QEMU from git will
>>> just need libvirt from git as well.
>>
>> Speaking as an innocent* bystander:
>>
>> I would usually presume that I can use any recent libvirt to test
>> current QEMU, even bleeding edge. In this case, not even the latest
>> released libvirt version will be fine, I would also need to build
>> libvirt from git (which is probably not something a non-libvirt
>> developer will usually do). If everything goes according to plan, I can
>> only test QEMU with a released libvirt version at the very tail end of
>> hardfreeze, where only release blockers are appropriate.
>=20
> I understand where you're coming from, but let's be honest: It's not as
> if disk geometry or serial numbers were features that absolutely need
> to be there to give QEMU any testing.

For s390 it really has values when you use image files with a dasd geometry.
I also use the serial number a lot for mount by disk-id. So it certainly br=
eaks
parts of my tests.

>=20
> Also, my understanding has always been that we expect users to have a
> libvirt version that isn't older than QEMU. It would be useful to set a
> clear policy for this and document it.
>=20
>> I think it would be really beneficial to general QEMU test coverage to
>> push deleting this option back a release or two. We should make testing
>> QEMU in conjunction with libvirt as uncomplicated as possible.
>=20
> Essentially, what is important to me isn't getting these options dropped
> exactly in 3.0, but not setting a bad precedence that deprecation isn't
> actually worth anything. We may easily end up with this deprecation
> process:
>=20
> depreate a feature
> release QEMU version n + 1
> release QEMU version n + 2
> remove the feature
> while libvirt hasn't removed use of the feature:
>     # ...and why should it when everything is still working?
>     reinstate the feature
>     release QEMU version n + x
>     remove the feature
>=20
> When management tools know that this is the process, the motivation to
> remove the use of the feature gets even lower (not out of malice, but
> because there will be always more important things), so this will
> "optimise" itself into an endless loop and we're back to never actually
> removing old cruft that impedes development.

I think this is really a theoretical issue that assumes that libvirt people
are evil and try to undermine our deprecation. And this is simply not true.
Everybody tries to do his best, but we are all busy. So we had the issue
because we were sloppy and have not dealt with the deprecation properly
(by pushing the libvirt people at time of deprecation) And the reason is
that we really have no process for qemu->libvirt requirements. I mean:
look at virtio-vsock and other things.  How long it took from qemu to=20
libvirt show that the real issue is actually somewhere else and we might=20
want to talk about "how to improve qemu<->libvirt interaction" at the qemu
summit.


>=20
> The libvirt patch has just been merged (and I'm almost sure that this
> wouldn't have happened so quickly if I had just reverted the patch right
> away), so at least we know now that this specific instance of the loop
> is going to terminate.
>=20
> What's left is first and foremost that we need to sort out our broken
> deprecation mechanism, and if that gets done, I don't mind if someone
> wants to revert the patch for 3.0 as long as they also take care that it
> gets back into 3.1.

So what about the following:
- revert these patches now
- add these patches to the block-next-for-3.1 branch immediately (or whatev=
er branch
name you have for that)
