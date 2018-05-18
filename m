Received: from eggs.gnu.org ([2001:4830:134:3::10]:55739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1fJacU-0004rJ-8a
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1fJacT-0003Uv-F9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:20:10 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1fJacT-0003Ub-98
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:20:09 -0400
Received: by mail-oi0-x244.google.com with SMTP id k17-v6so6412133oih.5
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 01:20:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518070412.4zlrltobjqc54g6b@sirius.home.kraxel.org>
References: <20180515185814.1374-1-peter.maydell@linaro.org>
	<20180518070412.4zlrltobjqc54g6b@sirius.home.kraxel.org>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Fri, 18 May 2018 11:20:07 +0300
Message-ID: <CAE5jQCfir-icuz+4rtJMDqwpQ3Vos8zuD=Vuf0qbYpfYpdaJwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sdl: Move use of surface pointer below
 check for whether it is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org

Please excuse me and thank you very much for the fix!

2018-05-18 10:04 GMT+03:00 Gerd Hoffmann <kraxel@redhat.com>:

> On Tue, May 15, 2018 at 07:58:14PM +0100, Peter Maydell wrote:
> > In commit 2ab858c6c38ee1 we added a use of the 'surf' variable
> > in sdl2_2d_update() that was unfortunately placed above the
> > early-exit-if-NULL check. Move it to where it ought to be.
>
> Added to ui patch queue.
>
> thanks,
>   Gerd
>
>


-- 
Anatoly <anatoly.trosinenko@gmail.com>
