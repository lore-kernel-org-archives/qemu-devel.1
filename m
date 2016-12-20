Received: from eggs.gnu.org ([2001:4830:134:3::10]:45532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cJNbh-0007pv-KV
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cJNbd-0007CU-Kc
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:49:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cJNbd-00079f-Ez
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:49:37 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C5AC91D2F
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 16:49:35 +0000 (UTC)
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-16-git-send-email-ehabkost@redhat.com>
	<df0f3ade-bd09-58a0-ac83-3775d4ab7c6c@redhat.com>
	<20161205235745.GJ13060@thinpad.lan.raisama.net>
	<20161216160236.GA964730@orkuz.home>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5ce94d10-dfa9-39d7-a77f-3ab5cb7584e5@redhat.com>
Date: Tue, 20 Dec 2016 17:49:32 +0100
MIME-Version: 1.0
In-Reply-To: <20161216160236.GA964730@orkuz.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 15/17] target-i386: Define static
 "base" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

Am 16.12.2016 um 17:02 schrieb Jiri Denemark:
> On Mon, Dec 05, 2016 at 21:57:45 -0200, Eduardo Habkost wrote:
>> On Mon, Dec 05, 2016 at 07:18:47PM +0100, David Hildenbrand wrote:
>>> Am 02.12.2016 um 22:18 schrieb Eduardo Habkost:
>>>> The query-cpu-model-expand QMP command needs at least one static
>>>> model, to allow the "static" expansion mode to be implemented.
>>>> Instead of defining static versions of every CPU model, define a
>>>> "base" CPU model that has absolutely no feature flag enabled.
>>>>
>>>
>>> Introducing separate ones makes feature lists presented to the user much
>>> shorter (and therefore easier to maintain). But I don't know how libvirt
>>> wants to deal with models on x86 in the future.
>>
>> I understand that having a larger set of static models would make
>> expansions shorter. But I worry that by defining a complete set
>> of static models on x86 would require extra maintenance work on
>> the QEMU side with no visible benefit for libvirt.
>>
>> I would like to hear from libvirt developers what they think. I
>> still don't know what they plan to use the type=static expansion
>> results for.
>
> Currently we are mostly interested in the expansion of the "host" CPU
> model. We're fine with the expansion based on the "basic" static model
> with no features. Returning some real model instead of "basic" would be
> OK as long as it would be one of the existing CPU models. Adding special
> static models, such as Broadwell-base would actually be a complication

I agree, mixing names would be confusing. So if we would want to 
introduce static CPU models for x86 in QEMU, they would have to be named
exactly like the libvirt models and contain the exact same feature set.

> since we would need to provide some translation to the existing models
> for backward compatibility. I'd appreciate if we could avoid doing this.

Right and translation would only confuse people, especially if the CPU
models in libvirt and QEMU behave differently.

>
> Jirka
>


-- 

David
