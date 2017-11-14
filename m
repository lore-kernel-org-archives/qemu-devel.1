Received: from eggs.gnu.org ([2001:4830:134:3::10]:55230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEctK-0006Ox-T3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEctG-0004X9-Rf
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:12:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEctG-0004W7-M6
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:12:42 -0500
Date: Tue, 14 Nov 2017 16:12:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171114151240.4wkiitoknjusnnit@sirius.home.kraxel.org>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-2-makovick@gmail.com>
	<20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
	<99826cbb-2f99-8100-484f-85eab0b4731c@redhat.com>
	<adc0fbc3-6bf6-d235-e0db-f79157ad7104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc0fbc3-6bf6-d235-e0db-f79157ad7104@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] sdl2: Fix broken display updating
 after the window is hidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Jindrich Makovicka <makovick@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

> > The only thing I can say is that I submitted
> > https://bugzilla.libsdl.org/show_bug.cgi?id=2818 as a result.  Nobody
> > has replied to that in three years, but when testing it on SDL 2.0.7,
> > the issue appears to be fixed.
> 
> Having done a bisect, SDL2 revision 11151:7cfe088fafba seems to have
> fixed the issue (for 2.0.6).  See also:
> 
> https://bugzilla.libsdl.org/show_bug.cgi?id=3410

Thanks for the effort.  Adding a note to the commit message.

cheers,
  Gerd
