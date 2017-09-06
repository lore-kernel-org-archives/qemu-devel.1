Received: from eggs.gnu.org ([2001:4830:134:3::10]:51369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpUdM-0007kS-J5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dpUdH-0007yp-LH
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dpUdH-0007yQ-F1
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:20:19 -0400
Message-ID: <1504682410.2206.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 06 Sep 2017 09:20:10 +0200
In-Reply-To: <87tw0ge3xf.fsf@dusky.pond.sub.org>
References: <CAO6-N=a7WwhsDqZsm=wppXWMunGub=RH17FBk5w_tK0vu-8=cQ@mail.gmail.com>
	<87tw0ge3xf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] stack smash while using SDL 1.2.5 with QEMU 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Taimoor Mirza <taimoor.mrza@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, 2017-09-06 at 08:28 +0200, Markus Armbruster wrote:
> Gerd, any ideas?

> > I want to know whether it is a known issue and Is QEMU 2.9
> > compatible with
> > SDL 1.2.5?

Everything working fine here, even valgrind doesn't report anything
unusual.

qemu 2.10, SDL 1.2.15

Do you really use SDL 1.2.5 not 1.2.15?
If so I'd strongly suggest to update SDL.

cheers,
  Gerd
