Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1coSap-0003k8-Mr
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1coSam-00031g-IQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:25:15 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu.bugs@whitewinterwolf.com>)
	id 1coSam-00031F-BM
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:25:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Mar 2017 11:25:04 +0100
From: Simon <qemu.bugs@whitewinterwolf.com>
In-Reply-To: <CAFEAcA-WzT80S_NJb8rSALspBZcCQbT7eounFn9HusjtLWoi_Q@mail.gmail.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
	<23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
	<CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
	<20170315180822.GU7770@redhat.com>
	<CAFEAcA-WzT80S_NJb8rSALspBZcCQbT7eounFn9HusjtLWoi_Q@mail.gmail.com>
Message-ID: <c3873903f70d3f7c2b4a4d5a8820d8a9@whitewinterwolf.com>
Subject: Re: [Qemu-devel] [Bug 1217339] [PATCH] Unix signal to send
 ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

> Why can't we use SIGHUP, again?

I suppose for all those people who use non ACPI-aware guests in non
daemonized Qemu instances and usually close their terminal without
stopping Qemu first on the assumption that Qemu will stop itself
automatically: this wouldn't work anymore...

More seriously, Qemu is a very versatile piece of software. I can only
rely on the word of experienced Qemu maintainers who have a better view
than me on the general Qemu user-base to determine whether a change of
SIGHUP handling will have a negative effect or not.

Using SIGHUP was my initial proposition and is the easy way to go.

In case it is determined that this would have too much side effects and
that no other signal is usable, the only other way I see is to add a new
command-line option to let users select Qemu behavior.

Regards,
Simon.
