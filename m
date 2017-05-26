Received: from eggs.gnu.org ([2001:4830:134:3::10]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6U3-0007Bx-HV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6U0-0003jo-E8
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE6U0-0003jc-7T
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:04:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D14FC80460
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:04:10 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b7f9de2d-e09c-bcf1-24c8-0d961989cd9c@redhat.com>
Date: Fri, 26 May 2017 12:03:59 +0800
MIME-Version: 1.0
In-Reply-To: <1495649128-10529-2-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com


On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 02:05, Vladislav Yasevich wrote:
> Add parameters that control RARP/GARP announcement timeouts.
> The parameters structure is added to the QAPI and a qmp command
> is added to set/get the parameter data.
>
> Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

I think it's better to explain e.g under which condition do we need to=20
tweak such parameters.

Thanks
