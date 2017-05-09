Received: from eggs.gnu.org ([2001:4830:134:3::10]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d8B3G-0000XB-0N
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d8B3B-0000yt-Uc
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:44:05 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:36799)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1d8B3B-0000yX-IJ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:44:01 -0400
Date: Tue, 9 May 2017 22:43:44 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170509194344.za4abntjp3tkrilt@post>
References: <f4a22cdebdd0bca6a13a43a2a6deead7f2ec4bb3.1493906281.git.pkrempa@redhat.com>
	<20170509154439.GA16494@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20170509154439.GA16494@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: curl: Allow passing
 cookies via QCryptoSecret
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, May 04, 2017 at 04:00:06PM +0200, Peter Krempa wrote:
> +    cookie_secret = qemu_opt_get(opts, CURL_BLOCK_OPT_COOKIE_SECRET);
> +
> +    if (cookie && cookie_secret) {
> +        error_setg(errp,
> +                   "curl driver cannot handle both cookie and cookie secret");
> +        goto out_noclean;
> +    }
> +
> +    if (cookie_secret) {
> +        s->cookie = qcrypto_secret_lookup_as_utf8(cookie_secret, errp);
> +        if (!s->cookie) {
> +            goto out_noclean;
> +        }
> +    } else {
> +        s->cookie = g_strdup(cookie);
> +    }

There's no check here for if both cookie and cookie_secret are NULL. 
