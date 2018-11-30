Received: from eggs.gnu.org ([2001:4830:134:3::10]:37583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSlAL-0001sh-C3
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSlAI-0000nj-2a
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:57:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSlAH-0000nH-Ss
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:57:14 -0500
References: <20181129100340.13823-1-fli@suse.com>
	<4031aa35-a9f0-dd87-ad2a-0cc35546f7af@redhat.com>
	<27e46dfa-f874-8b20-7522-f933d0dda897@suse.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f774e48-892a-de5b-74d2-2a1694e6022f@redhat.com>
Date: Fri, 30 Nov 2018 09:57:12 -0600
MIME-Version: 1.0
In-Reply-To: <27e46dfa-f874-8b20-7522-f933d0dda897@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1? RFC v2 0/5] fix some segmentation
 faults and migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 11/30/18 12:15 AM, Fei Li wrote:
>=20
>=20
> On 11/29/2018 10:20 PM, Eric Blake wrote:
>> On 11/29/18 4:03 AM, Fei Li wrote:
>>> These five patches almost get the Reviewed-by and are extracted from
>>> previous "[PATCH RFC v7 0/9] qemu_thread_create: propagate errors to
>>> callers to check."=C2=A0 The mentioned patch series have waited on on=
e
>>> multifd issue for a while and still needs a further discussion.
>>>
>>> Thus separate(send) these five almost-done patches and hope they can
>>> be merged for the next tag. Thanks for the review. :)
>>
>> How likely are any of these crashers to affect an end user?=20
> IMHO, they are not easily triggered.

A crash at the command line is annoying, but not too bad (because you=20
didn't start the guest after all).  A crash after the guest has been=20
running for some time, though, is worth considering (data loss should be=20
avoided).  I won't make the final determination on this series, but hope=20
that my questions are helpful to the maintainers for this code in=20
ranking the severity of these crashes.

>> Are any of them regressions over 3.0?
> I do not think so.
>> I'm trying to gauge if any of this is serious enough to warrant a=20
>> -rc4, or if we are okay just documenting them as known corner-case=20
>> bugs and deferring the fix to 4.0 and qemu-stable.
> Emm, actually not so emergency to be included in -rc4.
> And I think it is ok to wait for maintainers to do the pick for the=20
> appropriate release.
> BTW, why 4.0, but not 3.2 or 3.3 (I mean 3.minor version)?

See https://www.qemu.org/download/ for the explanation on version numberi=
ng

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
