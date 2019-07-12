Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC008C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B51208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT7i5Zsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B51208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwpl-0002Of-Oa
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49696)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlwpZ-0001tX-Fn
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1hlwpY-0004ln-FO
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:47:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1hlwpV-0004i2-Fd; Fri, 12 Jul 2019 10:47:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so10241018wrf.11;
 Fri, 12 Jul 2019 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=04IwV+TUkf32mECcVEsbSZGl4M5f9jdHOjZ03oGi6Iw=;
 b=gT7i5ZsjWXdy15NmIG7j9rCS8yAIpX7O0Ikgo6W01/b0XIWHv5yTWyY2eXyWb2SfMb
 QMEANyVdBLN+ZQBQjsaTzfR6VaPGJGxQfCGY//WJD4LqMOIFU1IeJo1gOqEmqFtaV/IV
 r5XA56Z/ftjg+1fXkYYODLe17xP1pq0EhVoQGavgiy/ZrHNCFWxsr0iANKCZq0n8PpGE
 ZdMi+i9XNdfCIlK1U+frxA5koJNTakrxQ++4tNVnBxjn8vsHbTBGIH6P1MkyeIa/sWZk
 OSpbtvGkTvijSXdpgHmYmI2q+atXMalLgp6wSsX48ooHHWQvkXEig6lUMM0Yph3slLd/
 C4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=04IwV+TUkf32mECcVEsbSZGl4M5f9jdHOjZ03oGi6Iw=;
 b=K6aumokdCDEddhYCiXIbCXtg7qSV1kbTRw0dE61iw5iA9bY3nLXDl5jTOcQyxjgnMD
 MtP6YwdA6qYBVuf+IKlxtJsnFKKZ3HkwpRFuDs6IgAjIOf1gyvWh39TW77WbP+waK6Y5
 TAZ9rijQhB3Lu82LdSY3YvlJyzMHcUI3fkNkMM7GXnbb9zsZ8XYet6dlMyKNSf5a9TvZ
 6pQDsEyRqK7/qWL6CNCaxgOj9o0/1PBFOK1N5jK+2goclp2qbg9w0eUkmX/+PQUN5ptN
 Nag1+djMkxOz1E55qj9NGcJeWujgR0/6P7rCQsT2BrT16nVFmwKdE9YV+SLvSI2MQDKi
 hwLQ==
X-Gm-Message-State: APjAAAXqd0lPMeyQxtRNm5EYbhszEz0nBsZS6bexq6reWlLPtNI0VVhm
 7+ULe/jJdeBSymRg9DvKV2Or22Hjhmxc3KcQKmg=
X-Google-Smtp-Source: APXvYqykVOR23LPyiBdtOvs4b7mcYSFCiCs1peUr1LfIqA03SbKrWWf/ELMNSPO9X27Mo3F4Tn6kzYAEfkl9Dg0yJ5k=
X-Received: by 2002:adf:c70e:: with SMTP id k14mr12542106wrg.201.1562942839527; 
 Fri, 12 Jul 2019 07:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <db150a03315a89a849ab9968e4a5a26110d41424.1562942402.git.mprivozn@redhat.com>
In-Reply-To: <db150a03315a89a849ab9968e4a5a26110d41424.1562942402.git.mprivozn@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jul 2019 18:47:07 +0400
Message-ID: <CAJ+F1CLm251K1ysYKMxyovRFv1KA8b=R6hEh_=Z+bCatjCvyZw@mail.gmail.com>
To: Michal Privoznik <mprivozn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] .gitignore: ignore some vhost-user*
 related files
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
Cc: qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 6:42 PM Michal Privoznik <mprivozn@redhat.com> wrot=
e:
>
> Commit d52c454aadc creates
> '/contrib/vhost-user-gpu/50-qemu-gpu.json' and '/vhost-user-gpu'
> and commit 06914c97d3a creates '/vhost-user-input' neither of
> which is ignored by git.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index fd6e6c38c7..e9bbc006d3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -65,6 +65,8 @@
>  /scsi/qemu-pr-helper
>  /vhost-user-scsi
>  /vhost-user-blk
> +/vhost-user-gpu
> +/vhost-user-input
>  /fsdev/virtfs-proxy-helper
>  *.tmp
>  *.[1-9]
> @@ -131,6 +133,7 @@
>  /docs/interop/qemu-qmp-ref.info*
>  /docs/interop/qemu-qmp-ref.txt
>  /docs/version.texi
> +/contrib/vhost-user-gpu/50-qemu-gpu.json
>  *.tps
>  .stgit-*
>  .git-submodule-status
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

