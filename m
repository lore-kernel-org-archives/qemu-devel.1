Received: from eggs.gnu.org ([2001:4830:134:3::10]:34693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHsu0-0007ru-Af
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHstn-0002na-Mx
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:59:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gHstg-0002jz-AZ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:59:09 -0400
Date: Wed, 31 Oct 2018 11:59:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181031155903.GA15881@flamenco>
References: <20181031104136.9953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181031104136.9953-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user-bridge: fix "unknown type name"
 compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, victork@redhat.com, pbonzini@redhat.com

On Wed, Oct 31, 2018 at 14:41:36 +0400, Marc-André Lureau wrote:
> osdep.h should be included first:
> 
>   CC      tests/vhost-user-bridge.o
> In file included from /home/elmarco/src/qemu/tests/vhost-user-bridge.c:32:
> /home/elmarco/src/qemu/include/qemu/atomic.h:480:1: error: unknown type name ‘int64_t’
>  int64_t  atomic_read_i64(const int64_t *ptr);
(snip)
> (regression from 782da5b2921c4d18777d5d5bd9385b9f7beae360)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio
