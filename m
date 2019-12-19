Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EECC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14BD227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSDTgfvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14BD227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihytd-0002iJ-0f
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1ihysf-0001mn-0f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1ihysc-0003dp-IO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:42:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1ihysc-0003bt-4O
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:42:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEaZi144300;
 Thu, 19 Dec 2019 16:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=KF/ttofScLAJdUi2RUKoRnIaYeLPMTsO0WRq45MRN8U=;
 b=RSDTgfvvO0gGNBLAd8Z4tuzJtL/IH4OipJVi1udGcHqupx27VviWWr71ep/Ai6yp+ojk
 sAMUI0jUAiPeqHMk0KzNbgfWt73gUfXNNrY8483BR2Qefv8KHM+ojcj1O94cofWGA1mN
 FvtTDxcCe8KGgJNcVVe2Uqhf60OMyZ+xf4tMpHDYlH8Gjo3S8CJKZt1NRzuI5s37C4Qn
 ys6/9sS2+JpMJ8G6WUAlc2XyNwA0xe/BqOjgp3cuk6aytAJXma6r7JnUU/sJbG1yKc7T
 4NeqMF4JHur4U0nNQ4o5zvp2yL8XzRdYLYzjUZNw2Ez+Z9UWiYOnpOpISiUW7rVUle5c sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2x01jabyqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2019 16:42:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJGEHYn114025;
 Thu, 19 Dec 2019 16:40:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2x04mq9bp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2019 16:40:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBJGeASH004424;
 Thu, 19 Dec 2019 16:40:10 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 19 Dec 2019 08:40:10 -0800
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
To: Felipe Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <a98221a8-0a62-46f8-499d-84447fb4980a@oracle.com>
Date: Thu, 19 Dec 2019 11:40:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190135
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 xBJGEaZi144300
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/19/2019 7:33 AM, Felipe Franciosi wrote:
> Hello,
>=20
> (I've added Jim and Ben from the SPDK team to the thread.)
>=20
>> On Dec 19, 2019, at 11:55 AM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
>>
>> On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi wrote:
>>>> On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi <stefanha@redhat.com> w=
rote:
>>>> On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
>>>>>> On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@oracle.=
com> wrote:
>>>>>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi=
 wrote:
>>>> Questions I've seen when discussing muser with people have been:
>>>>
>>>> 1. Can unprivileged containers create muser devices?  If not, this i=
s a
>>>>   blocker for use cases that want to avoid root privileges entirely.
>>>
>>> Yes you can. Muser device creation follows the same process as genera=
l
>>> mdev device creation (ie. you write to a sysfs path). That creates an
>>> entry in /dev/vfio and the control plane can further drop privileges
>>> there (set selinux contexts, &c.)
>>
>> In this case there is still a privileged step during setup.  What abou=
t
>> completely unprivileged scenarios like a regular user without root or =
a
>> rootless container?
>=20
> Oh, I see what you are saying. I suppose we need to investigate
> adjusting the privileges of the sysfs path correctly beforehand to
> allow devices to be created by non-root users. The credentials used on
> creation should be reflected on the vfio endpoint (ie. /dev/fio/<group>=
).
>=20
> I need to look into that and get back to you.

As a prerequisite to using the "vfio-pci" device in QEMU, the user
assigns the PCI device on the host bus to the VFIO kernel driver by
writing to "/sys/bus/pci/drivers/vfio-pci/new_id" and
"/sys/bus/pci/drivers/vfio-pci/bind"

I believe a privileged control plane is required to perform these
prerequisite steps. Therefore, I wonder how rootless containers or
unprivileged users currently go about using a VFIO device with QEMU/KVM.

Thanks!
--
Jag

>=20
>>
>>>> 2. Does muser need to be in the kernel (e.g. slower to develop/ship,
>>>>   security reasons)?  A similar library could be implemented in
>>>>   userspace along the lines of the vhost-user protocol.  Although VM=
Ms
>>>>   would then need to use a new libmuser-client library instead of
>>>>   reusing their VFIO code to access the device.
>>>
>>> Doing it in userspace was the flow we proposed back in last year's KV=
M
>>> Forum (Edinburgh), but it got turned down. That's why we procured the
>>> kernel approach, which turned out to have some advantages:
>>> - No changes needed to Qemu
>>> - No Qemu needed at all for userspace drivers
>>> - Device emulation process restart is trivial
>>>   (it therefore makes device code upgrades much easier)
>>>
>>> Having said that, nothing stops us from enhancing libmuser to talk
>>> directly to Qemu (for the Qemu case). I envision at least two ways of
>>> doing that:
>>> - Hooking up libmuser with Qemu directly (eg. over a unix socket)
>>> - Hooking Qemu with CUSE and implementing the muser.ko interface
>>>
>>> For the latter, libmuser would talk to a character device just like i=
t
>>> talks to the vfio character device. We "just" need to implement that
>>> backend in Qemu. :)
>>
>> What about:
>> * libmuser's API stays mostly unchanged but the library speaks a
>>    VFIO-over-UNIX domain sockets protocol instead of talking to
>>    mdev/vfio in the host kernel.
>=20
> As I said above, there are advantages to the kernel model. The key one
> is transparent device emulation restarts. Today, muser.ko keeps the
> "device memory" internally in a prefix tree. Upon restart, a new
> device emulator can recover state (eg. from a state file in /dev/shm
> or similar) and remap the same memory that is already configured to
> the guest via Qemu. We have a pending work item for muser.ko to also
> keep the eventfds so we can recover those, too. Another advantage is
> working with any userspace driver and not requiring a VMM at all.
>=20
> If done entirely in userspace, the device emulator needs to allocate
> the device memory somewhere that remains accessible (eg. tmpfs), with
> the difference that now we may be talking about non-trivial amounts of
> memory. Also, that may not be the kind of content you want lingering
> around the filesystem (for the same reasons Qemu unlinks memory files
> from /dev/hugepages after mmap'ing it).
>=20
> That's why I'd prefer to rephrase what you said to "in addition"
> instead of "instead".
>=20
>> * VMMs can implement this protocol directly for POSIX-portable and
>>    unprivileged operation.
>> * A CUSE VFIO adapter simulates /dev/vfio so that VFIO-only VMMs can
>>    still take advantage of libmuser devices.
>=20
> I'm happy with that.
> We need to think the credential aspect throughout to ensure nodes can
> be created in the right places with the right privileges.
>=20
>>
>> Assuming this is feasible, would you lose any important
>> features/advantages of the muser.ko approach?  I don't know enough abo=
ut
>> VFIO to identify any blocker or obvious performance problems.
>=20
> That's what I elaborated above. The fact that muser.ko can keep
> various metadata (and other resources) about the device in the kernel
> and grant it back to userspace as needed. There are ways around it,
> but it requires some orchestration with tmpfs and the VMM (only so
> much can be kept in tmpfs; the eventfds need to be retransmitted from
> the machine emulator on request).
>=20
> Restarting is a critical aspect of this. One key use case for the
> project is to be able to emulate various devices from one process (for
> polling). That must be able to restart for upgrades or recovery.
>=20
>>
>> Regarding recovery, it seems straightforward to keep state in a tmpfs
>> file that can be reopened when the device is restarted.  I don't think
>> kernel code is necessary?
>=20
> It adds a dependency, but isn't a show stopper. If we can work through
> permission issues, making sure the VMM can reconnect and retransmit
> eventfds and other state, then it should be ok.
>=20
> To be clear: I'm very happy to have a userspace-only option for this,
> I just don't want to ditch the kernel module (yet, anyway). :)
>=20
> F.
>=20
>>
>> Stefan
>=20

