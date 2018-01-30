Received: from eggs.gnu.org ([2001:4830:134:3::10]:54988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egXkG-0004LB-Tj
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egXk7-0000IV-G7
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:22:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egXk7-0000Go-9G
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:22:39 -0500
Date: Tue, 30 Jan 2018 16:22:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180130152233.kg2qpibe4zxrtytx@sirius.home.kraxel.org>
References: <20180117145029.28736-1-tournier.elie@gmail.com>
	<20180129161155.GA25994@Nikki.localdomain>
	<20180129180830.tinzwowiarfolyfr@sirius.home.kraxel.org>
	<20180130144335.GA4881@Nikki.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130144335.GA4881@Nikki.localdomain>
Subject: Re: [Qemu-devel] [RFC 0/2] Use SDL to create an OpenGL ES context
 for virglrenderer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elie Tournier <tournier.elie@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

  Hi,

> > Well, display configuration is going to be rewritten, and while that is
> > in flight adding new config options isn't a good idea b/c things will
> > conflict ...
> I'm wondering how extensive this rewrite is going to be. Did you plan to modify the qemu interface?
> If someone already start working on this task, can you send me the link to the repository?
> I will be happy to help if needed.

https://www.kraxel.org/cgit/qemu/log/?h=sirius/display-cmdline

> > Beside that:  Is a new config option actually needed in the first place?
> > 
> > Ideally qemu (or sdl) would figure on its own that a full core context
> > isn't available and try fallback to gles then.
> I'm fine with this idea.
> However, I think we still need to add a way to the user to choose the backend he want.

Changing gl from bool to multiple choice looks more useful to me then,
i.e. have "gl={on,core,gles,off}", where "on" automatically picks "core"
or "gles" depending on what is available.

What is the status of the virglrenderer patches btw?

cheers,
  Gerd
