Received: from eggs.gnu.org ([2001:4830:134:3::10]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BJF-0000Qv-Ma
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BJE-00068B-U9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:36:21 -0400
Date: Thu, 4 May 2017 15:36:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504073615.GF19184@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/17] util: add stats64 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> +static inline void stat64_rdlock(Stat64 *s)
> +{
> +    /* Keep out incoming writers to avoid them starving us. */
> +    atomic_add(&s->lock, 2);
> +
> +    /* If there is a concurrent writer, wait for it.  */
> +    while (atomic_read(&s->lock) & 1) {
> +        g_usleep(5);

What's the difference of g_usleep() from cpu_relax() in
qemu_co_mutex_lock_unlock?

> +    }
> +}

Fam
