Received: from eggs.gnu.org ([2001:4830:134:3::10]:35033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f95jt-0001r9-5h
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f95jo-0002UJ-7v
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:20:25 -0400
Date: Thu, 19 Apr 2018 11:20:17 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180419092017.olujzxzlwvjlt6en@sirius.home.kraxel.org>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418144538.4aa2f492.cohuck@redhat.com>
	<20180418125545.GN27579@redhat.com>
	<87sh7rvf27.fsf@dusky.pond.sub.org>
	<20180419093024.27c77433.olaf@aepfle.de>
	<20180419075958.GD10259@redhat.com>
	<CAFEAcA9UYM3hifEbs_sp9jcFkwu5sSSXaLq9CLWuhNbV67+MBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9UYM3hifEbs_sp9jcFkwu5sSSXaLq9CLWuhNbV67+MBQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> Well, it depends. You might be stuck with an old distro because
> some software you want to run depends on it, but also want to run
> newer versions of some programs like QEMU. If you're in that
> boat you can probably live with having to also compile a newer
> version of glib to go with your newer QEMU, though.

Core libraries like glib might not be that easy, I've seen updating glib
breaking apps in the past.

For stuff like spice where qemu and spice clients are pretty much the
only users it is alot more reasonable to say "well, just update
$dependency too if you want run cutting edge qemu."

cheers,
  Gerd
