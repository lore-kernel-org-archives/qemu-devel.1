Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9854C83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DF2206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCbArhM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DF2206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33037 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRLg-0003KZ-Mf
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.s.norwitz@gmail.com>) id 1jTRK7-00011I-HP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <raphael.s.norwitz@gmail.com>) id 1jTRJM-0002Gn-0y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:34:59 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129]:36584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jTRJL-0002GI-Jh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:34:11 -0400
Received: by mail-il1-x129.google.com with SMTP id c16so20469975ilr.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=A5QpfsIfnDUpV4BKNNiW5exwok1jnhZN19ZVuCSbuEk=;
 b=lCbArhM7OLB5cGVo4frI21erOVOyjCd20/9jzouoA8CSp43qovBFQQtHP7jlsRe2eO
 z/OlMV4d78VTi6CvHFJP7MRfUYUqQb1IG6C80CYG+byyA2Zk/2wMHGrxxCJ4IyLpq99z
 Yw+Rt7W6oLP3S+IVQ+GnM9wWzyO3ukmrXmmEpiTcHB/sjC3XODu+1nVYH56D6SYI5FnS
 fJcbRK01F60iNKGYP/pual+Urwe9KXR6nE6RFx0NRRIiMfgQ4k6sihFtgc8vSDFo4ddJ
 yS5ilc8CJlFlUtGb3TrM3sb47KJQNcazPKx+k0HBFAFQbakaspAifLpHtrl8Ah7+QQaJ
 wuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=A5QpfsIfnDUpV4BKNNiW5exwok1jnhZN19ZVuCSbuEk=;
 b=JwV2sH8H6uPx8v8xv6SDQhacbaL47Mmh8WXAouck6pne76GlOvTlUWTZSMjDpDhapn
 kKX8jOgUaYc2kYboSmWxini2PCX+dzxP4SEOnuJwKZgUPx5DkevRNceQrftzMUocSdMX
 2SzTcR2F5gnwnwE6dWJzgoZIZfhCsJSfgyddojR71rAegLfmv4ADynt83O+fvMvdUbZz
 sTweHWS8sygk9JNQEiaY+QEAdaDDoYFwHSQlxps/GY5dSuEzPpykS0mXg1wZi0QnDbO+
 pR2H11h8NwdcdkRryzG9qIgj40ztAsikHc8I1kS7ZZT3D7YPYIVIYwP8qcMaQKufjr9s
 rUbw==
X-Gm-Message-State: AGi0PubIqn57WcUf5kUBm2Y65e37zcmVNCRvuHAWfG4XEEu8lrCk6V+1
 iEMm0vO84/gJHpbHZwur48reFF3a2OUpMqMi7dU=
X-Google-Smtp-Source: APiQypLOkxWMLT3bVsQVaanY3v0zOsLPZoL+fnYbnNo4gBvX5ATeglFExt+lNxcdueynKR04BCmwcmTk6oV5DAlA7kI=
X-Received: by 2002:a92:d7c6:: with SMTP id g6mr26728094ilq.51.1588084449197; 
 Tue, 28 Apr 2020 07:34:09 -0700 (PDT)
MIME-Version: 1.0
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 28 Apr 2020 10:33:58 -0400
Message-ID: <CAFubqFuvE9oz-N2c7Tw70sdvVDsfO7LmHD3bbRabLUpw6z5KWg@mail.gmail.com>
Subject: Re: [Qemu-devel] Should memory hotplug work with vhost-user backends?
To: stefanha@redhat.com, dgilbert@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x129.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::129
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > I've briefly looked through the libvhost-user code and the hot-add path
> > looks safe enough to me (or at least no more broken than the regular
> > vhost-user memory hot-add path).
> >
> > Can you elaborate a little more about why memory hot-add is unsafe with
> > vhost-user device backends built with libvhost-user, as opposed to thos=
e
> > using the raw vhost-user protocol semantics?
>
> The libvhost-user problem is that the library is mostly designed for a
> single-threaded event loop that handles all virtqueue and vhost-user
> protocol activity.
>
> As soon as virtqueues are handled by dedicated threads there are race
> conditions between the virtqueue threads and the vhost-user protocol
> thread.
>
> A virtqueue thread may or may not have an up-to-date view of memory
> translation.  This can result in it missing memory that is currently
> being hotplugged and continuing to access memory that has been removed.
>

I agree - this is definitely seems like a problem if memory is being remove=
d,
but I don=E2=80=99t see how a virtqueue thread may have an outdated view of=
 memory
in the hot-add case.

libvhost-user now supports the REPLY_ACK feature, so that on hot-add qemu
will wait for a response from the backend, confirming the new memory was
successfully mapped in, before returning from vhost_user_set_mem_table(). I=
f
the new memory is mapped in by the backend before the ram is exposed to the
guest, how could a virtqueue thread receive operations on missing memory?

> Dave might have additional comments.
>
> Stefan

