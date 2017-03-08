Received: from eggs.gnu.org ([2001:4830:134:3::10]:58485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clYhe-0006oc-Ul
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clYhb-0002hN-P1
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:20:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1clYhb-0002gw-Fw
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:20:15 -0500
Date: Wed, 8 Mar 2017 10:20:09 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170308102009.GF7470@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Mar 08, 2017 at 09:26:00AM +0100, Thomas Huth wrote:
> 
>  Hi everybody,
> 
> what will be the next version of QEMU after 2.9? Will we go for a 2.10
> (as I've seen it mentioned a couple of times on the mailing list
> already), or do we dare to switch to 3.0 instead?
> 
> I personally dislike two-digit minor version numbers like 2.10 since the
> non-experienced users sometimes mix it up with 2.1 ... and there have
> been a couple of new cool features in the past releases that would
> justify a 3.0 now, too, I think.

If we need to debate whether to switch major version numbers, it is a sign
we should set out a clearer policy on version numbering :-)

AFAIK, QEMU's never documented semantics for changes in the major number
part of the version. I don't think the 1.0 or 2.0 releases were particularly
significant in what they introduced/changed, as opposed to many of the .x
releases. It was a fairly arbitrary decision to bump the major version.

libvirt suffered similar lack of clarity around when to bump major version
number as opposed to minor version. To address this we recently adopted the
rule[1] that major version number changes have no relation to features. The
major number is simply incremented at the start of each calendar year.

> But anyway, the more important thing that keeps me concerned is: Someone
>  once told me that we should get rid of old parameters and interfaces
> (like HMP commands) primarily only when we're changing to a new major
> version number. As you all know, QEMU has a lot of legacy options, which
> are likely rather confusing than helpful for the new users nowadays,
> e.g. things like the "-net channel" option (which is fortunately even
> hardly documented), but maybe also even the whole vlan/hub concept in
> the net code, or legacy parameters like "-usbdevice". If we switch to
> version 3.0, could we agree to remove at least some of them?

This would, by inference, say that increments of major part of the version
number indicate backwards incompatible changes in QEMU API.

That is certainly one option for a rule around major version number changes
but is not one QEMU seems to have traditionally followed. The release notes
show plenty of incompatible changes in arbitrary .x releases.

>From the POV of libvirt, I don't think saying that .0 releases have
incompatible changes is particularly useful in itself. What *is* useful
is to have a clear rule around a deprecation cycle. ie, a rule that says
a feature will be marked deprecated for 3 releases or 12 months, before it
is permitted to be removed/changed. If that were followed, there is no
need to batch up such changes in a .0 release IMHO.

Regards,
Daniel

[1] http://libvirt.org/downloads.html#numbering
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
