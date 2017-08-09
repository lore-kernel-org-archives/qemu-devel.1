Received: from eggs.gnu.org ([2001:4830:134:3::10]:47587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfQo4-0001bK-3U
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfQo0-0005bh-Uf
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dfQo0-0005bK-No
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:13:48 -0400
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-6-david@redhat.com>
	<20170809150105.66c970c0.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d45182f4-6625-9f14-a797-b67d3343a0b6@redhat.com>
Date: Wed, 9 Aug 2017 15:13:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170809150105.66c970c0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/6] target/s390x: add basic MSA features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, borntraeger@de.ibm.com

On 09.08.2017 15:01, Cornelia Huck wrote:
> On Fri, 21 Jul 2017 14:56:08 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> Finally got around to that one...
> 
>> The STFLE bits for the MSA (extension) facilities simply indicate that
>> the respective instructions can be executed. The QUERY subfunction can then
>> be used to identify which features exactly are available.
>>
>> Availability of subfunctions can also vary on real hardware. For now, we
>> simply implement a CPU model without any available subfunctions except
>> QUERY (which is always around).
>>
>> As all MSA functions behave quite similarly, we can use one translation
>> handler for now. Prepare the code for implementation of actual subfunctions.
> 
> Sounds reasonable.
> 
>>
>> At least MSA is helpful for now, as older Linux kernels require this
>> facility when compiled for a z9 model. Allow to enable the facilities
>> for the qemu cpu model.
> 
> Do you remember which kernels?

Basically everything before kernel version 4.13 - the patch to lift this
requirement has just been merged very recently:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8aa8680aa383bf6e2ac2a7d3369097268c75f7da

 Thomas
