Received: from eggs.gnu.org ([2001:4830:134:3::10]:52150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gKKAx-0006r3-99
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gKKAu-0005Y9-6q
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gKKAt-0005VO-Od
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:31:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14F49C049AFE
	for <qemu-devel@nongnu.org>; Wed,  7 Nov 2018 09:30:58 +0000 (UTC)
References: <20181030123526.26415-1-kchamart@redhat.com>
	<20181030123526.26415-3-kchamart@redhat.com>
	<10e3b401-92fc-f096-9e7e-b08223408ce9@redhat.com>
	<20181107084931.GB19617@paraplu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f84608d0-7080-d476-e1d6-36c9643493bd@redhat.com>
Date: Wed, 7 Nov 2018 10:30:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181107084931.GB19617@paraplu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] Deprecate HMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com

On 2018-11-07 09:49, Kashyap Chamarthy wrote:
> On Mon, Nov 05, 2018 at 12:20:05PM +0100, Thomas Huth wrote:
>> On 2018-10-30 13:35, Kashyap Chamarthy wrote:
>>> Since we're deprecating the QMP `cpu-add`, let's deprecate its HMP
>>> equivalent, too.
>>>
>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> 
> [...]
> 
>>> diff --git a/hmp.c b/hmp.c
>>> index 4975fa56b0..c3f3db7795 100644
>>> --- a/hmp.c
>>> +++ b/hmp.c
>>> @@ -2353,6 +2353,8 @@ void hmp_cpu_add(Monitor *mon, const QDict *qdict)
>>>      int cpuid;
>>>      Error *err = NULL;
>>>  
>>> +    error_report("cpu_add is deprecated, please use device_add instead");
>>> +
>>>      cpuid = qdict_get_int(qdict, "id");
>>>      qmp_cpu_add(cpuid, &err);
>>>      hmp_handle_error(mon, &err);
>>>
>>
>> I think you should also mention this explicitly in qemu-deprecated.texi,
>> too.
> 
> I think you mean I should explicitly mention that the HMP equivalent is
> also deprecated -- currently I only call out the QMP command:
> 'qemu-deprecated.texi'.
> 
> I saw that Eduardo already queued this series; maybe I can add a
> follow-up if it can't be tweaked before submitting a pull request.

Yes, a follow-up patch is perfectly fine for this.

 Thanks,
  Thomas
