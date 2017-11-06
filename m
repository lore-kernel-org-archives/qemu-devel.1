Received: from eggs.gnu.org ([2001:4830:134:3::10]:39224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBabF-0006CT-94
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBabA-0003pC-65
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:09:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eBabA-0003ld-08
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:09:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1509638660.11873.13.camel@redhat.com>
	<20171102161103.GU32533@redhat.com>
	<1509691743.31823.1.camel@redhat.com>
	<20171103101055.GD20155@redhat.com>
	<1509705781.31823.18.camel@redhat.com>
Date: Mon, 06 Nov 2017 07:09:22 +0100
In-Reply-To: <1509705781.31823.18.camel@redhat.com> (Gerd Hoffmann's message
	of "Fri, 03 Nov 2017 11:43:01 +0100")
Message-ID: <87lgjkgcq5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] seabios serial console vs. sgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

[...]
>> Libvirt doesn't use=C2=A0=C2=A0'-machine graphics=3Doff' AFAIK, only '-
>> nographic'.
>
> I think that is pretty much the same.  Setting "graphichs=3Doff" is one
> of the effects of passing -nographic, and the other effects (like
> setting up default serial + monitor in a different way) don't happen
> due to libvirt also using -nodefaults.

-nographic is a legacy / convenience option these days.  I'd recommend
management tools use -machine graphics=3Doff instead.
