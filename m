Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2176C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9927C2081C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9927C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52187 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVwuu-0003Bd-Um
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:38:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fiuczy@linux.ibm.com>) id 1hVwts-0002hK-Rj
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fiuczy@linux.ibm.com>) id 1hVwtr-0008Nf-LT
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:37:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fiuczy@linux.ibm.com>)
	id 1hVwtr-0008Jq-Be
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:37:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4TBWfvv063864
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 07:37:40 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ssq2vwpgh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 07:37:39 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <fiuczy@linux.ibm.com>;
	Wed, 29 May 2019 12:37:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 29 May 2019 12:37:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4TBbPjW36307154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 29 May 2019 11:37:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D45AA4040;
	Wed, 29 May 2019 11:37:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 840C1A4055;
	Wed, 29 May 2019 11:37:24 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.222.40])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2019 11:37:24 +0000 (GMT)
To: Alex Williamson <alex.williamson@redhat.com>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507151826.502be009@x1.home>
	<20190508112740.GA24397@joy-OptiPlex-7040>
	<20190508152242.4b54a5e7@x1.home>
	<5eac912c-e753-b5f6-83a4-b646f991d858@linux.ibm.com>
	<20190514093140.68cc6f7a@x1.home>
From: Boris Fiuczynski <fiuczy@linux.ibm.com>
Date: Tue, 28 May 2019 22:57:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514093140.68cc6f7a@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19052911-0016-0000-0000-000002809C8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052911-0017-0000-0000-000032DDACFC
Message-Id: <0c1f5f03-1895-b9a2-999f-f611dd295732@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-29_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905290078
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0a-001b2d01.pphosted.com id x4TBWfvv063864
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [libvirt] [PATCH v2 1/2] vfio/mdev: add version
 attribute for mdev device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
	"shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"eauger@redhat.com" <eauger@redhat.com>, Tony@pps.reinject, "Liu,
	Yi L" <yi.l.liu@intel.com>,
	"eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
	Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"dinechin@redhat.com" <dinechin@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>, Krowiak <akrowiak@linux.ibm.com>,
	Pierre Morel <pmorel@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:31 PM, Alex Williamson wrote:
> On Wed, 8 May 2019 17:27:47 +0200
> Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:
>=20
>> On 5/8/19 11:22 PM, Alex Williamson wrote:
>>>>> I thought there was a request to make this more specific to migrati=
on
>>>>> by renaming it to something like migration_version.  Also, as an
>>>>>     =20
>>>> so this attribute may not only include a mdev device's parent device=
 info and
>>>> mdev type, but also include numeric software version of vendor speci=
fic
>>>> migration code, right?
>>> It's a vendor defined string, it should be considered opaque to the
>>> user, the vendor can include whatever they feel is relevant.
>>>   =20
>> Would a vendor also be allowed to provide a string expressing required
>> features as well as containing backend resource requirements which nee=
d
>> to be compatible for a successful migration? Somehow a bit like a cpu
>> model... maybe even as json or xml...
>> I am asking this with vfio-ap in mind. In that context checking
>> compatibility of two vfio-ap mdev devices is not as simple as checking
>> if version A is smaller or equal to version B.
>=20
> Two pieces to this, the first is that the string is opaque exactly so
> that the vendor driver can express whatever they need in it.  The user
> should never infer that two devices are compatible.  The second is that
I agree.

> this is not a resource availability or reservation interface.  The fact
I also agree. The migration_version (version in this case is not really=20
a good fit) is a summary of requirements the source mdev has which a=20
target mdev needs to be able to fulfill in order to allow migration.
The target mdev already exists and was already configured by other means=20
not involved in the migration check process.
Using the migrations_version as some kind of configuration transport=20
and/or reservation mechanism wasn't my intention and IMHO would both be=20
wrong.

> that a target device would be compatible for migration should not take
> into account whether the target has the resources to actually create
> such a device.  Doing so would imply some sort of resource reservation
> support that does not exist.  Matrix devices are clearly a bit
> complicated here since maybe the source is expressing a component of
> the device that doesn't exist on the target.  In such a "resource not
> available at all" case, it might be fair to nak the compatibility test,
> but a "ok, but resource not currently available" case should pass,
> imo.  Thanks,
>=20
> Alex
>=20
> --
> libvir-list mailing list
> libvir-list@redhat.com
> https://www.redhat.com/mailman/listinfo/libvir-list
>=20


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen/Kind regards
    Boris Fiuczynski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294


