Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C40C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78F620705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZGiBnVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78F620705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVblc-0004M5-0N
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jVbkx-0003nk-Lf
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:07:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jVbkw-00008B-LV
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:07:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id f13so21056120wrm.13
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kkVigSOyFNsaV1ZegAM2y/NGEHtYnnqvdavQS7+K9CM=;
 b=hZGiBnVcVjVFhmIk9wUmxg+n4prFL9jAWF1zbgFM2P/nTb3XjLF2mJtfg46ztJWg3O
 gkjXwwcafW5bMtPleQMk+4ekDBlCaIx3Pg3ibWNT7bP1INhfkJlVwBXprVlQGSsas1Oo
 EQS/NTrFF2dMF0bA2Xi42oET9DOaiVNYL9n6bfGVsNfzCRoe+IMseO/bM4i3iGe6ZVqC
 qLv4o0+3C57xDq09rplo04JB/XmZYVO2/WtFrq+zfy2AmzSE/UCjfMhxi5xD446bMbl3
 dODSUPnjb/jrZhzrs2/w93jE7A47GEYejLAaFci1I7L0ndqIIHehV3PO2XqlcVHM2mMy
 Kwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kkVigSOyFNsaV1ZegAM2y/NGEHtYnnqvdavQS7+K9CM=;
 b=qVxHRNIr3daTw8RQ39SDMnvWxMaHkmGv1I67SAXWMmmz6ucV+2d4ZDSzV7O4OeA4+b
 w7w0LbstvEuR/upW5YwqeJjTDcDJfdBLNq8kZk+6wJFM6vMeE3JnS0IqrpgKz92g7ONT
 gUGeNgsdtBfgIfenhRvUiCFatZXsWF65tMIVw0h3LluPQQAKEK0YejFNFVanvcXK+Ze9
 fbni9ZvHiLvfSbdtLlTzFYpgdo/jQvuIH/s4sfK7AznRRqRFcGBCT1E1S/kWE9Ae6uES
 nJlKieWx1HnnqQmcDg+syYuMKBWeCpQsb3nix6/opopek6SFjgAVh68Xhe8ljse5OH6m
 GYlQ==
X-Gm-Message-State: AGi0PuZDFNBOfLL6Dk/a/RHIh3ZjDVEfGrHj9Wz81pEI5qRewqJBGZGb
 f/DJ8faq8DVwuAUIqUvk3vvF8J8tJAJQ6cLtw+U=
X-Google-Smtp-Source: APiQypKl9Omap+fCExSxhFYqKFvQ6f1c9OsX9eaFt7j0+CXXdzYChe6K1qJRAjeto6ymIXbrB+mjhc/b8OvOJpEmcAc=
X-Received: by 2002:adf:c7c3:: with SMTP id y3mr18050721wrg.196.1588601254303; 
 Mon, 04 May 2020 07:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
In-Reply-To: <348d4774-bd5f-4832-bd7e-a21491fdac8d@www.fastmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 May 2020 16:07:22 +0200
Message-ID: <CAJ+F1CJsBRp+9yf=kGZt18APXskO8NWyQ1YEqauLYhiNmcW39Q@mail.gmail.com>
Subject: Re: [PATCH] virtiofsd: Use clone() and not unshare(), support non-root
To: Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, May 1, 2020 at 8:29 PM Colin Walters <walters@verbum.org> wrote:
>
> I'd like to make use of virtiofs as part of our tooling in
> https://github.com/coreos/coreos-assembler
> Most of the code runs as non-root today; qemu also runs as non-root.
> We use 9p right now.
>
> virtiofsd's builtin sandboxing effectively assumes it runs as
> root.
>
> First, change the code to use `clone()` and not `unshare()+fork()`.
>
> Next, automatically use `CLONE_NEWUSER` if we're running as non root.
>
> This is similar logic to that in https://github.com/containers/bubblewrap
> (Which...BTW, it could make sense for virtiofs to depend on bubblewrap
>  and re-exec itself rather than re-implementing the containerization
>  itself)
>

Now that systemd-nspawn works without privileges, isn't that also a
solution? One that would fit both system and session level
permissions, and integration with other services?

> Signed-off-by: Colin Walters <walters@verbum.org>
> ---
>  tools/virtiofsd/passthrough_ll.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 4c35c95b25..468617f6d6 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2530,6 +2530,21 @@ static void print_capabilities(void)
>      printf("}\n");
>  }
>
> +/* Copied from bubblewrap */
> +static int
> +raw_clone(unsigned long flags, void *child_stack)
> +{
> +#if defined(__s390__) || defined(__CRIS__)
> +  /*
> +   * On s390 and cris the order of the first and second arguments
> +   * of the raw clone() system call is reversed.
> +   */
> +    return (int) syscall(__NR_clone, child_stack, flags);
> +#else
> +    return (int) syscall(__NR_clone, flags, child_stack);
> +#endif
> +}
> +
>  /*
>   * Move to a new mount, net, and pid namespaces to isolate this process.
>   */
> @@ -2547,14 +2562,15 @@ static void setup_namespaces(struct lo_data *lo, =
struct fuse_session *se)
>       * an empty network namespace to prevent TCP/IP and other network
>       * activity in case this process is compromised.
>       */
> -    if (unshare(CLONE_NEWPID | CLONE_NEWNS | CLONE_NEWNET) !=3D 0) {
> -        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_NEWPID | CLONE_NEWNS): %m\=
n");
> -        exit(1);
> +    int clone_flags =3D SIGCHLD | CLONE_NEWPID | CLONE_NEWNS | CLONE_NEW=
NET;
> +    /* If we're non root, we need a new user namespace */
> +    if (getuid() !=3D 0) {
> +        clone_flags |=3D CLONE_NEWUSER;
>      }
>
> -    child =3D fork();
> +    child =3D raw_clone(clone_flags, NULL);
>      if (child < 0) {
> -        fuse_log(FUSE_LOG_ERR, "fork() failed: %m\n");
> +        fuse_log(FUSE_LOG_ERR, "clone() failed: %m\n");
>          exit(1);
>      }
>      if (child > 0) {
> --
> 2.24.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

