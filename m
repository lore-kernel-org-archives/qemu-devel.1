Received: from eggs.gnu.org ([2001:4830:134:3::10]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4iz9-0001PT-VY
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4iz6-00042e-TE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:41:52 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:50848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4iz6-00040f-L4
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 03:41:48 -0400
Received: by mail-wm0-f47.google.com with SMTP id u138so8126424wmu.5
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 00:41:47 -0700 (PDT)
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-39-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b420cf7c-a15f-6edc-74a8-4e41738bad28@redhat.com>
Date: Wed, 18 Oct 2017 09:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171016172609.23422-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 38/50] translate-all: use a binary
 search tree to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org

On 16/10/2017 19:25, Richard Henderson wrote:
>   * Translation Cache-related fields of a TB.
> + * This struct exists just for convenience; we keep track of TB's in a binary
> + * search tree, and the only fields needed to compare TB's in the tree are
> + * @ptr and @size. @search is brought here for consistency, since it is also
> + * a TC-related field.
>   */
>  struct tb_tc {
>      void *ptr;    /* pointer to the translated code */
>      uint8_t *search;  /* pointer to search data */
> +    size_t size;
>  };

Isn't search equal to ptr + size, or something like that?

Paolo
