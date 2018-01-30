Received: from eggs.gnu.org ([2001:4830:134:3::10]:47565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1egZQp-0006Mc-DT
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1egZQn-0006US-Cm
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:10:51 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:50765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1egZQn-0006SU-2n
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:10:49 -0500
Received: by mail-wm0-x230.google.com with SMTP id f71so2684457wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 09:10:48 -0800 (PST)
Date: Tue, 30 Jan 2018 17:08:24 +0000
From: Elie Tournier <tournier.elie@gmail.com>
Message-ID: <20180130170824.GA7376@Nikki.localdomain>
References: <20180117145029.28736-1-tournier.elie@gmail.com>
	<20180129161155.GA25994@Nikki.localdomain>
	<20180129180830.tinzwowiarfolyfr@sirius.home.kraxel.org>
	<20180130144335.GA4881@Nikki.localdomain>
	<20180130152233.kg2qpibe4zxrtytx@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130152233.kg2qpibe4zxrtytx@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Jan 30, 2018 at 04:22:33PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > Well, display configuration is going to be rewritten, and while that is
> > > in flight adding new config options isn't a good idea b/c things will
> > > conflict ...
> > I'm wondering how extensive this rewrite is going to be. Did you plan to modify the qemu interface?
> > If someone already start working on this task, can you send me the link to the repository?
> > I will be happy to help if needed.
> 
> https://www.kraxel.org/cgit/qemu/log/?h=sirius/display-cmdline
Awesome, thanks. I will definitely have a look to it.
> 
> > > Beside that:  Is a new config option actually needed in the first place?
> > > 
> > > Ideally qemu (or sdl) would figure on its own that a full core context
> > > isn't available and try fallback to gles then.
> > I'm fine with this idea.
> > However, I think we still need to add a way to the user to choose the backend he want.
> 
> Changing gl from bool to multiple choice looks more useful to me then,
> i.e. have "gl={on,core,gles,off}", where "on" automatically picks "core"
> or "gles" depending on what is available.
I like that solution. ;). I will implement it on top of your work.
> 
> What is the status of the virglrenderer patches btw?
We keep upstreaming no invasive patches.
But with upstream virglrenderer, you will not be able to use a gles backend.
If you want to know more about the current status of the project, you can have a look to our repo [1].

Currently, we are working through bugs, cleaning up the remaing patches.
Our short term goal is to pass the GLES2 CTS [2] in the guest side.

Regards,
Elie

[1] https://gitlab.collabora.com/jakob/virglrenderer-gles/tree/hacks
[2] https://github.com/KhronosGroup/VK-GL-CTS
> 
> cheers,
>   Gerd
> 
