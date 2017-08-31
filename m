Received: from eggs.gnu.org ([2001:4830:134:3::10]:56341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dnPQZ-00062u-Q6
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dnPQV-0003bV-Iv
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1dnPQV-0003b3-AU
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:22:31 -0400
Date: Thu, 31 Aug 2017 15:22:24 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170831132224.kz7i7jmentdtlvv3@eukaryote>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<20170831104710.GG17315@redhat.com>
	<CAFEAcA9pk5n7z5PkLDeuLdvknPmzHqcGtG6in1E9-+BwjVOqTg@mail.gmail.com>
	<20170831110222.GH17315@redhat.com>
	<874lsnnbxx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lsnnbxx.fsf@dusky.pond.sub.org>
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Michael <fedora.dm0@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, Aug 31, 2017 at 02:44:58PM +0200, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > On Thu, Aug 31, 2017 at 11:55:18AM +0100, Peter Maydell wrote:
> >> On 31 August 2017 at 11:47, Daniel P. Berrange <berrange@redhat.com> wrote:
> >> > If we can update to python 2.7 as our minimum, then supporting py2
> >> > and py3 gets simpler, avoiding some of the nastier hacks, even
> >> > without that though it isn't too hard.
> >> 
> >> Unfortunately RHEL6 is what's holding us to retaining 2.6
> >> support, and googling suggests that doesn't go EOL until 2020...
> >
> > Who is actually requiring that we support RHEL6 until EOL though ?
> >
> > AFAIK, from Red Hat side, we don't need QEMU git master to be buildable
> > on RHEL-6 machines anymore, since QEMU there is long since in bug-fix
> > only mode, no rebases or feature backports.
> 
> Even in the unlikely case that a bug fix involves backporting some
> Python, having to port just those bits to RHEL-6's version of Python
> would be less work than making *all* upstream Python code work with both
> Python dialects.
> 
> > I assume there's probably some community interest in building git master
> > on RHEL-6, but I think it is reasonable for us to say no at some point,
> > rather than waiting until final EOL (2020 for normal subscribers, 2024
> > for people who paid for extended lifetime).
> 
> "Interest" by itself doesn't pay bills or write code.
> 
> If you have to have upstream QEMU on RHEL-6, and you're fine with
> getting it by building it yourself (there being no other way), then you
> should also be fine with getting its build requirements.  Python 3.4 is
> in EPEL.

That sounds like a good argument (to ditch Python 2.6) to me -- EL-6
users getting it from EPEL[*], one of its purposes is to facilate cases
exactly like the one above.

[*] https://fedoraproject.org/wiki/EPEL

-- 
/kashyap
