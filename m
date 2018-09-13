Received: from eggs.gnu.org ([2001:4830:134:3::10]:50063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0PYq-0005sC-8f
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0PYk-0005SD-Gx
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:13:23 -0400
Received: from mail.ispras.ru ([83.149.199.45]:42414)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0PYh-0005Pw-1M
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:13:15 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081956.3228.17903.stgit@pasha-VirtualBox>
	<b0deae03-cfdf-85c0-4262-884a1e07e5a3@redhat.com>
In-Reply-To: <b0deae03-cfdf-85c0-4262-884a1e07e5a3@redhat.com>
Date: Thu, 13 Sep 2018 14:13:10 +0300
Message-ID: <000901d44b52$c1bdcd30$45396790$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v6 22/25] replay: add BH oneshot event for
 block layer
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
> > + uint64_t id = replay_get_current_step();
> > + replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
> 
> Why does it need an id, while REPLAY_ASYNC_EVENT_BH does not?

Because _oneshot() function takes only context and callback,
and BH object is created inside that function.
Therefore to use the normal bh scheduling events we have to refactor
block code - add bh creation, scheduling, and freeing.

Pavel Dovgalyuk
