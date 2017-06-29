Received: from eggs.gnu.org ([2001:4830:134:3::10]:55823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQfAD-0006i1-4S
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dQfA9-0000eo-2X
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:31:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dQfA8-0000eC-OW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:31:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TJSe3l119428
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 15:31:34 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bd1dtjw2b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 15:31:34 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Jun 2017 13:31:33 -0600
References: <7f0b8d00-236d-37e8-5c1f-e7ea8e4b9146@redhat.com>
	<e24f5884-5c1a-593d-6ae6-c8c4667a07d5@linux.vnet.ibm.com>
	<6fc5cb94-2cbe-e8ec-7ad7-1aa64cd3a0d1@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 15:31:27 -0400
MIME-Version: 1.0
In-Reply-To: <6fc5cb94-2cbe-e8ec-7ad7-1aa64cd3a0d1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <1e0889cf-5b50-eae9-037c-5f2b51afc9d7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] TPM status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu devel list <qemu-devel@nongnu.org>, Javier Martinez Canillas <javierm@redhat.com>, Peter Jones <pjones@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 06/27/2017 12:32 PM, Laszlo Ersek wrote:
>
> Looks great to me, thank you!
>
> Two requests in addition to the above remarks:
> - can you provide command line options / examples wherever appropriate?

I didn't add it because we describe that on this page here:

http://download.qemu.org/qemu-doc.html


"To create a passthrough TPM use the following two options:

-tpmdev passthrough,id=tpm0 -device tpm-tis,tpmdev=tpm0"


   Stefan
