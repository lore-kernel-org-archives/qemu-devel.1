Received: from eggs.gnu.org ([2001:4830:134:3::10]:39201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVxVh-0002CM-3J
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVxVc-0007oT-4L
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:35:29 -0500
References: <5878AF90.8020709@kamp.de>
	<260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
	<20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
	<b7f5dc23-6d72-4897-e9ca-6482acfb4c72@redhat.com>
	<20170117112224.2st4wuivcbwuif2m@nora.maurer-it.com>
	<196ac8f5-2fd7-37e9-d577-8177802d0fb4@redhat.com>
	<40cbdb51-3dcc-35bc-bb99-6c85a47d20d0@redhat.com>
	<20170118115050.6o2ut7wtfkuzy5oh@nora.maurer-it.com>
	<20170118161941.g72fzppyyc3pdwkf@nora.maurer-it.com>
	<5de45f2f-d83b-64d2-6406-dc09fd4c455f@redhat.com>
	<20170119115958.zbpy42cmntwqfuas@nora.maurer-it.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94844aea-70ca-6f8c-2194-baedac929f1e@redhat.com>
Date: Tue, 24 Jan 2017 10:35:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170119115958.zbpy42cmntwqfuas@nora.maurer-it.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexandre DERUMIER <aderumier@odiso.com>, qemu-stable <qemu-stable@nongnu.org>



On 19/01/2017 12:59, Fabian Gr=FCnbichler wrote:
> > I'm not sure how to fix it, unfortunately. :(
>=20
> so this means either use non-transparent huge pages when using
> scsi-block (haven't verified but should work?), or use aggressive THP
> settings and/or always leave enough memory reserves? :-/ this is very
> unfortunate IMHO (and probably also not a very realistic usage
> scenario?)

Yes, I agree.  Unfortunately there is no API in Linux that lets you
verify how many segments an iov is split into.

Paolo
