Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0064AC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A399620674
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX69zvTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A399620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7E1K-0002m2-Qi
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 04:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k7E0j-0002I9-18; Sun, 16 Aug 2020 04:27:25 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:42751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k7E0g-00029B-GW; Sun, 16 Aug 2020 04:27:24 -0400
Received: by mail-oi1-x231.google.com with SMTP id j7so12144244oij.9;
 Sun, 16 Aug 2020 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yNKVsnrfUrUERwIie4oLeayjoiN+EQXXS/LThrnMAJg=;
 b=DX69zvTEcupe1/5sPizB4xd7E3s30jmYbd8D4f+Hb5A5gYYAlGkptlYPH+nPbJDXH6
 TwlfpRG3j+4y6APNOcxPBDGxQGLEFbPvOfjxie4IhC81CofR2h5cLpIO4UCmkH6/NpxW
 bVwjFb7sjB0a/wfggyJSIe8VJCU2i65F65pSSe0WI6uV9wdmLmavkg+kY5bL1NSjriGl
 OxkumLnRVx1XjtbkXuvHwvFTNGKQDKdcX9WxA4khU39dNVbUQy7vZ7SdsC9Xrq8jq5jc
 cBQ2vQS6XzAu8xvIyFztvsbbl/hgVAHmrub3jJGxQ/TYCt/ubdnHzAXgFodS5o+SF9fz
 Oy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yNKVsnrfUrUERwIie4oLeayjoiN+EQXXS/LThrnMAJg=;
 b=UP4gpZaPQhb80vAUBZFvgYYd+2wyvEpNDOBxjROUsOTIMLhvcZUuWUsxQy/o4GodZ/
 7tjAb/aoOSCwp3t5yXhhWaM0+I0pkNfjU1WGlPrHHPBkQzWC/pmjq4nr2kBVeZfXre+u
 513g4i/stLbzqHyyUWcXWWQ06NUribGXE5jKX1WNRhFfzZl+aEa3XXyyZnucLXxZ65zZ
 57K0B+G0xk9JIQRKjJpkUzD1D/bmw7QxsNlaYworOn0cQpFgVtrJ5M018EZ1gM7CA4zN
 HRaIFLY0BvVd1aM5Lx6F6pQ4HRcMu1hGWEp1no/T+lDR0JkeEssEq/QIVg0PBl3Vd/VE
 t7XQ==
X-Gm-Message-State: AOAM530sYXtRyBh65lQ9+R94w8HVDWzMdutjXqy8Zwcq0eMInon7ab2d
 9lCgeyukOMpo+jo8hd5sPIIDKQq2BEmQTCI4tB4=
X-Google-Smtp-Source: ABdhPJySNmZox4Y2K6voZELKqTNOUh7YCFx2/8ISjvzOdjwGMIlMUTGbNZpI3Wy7wI4bzZSHP6Bdi6ytjaAUbCn83lk=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr6612318oif.56.1597566441022; 
 Sun, 16 Aug 2020 01:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200812104918.107116-1-stefanha@redhat.com>
 <20200812104918.107116-2-stefanha@redhat.com>
In-Reply-To: <20200812104918.107116-2-stefanha@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 16 Aug 2020 16:26:45 +0800
Message-ID: <CAKXe6S+nUWQGFDKRu8mBBOTKc1kWc7YfO=p+F7+ObnmW017atg@mail.gmail.com>
Subject: Re: [PATCH 1/3] util/iov: add iov_discard_undo()
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000038eb6405acfa6c7c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x231.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000038eb6405acfa6c7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:52=E5=86=99=E9=81=93=EF=BC=9A

> The iov_discard_front/back() operations are useful for parsing iovecs
> but they modify the array elements. If the original array is needed
> after parsing finishes there is currently no way to restore it.
>
> Although g_memdup() can be used before performing destructive
> iov_discard_front/back() operations, this is inefficient.
>
> Introduce iov_discard_undo() to restore the array to the state prior to
> an iov_discard_front/back() operation.
>
>

Seems there are some errors. See below



> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/iov.h |  23 +++++++
>  tests/test-iov.c   | 165 +++++++++++++++++++++++++++++++++++++++++++++
>  util/iov.c         |  50 ++++++++++++--
>  3 files changed, 234 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
> index bffc151282..b6b283a5e5 100644
> --- a/include/qemu/iov.h
> +++ b/include/qemu/iov.h
> @@ -130,6 +130,29 @@ size_t iov_discard_front(struct iovec **iov, unsigne=
d
> int *iov_cnt,
>  size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,
>                          size_t bytes);
>
> +/* Information needed to undo an iov_discard_*() operation */
> +typedef struct {
> +    struct iovec *modified_iov;
> +    struct iovec orig;
> +} IOVDiscardUndo;
> +
> +/*
> + * Undo an iov_discard_front_undoable() or iov_discard_back_undoable()
> + * operation. If multiple operations are made then each one needs a
> separate
> + * IOVDiscardUndo and iov_discard_undo() must be called in the reverse
> order
> + * that the operations were made.
> + */
> +void iov_discard_undo(IOVDiscardUndo *undo);
> +
> +/*
> + * Undoable versions of iov_discard_front() and iov_discard_back(). Use
> + * iov_discard_undo() to reset to the state before the discard operation=
s.
> + */
> +size_t iov_discard_front_undoable(struct iovec **iov, unsigned int
> *iov_cnt,
> +                                  size_t bytes, IOVDiscardUndo *undo);
> +size_t iov_discard_back_undoable(struct iovec *iov, unsigned int *iov_cn=
t,
> +                                 size_t bytes, IOVDiscardUndo *undo);
> +
>  typedef struct QEMUIOVector {
>      struct iovec *iov;
>      int niov;
> diff --git a/tests/test-iov.c b/tests/test-iov.c
> index 458ca25099..9c415e2f1f 100644
> --- a/tests/test-iov.c
> +++ b/tests/test-iov.c
> @@ -26,6 +26,12 @@ static void iov_free(struct iovec *iov, unsigned niov)
>      g_free(iov);
>  }
>
> +static bool iov_equals(const struct iovec *a, const struct iovec *b,
> +                       unsigned niov)
> +{
> +    return memcmp(a, b, sizeof(a[0]) * niov) =3D=3D 0;
> +}
> +
>  static void test_iov_bytes(struct iovec *iov, unsigned niov,
>                             size_t offset, size_t bytes)
>  {
> @@ -335,6 +341,87 @@ static void test_discard_front(void)
>      iov_free(iov, iov_cnt);
>  }
>
> +static void test_discard_front_undo(void)
> +{
> +    IOVDiscardUndo undo;
> +    struct iovec *iov;
> +    struct iovec *iov_tmp;
> +    struct iovec *iov_orig;
> +    unsigned int iov_cnt;
> +    unsigned int iov_cnt_tmp;
> +    size_t size;
> +
> +    /* Discard zero bytes */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_tmp =3D iov;
> +    iov_cnt_tmp =3D iov_cnt;
> +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, 0, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard more bytes than vector size */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_tmp =3D iov;
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D iov_size(iov, iov_cnt);
> +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, size + 1, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
>

The 'iov_discard_front_undoable' will change the 'iov_tmp' it will not
touch 'iov_orig'.
So the test will be always passed. The actually function will not be tested=
.

Also, maybe we could abstract a function to do these discard test?


> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard entire vector */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_tmp =3D iov;
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D iov_size(iov, iov_cnt);
> +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, size, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard within first element */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_tmp =3D iov;
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D g_test_rand_int_range(1, iov->iov_len);
> +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, size, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard entire first element */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_tmp =3D iov;
> +    iov_cnt_tmp =3D iov_cnt;
> +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, iov->iov_len,
> &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard within second element */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_tmp =3D iov;
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D iov->iov_len + g_test_rand_int_range(1, iov[1].iov_len);
> +    iov_discard_front_undoable(&iov_tmp, &iov_cnt_tmp, size, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +}
> +
>  static void test_discard_back(void)
>  {
>      struct iovec *iov;
> @@ -404,6 +491,82 @@ static void test_discard_back(void)
>      iov_free(iov, iov_cnt);
>  }
>
> +static void test_discard_back_undo(void)
> +{
> +    IOVDiscardUndo undo;
> +    struct iovec *iov;
> +    struct iovec *iov_orig;
> +    unsigned int iov_cnt;
> +    unsigned int iov_cnt_tmp;
> +    size_t size;
> +
> +    /* Discard zero bytes */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_cnt_tmp =3D iov_cnt;
> +    iov_discard_back_undoable(iov, &iov_cnt_tmp, 0, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard more bytes than vector size */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D iov_size(iov, iov_cnt);
> +    iov_discard_back_undoable(iov, &iov_cnt_tmp, size + 1, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard entire vector */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D iov_size(iov, iov_cnt);
> +    iov_discard_back_undoable(iov, &iov_cnt_tmp, size, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard within last element */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D g_test_rand_int_range(1, iov[iov_cnt - 1].iov_len);
> +    iov_discard_back_undoable(iov, &iov_cnt_tmp, size, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard entire last element */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D iov[iov_cnt - 1].iov_len;
> +    iov_discard_back_undoable(iov, &iov_cnt_tmp, size, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +
> +    /* Discard within second-to-last element */
> +    iov_random(&iov, &iov_cnt);
> +    iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);
> +    iov_cnt_tmp =3D iov_cnt;
> +    size =3D iov[iov_cnt - 1].iov_len +
> +           g_test_rand_int_range(1, iov[iov_cnt - 2].iov_len);
> +    iov_discard_back_undoable(iov, &iov_cnt_tmp, size, &undo);
> +    iov_discard_undo(&undo);
> +    assert(iov_equals(iov, iov_orig, iov_cnt));
> +    g_free(iov_orig);
> +    iov_free(iov, iov_cnt);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -412,5 +575,7 @@ int main(int argc, char **argv)
>      g_test_add_func("/basic/iov/io", test_io);
>      g_test_add_func("/basic/iov/discard-front", test_discard_front);
>      g_test_add_func("/basic/iov/discard-back", test_discard_back);
> +    g_test_add_func("/basic/iov/discard-front-undo",
> test_discard_front_undo);
> +    g_test_add_func("/basic/iov/discard-back-undo",
> test_discard_back_undo);
>      return g_test_run();
>  }
> diff --git a/util/iov.c b/util/iov.c
> index 45ef3043ee..efcf04b445 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -636,14 +636,33 @@ void qemu_iovec_clone(QEMUIOVector *dest, const
> QEMUIOVector *src, void *buf)
>      }
>  }
>
> -size_t iov_discard_front(struct iovec **iov, unsigned int *iov_cnt,
> -                         size_t bytes)
> +void iov_discard_undo(IOVDiscardUndo *undo)
> +{
> +    /* Restore original iovec if it was modified */
> +    if (undo->modified_iov) {
> +        *undo->modified_iov =3D undo->orig;
> +    }
> +}
> +
> +size_t iov_discard_front_undoable(struct iovec **iov,
> +                                  unsigned int *iov_cnt,
> +                                  size_t bytes,
> +                                  IOVDiscardUndo *undo)
>  {
>      size_t total =3D 0;
>      struct iovec *cur;
>
> +    if (undo) {
> +        undo->modified_iov =3D NULL;
> +    }
> +
>      for (cur =3D *iov; *iov_cnt > 0; cur++) {
>          if (cur->iov_len > bytes) {
> +            if (undo) {
> +                undo->modified_iov =3D cur;
> +                undo->orig =3D *cur;
> +            }
> +
>

Why here we remember the 'cur'? 'cur' is the some of the 'iov'.
Maybe we remember the 'iov'. I think we need the undo structure like this:

struct IOVUndo {
    iov **modified_iov;
    iov *orig;
};

Then we can remeber the origin 'iov'.

Thanks,
Li Qiang



>              cur->iov_base +=3D bytes;
>              cur->iov_len -=3D bytes;
>              total +=3D bytes;
> @@ -659,12 +678,24 @@ size_t iov_discard_front(struct iovec **iov,
> unsigned int *iov_cnt,
>      return total;
>  }
>
> -size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,
> -                        size_t bytes)
> +size_t iov_discard_front(struct iovec **iov, unsigned int *iov_cnt,
> +                         size_t bytes)
> +{
> +    return iov_discard_front_undoable(iov, iov_cnt, bytes, NULL);
> +}
> +
> +size_t iov_discard_back_undoable(struct iovec *iov,
> +                                 unsigned int *iov_cnt,
> +                                 size_t bytes,
> +                                 IOVDiscardUndo *undo)
>  {
>      size_t total =3D 0;
>      struct iovec *cur;
>
> +    if (undo) {
> +        undo->modified_iov =3D NULL;
> +    }
> +
>      if (*iov_cnt =3D=3D 0) {
>          return 0;
>      }
> @@ -673,6 +704,11 @@ size_t iov_discard_back(struct iovec *iov, unsigned
> int *iov_cnt,
>
>      while (*iov_cnt > 0) {
>          if (cur->iov_len > bytes) {
> +            if (undo) {
> +                undo->modified_iov =3D cur;
> +                undo->orig =3D *cur;
> +            }
> +
>              cur->iov_len -=3D bytes;
>              total +=3D bytes;
>              break;
> @@ -687,6 +723,12 @@ size_t iov_discard_back(struct iovec *iov, unsigned
> int *iov_cnt,
>      return total;
>  }
>
> +size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,
> +                        size_t bytes)
> +{
> +    return iov_discard_back_undoable(iov, iov_cnt, bytes, NULL);
> +}
> +
>  void qemu_iovec_discard_back(QEMUIOVector *qiov, size_t bytes)
>  {
>      size_t total;
> --
> 2.26.2
>
>

--00000000000038eb6405acfa6c7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Stefan Hajnoczi &lt;<a href=3D"mailto=
:stefanha@redhat.com">stefanha@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B48=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:52=E5=86=99=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
The iov_discard_front/back() operations are useful for parsing iovecs<br>
but they modify the array elements. If the original array is needed<br>
after parsing finishes there is currently no way to restore it.<br>
<br>
Although g_memdup() can be used before performing destructive<br>
iov_discard_front/back() operations, this is inefficient.<br>
<br>
Introduce iov_discard_undo() to restore the array to the state prior to<br>
an iov_discard_front/back() operation.<br>
<br></blockquote><div><br></div><div><br></div><div>Seems there are some er=
rors. See below</div><div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/qemu/iov.h |=C2=A0 23 +++++++<br>
=C2=A0tests/test-iov.c=C2=A0 =C2=A0| 165 ++++++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0util/iov.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 50 ++++++++++++--=
<br>
=C2=A03 files changed, 234 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/include/qemu/iov.h b/include/qemu/iov.h<br>
index bffc151282..b6b283a5e5 100644<br>
--- a/include/qemu/iov.h<br>
+++ b/include/qemu/iov.h<br>
@@ -130,6 +130,29 @@ size_t iov_discard_front(struct iovec **iov, unsigned =
int *iov_cnt,<br>
=C2=A0size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0size_t bytes);<br>
<br>
+/* Information needed to undo an iov_discard_*() operation */<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 struct iovec *modified_iov;<br>
+=C2=A0 =C2=A0 struct iovec orig;<br>
+} IOVDiscardUndo;<br>
+<br>
+/*<br>
+ * Undo an iov_discard_front_undoable() or iov_discard_back_undoable()<br>
+ * operation. If multiple operations are made then each one needs a separa=
te<br>
+ * IOVDiscardUndo and iov_discard_undo() must be called in the reverse ord=
er<br>
+ * that the operations were made.<br>
+ */<br>
+void iov_discard_undo(IOVDiscardUndo *undo);<br>
+<br>
+/*<br>
+ * Undoable versions of iov_discard_front() and iov_discard_back(). Use<br=
>
+ * iov_discard_undo() to reset to the state before the discard operations.=
<br>
+ */<br>
+size_t iov_discard_front_undoable(struct iovec **iov, unsigned int *iov_cn=
t,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t bytes, IOVDiscardUndo =
*undo);<br>
+size_t iov_discard_back_undoable(struct iovec *iov, unsigned int *iov_cnt,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t bytes, IOVDiscardUndo *=
undo);<br>
+<br>
=C2=A0typedef struct QEMUIOVector {<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *iov;<br>
=C2=A0 =C2=A0 =C2=A0int niov;<br>
diff --git a/tests/test-iov.c b/tests/test-iov.c<br>
index 458ca25099..9c415e2f1f 100644<br>
--- a/tests/test-iov.c<br>
+++ b/tests/test-iov.c<br>
@@ -26,6 +26,12 @@ static void iov_free(struct iovec *iov, unsigned niov)<b=
r>
=C2=A0 =C2=A0 =C2=A0g_free(iov);<br>
=C2=A0}<br>
<br>
+static bool iov_equals(const struct iovec *a, const struct iovec *b,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0unsigned niov)<br>
+{<br>
+=C2=A0 =C2=A0 return memcmp(a, b, sizeof(a[0]) * niov) =3D=3D 0;<br>
+}<br>
+<br>
=C2=A0static void test_iov_bytes(struct iovec *iov, unsigned niov,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 size_t offset, size_t bytes)<br>
=C2=A0{<br>
@@ -335,6 +341,87 @@ static void test_discard_front(void)<br>
=C2=A0 =C2=A0 =C2=A0iov_free(iov, iov_cnt);<br>
=C2=A0}<br>
<br>
+static void test_discard_front_undo(void)<br>
+{<br>
+=C2=A0 =C2=A0 IOVDiscardUndo undo;<br>
+=C2=A0 =C2=A0 struct iovec *iov;<br>
+=C2=A0 =C2=A0 struct iovec *iov_tmp;<br>
+=C2=A0 =C2=A0 struct iovec *iov_orig;<br>
+=C2=A0 =C2=A0 unsigned int iov_cnt;<br>
+=C2=A0 =C2=A0 unsigned int iov_cnt_tmp;<br>
+=C2=A0 =C2=A0 size_t size;<br>
+<br>
+=C2=A0 =C2=A0 /* Discard zero bytes */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_tmp =3D iov;<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 iov_discard_front_undoable(&amp;iov_tmp, &amp;iov_cnt_tmp, 0=
, &amp;undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard more bytes than vector size */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_tmp =3D iov;<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D iov_size(iov, iov_cnt);<br>
+=C2=A0 =C2=A0 iov_discard_front_undoable(&amp;iov_tmp, &amp;iov_cnt_tmp, s=
ize + 1, &amp;undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br></blockquote>=
<div><br></div><div>The &#39;iov_discard_front_undoable&#39; will change th=
e &#39;iov_tmp&#39; it will not touch &#39;iov_orig&#39;.</div><div>So the =
test will be always passed. The actually function will not be tested.</div>=
<div><br></div><div>Also, maybe we could abstract a function to do these di=
scard test?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard entire vector */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_tmp =3D iov;<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D iov_size(iov, iov_cnt);<br>
+=C2=A0 =C2=A0 iov_discard_front_undoable(&amp;iov_tmp, &amp;iov_cnt_tmp, s=
ize, &amp;undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard within first element */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_tmp =3D iov;<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D g_test_rand_int_range(1, iov-&gt;iov_len);<br>
+=C2=A0 =C2=A0 iov_discard_front_undoable(&amp;iov_tmp, &amp;iov_cnt_tmp, s=
ize, &amp;undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard entire first element */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_tmp =3D iov;<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 iov_discard_front_undoable(&amp;iov_tmp, &amp;iov_cnt_tmp, i=
ov-&gt;iov_len, &amp;undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard within second element */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_tmp =3D iov;<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D iov-&gt;iov_len + g_test_rand_int_range(1, iov[1].i=
ov_len);<br>
+=C2=A0 =C2=A0 iov_discard_front_undoable(&amp;iov_tmp, &amp;iov_cnt_tmp, s=
ize, &amp;undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+}<br>
+<br>
=C2=A0static void test_discard_back(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *iov;<br>
@@ -404,6 +491,82 @@ static void test_discard_back(void)<br>
=C2=A0 =C2=A0 =C2=A0iov_free(iov, iov_cnt);<br>
=C2=A0}<br>
<br>
+static void test_discard_back_undo(void)<br>
+{<br>
+=C2=A0 =C2=A0 IOVDiscardUndo undo;<br>
+=C2=A0 =C2=A0 struct iovec *iov;<br>
+=C2=A0 =C2=A0 struct iovec *iov_orig;<br>
+=C2=A0 =C2=A0 unsigned int iov_cnt;<br>
+=C2=A0 =C2=A0 unsigned int iov_cnt_tmp;<br>
+=C2=A0 =C2=A0 size_t size;<br>
+<br>
+=C2=A0 =C2=A0 /* Discard zero bytes */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 iov_discard_back_undoable(iov, &amp;iov_cnt_tmp, 0, &amp;und=
o);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard more bytes than vector size */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D iov_size(iov, iov_cnt);<br>
+=C2=A0 =C2=A0 iov_discard_back_undoable(iov, &amp;iov_cnt_tmp, size + 1, &=
amp;undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard entire vector */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D iov_size(iov, iov_cnt);<br>
+=C2=A0 =C2=A0 iov_discard_back_undoable(iov, &amp;iov_cnt_tmp, size, &amp;=
undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard within last element */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D g_test_rand_int_range(1, iov[iov_cnt - 1].iov_len);=
<br>
+=C2=A0 =C2=A0 iov_discard_back_undoable(iov, &amp;iov_cnt_tmp, size, &amp;=
undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard entire last element */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D iov[iov_cnt - 1].iov_len;<br>
+=C2=A0 =C2=A0 iov_discard_back_undoable(iov, &amp;iov_cnt_tmp, size, &amp;=
undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+<br>
+=C2=A0 =C2=A0 /* Discard within second-to-last element */<br>
+=C2=A0 =C2=A0 iov_random(&amp;iov, &amp;iov_cnt);<br>
+=C2=A0 =C2=A0 iov_orig =3D g_memdup(iov, sizeof(iov[0]) * iov_cnt);<br>
+=C2=A0 =C2=A0 iov_cnt_tmp =3D iov_cnt;<br>
+=C2=A0 =C2=A0 size =3D iov[iov_cnt - 1].iov_len +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_test_rand_int_range(1, iov[iov_=
cnt - 2].iov_len);<br>
+=C2=A0 =C2=A0 iov_discard_back_undoable(iov, &amp;iov_cnt_tmp, size, &amp;=
undo);<br>
+=C2=A0 =C2=A0 iov_discard_undo(&amp;undo);<br>
+=C2=A0 =C2=A0 assert(iov_equals(iov, iov_orig, iov_cnt));<br>
+=C2=A0 =C2=A0 g_free(iov_orig);<br>
+=C2=A0 =C2=A0 iov_free(iov, iov_cnt);<br>
+}<br>
+<br>
=C2=A0int main(int argc, char **argv)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
@@ -412,5 +575,7 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_func(&quot;/basic/iov/io&quot;, test_io);<br=
>
=C2=A0 =C2=A0 =C2=A0g_test_add_func(&quot;/basic/iov/discard-front&quot;, t=
est_discard_front);<br>
=C2=A0 =C2=A0 =C2=A0g_test_add_func(&quot;/basic/iov/discard-back&quot;, te=
st_discard_back);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/basic/iov/discard-front-undo&quot;, t=
est_discard_front_undo);<br>
+=C2=A0 =C2=A0 g_test_add_func(&quot;/basic/iov/discard-back-undo&quot;, te=
st_discard_back_undo);<br>
=C2=A0 =C2=A0 =C2=A0return g_test_run();<br>
=C2=A0}<br>
diff --git a/util/iov.c b/util/iov.c<br>
index 45ef3043ee..efcf04b445 100644<br>
--- a/util/iov.c<br>
+++ b/util/iov.c<br>
@@ -636,14 +636,33 @@ void qemu_iovec_clone(QEMUIOVector *dest, const QEMUI=
OVector *src, void *buf)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-size_t iov_discard_front(struct iovec **iov, unsigned int *iov_cnt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0size_t bytes)<br>
+void iov_discard_undo(IOVDiscardUndo *undo)<br>
+{<br>
+=C2=A0 =C2=A0 /* Restore original iovec if it was modified */<br>
+=C2=A0 =C2=A0 if (undo-&gt;modified_iov) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *undo-&gt;modified_iov =3D undo-&gt;orig;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+size_t iov_discard_front_undoable(struct iovec **iov,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *iov_cnt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t bytes,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IOVDiscardUndo *undo)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0size_t total =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *cur;<br>
<br>
+=C2=A0 =C2=A0 if (undo) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 undo-&gt;modified_iov =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0for (cur =3D *iov; *iov_cnt &gt; 0; cur++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cur-&gt;iov_len &gt; bytes) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (undo) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 undo-&gt;modified_=
iov =3D cur;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 undo-&gt;orig =3D =
*cur;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>Why here we remember the &#39;cur&#39=
;? &#39;cur&#39; is the some of the &#39;iov&#39;.</div><div>Maybe we remem=
ber=C2=A0the &#39;iov&#39;. I think we need the undo structure like this:</=
div><div><br></div><div>struct IOVUndo {</div><div>=C2=A0 =C2=A0 iov **modi=
fied_iov;=C2=A0</div><div>=C2=A0 =C2=A0 iov *orig;</div><div>};</div><div><=
br></div><div>Then we can remeber the origin &#39;iov&#39;.</div><div><br><=
/div><div>Thanks,</div><div>Li Qiang</div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur-&gt;iov_base +=3D bytes=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur-&gt;iov_len -=3D bytes;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total +=3D bytes;<br>
@@ -659,12 +678,24 @@ size_t iov_discard_front(struct iovec **iov, unsigned=
 int *iov_cnt,<br>
=C2=A0 =C2=A0 =C2=A0return total;<br>
=C2=A0}<br>
<br>
-size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size_t bytes)<br>
+size_t iov_discard_front(struct iovec **iov, unsigned int *iov_cnt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0size_t bytes)<br>
+{<br>
+=C2=A0 =C2=A0 return iov_discard_front_undoable(iov, iov_cnt, bytes, NULL)=
;<br>
+}<br>
+<br>
+size_t iov_discard_back_undoable(struct iovec *iov,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *iov_cnt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t bytes,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IOVDiscardUndo *undo)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0size_t total =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *cur;<br>
<br>
+=C2=A0 =C2=A0 if (undo) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 undo-&gt;modified_iov =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (*iov_cnt =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -673,6 +704,11 @@ size_t iov_discard_back(struct iovec *iov, unsigned in=
t *iov_cnt,<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (*iov_cnt &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cur-&gt;iov_len &gt; bytes) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (undo) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 undo-&gt;modified_=
iov =3D cur;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 undo-&gt;orig =3D =
*cur;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur-&gt;iov_len -=3D bytes;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total +=3D bytes;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -687,6 +723,12 @@ size_t iov_discard_back(struct iovec *iov, unsigned in=
t *iov_cnt,<br>
=C2=A0 =C2=A0 =C2=A0return total;<br>
=C2=A0}<br>
<br>
+size_t iov_discard_back(struct iovec *iov, unsigned int *iov_cnt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size_t bytes)<br>
+{<br>
+=C2=A0 =C2=A0 return iov_discard_back_undoable(iov, iov_cnt, bytes, NULL);=
<br>
+}<br>
+<br>
=C2=A0void qemu_iovec_discard_back(QEMUIOVector *qiov, size_t bytes)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0size_t total;<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div>

--00000000000038eb6405acfa6c7c--

