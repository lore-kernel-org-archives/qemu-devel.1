Received: from eggs.gnu.org ([2001:4830:134:3::10]:49744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clxGA-00024q-Dg
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1clxG6-0005so-Ck
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:33:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1clxG6-0005sf-4s
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:33:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<20170308112441.GI7470@redhat.com>
Date: Thu, 09 Mar 2017 13:33:26 +0100
In-Reply-To: <20170308112441.GI7470@redhat.com> (Daniel P. Berrange's message
	of "Wed, 8 Mar 2017 11:24:41 +0000")
Message-ID: <87bmtavdd5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Wed, Mar 08, 2017 at 12:22:24PM +0100, Thomas Huth wrote:
>> On 08.03.2017 11:03, Peter Maydell wrote:
>> > On 8 March 2017 at 09:26, Thomas Huth <thuth@redhat.com> wrote:
>> >> But anyway, the more important thing that keeps me concerned is: Someone
>> >>  once told me that we should get rid of old parameters and interfaces
>> >> (like HMP commands) primarily only when we're changing to a new major
>> >> version number. As you all know, QEMU has a lot of legacy options, which
>> >> are likely rather confusing than helpful for the new users nowadays,
>> >> e.g. things like the "-net channel" option (which is fortunately even
>> >> hardly documented), but maybe also even the whole vlan/hub concept in
>> >> the net code, or legacy parameters like "-usbdevice". If we switch to
>> >> version 3.0, could we agree to remove at least some of them?
>> > 
>> > I think if we are going to deprecate and remove options we need
>> > a clear transition plan for doing so, which means at least one
>> > release where options are "still works, but warn that they
>> > are going away with pointer to documentation or similar info
>> > about their replacement syntax", before actually dropping them.
>> 
>> Yes, that's certainly a good idea. But as Daniel suggested in his mail,
>> I think we should also have the rule that the option should be marked as
>> deprecated in multiple releases first - so that the users have a chance
>> to speak up before something gets really removed (otherwise the option
>> could be removed right on the first day after the initial release with
>> the deprecation message, so there is no time for the user to notice this
>> and complain). Not sure whether we need three releases, as Daniel
>> suggested, though, but if that's common sense, that's fine for me, too.
>
> FYI, I didn't put any thought into my 3 releases / 12 months numbers. I
> just arbitrarily picked them out of the hat, so don't consider it my
> endorsement of that particular length of time :-) I think 2 is the minimum
> number of releases we should deprecate for, beyond that, I'm open minded

I don't think a hard rule for the grace period makes sense.  It really
depends.  A guideline like "normally 12 months" is of course fine.
