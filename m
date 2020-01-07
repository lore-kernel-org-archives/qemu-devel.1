Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F9FC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13AD2072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTn2vPdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13AD2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioodt-0002fH-3x
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1ioo7X-0005nY-He
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1ioo7W-0006Kc-7O
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:38:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ioo7W-0006KS-3w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578400681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqUhkJXsVQ4TuLxzB7hb07CeRJM/DKs21CrozLauia8=;
 b=ZTn2vPdrQfFdLMbkp6xN7O5xTg7HZ43pjX+WjMxC3gxN8F7Bxv5BNGchN5yaIwhbBCWIwF
 4B4hHmloPLEoiqiHSQrxdgAHSDqJ4XDtsIKEPU5P0h37lcIMLdNM7hsShc6oDBQLymDx8N
 ///O55KRt+3hsMBqiVzvNzi9t7e86DU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-yHgp0jnLPEiQeRiTYR3vAA-1; Tue, 07 Jan 2020 07:38:00 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so26960312wrm.17
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 04:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tqUhkJXsVQ4TuLxzB7hb07CeRJM/DKs21CrozLauia8=;
 b=eqn9exGJph6uN9wqgeUXF9rvj0LX3iemPZqDVrpJ/E6co3QEgI7ZcVxTx5FtHFrBSJ
 xwRYRt7G/iYHEZsuksL8BfhLkXOkjfD/vPXKxblA24XhgOac56BX+jcsb//JYrJk5Sel
 q7gqbPX7R2KNbeuoWxmw5lJwRYy1/qjk9K/a3AVAD9MPI9GldTLPrHQYC4OOxcbocQUK
 itpFMjL7gq9AeQpqle8514yPHSRQ34mMqgx52o9BlHbYirAslyxXYCBinZyUZ8L6LSUD
 dSlxARcfj3noXR2stYE2v+vgDxdmB8QYlETLw6eZN25WfBhKoHvLN0xD6Q5eBCayqI/0
 ZmRA==
X-Gm-Message-State: APjAAAXJj30LL2r0PhI2Is7f5O/64sNxJ8FZjyyTKcWg/JoRtn64ywlF
 3qKcx6XRiSpxtRDI071Xv1k8RrwaifH2SwXl43d1xreBCh9jttFlvWMWpBhuIdf76TOSb8pgKV6
 fEuPePuVLc27sQkpMHpxtspkQV0dHIJE=
X-Received: by 2002:a1c:4004:: with SMTP id n4mr39787790wma.153.1578400679646; 
 Tue, 07 Jan 2020 04:37:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyixcGA41IzkLxybhezBI5n4lUqk4raGxwM/LktYqux1bRDSveEHsP9hWwDS59CaKXBubCNVGWBz470dKyu9bM=
X-Received: by 2002:a1c:4004:: with SMTP id n4mr39787765wma.153.1578400679443; 
 Tue, 07 Jan 2020 04:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <7322b7c9-51a9-f8e3-9d90-1d242d1c8cb4@redhat.com>
In-Reply-To: <7322b7c9-51a9-f8e3-9d90-1d242d1c8cb4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 7 Jan 2020 13:37:48 +0100
Message-ID: <CAP+75-XbPLNErEWGUZbFo8r74bacL9wkYaJFS8CzP59znf4SPg@mail.gmail.com>
Subject: Re: Priority of -accel
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-MC-Unique: yHgp0jnLPEiQeRiTYR3vAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 7, 2020 at 1:34 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> On 1/7/20 1:18 PM, Thomas Huth wrote:
> > On 07/01/2020 11.14, Paolo Bonzini wrote:
> >> On 07/01/20 11:03, Thomas Huth wrote:
> >>>>
> >>>>   vm =3D QEMUMachine(iotests.qemu_prog)
> >>>> -vm.add_args('-machine', 'accel=3Dkvm:tcg')
> >>>> +vm.add_args('-accel', 'kvm', '-accel', 'tcg')
> >>> Looking at this, I wonder whether we really want the "-accel" option =
to
> >>> prioritize the accelerators in the order of appearance? A lot of othe=
r
> >>> CLI tools give the highest priority to the last parameter instead, e.=
g.
> >>> "gcc -O3 -O1" compiles with -O1, and not with -O3.
> >>>
> >>> Also I think it might be quite common that there are shell scripts wh=
ich
> >>> call "qemu-system-xxx -accel xyz $*" ... and if we don't invert the
> >>> priorities of -accel, it will be impossible to override -accel in tha=
t
> >>> case...
> >>
> >> Hmm, it does match "-machine accel=3Dkvm:tcg" and in general I think i=
t's
> >> more self-explanatory.  However, it is indeed less friendly to scripts=
.
> >>   On one hand those could be changed to place "-accel xyz" after $* (o=
r
> >> better "$@"), on the other hand we could also add a priority option to
> >> "-accel".  What do you think?
> >
> > I don't think we need a separate priority parameter here. But IMHO it's
> >   really rather common practice to prioritize the last option. So while
> > it might be more "self-explanatory" to a CLI newbie if the first
> > occurrence got the highest priority, it might be rather confusing
> > instead for a CLI veteran...?
> >
> > What do others on the list here think about this?
>
> We can make CLI more complex by adding a 'priority' option:
>
>    -accel tcg,priority=3D1 -accel kvm,priority=3D0

I meant "more explicit" =3D)


