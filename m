Received: from eggs.gnu.org ([2001:4830:134:3::10]:36829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvLu6-0002c3-2s
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvLu5-0003nC-3z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:13:54 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:49851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvLu4-0003mh-SX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:13:53 -0400
Received: by mail-wm0-x235.google.com with SMTP id r74so2909721wme.4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 04:13:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922073432.2811-1-cohuck@redhat.com>
References: <20170922073432.2811-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 12:13:31 +0100
Message-ID: <CAFEAcA-VVdA=BqauYt5BCKr=MCtNFFxgbFSGR9H2Hg+5inpeaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] s390x bugfix (needed for stable)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, zyimin@linux.vnet.ibm.com, Halil Pasic <pasic@linux.vnet.ibm.com>

On 22 September 2017 at 08:34, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 0a8066f0c068f1e318a1aacd7864fc00e455a37b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170921' into staging (2017-09-21 17:42:27 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170922
>
> for you to fetch changes up to 3f2d07b3b01ea61126b382633ab4006320923048:
>
>   s390x/ais: for 2.10 stable: disable ais facility (2017-09-22 09:25:21 +0200)
>
> ----------------------------------------------------------------
> Fix an s390x migration breakage up for 2.10 stable.
> This will be fixed properly for 2.11.
>
> ----------------------------------------------------------------
>
> Christian Borntraeger (1):
>   s390x/ais: for 2.10 stable: disable ais facility
>
>  target/s390x/kvm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>

Applied, thanks.

-- PMM
