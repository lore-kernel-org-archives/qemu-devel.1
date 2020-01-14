Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9961C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA5620CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 01:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nrcM30Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA5620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBSQ-0007an-LF
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 20:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <john.g.johnson@oracle.com>) id 1irBRo-0007Ak-57
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <john.g.johnson@oracle.com>) id 1irBRm-0005lX-8a
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:56:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <john.g.johnson@oracle.com>)
 id 1irBRm-0005jd-0m
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 20:56:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E1rddn125387;
 Tue, 14 Jan 2020 01:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=CVmPPKTD/WLZ9DN1mvqTo4fzHPaNOG+tC1SsXFP6wy4=;
 b=nrcM30ThBfCkop7okO3CvZdZzrqL4r7Fy0gQnxKc95IYO9EqIb4eNy7C8GRYVYbVjLVm
 /wGf8khyXOCLJlMVW1J3Cts02E9hm6nqxZboqQS7gYuyaBVYJC1aCSX3UUBF06/duuxZ
 p1DSuEXpaBexFeHT0nRD93rLSZng0Xs713B4H9CyMyE/oFasP5MA/1/NZWofxcQj2Bwy
 8uW8oW9exKXKBGe/4wrFF3uyWYBIvZQ/OuFUUbwbcDKG5ubiSoqUIpG7DBeku2nuAn3L
 3DJrTGiu2wc/PaHUkwnolsF3ZFgo24LnqbfRrcaQxkelH1B6iAyHOcBxQ9wKywWlhk9L KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2xf73tjtvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2020 01:56:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E1n7Zv030433;
 Tue, 14 Jan 2020 01:56:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2xfrgjq6a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2020 01:56:32 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00E1uS8A031439;
 Tue, 14 Jan 2020 01:56:29 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 13 Jan 2020 17:56:28 -0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20200103155920.GB281236@stefanha-x1.localdomain>
Date: Mon, 13 Jan 2020 17:56:25 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <39A027D6-21C3-484F-8F90-9F04DCB9E4CF@oracle.com>
References: <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <20191220102237.GA1699760@redhat.com>
 <20200102104255.GF121208@stefanha-x1.localdomain>
 <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
 <20200103155920.GB281236@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140015
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jan 3, 2020, at 7:59 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> On Thu, Jan 02, 2020 at 11:03:22AM +0000, Felipe Franciosi wrote:
>>> On Jan 2, 2020, at 10:42 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>> On Fri, Dec 20, 2019 at 10:22:37AM +0000, Daniel P. Berrang=C3=A9 =
wrote:
>>>> On Fri, Dec 20, 2019 at 09:47:12AM +0000, Stefan Hajnoczi wrote:
>>>>> On Thu, Dec 19, 2019 at 12:55:04PM +0000, Daniel P. Berrang=C3=A9 =
wrote:
>>>>>> On Thu, Dec 19, 2019 at 12:33:15PM +0000, Felipe Franciosi wrote:
>>>>>>>> On Dec 19, 2019, at 11:55 AM, Stefan Hajnoczi =
<stefanha@gmail.com> wrote:
>>>>>>>> On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi =
wrote:
>>>>>>>>>> On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi =
<stefanha@redhat.com> wrote:
>>>>>>>>>> On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi =
wrote:
>>>>>>>>>>>> On 16 Dec 2019, at 20:47, Elena Ufimtseva =
<elena.ufimtseva@oracle.com> wrote:
>>>>>>>>>>>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan =
Hajnoczi wrote:
>>>>>>> To be clear: I'm very happy to have a userspace-only option for =
this,
>>>>>>> I just don't want to ditch the kernel module (yet, anyway). :)
>>>>>>=20
>>>>>> If it doesn't create too large of a burden to support both, then =
I think
>>>>>> it is very desirable. IIUC, this is saying a kernel based =
solution as the
>>>>>> optimized/optimal solution, and userspace UNIX socket based =
option as the
>>>>>> generic "works everywhere" fallback solution.
>>>>>=20
>>>>> I'm slightly in favor of the kernel implementation because it =
keeps us
>>>>> better aligned with VFIO.  That means solving problems in one =
place only
>>>>> and less reinventing the wheel.
>>>>>=20
>>>>> Knowing that a userspace implementation is possible is a plus =
though.
>>>>> Maybe that option will become attractive in the future and someone =
will
>>>>> develop it.  In fact, a userspace implementation may be a cool =
Google
>>>>> Summer of Code project idea that I'd like to co-mentor.
>>>>=20
>>>> If it is technically viable as an approach, then I think  we should =
be
>>>> treating a fully unprivileged muser-over-UNIX socket as a higher =
priority
>>>> than just "maybe a GSoC student will want todo it".
>>>>=20
>>>> Libvirt is getting strong message from KubeVirt project that they =
want to
>>>> be running both libvirtd and QEMU fully unprivileged. This allows =
their
>>>> containers to be unprivileged. Anything that requires privileges =
requires
>>>> jumping through extra hoops writing custom code in KubeVirt to do =
things
>>>> outside libvirt in side loaded privileged containers and this =
limits how
>>>> where those features can be used.
>>>=20
>>> Okay this makes sense.
>>>=20
>>> There needs to be a consensus on whether to go with a =
qdev-over-socket
>>> approach that is QEMU-specific and strongly discourages third-party
>>> device distribution or a muser-over-socket approach that offers a =
stable
>>> API for VMM interoperability and third-party device distribution.
>>=20
>> The reason I dislike yet another offloading protocol (ie. there is
>> vhost, there is vfio, and then there would be qdev-over-socket) is
>> that we keep reinventing the wheel. I very much prefer picking
>> something solid (eg. VFIO) and keep investing on it.
>=20
> I like the idea of sticking close to VFIO too.  The first step is
> figuring out whether VFIO can be mapped to a UNIX domain socket =
protocol
> and many non-VFIO protocol messages are required.  Hopefully that =
extra
> non-VFIO stuff isn't too large.
>=20


	I looked at this and think we could map VFIO commands over a
UNIX socket without a lot of difficulty.  We'd have to use SCM
messages to pass file descriptors from the QEMU process to the
emulation process for certain operations, but that shouldn't be
a big problem.  Here are the mission mode operations:

configuration

	VFIO defines a number of configuration ioctl()s that we could
turn into messages, but if we make the protocol specific to PCI, then
all of the information they transmit (e.g., device regions and
interrupts) can be discovered by parsing the device's PCI config
space.  A lot of the current VFIO code that parses config space could
be re-used to do this.

MMIO

	VFIO uses reads and writes on the VFIO file descriptor to
perform MMIOs to the device.  The read/write offset encodes the VFIO
region and offset of the MMIO. (the VFIO regions correspond to PCI
BARs) These would have to be changed to send messages that include the
VFIO region and offset (and data for writes) to the emulation process.

interrupts

	VFIO creates eventfds that are sent to the kernel driver so it
can inject interrupts into a guest.  We would have to send these
eventfds over the socket to the emulation process using SCM messages.
The emulation process could then trigger interrupts by writing on the
eventfd.

DMA

	This is one place where I might diverge from VFIO.  It uses an
ioctl to tell the kernel driver what areas of guest memory the device
can address.  The driver then pins that memory so it can be programmed
into a HW IOMMU.  We could avoid pinning of guest memory by adopting
the vhost-user idea of sending the file descriptors used by QEMU to
create guest memory to the emulation process, and having it mmap() the
guest itself.  IOMMUs are handled by having the emulation process
request device DMA to guest PA translations from QEMU.



> If implementations can use the kernel uapi vfio header files then =
we're
> on track for compatibility with VFIO.
>=20
>>> This is just a more elaborate explanation for the "the cat is out of =
the
>>> bag" comments that have already been made on licensing.  Does anyone
>>> still disagree or want to discuss further?
>>>=20
>>> If there is agreement that a stable API is okay then I think the
>>> practical way to do this is to first merge a cleaned-up version of
>>> multi-process QEMU as an unstable experimental API.  Once it's being
>>> tested and used we can write a protocol specification and publish it =
as
>>> a stable interface when the spec has addressed most use cases.
>>>=20
>>> Does this sound good?
>>=20
>> In that case, wouldn't it be preferable to revive our proposal from
>> Edinburgh (KVM Forum 2018)? Our prototypes moved more of the Qemu =
VFIO
>> code to "common" and added a "user" backend underneath it, similar to
>> how vhost-user-scsi moved some of vhost-scsi to vhost-scsi-common and
>> added vhost-user-scsi. It was centric on PCI, but it doesn't have to
>> be. The other side can be implemented in libmuser for facilitating =
things.
>=20
> That sounds good.
>=20

       The emulation program API could be based on the current
libmuser API or the libvfio-user API.  The protocol itself wouldn=E2=80=99=
t
care which is chosen.  Our multi-processQEMU project would have to
change how devices are specified from the QEMU command line to the
emulation process command line.

							JJ


