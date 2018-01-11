Received: from eggs.gnu.org ([2001:4830:134:3::10]:38414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZcf0-0000bX-Rw
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZcex-0008DO-Nk
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:12:46 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46432)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZcex-0008Ah-GU
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:12:43 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<20180111082738.27295.80055.stgit@pasha-VirtualBox>
	<0e223aaa-c3c9-1cdf-5548-5a532d3a7361@redhat.com>
In-Reply-To: <0e223aaa-c3c9-1cdf-5548-5a532d3a7361@redhat.com>
Date: Thu, 11 Jan 2018 16:12:42 +0300
Message-ID: <000901d38add$ddb4b750$991e25f0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v3 29/30] replay: improve replay
 performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> On 11/01/2018 09:27, Pavel Dovgalyuk wrote:
> > +        } else {
> > +            qemu_notify_event();
> > +        }
> 
> Before this patch, what would do the qemu_notify_event?

We tried using qemu_notify_event to wake up the iothread and speedup the replay,
when there is no work for vcpu thread to do.

Pavel Dovgalyuk
