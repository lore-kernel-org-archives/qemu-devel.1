Received: from eggs.gnu.org ([2001:4830:134:3::10]:49841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f95LX-0005rx-RO
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f95LQ-0002RG-U4
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:55:15 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:40740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f95LQ-0002Pl-NL
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:55:08 -0400
Received: by mail-ot0-x22a.google.com with SMTP id h8-v6so5019112otj.7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 01:55:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419075958.GD10259@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418144538.4aa2f492.cohuck@redhat.com>
	<20180418125545.GN27579@redhat.com> <87sh7rvf27.fsf@dusky.pond.sub.org>
	<20180419093024.27c77433.olaf@aepfle.de>
	<20180419075958.GD10259@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 09:54:47 +0100
Message-ID: <CAFEAcA9UYM3hifEbs_sp9jcFkwu5sSSXaLq9CLWuhNbV67+MBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 19 April 2018 at 08:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> I wouldn't say people don't care about SLE11 (or other similarly old dist=
ros
> like RHEL-6). Rather the view in libvirt was that if a user is stuck on s=
uch
> an old distro, they are likely doing that because they want the stability
> inherant in running fixed software versions for years. IOW it is unlikely
> that they want the stability of an old distro, combined with cutting edge
> libvirt and/or QEMU.

Well, it depends. You might be stuck with an old distro because
some software you want to run depends on it, but also want to run
newer versions of some programs like QEMU. If you're in that
boat you can probably live with having to also compile a newer
version of glib to go with your newer QEMU, though. I think the
policy as outlined in that libvirt page seems a good one (it's
basically a codification of what we've been doing already), with
a few tweaks -- I think we still believe we support some older
OSX releases, and would want to mention NetBSD/OpenBSD I guess.

thanks
-- PMM
