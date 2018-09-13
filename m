Received: from eggs.gnu.org ([2001:4830:134:3::10]:48683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0PSL-0003jm-FP
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0PSG-0007U9-DF
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:06:41 -0400
Received: from mail.ispras.ru ([83.149.199.45]:41856)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0PSG-0007Rz-31
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:06:36 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081945.3228.19776.stgit@pasha-VirtualBox>
	<add3b71c-018b-3aae-1a98-53cd756e1b77@redhat.com>
In-Reply-To: <add3b71c-018b-3aae-1a98-53cd756e1b77@redhat.com>
Date: Thu, 13 Sep 2018 14:06:28 +0300
Message-ID: <000801d44b51$d2c81870$78584950$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 12/09/2018 10:19, Pavel Dovgalyuk wrote:
> > This patch tries to wake up the vCPU when it sleeps and the icount warp
> > checkpoint isn't met. It means that vCPU has something to do, because
> > there are no other reasons of non-matching warp checkpoint.
> 
> What happens if !replay_has_checkpoint()?  Should that be an assertion?

The condition may be true, only when vCPU thread is sleeping.
In all other cases (e.g., running) the condition is false and we
have nothing to do.

Pavel Dovgalyuk
