Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97140207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqBtz8AF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97140207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZ1P-00076U-PF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYz6-0003jC-TV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:24:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYz5-0005Tw-3k
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:24:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so2577933wro.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6vZYLENAwP+r/+fZNjrAjmyi4brgpxM6B8dUEEXngNI=;
 b=BqBtz8AFnyTA2siMQ2wrNdBZrz1ob3M+Odnpu7XYrRflsOER/VxzJ1vQMnpslj+hgq
 pydOd4aHQotjTmeW3Sp7Y+MnJOjllEaI50344p0E6opU0C9e/7xw74PIw2hyahAtj239
 lqPPuDmR9yYvgGfX7tmaJMADn8ucpPYO4qzsBu+b5n0Ex8LAXUhDWawEqA3H+GUzG/Df
 ORKSn+DWdWxKGl+EmwEBV1QKMUr+FGnZYkTiDEUAHCnDl87cbzAYdQQtj3v+DfRzT7JY
 FWGo+/7DdKZJN08tefN0rUDWo0Q9/ep+il9TKZ1Br73zdR67GHbZiW63hzcN6Dvy/tew
 vltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6vZYLENAwP+r/+fZNjrAjmyi4brgpxM6B8dUEEXngNI=;
 b=so6jJ2jXhfYXc4JdYLAy09/fb8PSeE9y9BG81VkBNcY099MJWAL2xLmeQ4r7f6aCJw
 5TfKu/w78cN3idm77/x+ycGRqROJRJez3vxFLe8eMQWJW0iJnjgcimkbj0NNCnheFld5
 6Ct4zBm3LPo8WPGtXAwiUKwEuLz7IqmZJZkvSyg6vEGS2Bs1ABNgcJm3+Z0uTQla67B2
 ktbJDuwhWhQS+HjT4VF8IKsbnpMyQzKfKLanDvFb5K4Zr4OqRrLfPPI5NVtv+3Icp5Fd
 AdNgfwkhobMuVIlswgAroKjFtGAxqEErsTLPJiKCtVYJVnTiiTSTKaIcPvXsslr/e3fS
 9PvA==
X-Gm-Message-State: AOAM530uKVkPtT4PAM/63LAkGSNXF7jhisnjsUETHORyrC63u5LVF65L
 B0a+y0STa7QIiNU95g0OMAo=
X-Google-Smtp-Source: ABdhPJyhjWcTk3cB2/Q0mVuAeMuQ9DyJhOSa8xVDk48Mg+kgP4+ElS+YH6Y2dCgDIspdWjv1MlbEig==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr8924496wrm.168.1592403849482; 
 Wed, 17 Jun 2020 07:24:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h7sm604365wml.24.2020.06.17.07.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:24:08 -0700 (PDT)
Date: Wed, 17 Jun 2020 15:24:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 01/19] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
Message-ID: <20200617142407.GH1728005@stefanha-x1.localdomain>
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-2-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <20200522160755.886-2-robert.foley@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, Lingfeng Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 12:07:37PM -0400, Robert Foley wrote:
> +#define UC_DEBUG 0
> +#if UC_DEBUG && defined(CONFIG_TSAN)
> +#define UC_TRACE(fmt, ...) fprintf(stderr, "%s:%d:%p " fmt "\n", \
> +    __func__, __LINE__, __tsan_get_current_fiber(), ##__VA_ARGS__);
> +#else
> +#define UC_TRACE(fmt, ...)
> +#endif

QEMU has tracing support, see docs/devel/tracing.txt. These fprintfs
should be trace events defined in the util/trace-events file.

> +
>  /**
>   * Per-thread coroutine bookkeeping
>   */
> @@ -65,7 +80,20 @@ union cc_arg {
>      int i[2];
>  };
> =20
> -static void finish_switch_fiber(void *fake_stack_save)
> +/* QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use it.=
 */
> +static inline __attribute__((always_inline))

Please document why always_inline is necessary here and in other
functions. Is it for performance or because the __tsan_*() functions
need to be called from a the parent function?

> +void on_new_fiber(CoroutineUContext *co)
> +{
> +#ifdef CONFIG_TSAN
> +    co->tsan_co_fiber =3D __tsan_create_fiber(0); /* flags: sync on swit=
ch */
> +    co->tsan_caller_fiber =3D __tsan_get_current_fiber();
> +    UC_TRACE("Create new TSAN co fiber. co: %p co fiber: %p caller fiber=
: %p ",
> +             co, co->tsan_co_fiber, co->tsan_caller_fiber);
> +#endif
> +}
> +
> +static inline __attribute__((always_inline))
> +void finish_switch_fiber(void *fake_stack_save)
>  {
>  #ifdef CONFIG_ASAN
>      const void *bottom_old;
> @@ -78,18 +106,40 @@ static void finish_switch_fiber(void *fake_stack_sav=
e)
>          leader.stack_size =3D size_old;
>      }
>  #endif
> +#ifdef CONFIG_TSAN
> +    if (fake_stack_save) {
> +        __tsan_release(fake_stack_save);
> +        __tsan_switch_to_fiber(fake_stack_save, 0);  /* 0=3Dsynchronize =
*/
> +    }
> +#endif
>  }
> =20
> -static void start_switch_fiber(void **fake_stack_save,
> -                               const void *bottom, size_t size)
> +static inline __attribute__((always_inline)) void start_switch_fiber(
> +    CoroutineAction action, void **fake_stack_save,
> +    const void *bottom, size_t size, void *new_fiber)
>  {
>  #ifdef CONFIG_ASAN
> -    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
> +    if (action =3D=3D COROUTINE_TERMINATE) {
> +        __sanitizer_start_switch_fiber(
> +            action =3D=3D COROUTINE_TERMINATE ? NULL : fake_stack_save,

The if statement already checks action =3D=3D COROUTINE_TERMINATE, why is it
being checked again?

I think the old behavior can be retained by dropping the if statement
like this:

  __sanitizer_start_switch_fiber(action =3D=3D COROUTINE_TERMINATE ?
                                 NULL : fake_stack_save,
				 bottom, size);

> +            bottom, size);
> +    }
> +#endif
> +#ifdef CONFIG_TSAN
> +    void *curr_fiber =3D
> +        __tsan_get_current_fiber();
> +    __tsan_acquire(curr_fiber);
> +
> +    UC_TRACE("Current fiber: %p.", curr_fiber);
> +    *fake_stack_save =3D curr_fiber;
> +    UC_TRACE("Switch to fiber %p", new_fiber);
> +    __tsan_switch_to_fiber(new_fiber, 0);  /* 0=3Dsynchronize */
>  #endif
>  }

Please split start_switch_fiber() into two functions:
start_switch_fiber_asan() and start_switch_fiber_tsan(). That way the
asan- and tsan-specific arguments can be kept separate and the
co->tsan_* fields only need to be compiled in when CONFIG_TSAN is
defined.

For example:

  static inline __attribute__((always_inline))
  void start_switch_fiber_tsan(void **fake_stack_save,
                               CoroutineUContext *co,
  			     bool caller)
  {
  #ifdef CONFIG_TSAN
      void *new_fiber =3D caller ?
                        co->tsan_caller_fiber :
                        co->tsan_co_fiber;
      void *curr_fiber =3D __tsan_get_current_fiber();
      __tsan_acquire(curr_fiber);

      UC_TRACE("Current fiber: %p.", curr_fiber);
      *fake_stack_save =3D curr_fiber;
      UC_TRACE("Switch to fiber %p", new_fiber);
      __tsan_switch_to_fiber(new_fiber, 0);  /* 0=3Dsynchronize */
  #endif
  }

This does two things:
1. Unrelated ASAN and TSAN code is separate and each function only
   has arguments that are actually needed.
2. The co->tsan_caller_fiber and co->tsan_co_fiber fields are only
   access from within #ifdef CONFIG_TSAN.

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qJ4cACgkQnKSrs4Gr
c8gd2Af+KqJ9d/LbymQTFv2zQ5yNFA3NQDDKP/e6Jr3sC45/z3u8GC+fi9OsHGRC
QJOUeftpzpHGU4El3u/d3U7J9FYCcrbB+D9IeHJs6/KDxhQFioTMoAlr1VlAF/fR
00H+6cDAsD31nZiXIKJjmLXOySwkLhvUVeBK0QsvKyuYEyJibsYQK7PKhfBC5zT6
ZCbkzLv5g2bMsrhkG3CSPQH09xayMgmlEDDAq97Mext9KGBAnxiRzliVv8FVZ/Uk
SO9GnfagYdHenvctyRiHzWtwTPE3jOZ93VIlthZmC8VCkqKMksj2Ci+PMPKFxGik
X0XB61K7r7kx67AyyKPhRM/dqEACuw==
=SJ+x
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--

