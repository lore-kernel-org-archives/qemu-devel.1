Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGNfp-00018t-VI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fGNfm-0007pl-Ug
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:54:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fGNfm-0007oK-PG
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:54:18 -0400
References: <20180413075200.15217-1-clg@kaod.org>
	<20180419165800.GA2731@work-vm>
	<e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
	<20180509110833.GD2527@work-vm>
	<CAFEAcA9T=UUXS1ABrtahv_LyDtAf6DT-pRoTRYFr3LvvSkdyTQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec5b599c-32ae-5021-911a-db680327bbb5@redhat.com>
Date: Wed, 9 May 2018 13:54:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9T=UUXS1ABrtahv_LyDtAf6DT-pRoTRYFr3LvvSkdyTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On 09/05/2018 13:33, Peter Maydell wrote:
> 
> I don't think we need to fix those first, but:
> 
>  * we should note in the commit message for this patch that
>    it is a de-facto migration break for those boards
>  * we should fix those devices/boards in this release cycle,
>    since we've broken migration compat anyway
>  * we should check with the MIPS maintainers that they're ok
>    with a cross-version migration compat break for those boards
>    (I've cc'd them)

Isn't that implicitly the case for non-versioned machine types?...

Paolo
