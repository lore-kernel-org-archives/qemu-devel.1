Received: from eggs.gnu.org ([208.118.235.92]:47937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eR0ER-0000WH-07
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eR0E8-0008NT-GM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:33:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38852
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eR0E8-0008N9-87
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:33:24 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIITS5A067443
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:33:22 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exjf89hqq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:33:22 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 13:33:21 -0500
References: <20171218140002.23677-1-cohuck@redhat.com>
	<151360760770.51.389844259110219934@5adcb62bf0d6>
	<20171218165346.1fe50257.cohuck@redhat.com>
	<180764363.27732961.1513612859884.JavaMail.zimbra@redhat.com>
	<20171218170618.69ff1ca1.cohuck@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 13:33:17 -0500
MIME-Version: 1.0
In-Reply-To: <20171218170618.69ff1ca1.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <35de20d9-96a6-3727-30e6-cadf790a8a2e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] tpm: move qdev_prop_tpm to hw/tpm/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: no-reply@patchew.org, qemu-devel@nongnu.org, famz@redhat.com, marcandre lureau <marcandre.lureau@redhat.com>, thuth@redhat.com

On 12/18/2017 11:06 AM, Cornelia Huck wrote:
> On Mon, 18 Dec 2017 11:00:59 -0500 (EST)
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>>>> ../hw/tpm/tpm_tis.o:tpm_tis.c:(.data+0x50): undefined reference to
>>>> `qdev_prop_tpm'
>>>> collect2: error: ld returned 1 exit status
>>>> Makefile:193: recipe for target 'qemu-system-x86_64w.exe' failed
>>>> make[1]: *** [qemu-system-x86_64w.exe] Error 1
>>>> make: *** [subdir-x86_64-softmmu] Error 2
>>>> Makefile:384: recipe for target 'subdir-x86_64-softmmu' failed
>>> Seems we need to build tpm_util also when tpm_tis is built (and none of
>>> the others).
>> Or place the property in its own file.
> Currently testing building tpm_util all of the time; waiting for a vote
> from the tpm maintainer.
>
> [Building a file called 'util' all of the time makes sense to me.]
>
Fine by me.

    Stefan
