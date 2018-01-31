Received: from eggs.gnu.org ([2001:4830:134:3::10]:32855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egscc-0003Pd-VQ
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egscT-0003JD-Fs
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:40:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1egscT-0003HM-6R
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:40:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0VDd4wd105666
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:40:06 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fuc88fusd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:40:06 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 31 Jan 2018 13:40:04 -0000
References: <20180130133828.77336-1-borntraeger@de.ibm.com>
	<20180130133828.77336-2-borntraeger@de.ibm.com>
	<fb70731d-b857-8adb-0dc7-cd072a2c50b1@redhat.com>
	<34c2cdf6-b773-61b6-64de-943cb2cf8ace@de.ibm.com>
	<CAFEAcA9yaR2Ha4-8cSgO7dsCZaZVayyOuO7MGcQpZNa1C6K6uA@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 31 Jan 2018 14:40:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9yaR2Ha4-8cSgO7dsCZaZVayyOuO7MGcQpZNa1C6K6uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <181748c7-c6e3-56b8-4aad-8c93cf4ebe08@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] Fix configure for s390 qemu on
 alpine and other busybox environments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alice Frosi <alice@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On 01/31/2018 01:51 PM, Peter Maydell wrote:
> On 31 January 2018 at 12:14, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> On 01/30/2018 04:41 PM, Eric Blake wrote:
>>> On 01/30/2018 07:38 AM, Christian Borntraeger wrote:
>>>> +++ b/configure
>>>> @@ -1906,9 +1906,9 @@ int main(int argc, char *argv[]) {
>>>>  EOF
>>>>
>>>>  if compile_object ; then
>>>> -    if grep -q BiGeNdIaN $TMPO ; then
>>>> +    if strings -a $TMPO | grep -q BiGeNdIaN ; then
>>>>          bigendian="yes"
>>>> -    elif grep -q LiTtLeEnDiAn $TMPO ; then
>>>> +    elif strings -a $TMPO | grep -q LiTtLeEnDiAn ; then
>>>
>>> Yes, this is indeed a more portable way to grep binary files (it's also
>>> possible to do:
>>>
>>> tr -d '\0' < $TMPO | grep -q ...
>>>
>>> if we're worried about the availability of strings, but I don't see that
>>> being a problem if no one reports it actually failing).
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Peter, does that patch work on MacOS and Windows? If yes we could
>> get this patch in via the s390 tree.
> 
> I haven't tested but I think it should be fine. OSX provides
> a strings binary that supports -a, and Windows cross-builds
> so it will use the Linux strings.
> 
> thanks
> -- PMM
> 

Conny, can you take this patch via s390-next?
