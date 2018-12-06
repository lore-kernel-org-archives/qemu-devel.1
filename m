Received: from eggs.gnu.org ([2001:4830:134:3::10]:55125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gUyLj-0005Gy-Pp
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gUyLe-0000rq-Ul
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:26:11 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gUyLe-0000qt-Oq
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 13:26:06 -0500
Received: by mail-it1-f173.google.com with SMTP id c9so3027456itj.1
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 10:26:06 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<9b63140e-1d06-27d0-7686-226b7045931e@gmx.com>
	<20181206102306.GI29540@redhat.com>
In-Reply-To: <20181206102306.GI29540@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Thu, 6 Dec 2018 13:25:52 -0500
Message-ID: <CAPyFy2Dc=vjcJk9YQhEHJCEq25gCh-Gft_FbWOmLg4vVoq5pgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, 6 Dec 2018 at 05:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> I'd encourage you to loook at installing as many deps as possible to
> maximise the coverage. eg gnutls, nettle, spice, and anything else that
> is relevant

I've now added: bison curl cyrus-sasl fontconfig freetype2 gnutls
nettle png usbredir
I think this should give a decent starting point and can post a patch
to add .cirrus.yml, then someone in the GitHub qemu organization would
have to add Cirrus CI for it to start running when commits happen.

> Are the Cirrus CI environments SMP ? If so adding a -j flag would
> give much improved build times.

For FreeBSD Cirrus CI spins up a VM (it doesn't run the test in a
jail/container) and supports a configurable CPU count. I changed it to
specify 8 vCPUs and ran a -j8 build/test in about 15 minutes - here's
a link to the run: https://cirrus-ci.com/task/6214818623127552
