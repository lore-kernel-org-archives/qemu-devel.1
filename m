Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7BuS-00038b-PV
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7BuO-0007XH-RZ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:31:28 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:38412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f7BuO-0007WI-M3
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:31:24 -0400
Received: by mail-pf0-x22d.google.com with SMTP id y69so7442370pfb.5
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 20:31:24 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-12-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f053c3b2-771e-a3d6-7226-6c046ad8c134@linaro.org>
Date: Fri, 13 Apr 2018 17:31:20 -1000
MIME-Version: 1.0
In-Reply-To: <1522980788-1252-12-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/17] translate-all: add page_locked
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
> +#ifdef CONFIG_DEBUG_TCG
> +
> +struct page_lock_debug {
> +    const PageDesc *pd;
> +    QLIST_ENTRY(page_lock_debug) entry;
> +};
> +
> +static __thread QLIST_HEAD(, page_lock_debug) page_lock_debug_head;
> +
> +static struct page_lock_debug *get_page_lock_debug(const PageDesc *pd)
> +{
> +    struct page_lock_debug *pld;
> +
> +    QLIST_FOREACH(pld, &page_lock_debug_head, entry) {
> +        if (pld->pd == pd) {
> +            return pld;
> +        }
> +    }
> +    return NULL;
> +}

Why do you need a separate data structure for this?


r~
