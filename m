Received: from eggs.gnu.org ([2001:4830:134:3::10]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f735g-0002LO-7b
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f735d-0002eo-0t
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:06:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
	<df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
	<f3d7c3d0-26fe-37db-abb3-0e99373ae315@redhat.com>
	<6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb58d12d-92b3-2a68-af10-f8f5608f5237@amsat.org>
Date: Fri, 13 Apr 2018 15:06:12 -0300
MIME-Version: 1.0
In-Reply-To: <6b294d1a-5f3b-aa9c-c0e4-db9da04c4548@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 04/13/2018 01:59 PM, Halil Pasic wrote:
>>> On 04/13/2018 04:30 PM, Thomas Huth wrote:
>>>> "size_t" should be an unsigned type - the signed counterpart is called
>>>> "ssize_t" in the C standard instead. Thus we should also use this
>>> The first sentence sounds like ssize_t is too a type defined by some
>>> C standard. Is it or does ssize_t come form somewhere else?
>> Arrr, seems like ssize_t is rather coming from POSIX than from the C
>> standard, thanks for the hint. I'll rephrase the first sentence to:
>>
>> "size_t" should be an unsigned type according to the C standard, and
>> most libc implementations provide a signed counterpart called "ssize_t".
>>
>> OK?
>>
> 
> This ssize_t seems to be an rather interesting type. For instance POSIX says
> """
> size_t
>     Used for sizes of objects.
> ssize_t
>     Used for a count of bytes or an error indication.
> """
> and
> """
> The type ssize_t shall be capable of storing values at least in the range [-1, {SSIZE_MAX}].
> """
> 
> And it does not mandate SSIZE_MIN in limits (but of course mandates SSIZE_MAX.
> 
> I don't like this 'counterpart' word here, because AFAIU these don't have to
> be counterparts in any sense. That is SSIZE_MAX << SIZE_MAX is possible for
> example. I'm not sure about the every positive has a negative thing, but
> that's not important here.
> 
> The code in question kind of uses both signed and unsigned size for
> the same (the string). We even have a signed to unsigned comparison which
> could result in warnings. I still think the change is OK in practice, but
> maybe avoiding introducing ssize_t (until we really need it) is a better
> course of action. I think uitoa can be easily rewritten so it does not
> need the ssize_t.
> 
> How about that?

This seems clever indeed.
