Received: from eggs.gnu.org ([2001:4830:134:3::10]:58723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8a2-00010J-K4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 21:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8Zy-0006og-7T
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 21:59:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8Zy-0006o5-1O
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 21:59:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC5EB81DF3
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 01:59:32 +0000 (UTC)
References: <20170907083552.17725-1-famz@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <285ebeab-ccce-4339-f782-2a5a39139777@redhat.com>
Date: Fri, 8 Sep 2017 09:59:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170907083552.17725-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] buildsys: Move vde cflags/libs to per
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B409=E6=9C=8807=E6=97=A5 16:35, Fam Zheng wrote:
> Hi Jason,
>
> this is the net/ part of the conversion of library cflags/libs from glo=
bal
> QEMU_CFLAGS and libs_softmmu to per object variables. Please review.
>
> Fam Zheng (2):
>    vl: Don't include vde header
>    buildsys: Move vde libs to per object
>
>   configure         | 3 +--
>   net/Makefile.objs | 2 ++
>   vl.c              | 4 ----
>   3 files changed, 3 insertions(+), 6 deletions(-)
>

Reviewed-by: Jason Wang <jasowang@redhat.com>
