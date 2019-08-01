Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28673C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E815020838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQdCLBZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E815020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htEni-00051H-H8
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1htElh-00048c-Qv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1htElg-0002Td-L1
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:21:33 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:33792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1htElg-0002R1-BK
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:21:32 -0400
Received: by mail-oi1-x22d.google.com with SMTP id l12so54592412oil.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CsI1FQGBxpsTH7KVfiPzD4fsugf0Cfj9pyUpkzWame4=;
 b=fQdCLBZS8gI+af8TpLyTkPqg0YmNG9MkAodg3IvhG9Pk58c6ZDjmLbSUhiD6mtKHRJ
 xf5CCZ/8WtH07zdrOo5p7zq4etX0nnsodWuf6K7TKM8d+jp74DARqFqHRyXIZEpALBxF
 eV5qYBEbEAyGZ0zYn4scP277kwkv4BtpgN0IigtfzT7u3r5Zs2JkAR979V6/ZlJLHKGA
 9f2DUNxVZSiOVwFIEdjMccOAi+FWU9113WarZa94uEuAFPLhI+Wdl9LTz+mu8tjex4xL
 VVj+nZzFlLLmLDms6tkee788VBFvUXwEq1oyVXLsYCxGCG1z4egjdpLUhlAZlJ3vgSC+
 7JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CsI1FQGBxpsTH7KVfiPzD4fsugf0Cfj9pyUpkzWame4=;
 b=AgtW8ioLwO3/DEKcaQFqqGRBtOmvmCO3mE2DAUS6V7kAamzU5qXOi2ko4sBE+9RZ9E
 JxZxHQIzYnGs+/dCIvQKx/OaDbQh++/cZ8yhk9dl/Why5HAYWAe1NEW1kYLNCTUcKWxg
 41TLFNjkC8YbQHTf+UzfTxqKJzCoTUV6d6Ij7hwWKDC3BA7mygp9fF9ZC4TRGvWHcrRe
 rRXL5GouEGKvrplBxiJWAaYcuOEhYmicucaGl8RzB983PkCQ8YT3ag5ML4XcCBIswA0j
 VeX2p8VzfYS/HluPsn38v3beoiavHzHiUdbA5RkY193jl1a3zG+VDx5xlTopgl0FKEy4
 A8BQ==
X-Gm-Message-State: APjAAAXPjCAAfr1HgNTDud3xIbIJnC9TPg/9VjiEpCw/q57bRn6vfdmv
 ShKwGvTnzbtohl76y9K6c1lvGvVOE0Ex6ZPjePc=
X-Google-Smtp-Source: APXvYqypmGGoQ8mNb2GSwiY00D0ommbTyL8+T1B33fi7Ue31LzZzaUiwvGYl43xrMArWHoBtLdChRebK5674vajxEV8=
X-Received: by 2002:aca:abd8:: with SMTP id
 u207mr62452545oie.136.1564680091459; 
 Thu, 01 Aug 2019 10:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net> <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
 <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
 <20190730210718.GU4313@habkost.net>
In-Reply-To: <20190730210718.GU4313@habkost.net>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 1 Aug 2019 19:21:20 +0200
Message-ID: <CAL1e-=g3tXAD3_c4qqyeAEjTbk-nucczZ4u8GuW2dbn85eOJVQ@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC] HACKING: Document 'struct' keyword usage
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 30, 2019 at 11:07 PM Eduardo Habkost <ehabkost@redhat.com>
wrote:

> Sometimes we use the 'struct' keyword to help us reduce
> dependencies between header files.  Document that practice.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> I wonder if this is too terse?  Should we give examples?
> ---
>

I am inclined to have the judgement very similar to Eric's - it seems to me
the change
is fine as is, so:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>  HACKING | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/HACKING b/HACKING
> index 0fc3e0fc04..112685bdaf 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -101,6 +101,8 @@ it points to, or it is aliased to another pointer that
> is.
>
>  2.3. Typedefs
>  Typedefs are used to eliminate the redundant 'struct' keyword.
> +However, the 'struct' keyword may be sometimes used in header
> +files to avoid unnecessary dependencies between headers.
>
>  2.4. Reserved namespaces in C and POSIX
>  Underscore capital, double underscore, and underscore 't' suffixes should
> be
> --
> 2.21.0
>
>
