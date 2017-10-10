Received: from eggs.gnu.org ([2001:4830:134:3::10]:55832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21RQ-0000oy-9p
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21RL-0001HC-EV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:47:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54192
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e21RL-0001Gz-92
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:47:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKhtuL067636
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:47:43 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh2grhy20-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:47:43 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:47:42 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-38-marcandre.lureau@redhat.com>
	<20171010202151.GA4178@localhost.localdomain>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:47:38 -0400
MIME-Version: 1.0
In-Reply-To: <20171010202151.GA4178@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <efe8e952-d487-0cc4-2935-5234a1d88928@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 37/42] tpm: lookup the the TPM interface
 instead of TIS device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, amarnath.valluri@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/10/2017 04:21 PM, Eduardo Habkost wrote:
> On Tue, Oct 10, 2017 at 12:56:18AM +0200, Marc-Andr=E9 Lureau wrote:
> [...]
>> -static inline TPMVersion tpm_get_version(void)
>> +static inline TPMIf *tpm_find(void)
>>   {
>> -#ifdef CONFIG_TPM
>> -    Object *obj =3D object_resolve_path_type("", TYPE_TPM_TIS, NULL);
>> +    Object *obj =3D object_resolve_path_type("", TYPE_TPM_IF, NULL);
> Considering that tpm_crb_realizefn() will rely on tpm_find()
> returning NULL if there are multiple TPM devices, I suggest
> adding a "returns NULL unless there is exactly one TPM device"
> comment, just like fw_cfg_find() and find_vmgenid_dev()

I wonder whether the function couldn't have a better name.=20
tpm_find_single() ?

    Stefan

>
>> +
>> +    return TPM_IF(obj);
>> +}
> [...]
>
