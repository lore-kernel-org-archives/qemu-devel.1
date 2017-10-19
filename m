Received: from eggs.gnu.org ([2001:4830:134:3::10]:53258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5Bmv-0008By-Dv
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5Bms-0004FC-8p
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:27:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5Bmr-0004Eo-WC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:27:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JEPx5O143533
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:27:01 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpws1r74d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:27:00 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 10:26:55 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 10:26:52 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <523bf8e7-0be0-0db9-83da-4e7d7449562f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/42] TPM: code cleanup & CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>
> I accumulated a series of patch doing some TPM code cleanup while
> doing review. I removed some dead code, simplified other parts, and
> tried to isolate implementation of the backend and frontend by using a
> new TPMIf interface. I solved a few issues, and added some FIXME for
> what should be tackled.  Finally, I implemented a simple CRB device
> (tpm 2.0) that is work in progress for now - it works fine with
> passthrough, but swtpm/libtpms with win10 has some issues that need
> more investigations.
>
> seabios CRB support is required for TPM 2.0 & emulation
> (https://mail.coreboot.org/pipermail/seabios/2017-October/011839.html)
>
> Comments/review welcome!

Are you going to post a v2 soon?

    Stefan
