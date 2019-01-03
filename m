Received: from eggs.gnu.org ([208.118.235.92]:40426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gfCfi-0003Db-Bv
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gfCff-0001Gr-8Q
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:45:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:53580 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1gfCfe-0001G3-Un
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:45:03 -0500
References: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <9b211327-06a8-9739-e984-4b05557c12b4@suse.de>
Date: Fri, 4 Jan 2019 00:44:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] can we update QEMU's version of u-boot.e500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>



On 03.01.19 18:38, Peter Maydell wrote:
> Hi; currently we ship with a u-boot.e500 which is from u-boot
> v2017.07. It would be nice to move that forward, specifically
> to at least v2017.11, which contains upstream u-boot's part of the
> fix for https://bugs.launchpad.net/qemu/+bug/1714750 .
> (There are more recent releases than that; it's just the first
> that contains the fix.)
> 
> Then we could remove the workaround in scripts/make-release and
> close out the bug.
> 
> I've cc'd David as the current maintainer of pc-bios/u-boot.e500
> and Alex as the last person who did an update.

I think it's a great idea to update it.

David, do you want to do that or rather have me send a patch?


Alex
