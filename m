Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959CCC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F9120818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F9120818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hneb8-0001RQ-93
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 03:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60197)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hneay-00012z-13
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hneax-0001wl-0r
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:43:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hneaw-0001wG-R4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:43:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so11525591plt.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 00:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gAlEcrM18b+W4ooSy7YFXsV7Rgsl8Z1fwjtL9i8HO9g=;
 b=ZLfnnw1s7sMFygTXq+17y24GTVqJfOPRuX2jOeizoYR6QuvZXPJlFHxoffYhNyGlMW
 9ue64FQcu0VJWkStZp75dx/FKEMTVunPMimUR/XDu7mcPBCRRdhyImeoc/w+28KP+giF
 9Fc2xbLbr8LQ2vhdJfoj8sk4xerRdh9RCEySnJmuJ6CXxsQBvrF0BmvXoe5a/9TqOhMy
 S6yFw1+xKLhEcUZT4gOJSF6XD1gzNSmYtzwP75ecjZNMhKZWhgKnebtKeI5Uw9TNox5u
 cM3JcrlBNd2sDQrFeIAr15tZwUQrE/xOznTs/mXy0GJ3UBCI7mppVoGSmTnNWyBFv8Dl
 Cx3A==
X-Gm-Message-State: APjAAAVDAp19Tr4s9gSqI21Udzdy2eCYoDIDd9n0v6jn92JFkmi9cVkx
 r9ZUTzvqK4MkAkFQdZM809ZxVg==
X-Google-Smtp-Source: APXvYqxpXgnDQ7pCZdVqtYAMgMIVgRAsVyMj85j7FLgPut6/TF26TKkDq5vpKgn6cC1K2ZvQAvXOaQ==
X-Received: by 2002:a17:902:f095:: with SMTP id
 go21mr42245607plb.58.1563349401072; 
 Wed, 17 Jul 2019 00:43:21 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q7sm28516959pff.2.2019.07.17.00.43.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 00:43:20 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Wed, 17 Jul 2019 15:43:11 +0800
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190717074311.GG30980@xz-x1>
References: <20190717071114.14772-1-richardw.yang@linux.intel.com>
 <20190717071114.14772-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717071114.14772-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: Re: [Qemu-devel] [PATCH v2 2/2] test-bitmap: add test for bitmap_set
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 03:11:14PM +0800, Wei Yang wrote:
> Add a test for bitmap_set. There are three cases:
> 
>   * Both start and end is BITS_PER_LONG aligned
>   * Only start is BITS_PER_LONG aligned
>   * Only end is BITS_PER_LONG aligned
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Hi, Wei,

Thanks for doing this.  I've got a few comments below.

> ---
>  tests/test-bitmap.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
> index cb7c5e462d..1f0123f604 100644
> --- a/tests/test-bitmap.c
> +++ b/tests/test-bitmap.c
> @@ -59,12 +59,45 @@ static void check_bitmap_copy_with_offset(void)
>      g_free(bmap3);
>  }
>  
> +static void check_bitmap_set(void)
> +{
> +    unsigned long *bmap;
> +
> +    bmap = bitmap_new(BMAP_SIZE);

Need to free this.

> +
> +    /* Both Aligned, set bits [BITS_PER_LONG, 2*BITS_PER_LONG] */
> +    bitmap_set(bmap, BITS_PER_LONG, BITS_PER_LONG);
> +    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG), ==, BITS_PER_LONG);

Can check all 1's set correctly.

       g_assert_cmpuint(bmap[1], ==, -1ul);

Can also make this at least across multiple long fields.

> +    g_assert_cmpint(find_next_zero_bit(bmap, 2 * BITS_PER_LONG, BITS_PER_LONG),
> +                    ==, 2 * BITS_PER_LONG);
> +
> +    bitmap_clear(bmap, 0, BMAP_SIZE);
> +    /* End Aligned, set bits [BITS_PER_LONG - 5, 2*BITS_PER_LONG] */
> +    bitmap_set(bmap, BITS_PER_LONG - 5, BITS_PER_LONG + 5);

Same here.

> +    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
> +                    ==, BITS_PER_LONG - 5);
> +    g_assert_cmpint(find_next_zero_bit(bmap,
> +                                       2 * BITS_PER_LONG, BITS_PER_LONG - 5),
> +                    ==, 2 * BITS_PER_LONG);
> +
> +    bitmap_clear(bmap, 0, BMAP_SIZE);
> +    /* Start Aligned, set bits [BITS_PER_LONG, 2*BITS_PER_LONG + 5] */
> +    bitmap_set(bmap, BITS_PER_LONG, BITS_PER_LONG + 5);

And here.

> +    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
> +                    ==, BITS_PER_LONG);
> +    g_assert_cmpint(find_next_zero_bit(bmap,
> +                                       2 * BITS_PER_LONG + 5, BITS_PER_LONG),
> +                    ==, 2 * BITS_PER_LONG + 5);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>  
>      g_test_add_func("/bitmap/bitmap_copy_with_offset",
>                      check_bitmap_copy_with_offset);
> +    g_test_add_func("/bitmap/bitmap_set",
> +                    check_bitmap_set);

Can at least do the same test to bitmap_set_atomic too, simply by
allowing your helper test function to take a func pointer:

void (*bmap_set_func)(unsigned long *map, long i, long len);

Then call with both bitmap_set{_atomic}.

Thanks,

-- 
Peter Xu

