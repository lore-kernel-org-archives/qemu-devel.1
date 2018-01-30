Received: from eggs.gnu.org ([2001:4830:134:3::10]:44709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1egXAf-0002aE-9z
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tournier.elie@gmail.com>) id 1egXAe-0008PB-Dj
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:46:01 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:43847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tournier.elie@gmail.com>)
	id 1egXAe-0008Or-6M
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:46:00 -0500
Received: by mail-wr0-x22a.google.com with SMTP id 39so2746512wrb.10
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 06:46:00 -0800 (PST)
Date: Tue, 30 Jan 2018 14:43:35 +0000
From: Elie Tournier <tournier.elie@gmail.com>
Message-ID: <20180130144335.GA4881@Nikki.localdomain>
References: <20180117145029.28736-1-tournier.elie@gmail.com>
	<20180129161155.GA25994@Nikki.localdomain>
	<20180129180830.tinzwowiarfolyfr@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129180830.tinzwowiarfolyfr@sirius.home.kraxel.org>
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

On Mon, Jan 29, 2018 at 07:08:30PM +0100, Gerd Hoffmann wrote:
Hello,

First, thanks for your reply.
I added some comments and questions below.

Cheers,
Elie

>   Hi,
> 
> > > In order to use this feature, we need to create a gles context.
> > > This series add an option (`-display sdl,gles=on`) in the SDL display to create that context.
> > 
> > Humble ping.
> > I didn't get any comment on this series.
> 
> Well, display configuration is going to be rewritten, and while that is
> in flight adding new config options isn't a good idea b/c things will
> conflict ...
I'm wondering how extensive this rewrite is going to be. Did you plan to modify the qemu interface?
If someone already start working on this task, can you send me the link to the repository?
I will be happy to help if needed.
> 
> Beside that:  Is a new config option actually needed in the first place?
> 
> Ideally qemu (or sdl) would figure on its own that a full core context
> isn't available and try fallback to gles then.
I'm fine with this idea.
However, I think we still need to add a way to the user to choose the backend he want.
> 
> cheers,
>   Gerd
> 
