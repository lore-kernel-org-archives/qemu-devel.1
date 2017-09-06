Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dphk9-0002tg-Dn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dphk6-0003rz-9z
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:20:17 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:37525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dphk6-0003rO-2V
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 17:20:14 -0400
Received: by mail-pg0-x231.google.com with SMTP id d8so17314902pgt.4
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 14:20:13 -0700 (PDT)
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-12-david@redhat.com>
	<2c620927-0406-2fc1-895c-09ffc2e44a4e@linux.vnet.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b3e9c2b-4cb7-fdf8-5f9b-ff7ebbf52d1e@linaro.org>
Date: Wed, 6 Sep 2017 14:20:09 -0700
MIME-Version: 1.0
In-Reply-To: <2c620927-0406-2fc1-895c-09ffc2e44a4e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/19] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com

On 09/06/2017 11:16 AM, Matthew Rosato wrote:
> On 09/04/2017 11:43 AM, David Hildenbrand wrote:
>> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
>> guest tries to bring these CPUs up but fails), because we don't support
>> multiple CPUs on s390x under TCG.
>>
>> Let's bail out if more than 1 is specified, so we don't raise people's
>> hope. Make it a define, so we can easily bump it up later.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Makes sense.  Ran the described environment without this patch (errors)
> and again with this patch (graceful exit w/ message).
> 
> Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Can someone review

  http://patchwork.ozlabs.org/patch/760010/

which does at least start to add the SIGP support.

Once tcg can bring up 2 cpus, I see no reason it couldn't bring up N.  I don't
see the point of the define.


r~
