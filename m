Received: from eggs.gnu.org ([2001:4830:134:3::10]:36976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gG27w-0006Q7-Jx
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gG27t-0007ib-E5
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:26:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gG27p-0007gd-DU
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 09:26:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9QDOcoH127395
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:26:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nc2rbugsu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:26:02 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Oct 2018 14:25:58 +0100
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<nycvar.YSQ.7.76.1810261213001.8270@xnncv>
	<20181026094208.GD31390@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 26 Oct 2018 15:25:53 +0200
In-Reply-To: <20181026094208.GD31390@redhat.com>
Content-Language: en-US
Message-Id: <5822e59e-7ecf-87c8-3609-770fc72f8bd8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [libvirt]  [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, P J P <ppandit@redhat.com>
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org



On 10/26/2018 11:42 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Oct 26, 2018 at 12:33:55PM +0530, P J P wrote:
>>   Hello Dan, all
>>
>> +-- On Thu, 25 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
>> | On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
>> | > While being at it deprecate cirrus too.
>> | >=20
>> | > Reason (short version): use stdvga instead.
>> | > Verbose version:
>> | >     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered=
-harmful
>> |=20
>> |=20
>> | I don't debate the points in the blog post above that stdvga is a
>> | better choice, but I don't think that's enough to justify deprecating
>> | cirrus at this point in time, because when it then gets deleted it
>> | will break way too many existing deployments.
>> |=20
>> | We need to socialize info in that blog post above more widely and
>> | especially ensure that apps are not using that by default. I don't
>> | see it being viable to formally deprecate it in QEMU any time soon
>> | though given existing usage.
>>
>> To note, IMO there are other devices/sources in QEMU which are potential=
=20
>> candidates for deprecation, similar to adlib etc. It'll help if we could=
=20
>> device a process to deprecate/remove such code base. Other than maintena=
nce it=20
>> invariably also becomes source of security issues.
>>
>> Ex.(similar to Fedora) we could announce such candidate on qemu-devel li=
st and=20
>> after review over a period of say a month, candidate will be
>> deprecated/expunged. (thinking aloud)
>=20
> QEMU has a deprecation process:
>=20
>   https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
>=20
> Most of the stuff deprecated is CLI args / monitor commands, etc where
> mgmt apps just adjust the way they are calling QEMU, so end user's VMs
> are largely not impacted.
>=20
> Deprecating a device type that is widely used is not desirable because
> that will cause breakage of existing guests.  Distros are free to disable
> devices in their builds if they want to reduce the scope for CVEs in
> packages they maintain, but again they should think carefully about how
> many users they are going to break by doing so.

I agree with what Daniel said. Deprecating something that is in heavy use=20
by users just because we have trouble maintaining it not going to help the
QEMU project - quite the opposite.=20
