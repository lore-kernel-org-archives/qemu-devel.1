Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11271C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC19B20760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuRuD3Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC19B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiuCK-0007K8-22
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jiuBQ-0006Ue-Pl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:25:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.g.johnson@oracle.com>)
 id 1jiuBP-0005mk-0j
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 02:25:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A6N7fP018111;
 Wed, 10 Jun 2020 06:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=JykLzd6JGGfmJi6k2Q/mETa4hNuBm8YHTW3FhKiLtFw=;
 b=cuRuD3Rruwroa9Jlq4qvG3d4D1Qre08EhMAA2BMH1TPKWYCNN51CnvejczT3JIxdZHLJ
 kL/6zw21h5GRO4fLPZzrt1XAE5EG/NNhl/426vPLmx5UlytrUgHGkj+QnAITExawmaJ4
 1bv1e67pHrYekXJhA0GRmuSgNU+ADI7jV2wkRp7wVh/98QYPsdLSn5rA8CRuOw14D5CY
 HR2M9bmPkU+hms//Yy+poviXGEFdSzrWPZWjHzneN699WlX+EE/Qn0zRwUvN70ns0qVh
 +WwcGqhr53cjmoHcRrm+J3phdJskCtUEqXWhrbx+xYKMoqgy83igEBsRiwJxxHyuFDNy 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 31g2jr8k1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Jun 2020 06:25:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A6IOq4127638;
 Wed, 10 Jun 2020 06:25:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 31gn28242r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 06:25:46 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05A6PhqV012235;
 Wed, 10 Jun 2020 06:25:43 GMT
Received: from [192.168.10.3] (/24.5.35.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 09 Jun 2020 23:25:43 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
From: John G Johnson <john.g.johnson@oracle.com>
In-Reply-To: <20200602090629.66f9e3f7@x1.home>
Date: Tue, 9 Jun 2020 23:25:41 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
 <20200602090629.66f9e3f7@x1.home>
To: Alex Williamson <alex.williamson@redhat.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100048
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=john.g.johnson@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 02:25:50
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jun 2, 2020, at 8:06 AM, Alex Williamson =
<alex.williamson@redhat.com> wrote:
>=20
> On Wed, 20 May 2020 17:45:13 -0700
> John G Johnson <john.g.johnson@oracle.com> wrote:
>=20
>>> I'm confused by VFIO_USER_ADD_MEMORY_REGION vs =
VFIO_USER_IOMMU_MAP_DMA.
>>> The former seems intended to provide the server with access to the
>>> entire GPA space, while the latter indicates an IOVA to GPA mapping =
of
>>> those regions.  Doesn't this break the basic isolation of a vIOMMU?
>>> This essentially says to me "here's all the guest memory, but please
>>> only access these regions for which we're providing DMA mappings".
>>> That invites abuse.
>>>=20
>>=20
>> 	The purpose behind separating QEMU into multiple processes is
>> to provide an additional layer protection for the infrastructure =
against
>> a malign guest, not for the guest against itself, so preventing a =
server
>> that has been compromised by a guest from accessing all of guest =
memory
>> adds no additional benefit.  We don=E2=80=99t even have an IOMMU in =
our current
>> guest model for this reason.
>=20
> One of the use cases we see a lot with vfio is nested assignment, ie.
> we assign a device to a VM where the VM includes a vIOMMU, such that
> the guest OS can then assign the device to userspace within the guest.
> This is safe to do AND provides isolation within the guest exactly
> because the device only has access to memory mapped to the device, not
> the entire guest address space.  I don't think it's just the =
hypervisor
> you're trying to protect, we can't assume there are always trusted
> drivers managing the device.
>=20

	We intend to support an IOMMU.  The question seems to be whether
it=E2=80=99s implemented in the server or client.  The current proposal =
has it
in the server, ala vhost-user, but we are fine with moving it.


>>=20
>> 	The implementation was stolen from vhost-user, with the =
exception
>> that we push IOTLB translations from client to server like VFIO does, =
as
>> opposed to pulling them from server to client like vhost-user does.
>=20
> It seems that vhost has numerous hacks forcing it to know whether a
> vIOMMU is present as a result of this, vfio has none.
>=20

	I imagine this decision was driven by performance =
considerations.
If the IOMMU is implemented on the client side, the server must execute =
mmap()
or munmap() for every IOMMU MAP/UNMAP message.  If the IOMMU is =
implemented
on the server side, the server doesn=E2=80=99t need these system calls; =
it just adds a
SW translation entry to its own table.


>> 	That said, neither the qemu-mp nor MUSER implementation uses an
>> IOMMU, so if you prefer another IOMMU model, we can consider it.  We
>> could only send the guest memory file descriptors with IOMMU_MAP_DMA
>> requests, although that would cost performance since each request =
would
>> require the server to execute an mmap() system call.
>=20
> It would seem shortsighted to not fully enable a vIOMMU compatible
> implementation at this time.
>=20
>>> Also regarding VFIO_USER_ADD_MEMORY_REGION, it's not clear to me how
>>> "an array of file descriptors will be sent as part of the message
>>> meta-data" works.  Also consider s/SUB/DEL/.  Why is the Device ID =
in
>>> the table specified as 0?  How does a client learn their Device ID?
>>>=20
>>=20
>> 	SCM_RIGHTS message controls allow sendmsg() to send an array of
>> file descriptors over a UNIX domain socket.
>>=20
>> 	We=E2=80=99re only supporting one device per socket in this =
protocol
>> version, so the device ID will always be 0.  This may change in a =
future
>> revision, so we included the field in the header to avoid a major =
version
>> change if device multiplexing is added later.
>>=20
>>=20
>>> VFIO_USER_DEVICE_GET_REGION_INFO (or anything else making use of a
>>> capability chain), the cap_offset and next pointers within the chain
>>> need to specify what their offset is relative to (ie. the start of =
the
>>> packet, the start of the vfio compatible data structure, etc).  I
>>> assume the latter for client compatibility.
>>>=20
>>=20
>> 	Yes.  We will attempt to make the language clearer.
>>=20
>>=20
>>> Also on REGION_INFO, offset is specified as "the base offset to be
>>> given to the mmap() call for regions with the MMAP attribute".  Base
>>> offset from what?  Is the mmap performed on the socket fd?  Do we =
not
>>> allow read/write, we need to use VFIO_USER_MMIO_READ/WRITE instead?
>>> Why do we specify "MMIO" in those operations versus simply "REGION"?
>>> Are we arbitrarily excluding support for I/O port regions or device
>>> specific regions?  If these commands replace direct read and write =
to
>>> an fd offset, how is PCI config space handled?
>>>=20
>>=20
>> 	The base offset refers to the sparse areas, where the sparse =
area
>> offset is added to the base region offset.  We will try to make the =
text
>> clearer here as well.
>>=20
>> 	MMIO was added to distinguish these operations from DMA =
operations.
>> I can see how this can cause confusion when the region refers to a =
port range,
>> so we can change the name to REGION_READ/WRITE.=20
>>=20
>>=20
>>> VFIO_USER_MMIO_READ specifies the count field is zero and the reply
>>> will include the count specifying the amount of data read.  How does
>>> the client specify how much data to read?  Via message size?
>>>=20
>>=20
>> 	This is a bug in the doc.  As you said, the read field should
>> be the amount of data to be read.
>> =09
>>=20
>>> VFIO_USER_DMA_READ/WRITE, is the address a GPA or IOVA?  IMO the =
device
>>> should only ever have access via IOVA, which implies a DMA mapping
>>> exists for the device.  Can you provide an example of why we need =
these
>>> commands since there seems little point to this interface if a =
device
>>> cannot directly interact with VM memory.
>>>=20
>>=20
>> 	It is a GPA.  The device emulation code would only handle the =
DMA
>> addresses the guest programmed it with; the server infrastructure =
knows
>> whether an IOMMU exists, and whether the DMA address needs =
translation to
>> GPA or not.
>=20
> I'll re-iterate, a device should only ever issue DMAs in terms of =
IOVA.
> This is how vfio works.
>=20
>>> The IOMMU commands should be unnecessary, a vIOMMU should be
>>> transparent to the server by virtue that the device only knows about
>>> IOVA mappings accessible to the device.  Requiring the client to =
expose
>>> all memory to the server implies that the server must always be =
trusted.
>>>=20
>>=20
>> 	The client and server are equally trusted; the guest is the =
untrusted
>> entity.
>=20
> And therefore the driver is untrusted and opening the client/sever
> window to expose all of guest memory presents a larger attack surface.
>=20
>>> Interrupt info format, s/type/index/, s/vector/subindex/
>>>=20
>>=20
>> 	ok
>>=20
>>=20
>>> In addition to the unused ioctls, the entire concept of groups and
>>> containers are not found in this specification.  To some degree that
>>> makes sense and even mdevs and typically SR-IOV VFs have a 1:1 =
device
>>> to group relationship.  However, the container is very much involved =
in
>>> the development of migration support, where it's the container that
>>> provides dirty bitmaps.  Since we're doing map and unmap without =
that
>>> container concept here, perhaps we'd equally apply those APIs to =
this
>>> same socket.  Thanks, =20
>>=20
>> 	Groups and containers are host IOMMU concepts, and we don=E2=80=99=
t
>> interact with the host here.  The kernel VFIO driver doesn=E2=80=99t =
even need
>> to exist for VFIO over socket.  I think it=E2=80=99s fine to assume a =
1-1
>> correspondence between containers, groups, and a VFIO over socket =
device.
>=20
> Obviously the kernel driver and host IOMMU are out of the picture =
here.
> The point I was trying to make is that we're building interfaces to
> support migration around concepts that don't exist in this model, so
> it's not clear how we'd map, for example, dirty page tracking on the
> container interface to this API.  This seems more akin to the no-iommu
> model of vfio, which is a hack where we allow userspace to have access
> to a device using the vfio API, but they're on their own for DMA.  We
> don't support that model in QEMU, and without those conceptual
> equivalencies, I wonder how much we'll be able to leverage existing
> QEMU code or co-develop and support future features.  IOW, is this
> really just "a vfio-like device model over unix socket" rather than
> "vfio over unix socket"?  Thanks,
>=20


	In this model, each device is in its own IOMMU and VFIO =
container.
We can add a note stating this to the spec.

	VFIO does seem to support a QEMU guest with no IOMMU.  It uses =
the
VFIO_IOMMU_MAP_DMA ioctl()s to establish the 1-1 device DMA address to
guest physical address mapping in the host IOMMU.  The current MUSER
prototypes takes advantage of this in their guest, which lacks an IOMMU.

						Thanos & JJ



