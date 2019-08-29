Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E524C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2973B2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKdBec0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2973B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NwV-0007OB-5x
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3NiC-0007Bp-2J
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3NiA-0001wl-QT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:55:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3NiA-0001wD-Iu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:55:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id u16so4209422wrr.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FCpUQ9YsClgF4PcUE7Hce8uFYZKoJJ1UcHOaaE0v3Xc=;
 b=hKdBec0Op3ztprQWjvM7XtWtfxFiQUAn9qJCs20r0NZZoClumASaY2gnLtPalJ1qjl
 6LgplT8LwNTi6a3VlfVTDSHX26sNp0kH/O1P8/0ZOmkj1x0X7qArKxTimjZTKJjhAz5k
 7AxE7pefbDaE0Z/tD5avN3ZP460MRTz+eMdkcJbpoQAe+6h/dySuTAidkfXSUreGc4bB
 RFPO8+IgQyDXoMxkW3yZp57yIrGnMQQab2yI3X+rdxv31pRZskHsWhAeqXOtdbcLRDvL
 skypz7rWjNib5Q86KK7E6RT3g0ZTHGF5J20LDZL2IB45mRWJae35v6bVlAaiDz3UMZcS
 M9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FCpUQ9YsClgF4PcUE7Hce8uFYZKoJJ1UcHOaaE0v3Xc=;
 b=BWHR1vhXDa8ay/ZjAVBbR0398ECF9sbPPw55aHE6MIzl+YZlG7wtJUog9/LVvkgla3
 lE4YIXsF/dNOfsPjkdwm92YH9k0+3zvAnqkESl6FGfGCn/vD/8PPmtdTh2JHBTbKB4jf
 LEXZPaFeCYi7Em9qalqubN4Pa9qBPuIV2cc8eeZ6XWVnGBIGxlsL2qkDUhp6dJNs4Wle
 lzhnSm7G/6DXHNXrvJmu26jV7AA4QcLhLg1/Ig12t/ILN9X0yhHkZL5RmoFgu6fAZ0eB
 xQQPlL4oMIvW0uWkRbPcS8UG09Z8xuOgauW6nrnu1oqyW+fv4VxUV12DrmtJN5vbdtrv
 ww6g==
X-Gm-Message-State: APjAAAWB1EENQroZhskumYPK4ZeCtOT66AG3lkKfEVRADWf5Qfoudprr
 YvPpQwwuLtlcOsTE/obZ98iNzgCUnJg=
X-Google-Smtp-Source: APXvYqwZb+pAFQWYJ0rbMz2RS26kTy+4+6zuDxs7FPqkHNDI1rhfK6rL+IZUhmMvGaK10FzHTw36jQ==
X-Received: by 2002:a5d:6192:: with SMTP id j18mr2686376wru.336.1567097749266; 
 Thu, 29 Aug 2019 09:55:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm3907884wrj.17.2019.08.29.09.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:55:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D45DA1FF87;
 Thu, 29 Aug 2019 17:55:47 +0100 (BST)
References: <20190829160710.8792-1-berrange@redhat.com>
 <20190829160710.8792-4-berrange@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190829160710.8792-4-berrange@redhat.com>
Date: Thu, 29 Aug 2019 17:55:47 +0100
Message-ID: <87woev52ss.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 3/4] docs: document use of automatic
 cleanup functions in glib
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Document the use of g_autofree and g_autoptr in glib for automatic
> freeing of memory.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  CODING_STYLE.rst | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 4501d87352..39397f0f6f 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -441,6 +441,91 @@ In addition, QEMU assumes that the compiler does not=
 use the latitude
>  given in C99 and C11 to treat aspects of signed '<<' as undefined, as
>  documented in the GNU Compiler Collection manual starting at version 4.0.
>
> +Automatic memory deallocation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +QEMU has a mandatory dependency either the GCC or CLang compiler. As
> +such it has the freedom to make use of a C language extension for
> +automatically running a cleanup function when a stack variable goes
> +out of scope. This can be used to simplify function cleanup paths,
> +often allowing many goto jumps to be eliminated, through automatic
> +free'ing of memory.
> +
> +The GLib2 library provides a number of functions/macros for enabling
> +automatic cleanup:
> +
> +  `<https://developer.gnome.org/glib/stable/glib-Miscellaneous-Macros.ht=
ml>`_
> +
> +Most notably:
> +
> +* g_autofree - will invoke g_free() on the variable going out of scope
> +
> +* g_autoptr - for structs / objects, will invoke the cleanup func created
> +  by a previous use of G_DEFINE_AUTOPTR_CLEANUP_FUNC. This is
> +  supported for most GLib data types and GObjects
> +
> +For example, instead of
> +
> +.. code-block:: c
> +
> +    int somefunc(void) {
> +        int ret =3D -1;
> +        char *foo =3D g_strdup_printf("foo%", "wibble");
> +        GList *bar =3D .....
> +
> +        if (eek) {
> +           goto cleanup;
> +        }
> +
> +        ret =3D 0;
> +
> +      cleanup:
> +        g_free(foo);
> +        g_list_free(bar);
> +        return ret;
> +    }
> +
> +Using g_autofree/g_autoptr enables the code to be written as:
> +
> +.. code-block:: c
> +
> +    int somefunc(void) {
> +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> +        g_autoptr (GList) bar =3D .....
> +
> +        if (eek) {
> +           return -1;
> +        }
> +
> +        return 0;
> +    }
> +
> +While this generally results in simpler, less leak-prone code, there
> +are still some caveats to beware of
> +
> +* Variables declared with g_auto* MUST always be initialized,
> +  otherwise the cleanup function will use uninitialized stack memory
> +
> +* If a variable declared with g_auto* holds a value which must
> +  live beyond the life of the function, that value must be saved
> +  and the original variable NULL'd out. This can be simpler using
> +  g_steal_pointer
> +
> +
> +.. code-block:: c
> +
> +    char *somefunc(void) {
> +        g_autofree char *foo =3D g_strdup_printf("foo%", "wibble");
> +        g_autoptr (GList) bar =3D .....
> +
> +        if (eek) {
> +           return NULL;
> +        }
> +
> +        return g_steal_pointer(&foo);
> +    }
> +
> +
>  Error handling and reporting
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D


--
Alex Benn=C3=A9e

