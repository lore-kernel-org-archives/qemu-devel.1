Received: from eggs.gnu.org ([2001:4830:134:3::10]:36615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0OcI-0001Cz-4T
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0OcD-0004nA-W3
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:12:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0OcD-0004is-M5
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:12:49 -0400
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081945.3228.19776.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <add3b71c-018b-3aae-1a98-53cd756e1b77@redhat.com>
Date: Thu, 13 Sep 2018 12:12:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180912081945.3228.19776.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 20/25] replay: wake up vCPU when
 replaying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

On 12/09/2018 10:19, Pavel Dovgalyuk wrote:
> This patch tries to wake up the vCPU when it sleeps and the icount warp
> checkpoint isn't met. It means that vCPU has something to do, because
> there are no other reasons of non-matching warp checkpoint.

What happens if !replay_has_checkpoint()?  Should that be an assertion?

Thanks,

Paolo
