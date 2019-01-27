Received: from eggs.gnu.org ([209.51.188.92]:34647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnY7t-0005YK-M4
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnXtX-0005ot-IC
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:01:52 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:34480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnXtW-0005oS-Or
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 19:01:50 -0500
Date: Sun, 27 Jan 2019 01:01:48 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190127000148.b6pbeenaks3fq3hl@function>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
	<20190117114359.5164-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117114359.5164-6-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/27] slirp: add callbacks for timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Applied too, but

Marc-Andr=C3=A9 Lureau, le jeu. 17 janv. 2019 15:43:37 +0400, a ecrit:
> +    /* Create a new timer with the given callback and opaque data */
> +    void *(*timer_new)(SlirpTimerCb cb, void *opaque);
> +    /* Remove and free a timer */
> +    void (*timer_free)(void *timer);
> +    /* Modify a timer to expire at @expire_time */
> +    void (*timer_mod)(void *timer, int64_t expire_time);

I'd say we will want to make the API use an opaque type for timers, for
typechecking.

Samuel
