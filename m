Received: from eggs.gnu.org ([2001:4830:134:3::10]:38729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0Om9-0004P4-D4
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0Om6-00061a-2w
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0Om5-00061C-RH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:23:02 -0400
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081956.3228.17903.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0deae03-cfdf-85c0-4262-884a1e07e5a3@redhat.com>
Date: Thu, 13 Sep 2018 12:22:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180912081956.3228.17903.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

On 12/09/2018 10:19, Pavel Dovgalyuk wrote:
> + uint64_t id = replay_get_current_step();
> + replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);

Why does it need an id, while REPLAY_ASYNC_EVENT_BH does not?

Paolo
