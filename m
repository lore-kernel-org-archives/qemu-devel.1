Received: from eggs.gnu.org ([2001:4830:134:3::10]:54888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7C5V-0006wu-Vt
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7C5S-0008DE-SQ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:42:54 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f7C5S-0008Cv-Kf
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 23:42:50 -0400
Received: by mail-pf0-x22f.google.com with SMTP id f15so7468990pfn.0
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 20:42:50 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-13-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <565c5fac-2494-c30a-84c2-3bb1bb9c11b3@linaro.org>
Date: Fri, 13 Apr 2018 17:42:45 -1000
MIME-Version: 1.0
In-Reply-To: <1522980788-1252-13-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/17] translate-all: add
 page_collection assertions
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
> +static __thread bool page_collection_locked;
> +
> +void assert_page_collection_locked(bool val)
> +{
> +    tcg_debug_assert(page_collection_locked == val);
> +}
> +
> +static inline void set_page_collection_locked(bool val)
> +{
> +    page_collection_locked = val;
> +}
> +

This seems fairly fragile to me.

(1) Do you ever do assert_page_collection_locked(true)?  You don't appear to do
so, and it's somewhat confusing.

(2) Why does do_page_entry_lock set "locked" and not page_collection_lock?


r~
