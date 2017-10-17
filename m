Received: from eggs.gnu.org ([2001:4830:134:3::10]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e4WMu-0001nT-9y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 14:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e4WMp-0008Ee-Sm
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 14:13:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e4WMp-0008E4-KV
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 14:13:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9HI99ti087687
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 14:13:22 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dnmaafx2s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 14:13:21 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 17 Oct 2017 12:13:21 -0600
References: <1508247148-25240-1-git-send-email-thuth@redhat.com>
	<19010e69-6abe-0888-24a9-903ca4017355@linux.vnet.ibm.com>
	<09194092-7fa7-e640-7208-49fa270fd497@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 16:13:12 -0200
MIME-Version: 1.0
In-Reply-To: <09194092-7fa7-e640-7208-49fa270fd497@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <043c322c-eb5f-4797-839c-bb68dde65466@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] Improve the CPU hot plug
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, david@redhat.com, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>



On 10/17/2017 02:36 PM, Thomas Huth wrote:
> On 17.10.2017 18:27, Daniel Henrique Barboza wrote:
>>
>> On 10/17/2017 11:32 AM, Thomas Huth wrote:
>>> So far the CPU hot-plug qtest was only checking "cpu-add" on x86. With
>>> these patches, we now test "device_add" for hot-plugging CPUs on x86,
>>> and enable the test on ppc64 and s390x, too.
>> Question: is there a reason other than "no one bothered" to not have a
>> CPU hot
>> unplug test, something around the lines of the now cpu-plug-test.c? I might
>> give it a shot if there is no known roadblocks against it.
> AFAIK on x86, you need some ACPI magic on the guest side to do this
> (something similar to qpci_unplug_acpi_device_test() in
> tests/libqos/pci-pc.c I guess). And on s390x, CPU unplug is not
> supported at all. But it might work on ppc64 without guest intervention,
> not sure - maybe Bharata can comment on this...

Good point, it won't work in spapr machine without guest intervention too.
Both CPU and LMB unplug relies on guest-side callbacks to complete the
operation.

I'll see how this ACPI magic you mentioned is done and see how hard it is to
do it for ppc64.


Daniel

>
>   Thomas
>
