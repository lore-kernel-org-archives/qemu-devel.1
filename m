Received: from eggs.gnu.org ([2001:4830:134:3::10]:43537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1d3LJQ-0004bO-CT
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1d3LJP-0006ul-IY
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:40:48 -0400
MIME-Version: 1.0
In-Reply-To: <1492173995-14140-4-git-send-email-eric.auger@redhat.com>
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
	<1492173995-14140-4-git-send-email-eric.auger@redhat.com>
From: Prakash B <bjsprakash.linux@gmail.com>
Date: Wed, 26 Apr 2017 17:10:44 +0530
Message-ID: <CACJhumf3+knQdPj2watGezS0E+2es+Y5Y-wW0MQ1Tw1E810UGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v5 3/4] hw/intc/arm_gicv3_kvm: Implement
 pending table save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, drjones@redhat.com, Vijay Kilari <vijay.kilari@gmail.com>, quintela@redhat.com, dgilbert@redhat.com, Vijaya.Kumar@cavium.com, Christoffer Dall <christoffer.dall@linaro.org>

On Fri, Apr 14, 2017 at 6:16 PM, Eric Auger <eric.auger@redhat.com> wrote:
> This patch adds the flush of the LPI pending bits into the
> redistributor pending tables. This happens on VM stop.
>
> There is no explicit restore as the tables are implicitly sync'ed
> on ITS table restore and on LPI enable at redistributor level.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
