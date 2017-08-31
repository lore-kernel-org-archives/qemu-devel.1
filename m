Received: from eggs.gnu.org ([2001:4830:134:3::10]:49089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNF1-0004FP-TW
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnNEy-0006W7-1x
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:02:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnNEx-0006Vr-SC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:02:27 -0400
Date: Thu, 31 Aug 2017 12:02:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831110222.GH17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<20170831104710.GG17315@redhat.com>
	<CAFEAcA9pk5n7z5PkLDeuLdvknPmzHqcGtG6in1E9-+BwjVOqTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9pk5n7z5PkLDeuLdvknPmzHqcGtG6in1E9-+BwjVOqTg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Aug 31, 2017 at 11:55:18AM +0100, Peter Maydell wrote:
> On 31 August 2017 at 11:47, Daniel P. Berrange <berrange@redhat.com> wrote:
> > If we can update to python 2.7 as our minimum, then supporting py2
> > and py3 gets simpler, avoiding some of the nastier hacks, even
> > without that though it isn't too hard.
> 
> Unfortunately RHEL6 is what's holding us to retaining 2.6
> support, and googling suggests that doesn't go EOL until 2020...

Who is actually requiring that we support RHEL6 until EOL though ?

AFAIK, from Red Hat side, we don't need QEMU git master to be buildable
on RHEL-6 machines anymore, since QEMU there is long since in bug-fix
only mode, no rebases or feature backports.

I assume there's probably some community interest in building git master
on RHEL-6, but I think it is reasonable for us to say no at some point,
rather than waiting until final EOL (2020 for normal subscribers, 2024
for people who paid for extended lifetime).

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
