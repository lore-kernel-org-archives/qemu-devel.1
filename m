Received: from eggs.gnu.org ([2001:4830:134:3::10]:47334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emL10-0003bg-Bp
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emL0w-0007pg-Dl
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:00:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1emL0w-0007ou-5U
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:59:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FEtjM7130299
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:59:56 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5avucfga-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:59:54 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 14:59:52 -0000
References: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518690027-31318-3-git-send-email-mihajlov@linux.vnet.ibm.com>
	<3b41b0f0-09cf-9e43-bfa4-617335d76584@redhat.com>
	<50053a43-4905-9609-9be3-8418f1978465@linux.vnet.ibm.com>
	<cded2e23-fa97-0a11-c30c-9c6b79088fcf@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 15:59:47 +0100
MIME-Version: 1.0
In-Reply-To: <cded2e23-fa97-0a11-c30c-9c6b79088fcf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <55d9d665-df3d-80d1-2aab-a914493febc8@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 2/4] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 15.02.2018 15:53, Eric Blake wrote:
> On 02/15/2018 08:40 AM, Viktor Mihajlovski wrote:
>> On 15.02.2018 15:19, Eric Blake wrote:
>>> On 02/15/2018 04:20 AM, Viktor Mihajlovski wrote:
>>>> From: Luiz Capitulino <lcapitulino@redhat.com>
>>>>
>>>> The query-cpus command has an extremely serious side effect:
>>>> it always interrupts all running vCPUs so that they can run
>>>> ioctl calls. This can cause a huge performance degradation for
>>>> some workloads. And most of the information retrieved by the
>>>> ioctl calls are not even used by query-cpus.
>>>>
>>>> This commit introduces a replacement for query-cpus called
>=20
>>> You know, we have no back-compat guarantees on HMP.=C2=A0 We could ma=
ke 'info
>>> cpu' just ALWAYS call query-cpus-fast, with no HMP counterpart for th=
e
>>> slower query-cpus, and without needing a deprecation period.=C2=A0 Bu=
t I'll
>>> leave that up to David if that makes more sense.
>> Ditching info cpus_fast would make me happy as well, because it would
>> cause less headache on the libvirt side of things.
>=20
> Why is libvirt using HMP in the first place?=C2=A0 Libvirt should alway=
s be
> using the QMP command, when one exists.
> Which it does, but there's still a lot of fallback code including HMP
"info cpus". In real life this should of course never be used, because
the QMP is always there.

--=20
Regards,
 Viktor Mihajlovski
