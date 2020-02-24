Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FEEC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D1B20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hE4lTNKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D1B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MMY-0003b5-VY
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j6MBL-0003M4-Tz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j6MBK-0007bq-GV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:26:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42189
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j6MBI-0007a2-UJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582583186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tk7+NUh4F6PNuzBUgDrMyUujqWjrtANohetARUwFSrw=;
 b=hE4lTNKxzBe0XwEkC/rfUyt2AGjkNseP/j/KfET67iWixwf142gvh9Vh+XB5WFwKvo6cYM
 rWo1fvdUMitTiE2KuoY/CeAadt6FjMZz8zgecQD+EgzkdoHQdMllEWrwAAKx2J6z7EFELC
 KcrrQeGbW06jeWT3uaVQ05WA2iJr3HI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-DkVj9vM1OLOiHueAxL6B7w-1; Mon, 24 Feb 2020 17:26:22 -0500
X-MC-Unique: DkVj9vM1OLOiHueAxL6B7w-1
Received: by mail-qk1-f197.google.com with SMTP id 205so3583823qkg.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Utr9gdKR0MeStAEEWHwNDo0tcnBNfmKFvMtXm4/Axuw=;
 b=dQm0gd1KtRunk69lE2tv5/K0iaDlROJ7b0d0YlQbOXcyo4i+FqXIOJFea2vye/K8Pp
 bq64q72HL/csWTctdudhAwc2c+RH0cIg9iSVtfgNLfcNUmpRtY6OhuFdqS5OmGfzOyCI
 JeyzJx5n1baYGq7uRht4XCR7bRmuYMcYgv947pIyBPMPhut1VcuzfPUdqfLg07tdPiJP
 c2/Nppi0t1RzIEl06+oar76Lk52FQNIVtTvd1Ehxb5t7YrEwiRY0Gr/kOQtw6gbdObFN
 ApX/MiPtOnbiuEtHBF1tm28ZMPAs/BezOIQF6tXibufk2xYyLt72ZrvA6njV+Lwt2IKS
 mXfA==
X-Gm-Message-State: APjAAAUNcDdR4T9EEXbYQMvlK+O0LveLy3182NZax1kwzeQ2v5+0UktK
 vCDilRhG5hExvehFeFSFifAfjmVjGhq8oZcxGgDSZzPMKmQYa7wBWxPxgioQmeOY94bwAFtohjZ
 1xes0VAFgNADoeb4=
X-Received: by 2002:ad4:53a8:: with SMTP id j8mr46720578qvv.149.1582583181695; 
 Mon, 24 Feb 2020 14:26:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8iwoEEbXwhT86pLJ36XtOo23hsco1O3sdzMh+kr6Qc3cWmzSZlsGckNwt8WfaqnnsNVSO3A==
X-Received: by 2002:ad4:53a8:: with SMTP id j8mr46720567qvv.149.1582583181468; 
 Mon, 24 Feb 2020 14:26:21 -0800 (PST)
Received: from xz-x1 ([104.156.64.75])
 by smtp.gmail.com with ESMTPSA id t23sm6538152qtp.82.2020.02.24.14.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:26:20 -0800 (PST)
Date: Mon, 24 Feb 2020 17:26:18 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 10/13] migration/ram: Handle RAM block resizes during
 postcopy
Message-ID: <20200224222618.GA113102@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
 <20200221164204.105570-11-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221164204.105570-11-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 05:42:01PM +0100, David Hildenbrand wrote:

[...]

> @@ -3160,7 +3160,13 @@ static int ram_load_postcopy(QEMUFile *f)
>                  break;
>              }
> =20
> -            if (!offset_in_ramblock(block, addr)) {
> +            /*
> +             * Relying on used_length is racy and can result in false po=
sitives.
> +             * We might place pages beyond used_length in case RAM was s=
hrunk
> +             * while in postcopy, which is fine - trying to place via
> +             * UFFDIO_COPY/UFFDIO_ZEROPAGE will never segfault.
> +             */
> +            if (!block->host || addr >=3D block->postcopy_length) {

I'm thinking whether we can even avoid the -ENOENT failure of
UFFDIO_COPY.  With the postcopy_length you introduced, I think it's
the case when addr >=3D used_length && addr < postcopy_length, right?
Can we skip those?

Thanks,

>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret =3D -EINVAL;
>                  break;
> @@ -3757,6 +3763,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotif=
ier *n, void *host,
>                               rb->idstr);
>              }
>          }
> +        rb->postcopy_length =3D new_size;
>          break;
>      case POSTCOPY_INCOMING_NONE:
>      case POSTCOPY_INCOMING_RUNNING:
> --=20
> 2.24.1
>=20

--=20
Peter Xu


