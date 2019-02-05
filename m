Received: from eggs.gnu.org ([209.51.188.92]:44242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqyWt-0003ot-GX
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqyWq-0001cQ-IK
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:04:38 -0500
Date: Tue, 5 Feb 2019 11:04:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190205110417.GF20321@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190204211204.27321-1-philmd@redhat.com>
	<20190204211204.27321-4-philmd@redhat.com>
	<87a7jaag7q.fsf@dusky.pond.sub.org>
	<CAFEAcA8-YDTnszv7Mk+F+OAxGJSmdu4yEio1j-E477HNbh-SOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8-YDTnszv7Mk+F+OAxGJSmdu4yEio1j-E477HNbh-SOQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-riscv@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

On Tue, Feb 05, 2019 at 10:56:51AM +0000, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 06:44, Markus Armbruster <armbru@redhat.com> wrote:
> > There are two justifiable function comment placement styles: (1) next to
> > definition, and (2) next to declaration if it's in a header, else next
> > to definition.
> >
> > The rationale for the latter is having the headers do double-duty as
> > interface documentation.
> >
> > The rationale for the former is consistently placing the function
> > comments close to the code gives them a fighting chance to actually
> > match the code.
> >
> > I'm in the "next to definition" camp.  If you want concise interface
> > specification, use something like Sphinx.
> 
> I'm in the "next to declaration" camp. I don't want to have
> to wade into your implementation to find out what it does:
> document it for me in the interface, please.

I'm already looking at the header file to identify the function signature,
having the explanation / docs at the same place is desirable, especially
when the C file name is completely different from the header file name
forcing me to go grepping the code base to find where it is implemented.
The .c files are already volumous in size so not amenable to browsing
for the purpose of reading the docs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
