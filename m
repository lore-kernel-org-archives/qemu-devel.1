Received: from eggs.gnu.org ([2001:4830:134:3::10]:60767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhDW-00083C-7a
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhDR-0007F3-Qf
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:55:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJhDR-0007Ds-Ju
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:55:01 -0500
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-6-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e0abe1c-5ae8-a2b8-4210-75915ef2d3c5@redhat.com>
Date: Mon, 5 Nov 2018 09:54:20 -0600
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-6-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/8] git: use HTTPS git URLs for
 repo.or.cz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Daniel Berrange <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 11/4/18 5:24 AM, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS    | 14 +++++++-------
>   pc-bios/README |  2 +-
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
