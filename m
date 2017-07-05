Received: from eggs.gnu.org ([2001:4830:134:3::10]:46175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSieX-0000Ey-Cp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSieU-00040Z-90
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:39:29 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSieU-0003va-2g
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:39:26 -0400
Received: by mail-wm0-f46.google.com with SMTP id i127so163709867wma.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 04:39:24 -0700 (PDT)
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-2-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3557c70-c63d-efc6-7c8f-2956c15edad9@redhat.com>
Date: Wed, 5 Jul 2017 13:39:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170704220346.29244-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/35] WIP: coroutine: annotate coroutine
 with clang thread safety attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>

On 05/07/2017 00:03, Marc-André Lureau wrote:
> +typedef int TAA_ROLE coroutine_role;
> +extern coroutine_role _coroutine_fn;
> +
> +static inline void co_role_acquire(coroutine_role R) TAA_ACQUIRE(R) TAA_NO_ANALYSYS {}
> +static inline void co_role_release(coroutine_role R) TAA_RELEASE(R) TAA_NO_ANALYSYS {}

Is the argument necessary, or could it be simply TAA_ACQUIRE(_coroutine_fn)?

Paolo
