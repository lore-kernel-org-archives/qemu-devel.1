Received: from eggs.gnu.org ([2001:4830:134:3::10]:37487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJzp-0001xh-04
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXJzk-0004sv-3d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:20:29 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:33734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXJzj-0004si-UC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:20:24 -0400
Received: by mail-pf0-x232.google.com with SMTP id e26so5092481pfd.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:20:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-39-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2ff2e174-848c-6b50-8620-c741fe116b5c@twiddle.net>
Date: Mon, 17 Jul 2017 18:20:17 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-39-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 38/45] tcg: distribute profiling
 counters across TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> +#define PROF_ADD_MAX(to, from, field)                                   \
> +    do {                                                                \
> +        typeof((from)->field) val__ = atomic_read(&((from)->field));    \
> +        if (val__ > (to)->field) {                                      \
> +            (to)->field = val__;                                        \
> +        }                                                               \
> +    } while (0)

PROF_MAX?  There's no addition involved.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
