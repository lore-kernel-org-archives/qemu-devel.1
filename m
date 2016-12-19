Received: from eggs.gnu.org ([2001:4830:134:3::10]:57817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cIxi1-0002M3-Ac
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cIxhy-0000n9-42
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:10:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cIxhx-0000mT-Uv
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:10:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76AFC8EB45
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 13:10:24 +0000 (UTC)
Date: Mon, 19 Dec 2016 14:10:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161219131022.GA4805@noname.redhat.com>
References: <CAJ1JNOepVarVZZeVKaUN+5TTRFz-BKU+WcEu5koUR_W2YrFADA@mail.gmail.com>
	<CAJ1JNOc_HHVZOx_qZTWK=U_dn6_69UDnD3eDmoEVU4mYnCLC2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ1JNOc_HHVZOx_qZTWK=U_dn6_69UDnD3eDmoEVU4mYnCLC2w@mail.gmail.com>
Subject: Re: [Qemu-devel] Is qemu-img amend an atomic operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maor Lipchuk <mlipchuk@redhat.com>
Cc: qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>, mreitz@redhat.com

Am 19.12.2016 um 13:49 hat Maor Lipchuk geschrieben:
> 
> On Mon, Dec 19, 2016 at 2:47 PM, Maor Lipchuk <mlipchuk@redhat.com> wrote:
> 
>     Hi All,
> 
>     Does amend considered as an atomic operation or should we mark a volume as
>     ILLEGAL once the amend operation fails?
> 
>     also, if I call amend, but downgrade the QCOW volume compatibility level
>     from 1.1 to 0.10, is that atomic as well (or not, based on the answer on
>     the previous question)?
> 
>     Regards,
>     Maor
> 
> Adding also Nir and Kevin to the thread.

Like with every other operation, the image is supposed to stay
consistent at all times, even if the host crashes in the middle.
Leaked clusters are the worst that should be possible, anything
else would be a bug.

Kevin
