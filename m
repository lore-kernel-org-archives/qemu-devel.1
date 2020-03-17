Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB876C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7025320674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3TrbQ4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7025320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELXB-0004Rv-Hg
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jELWD-0003rf-Sy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jELWC-0008Cz-CQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:21:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jELWC-00081B-3e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:21:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id v11so28013744wrm.9
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qRJwUi782ziwDz0/bJ43zB3CXhs6p3juE1se1OxLBSo=;
 b=y3TrbQ4w6bJDcGcSKLofCVZjYTdeDFAk5D6PtAUQvKt7wCJKAtWhvbv4B6dnZ4Z/ZI
 ZRBKthLYPiwl4ruYS5hhJL3d5nv3wisJXSpgmYQO0q08DLoCf97JrvI7gk5AaCUtRj1w
 i5srKhuTV5I8rOj1vjjT6dSOrc6QO37Q2YXPPP5UpfOUDBOupeuRkForXCy5+stw2wUh
 5w9on9T7OQHpPA/okqhwcuZ+0+RTUfYDp34Z8TQo6jnG1Ce4u0vpV4Fc6TRZNcbzxuHs
 0Vo7g3Z6qEiivqf3EnrZS/vWM46ZsVP8OuC68ONhSGmdNuqZvwmo0tQfJWKkf27tbNFQ
 ZrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qRJwUi782ziwDz0/bJ43zB3CXhs6p3juE1se1OxLBSo=;
 b=VfiG7FPcqt68l2cJg9aD0cAMHI2Yx8fOHjIj14HHSHPYoszxXfi3JZ/N6+nPM8s2bX
 vuxWcjmfXLbacNZSyjlpEAC2uHCXqAvZvzyBfrnpAWEAQPh0Pp5O+CwHCj3bd4hSwMek
 txWi9bo1MqEESKm0GRJ/lg5vVtjTVN1PAfUEPfmEsCNRb1x3EjJW2b1xnYt9VlNiVKgs
 7XIJwD+YxrSUWGfNnOOaEr//Opd177jp9pE6IT2yb6DNTc4h/Tx8u0Hj20QdNVx2usrf
 uMYSoi9kUFzWEECCKEcboPg9dV1nnL1hxZ2PF1/BteJPQrpgS3H2t5Pi0otAL7KkE4pk
 k4xw==
X-Gm-Message-State: ANhLgQ04FStReUL8Yzye+qR0CL1cAo9uv+2/qEIn+xPGgLJiDwVpLsmw
 XBIhDDID/1ZjrAIA1IaM1ztaDg==
X-Google-Smtp-Source: ADFU+vu3S7MJI8+bUai/xFmxxwE0I7pmXPz35PhHobzzxFdoSeE0HaozvVuKyDEFsLxO46/K5+2eiQ==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr1420850wrk.101.1584487262374; 
 Tue, 17 Mar 2020 16:21:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y5sm1204170wmi.34.2020.03.17.16.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 16:21:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 12F4B1FF7E;
 Tue, 17 Mar 2020 23:21:00 +0000 (GMT)
References: <20200312104142.21259-1-alex.bennee@linaro.org>
 <20200312104913.GB4089516@redhat.com>
 <CAJ+F1CJWy2gEHHjzqyqnvHFf6EP4mEGABLt4aA7xptkXDwPGiw@mail.gmail.com>
 <20200316103331.GC1528804@redhat.com>
 <20200317095414.GC492272@stefanha-x1.localdomain>
 <20200317184704.GG3369@work-vm>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] tools/virtiofsd: add support for --socket-group
In-reply-to: <20200317184704.GG3369@work-vm>
Date: Tue, 17 Mar 2020 23:21:00 +0000
Message-ID: <87a74ek1pf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dr. David Alan Gilbert <dgilbert@redhat.com> writes:

> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
>> On Mon, Mar 16, 2020 at 10:33:31AM +0000, Daniel P. Berrang=C3=A9 wrote:
>> > On Sat, Mar 14, 2020 at 02:33:25PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> > > Hi
>> > >=20
>> > > On Thu, Mar 12, 2020 at 11:49 AM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>> > > >
>> > > > On Thu, Mar 12, 2020 at 10:41:42AM +0000, Alex Benn=C3=A9e wrote:
>> > > > > If you like running QEMU as a normal user (very common for TCG r=
uns)
>> > > > > but you have to run virtiofsd as a root user you run into connec=
tion
>> > > > > problems. Adding support for an optional --socket-group allows t=
he
>> > > > > users to keep using the command line.
>> > > >
>> > > > If we're going to support this, then I think we need to put it in
>> > > > the vhost-user.rst specification so we standardize across backends.
>> > > >
>> > > >
>> > >=20
>> > > Perhaps. Otoh, I wonder if the backend spec should be more limited to
>> > > arguments/introspection that are used by programs.
>> > >=20
>> > > In this case, I even consider --socket-path to be unnecessary, as a
>> > > management layer can/should provide a preopened & setup fd directly.
>> > >=20
>> > > What do you think?
>> >=20
>> > I think there's value in standardization even if it is an option targe=
tted
>> > at human admins, rather than machine usage. You are right though that
>> > something like libvirt would never use --socket-group, or --socket-pat=
h.
>> > Even admins would benefit if all programs followed the same naming for
>> > these.  We could document such options as "SHOULD" rather than "MUST"
>> > IOW, we don't mandate --socket-group, but if you're going to provide a
>> > way to control socket group, this option should be used.
>>=20
>> I agree.  It's still useful to have a convention that most vhost-user
>> backend programs follow.
>
> Alex:
>   Can you add the doc entry that Stefan and Marc-Andr=C3=A9 are asking
> for;  it's probably good they go together.

Sure - is docs/interop/vhost-user.rst the master spec for vhost-user
daemons?

>
> Dave
>
>> Stefan


--=20
Alex Benn=C3=A9e

