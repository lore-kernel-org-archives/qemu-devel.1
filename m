Received: from eggs.gnu.org ([2001:4830:134:3::10]:33971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dah09-0003Ts-IB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dah06-0000MH-UL
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dah06-0000Kx-Jm
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:30:42 -0400
Message-ID: <1501155038.27172.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Jul 2017 13:30:38 +0200
In-Reply-To: <20170727110324.GG5117@lemon.lan>
References: <20170717063521.GA7393@lemon>
	<20170717090531.GA7163@stefanha-x1.localdomain>
	<CAFEAcA8kt71pbxggfLdP3-WCc8u8v5iijZBksMSq6Yss2ydgiw@mail.gmail.com>
	<20170717093944.GA18516@lemon>
	<CAFEAcA-hzAq=fP6Pndre3b4truxJFV3go0C91d702pMsLGZRrg@mail.gmail.com>
	<20170717102607.GI3640@redhat.com>
	<CAFEAcA8pH6+aTNznDS7hTDTfNniuSBWgORCaiSm=vkAbukpcLw@mail.gmail.com>
	<20170727110324.GG5117@lemon.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 2017-07-27 at 19:03 +0800, Fam Zheng wrote:
> On Tue, 07/25 10:58, Peter Maydell wrote:
> > For patchew, I basically ignore patchew compile failure emails
> > because it is too painful to get to the bottom of the email
> > where the actual error message is because of the pages and
> > pages and pages of useless progress output :-(
> 
> Isn't it very easy to go to the bottom with a shortcut key and start
> looking
> from there? That's why I thought including the full log in the email
> isn't a
> problem, while not everyone likes web interface when it comes to
> working on a
> long log (I personally find travis web page annoyingly inefficient).

IMO it is fine to have a weblink only for the full build log if you
manage to include the relevant log snippet in the mail, so there is
rarely a need to actually lookup the full log online.

I think there is room for improvement on the latter.  You could try to
find the first "error" in the build log, go backwards 10 or 20 lines, 
from there include the next 50 to 100 lines inline in the mail. 
Probably needs some experimentation to figure which line counts work
best in practice.

cheers,
  Gerd
