Received: from eggs.gnu.org ([2001:4830:134:3::10]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHpW9-0008MZ-Lz
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHpW4-0001d7-MT
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:18:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHpW4-0001bo-Gq
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:18:00 -0500
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
Date: Thu, 23 Nov 2017 12:17:54 +0100
MIME-Version: 1.0
In-Reply-To: <1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 23/11/2017 11:57, Thomas Huth wrote:
> On 23.11.2017 11:17, Peter Maydell wrote:
>> On 23 November 2017 at 10:03, Cornelia Huck <cohuck@redhat.com> wrote:
>>> On Mon, 13 Nov 2017 08:14:28 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> By the way, before everybody now introduces "2.12" machine types ... is
>>>> there already a consensus that the next version will be "2.12" ?
>>>>
>>>> A couple of months ago, we discussed that we could maybe do a 3.0 after
>>>> 2.11, e.g. here:
>>>>
>>>>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
>>>>
>>>> I'd still like to see that happen... Peter, any thoughts on this?
>>>
>>> So, as I just thought about preparing the new machine for s390x as
>>> well: Did we reach any consensus about what the next qemu version will
>>> be called?
>>
>> I haven't seen any sufficiently solid plan to make me want to
>> pick anything except "2.12".
> 
> I still don't think that we need a big plan for this... The change from
> 1.7 to 2.0 was also rather arbitrary, wasn't it?
> 
> Anyway, I've now started a Wiki page to collect ideas:
> 
>  https://wiki.qemu.org/Features/Version3.0
> 
> Maybe we can jump to version 3.0 if there are enough doable items on the
> list that we can all agree upon.
> 
> I've put "--accel kvm:hax:tcg" also on the doable list since I don't
> remember any objections to that idea so far -- feel free to move it to
> the controversial list instead if you think it needs more discussion.

"hax" is very far from feature parity with TCG, it doesn't even support
CPUID (-cpu).  "-accel kvm:hvf:tcg" could be a possibility, but only if
we have resources to test it.  As far as I know the only active x86
developer who owns a Mac is Igor?

Paolo
