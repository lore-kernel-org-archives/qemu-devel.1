Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CBC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 06:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E322084B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 06:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4W3L1Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E322084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE6pq-0002jk-Mq
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 02:35:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hE6p7-0002LW-DH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hE6p6-0001eD-B9
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:35:05 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hE6p5-0001cx-Px
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:35:04 -0400
Received: by mail-lf1-x142.google.com with SMTP id j11so910911lfm.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 23:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=FehoX2UAa4UQY+U6PXbGv1aWT6BqrJCCnc+aOZG60/U=;
	b=H4W3L1CmzM4v4NUlmFVzhlPoPQIh+Jtlmu4eDo4eaS+Uq1seAUCy0XscBK4Rrcs54e
	xSZgWyxHlCza4h727JX5yTb1C0VKvfWX4I4voqRjLcYWbR4V6k/TZ5pTq6KDaHvXBSJj
	VbSbJqMJyyfpbP0GNl43apdRz5jUsSdtGBxTfE7WFxhq7GAdO3kmg3W/CCMC8xZCj7ME
	a2lwW+CIbqxvUAmyNihKlMO4WcJGBvoRLn4lcn9RxVg3OaueHvFRXr5PsLzBaRCT3uNT
	frA8i6sK+7nn8dmWDYeWQmRQCXDIqDh4M7cZ5Y8F/AAzuKZAQua6wUnLkLy3X8JeQ9f8
	8AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=FehoX2UAa4UQY+U6PXbGv1aWT6BqrJCCnc+aOZG60/U=;
	b=cY7UjPf7Gcv1s6Vk4wZ6XbxOkPQI2dxW696Bgsbb48Zd9hqmIojSdy2S1xL2LIlgy+
	0FFuh4VbTz2fiFnIvPSVvnwkFlArRdvZMqScgEljqBmTRyBwoO4q0AODwZgcY1jVWOsa
	zUh5cMwpDIYvVUDgLNTuVLAicCxyqlwmEwYxrTFOhbK8g+SxjyoRgsJYYX2c8xyNFCS6
	IOqCC99kvIuqIVgSCybd2eqtWrJYC3JOrreXrLual+ROsRALlSYgS5n8WxlNA50x85LT
	r8zawkWbc/Xo7zRKTQO9cb7z40G3b3vnfehVg18mt4G6SlOCj0mD4o15wTUbs3j+gH4y
	0JlA==
X-Gm-Message-State: APjAAAVEh+PtS6fqciICms52Hv8FV74oigjjJRdv5BhRnHjJzatN1L1W
	NL8HjoeeyoQNs2N41yTiRKjrlzovS9I9mHvbSP8=
X-Google-Smtp-Source: APXvYqxuzbnQjFpBM79ausix4Xnhd8gRwCRMtXIpS4Vp2yfWfgGjGvBmH2YcUo5TU31GazbqR5EnQD7TAgnudiqJmlQ=
X-Received: by 2002:ac2:41d8:: with SMTP id d24mr7675705lfi.56.1554878102646; 
	Tue, 09 Apr 2019 23:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
	<874l764eez.fsf@dusky.pond.sub.org>
	<38442eb0-501e-dbf8-60e0-74675a999dba@redhat.com>
	<87bm1e2yfa.fsf@dusky.pond.sub.org>
In-Reply-To: <87bm1e2yfa.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Apr 2019 23:34:33 -0700
Message-ID:
 <CAKmqyKM7fX6UqSU5K+w25xGxO2K4kqtyoRz7LMFN7GtBYL56KA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410063433.q1AaDKT9alc43PBzxWZoDj8lLvRconuh3G3q2JX5lUQ@z>

On Tue, Apr 9, 2019 at 10:59 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 4/10/19 7:28 AM, Markus Armbruster wrote:
> >> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >>> On 4/9/19 7:40 PM, Markus Armbruster wrote:
> >>>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> >>>> computation of @dt_size overflows to a negative number, which then
> >>>> gets converted to a very large size_t for g_malloc0() and
> >>>> load_image_size().  In the (fortunately improbable) case g_malloc0()
> >>>> succeeds and load_image_size() survives, we'd assign the negative
> >>>> number to *sizep.  What that would do to the callers I can't say, bu=
t
> >>>> it's unlikely to be good.
> >>>>
> >>>> Fix by rejecting images whose size would overflow.
> >>>>
> >>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>>> ---
> >>>>  device_tree.c | 4 ++++
> >>>>  1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/device_tree.c b/device_tree.c
> >>>> index 296278e12a..f8b46b3c73 100644
> >>>> --- a/device_tree.c
> >>>> +++ b/device_tree.c
> >>>> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path,=
 int *sizep)
> >>>>                       filename_path);
> >>>>          goto fail;
> >>>>      }
> >>>> +    if (dt_size > INT_MAX / 2 - 10000) {
> >>>
> >>> We should avoid magic number duplication.
> >>> That said, this patch looks safe.
> >>>
> >>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>
> >> Thanks!
> >>
> >>> BTW how did you figure that out?
> >>
> >> Downstream handling of upstream commit da885fe1ee8 led me to the
> >> function.  I spotted dt_size =3D get_image_size(filename_path).
> >> Experience has taught me to check the left hand side's type.  Bad.  Th=
en
> >> I saw how dt_size gets increased.  Worse.
> >
> > So you genuinely neglected to mention Kurtis Miller then :)
>
> Explanation, not excuse: the only occurence of the name in my downstream
> reading was a two-liner BZ comment, which I totally missed in my haste
> to give the fix a chance to make 4.0.  I certainly didn't mean to
> deprive him of credit!

No worries. I have sent the pull request and it includes the reported by.

Alistair

>
> [...]
>

