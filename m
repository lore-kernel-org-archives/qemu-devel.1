Received: from eggs.gnu.org ([2001:4830:134:3::10]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fxTWK-0002G0-Tu
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fxTLS-0005CR-ML
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:39:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fxTLQ-000547-MX
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 04:39:24 -0400
Date: Wed, 5 Sep 2018 09:39:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180905083916.GE3026@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180904123603.10016-1-berrange@redhat.com>
	<907dd14c-0707-3153-bd35-da0ee5ed3bdf@redhat.com>
	<CAFEAcA_n_Ah87Z7E5xBuSXr8-==ZD8hF4A8kUMqNDmqB_zZRjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_n_Ah87Z7E5xBuSXr8-==ZD8hF4A8kUMqNDmqB_zZRjg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] configure: preserve various environment
 variables in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On Tue, Sep 04, 2018 at 10:16:26PM +0100, Peter Maydell wrote:
> On 4 September 2018 at 17:21, Eric Blake <eblake@redhat.com> wrote:
> > I still find it odd
> > that we aren't precisely mirroring the (nice!) semantics that autoconf users
> > have come to rely on
> 
> I think that's more the result of (a) most people don't know the
> details of the autoconf semantics and (b) configure works well-enough
> that nobody spends more time messing with it than they need to. I think
> as an aspiration "behave like an autoconf configure script" is
> probably a sensible goal.

autoconf is so complex that we'll never have behavioural parity with it,
unless we actually rewrite QEMU to use autoconf, but I'm not really
going to advocate that. If there are easy changes we can do to make it
look a little more like autoconf, that's fine, but I wouldn't spend any
non-trivial amount of time on it as there's better uses of our time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
