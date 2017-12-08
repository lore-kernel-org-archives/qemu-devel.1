Received: from eggs.gnu.org ([2001:4830:134:3::10]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eNQ1r-0007v7-1t
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eNQ1m-000810-KL
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:17:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eNQ1m-00080N-Eg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:17:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB8LEgpB100070
	for <qemu-devel@nongnu.org>; Fri, 8 Dec 2017 16:17:49 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2er19rmsy8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 16:17:44 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 8 Dec 2017 16:17:42 -0500
References: <1512506153-8011-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1512506153-8011-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<d0eba370-dfa6-cb01-2137-2a2ec8d81158@kaod.org>
	<63ec1612-5998-4303-e1d9-16a2c37ac17d@linux.vnet.ibm.com>
	<157332b2-bfc2-a99d-0bf1-577a1dda775e@kaod.org>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 16:17:39 -0500
MIME-Version: 1.0
In-Reply-To: <157332b2-bfc2-a99d-0bf1-577a1dda775e@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <242276bf-f147-f848-a2b7-777f646df367@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm_spapr: Support TPM for ppc64 using
 CRQ based interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, lo1@us.ibm.com, James.Bottomley@HansenPartnership.com, David Gibson <david@gibson.dropbear.id.au>

On 12/08/2017 01:17 PM, C=C3=A9dric Le Goater wrote:
> On 12/06/2017 12:53 PM, Stefan Berger wrote:
>> On 12/06/2017 02:26 AM, C=C3=A9dric Le Goater wrote:
>>> Hello Stefan,
>>>
>>> Some comments below. How do we populate the device tree ?
>> Patched SLOF.
>
> Ah. Isn't that a problem ? I thought QEMU was in charge of populating
> the device tree.


I haven't seen this for ppc64 but it's true for ACPI on x86.

> You should send the full patchset rebased on QEMU's head or
> on David's 2.12 branch else this patch won't apply or compile.


I am maintaining a tpm-next branch for 2.12 that includes the patches=20
that this builds on top of.

    Stefan
