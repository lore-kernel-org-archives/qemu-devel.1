Received: from eggs.gnu.org ([209.51.188.92]:34199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QaW-000408-Fk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3QZl-0007Z4-1z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:27:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3QZk-0007YY-Kb
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:27:04 -0400
References: <20190311101428.GA11@765644dd90e5>
	<20190311103029.GF16@765644dd90e5>
	<1ab60a5e-bb20-5b13-6ddf-ebb8e28b3a08@vivier.eu>
	<CAGZZdDFXPkS__qyHCYbEdNz+0jY_MorSux3HAJnpi7pxTUN07g@mail.gmail.com>
	<ef1bf7aa-cbca-37a0-5885-b3838c9c81cd@vivier.eu>
	<CAGZZdDE6ZWr0g-8PHWwvg=9vyEo+GR_T1VONEo9GQEbZWn3m+w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0364042d-b710-0ee0-aca7-da2f83618120@vivier.eu>
Date: Mon, 11 Mar 2019 20:26:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAGZZdDE6ZWr0g-8PHWwvg=9vyEo+GR_T1VONEo9GQEbZWn3m+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 7/10] qemu-binfmt-conf.sh: generalize
 CPU to positional TARGETS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: unai.martinezcorral@ehu.eus
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>

On 11/03/2019 20:23, Unai Martinez Corral wrote:
> 2019/3/11 a las 14:36, Laurent Vivier:
>> On 11/03/2019 14:29, Unai Martinez Corral wrote:
>>> 2019/3/11 12:14, Laurent Vivier:
>>>> On 11/03/2019 11:30, Unai Martinez-Corral wrote:
>>>
>>>>> +-s|--systemd:                         don't write into /proc, generate file(s) for
>>>>> +                                      systemd-binfmt.service; environment variable HOST_ARCH
>>>>
>>>> why HOST_ARCH appears here?
>>>
>>> The existing comment seems to be specific to systemd:
>>> https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh#L201-L204
>>> 'systemd' is the single mode in which it makes sense to generate a
>>> bunch of configuration files for a different architecture than the
>>> current one, isn't it?
>>
>> No, it's not specific to systemd. If we register an interpreter for the
>> current architecture we can make it unusable.
> 
> I think we are not understanding each other in this point:
> 
> The comment about HOST_ARCH in the current master branch is as follows:
> 
>> With systemd, binfmt files are loaded by systemd-binfmt.service
>>
>> The environment variable HOST_ARCH allows to override 'uname' to generate
> configuration files for a different architecture than the current one.
> 
> That's why I assumed that the envvar is meant to be used with systemd
> only. Certainly, withou systemd no configuration files are generated
> at all; interpreters are directly registered/configured.
> 
> However, the implementation takes HOST_ARCH into account with no
> regard to 'systemd' or 'debian'. It is used unconditionally. This has
> been like this since the base of the current script was pushed in
> 2016/1/29.
> 
> So, what is your proposal?
> 
> - Move the comment below, as it was before.

Yes, move the comment below as it was before.

Thanks,
LAurent
