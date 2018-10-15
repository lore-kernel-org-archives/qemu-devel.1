Received: from eggs.gnu.org ([2001:4830:134:3::10]:49534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gC7wI-0001U3-8t
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gC7wD-0005ls-T9
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:50:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gC7wD-0005lK-HS
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:49:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9FIdJIM041052
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 14:49:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2n4w9j0dmn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 14:49:55 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 15 Oct 2018 19:49:53 +0100
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
	<CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
	<20181015101309.GD10459@localhost.localdomain>
	<87woqjw4o3.fsf@dusky.pond.sub.org>
	<d1335244-1aaa-a6e6-e27f-a4de6a38a785@de.ibm.com>
	<20181015183348.GS31060@habkost.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 15 Oct 2018 20:49:46 +0200
MIME-Version: 1.0
In-Reply-To: <20181015183348.GS31060@habkost.net>
Content-Language: en-US
Message-Id: <8b45171f-3686-cda6-8e04-de6d46af355d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 10/15/2018 08:33 PM, Eduardo Habkost wrote:
> On Mon, Oct 15, 2018 at 08:19:18PM +0200, Christian Borntraeger wrote:
[...]

>>>>
>>>> It's easier to port stuff to Python 3 though than making them work with
>>>> both. I think Eduardo's RFC is in part motivated by a patch from
>>>> Philippe that converted something in iotests to work with Python 3,
>>>> passed review and then turned out to break Python 2.
>>>
>>> Seconded.  This is not about the cost of maintaining existing
>>> compatibility gunk, it's about the extra effort to first get the
>>> remainder to work with 2 and 3, only to throw away 2 a few months later.
>>>
>>> I propose we permit ourselves to port stuff that isn't essential to
>>> building QEMU straight to 3 instead.  This includes iotests.
>>>
>>>> Having to test every iotests patch twice with different Python versions
>>>> isn't something I would like to do for extended periods of time.
>>>
>>> It's worth doing only if the benefits of doing it outweigh the costs.  I
>>> don't think they do.
>>
>> FWIW, I do not care about python 2 vs 3. I just want to emphasize that I 
>> consider the qemu iotest a very valuable part of the qemu test suite as it
>> has detected a lot of regressions over the past years. So as long as we keep
>> that running I am fine.
> 
> It depends where exactly one needs to keep them running.  Does
> anybody need to run iotests for QEMU 3.0+ builds in systems where
> it's impossible to install Python 3?

I run that as a regression package. Most distros seems to be fine,
with RHEL7 being the problematic case. But for upstream testing on a redhat
like distro fedora is good enough. 
> 
> If somebody really needs that, then I'd kindly ask them to
> volunteer to do the extra work to make iotests compatible with
> both Python 2 and 3.

As I said. As long as things continue to work on a resonably new distro
things are ok.
