Received: from eggs.gnu.org ([2001:4830:134:3::10]:54585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBFxg-00067A-9l
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBFxc-0004vL-9q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:39:36 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBFxc-0004ut-3P
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 04:39:32 -0400
Received: by mail-wr0-x229.google.com with SMTP id p18-v6so33265310wrm.1
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 01:39:31 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<b4090f17-757c-a012-f608-f6950de031ef@amsat.org>
	<20180425065745.ozsbiuztfh6aldkp@var.youpi.perso.aquilenet.fr>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180425065745.ozsbiuztfh6aldkp@var.youpi.perso.aquilenet.fr>
Date: Wed, 25 Apr 2018 09:39:29 +0100
Message-ID: <87muxrllxa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/46] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, richard.henderson@linaro.org, Agustin Henze <tin@debian.org>, Michael Tokarev <mjt@tls.msk.ru>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Ulises Vitulli <dererk@debian.org>, YunQiang Su <syq@debian.org>


Samuel Thibault <samuel.thibault@gnu.org> writes:

> Philippe Mathieu-Daud=C3=A9, le mar. 24 avril 2018 22:25:18 -0300, a ecri=
t:
>> > This is starting to shape up pretty nicely. I was able to add a whole
>> > bunch of additional architectures thanks to cross compilers in Debian
>> > Sid which are there to support the Debian "ports". These may not be
>> > around for ever, most "ports" are on the way out, but they will be the
>> > last thing to drop out of the Sid repo. Maybe when Debian stops
>> > caring (and no other distro does) maybe we should to?
>>
>> I *think* working with Sid is not recommended as very unstable and not
>> reproducible. A reproducible way is to use the Debian Snapshot Archive
>> (http://snapshot.debian.org/) eventually using package specific version
>> and holding packages at this version.
>>
>> I found an example in the following post:
>> https://blog.sleeplessbeastie.eu/2017/07/17/how-to-install-packages-usin=
g-repository-snapshot/
>>
>> (I Cc'ed Debian experts who might have a better idea).
>
> That looks like the correct idea :)
> (basically what we use to make "releases" of the hurd port, as sid
> snapshots).

So how would this work in docker. Should I take for example the
sid-20180312 tag and then just munge sources.list to the appropriate
snapshot url?

That said I'm relatively sanguine about the stability of the toolchain
in sid. It would be the last thing to bitrot as once the toolchain is
dead the distro dies with it so it is the last thing to die and the
first thing to fix.

--
Alex Benn=C3=A9e
