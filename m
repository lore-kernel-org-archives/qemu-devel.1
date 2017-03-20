Received: from eggs.gnu.org ([2001:4830:134:3::10]:46550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpvQI-0007Dd-DU
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpvQH-0001ze-J6
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:24:26 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpvQH-0001za-C0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:24:25 -0400
Received: by mail-wr0-x231.google.com with SMTP id u108so89939824wrb.3
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:24:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170320085844.15178-1-cornelia.huck@de.ibm.com>
References: <20170320085844.15178-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 11:24:03 +0000
Message-ID: <CAFEAcA8G_eEtNTg3fnxevE7=2986A-dJXPcH_2vb6N_UrQ9_hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] s390x: one bugfix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 08:58, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit ebedf0f9cd46b617df331eecc857c379d574ac62:
>
>   nios2: iic: Convert CPU prop to qom link (2017-03-18 18:22:54 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170320
>
> for you to fetch changes up to 3c788ebc6f6eef5ac6e9cb4a28c578abcf08247d:
>
>   s390x/css: reassign subchannel if schid is changed after migration (2017-03-20 09:22:57 +0100)
>
> ----------------------------------------------------------------
> One bugfix for device plug/unplug and migration in the
> channel subsystem code.
>
> ----------------------------------------------------------------
>
> Dong Jia Shi (1):
>   s390x/css: reassign subchannel if schid is changed after migration
>
>  hw/s390x/css.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks.

-- PMM
