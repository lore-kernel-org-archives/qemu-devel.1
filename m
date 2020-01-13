Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B57C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76B620678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjyNLkR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76B620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqvRf-0002Zz-Vt
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 03:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1iqvQZ-0001hp-O6
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 03:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1iqvQY-0004kN-GZ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 03:50:27 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>)
 id 1iqvQY-0004fW-9t; Mon, 13 Jan 2020 03:50:26 -0500
Received: by mail-pl1-x644.google.com with SMTP id b22so3549662pls.12;
 Mon, 13 Jan 2020 00:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L1SKSUAyoD/bHOLJkon4lyQ5GdcL2lV4qAInB435n8c=;
 b=LjyNLkR7Qv+wJCQHCAT43JYwfTl+f9ihM3ALPFf56ZmfzCTarCGdSkSHe5sAeG4xT2
 8Ijp7HtX716s/+Gd8IGnxg1850eDaOvH2kuiBErWUvZ8NL9EBuRx5hK7rj+MXdUkQBPA
 chEz0/IyaBkHeo62pPI5Xi8K0HfCgeCX0GJVHUPQBcNdIuWRUKfzOXnZjbgRm035bGYZ
 hfXkNQ1SpljfObfN+lis+8uk3KsRO3OA9IX85t8OTlarfABlnPKozde9N2Wwtq7xolid
 5Q623h7Njc+42wrHFnDq85r4e79QQ2bcw9YtNLeaEpwifS9Bf6Jb37KMzD0J9V+uJtxB
 hNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L1SKSUAyoD/bHOLJkon4lyQ5GdcL2lV4qAInB435n8c=;
 b=SeBqM54L8DOGMylzEY6G4soLNpU47RLkNoY9GJRjq2xC9ze/nG2HhMJvYWoRHiR8oP
 +b2bRMcQxC5WmZDGqcLfbarUmjcywqqPk+HY9Q+Ls7DLIRoaHh6zrjMATB9pO6/N6BV7
 qWB34RyB+LmFdKIE5/k9gTFyZJqGhC5frczRELHMMMpguQgmQq5IvqQk0QUrKCSpNiRU
 v4vjuSWDCEz8/EGTL7p7JWuw0PhDhT78iJebg7eqWUUi/qY2tVKwjR6pBrPwP+8qjZKr
 O9bsDwS8zJ98hNDuSOSWiWkDdVUbu18Y21oxep/HUYk5m/rqVVIZ6jidriKfduJwD6xu
 wIOw==
X-Gm-Message-State: APjAAAVeZEjxg5VxP9YvW61bGYSGB2KkpBVNdm+Mm5ohSiaVGIKIP/YK
 TeSVPNrZKuDmU3r+gqwPfzU7t5+IoYH7pKByVco=
X-Google-Smtp-Source: APXvYqy6W8yd0QUxnJYi/zVBl+awg1E5YRwX4vixK8CCy4auxM5lf9WVJcShGpD8J0a35k8jH6CrhDCKhcsd+ZBTixk=
X-Received: by 2002:a17:902:be0c:: with SMTP id
 r12mr19207296pls.148.1578905422751; 
 Mon, 13 Jan 2020 00:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
 <20200110194158.14190-3-vsementsov@virtuozzo.com>
In-Reply-To: <20200110194158.14190-3-vsementsov@virtuozzo.com>
From: Paul Durrant <pdurrant@gmail.com>
Date: Mon, 13 Jan 2020 08:50:11 +0000
Message-ID: <CACCGGhD+v3cPdrU0ZCctO3SCpN7yHJcd9=J6AwTrrYWZdHrTZA@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 19:42, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
[snip]
> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function which use
> + * Error **errp parameter to report error. It's needed only in cases where we
> + * want to use error_prepend, error_append_hint or dereference *errp. It's
> + * still safe (but useless) in other cases.
> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to a
> + * local Error object, which will be automatically propagated to the original
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to add information (by error_prepend or
> + * error_append_hint)
> + * (as, if it was error_fatal, we swapped it with a local_error to be
> + * propagated on cleanup).
> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredump
> + * to point to the place where the error happened, not to error_propagate.
> + */
> +#define ERRP_AUTO_PROPAGATE()                                  \
> +    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp};  \
> +    errp = ((errp == NULL || *errp == error_fatal)             \

Perhaps !errp rather than errp == NULL, for brevity.

  Paul

> +            ? &_auto_errp_prop.local_err : errp)
> +
>  /*
>   * Special error destination to abort on error.
>   * See error_setg() and error_propagate() for details.
> --
> 2.21.0
>

