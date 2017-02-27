Received: from eggs.gnu.org ([2001:4830:134:3::10]:56476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciII0-0000hR-Dl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciIHz-0003Re-59
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:12:20 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciIHy-0003RK-TF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:12:19 -0500
Received: by mail-wr0-x236.google.com with SMTP id u108so18758023wrb.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 02:12:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227010528.GM17615@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
	<20170223224911.GC17615@umbus.fritz.box>
	<20170224001613.GG17615@umbus.fritz.box>
	<CAFEAcA9V_1NA6-JgZd7Pc1hwih+uBKBrt4MPi4+kPWRu-xduPA@mail.gmail.com>
	<20170227010528.GM17615@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 10:11:57 +0000
Message-ID: <CAFEAcA9rR8X1Hg=w5FfYsoVSYjZYQAt+MaURKJ82mTyYohJOBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] using fdt_setprop() to set properties to empty
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 01:05, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Feb 24, 2017 at 10:35:35AM +0000, Peter Maydell wrote:
>> On 24 February 2017 at 00:16, David Gibson <david@gibson.dropbear.id.au> wrote:
>> > Ok, I've pushed libfdt upstream patches to (a) make passing NULL to
>> > setprop() with zero length explicitly safe and (b) add an
>> > fdt_setprop_empty() helper macro.  Do you want me to make a pullreq to
>> > update the qemu submodule?
>>
>> Yes, please. Are we OK with using a random libfdt commit or do
>> we update only to proper release tags?
>
> I'm find with a random SHA, but that's not really my department - I'm
> upstream libfdt maintainer, but update policy in the qemu tree seems
> like a qemu side decision.
>
>> There's no real rush with
>> this so if you have a release due shortly it might be better
>> to wait for that.
>
> dtc/libfdt releases are a rather haphazard affair.  Usually they
> happen when somebody complains that there hasn't been a release with
> some feature they want.  Our tests are both fast to run and have
> reasonaably good coverage, so random commits are usually good.  So a
> "release" is usually just slapping a new version number onto whatever
> is in master and making a tag and tarball.

>From my end I think we'd rather use a proper release version
(if only because it's then easier to refer to and to state
as a dependency for packaged versions if required). It looks
like we've done that for our previous updates (starting
with 1.3.0 and then moving to 1.4.0 and 1.4.2) so I think
we should continue using released versions.

thanks
-- PMM
