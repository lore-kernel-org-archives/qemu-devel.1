Received: from eggs.gnu.org ([2001:4830:134:3::10]:58285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnPXu-0000Tz-M0
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnPXs-00064i-KI
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:30:10 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:35391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnPXs-00063v-Di
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:30:08 -0400
Received: by mail-wm0-x230.google.com with SMTP id v2so4924349wmf.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 06:30:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2vrlwr3.fsf@dusky.pond.sub.org>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<87r2vrlwr3.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 14:29:46 +0100
Message-ID: <CAFEAcA8nL+_J8jJfamaUEfmo9b2Wox-wU4o_Mpz1fA00TXGT4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 31 August 2017 at 13:58, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 31 August 2017 at 07:35, Markus Armbruster <armbru@redhat.com> wrote:
>>> So, first we'll invest in work-arounds to make both 2 and 3 work.  Once
>>> 2 is gone, we can invest some more to clean them up.  Which probably
>>> won't happen, so we'll continue to carry work-arounds that no longer
>>> make sense.
>>>
>>> I maintain roughly one fourth of all Python code in qemu, and I'm not
>>> looking forward to this hoop-jumping at all.
>>>
>>> Are we really, really sure we want to go this way?  What exactly are we
>>> hoping to accomplish by it?
>>
>> My take is that we have the following goals we want to achieve:
>>
>> (1) We need to continue to build and run on older (long-term-support)
>> distros that still ship only Python 2.x (alas even back to 2.6)
>
> That's an assertion, not an answer to my question :)
>
> What exactly are we hoping to accomplish by supporting what distros
> exactly?

Of my current build-test machines:
 OSX is python 2.7
 Ubuntu 16.04 (s390) has both 2.7 and 3.5
 FreeBSD 11.0 has python 2.7 but I could install 3.3
 OpenBSD 6.0 has python 2.7 but I could install 3.5
 NetBSD 7.1 has python 2.7 but I could install 3.6
 The ppc64 box is Centos 7 which has python 2.7 but
  I could ask the admins to install 3.4
 The aarch64 box is Ubuntu 14.04 and has 2.7 and 3.4

So OSX is the major laggard in having no official Python 3 at all,
but the majority still seem to have their stock python be a version
2, even if a version 3 is optionally available.

Last time we discussed Python versions (in 2015) the
three cited reasons for 2.6 were RHEL6, SLES 11, and
OSX 10.6. We can maybe move forward to 2.7 (RHEL6
apparently has a 2.7 backport, I think our two or three
OSX 10.6 users can cope with installing a 2.7 from homebrew,
and I dunno what the SLES11 situation is). I don't think
we should move further forward than that yet, I don't see
the need.

>> I think (1) is pretty clearly not (yet) an empty set, so the
>> only alternative I see to "support 2 and 3 now" is "keep supporting
>> only 2 for the moment and hope that no distro drops 2 support
>> before all the LTS 2-only distro versions vanish into history".
>
> I don't buy the "clearly" in "pretty clearly not (yet) an empty set",
> because I don't understand *why* we need to support "older
> (long-term-support) distros".

I like that you can build QEMU on a lot of distros without
having to install from source a whole pile of dependent
libraries and tools. I think that's a service to our users
(and to the distros that we run on) which we shouldn't give
up without a good reason.

thanks
-- PMM
