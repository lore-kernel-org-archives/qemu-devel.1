Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B48C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D362F20684
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZDeNns8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D362F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFz8Y-00056Q-1S
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:46:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFz7Z-0004gF-FJ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hFz7Y-0003aU-7Z
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:45:53 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:40331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hFz7V-0003ZP-Lv; Mon, 15 Apr 2019 06:45:49 -0400
Received: by mail-it1-x143.google.com with SMTP id k64so2208254itb.5;
	Mon, 15 Apr 2019 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=MyXovjuHSm/CMp05SP37qH2hsDCGuptCifeVdqpHJ1o=;
	b=XZDeNns806mjjb8+9eVQJ4iTL4OLQhRxCtfC6mcgB0G9E9ZXVb/aXCwR6rXdztP5P9
	2saYqHccGa4UvXA4MKxKRwn6q70We2TZAUZQa5m1wFA3rq6dsrdcCufTTMmJLyqKBWmZ
	eoSRrsXzi6iFLlb8HFqOWz171yYJW8yApc+ug3qy4M1Vu/w5u1lZ1M1IlNSW2dZ2nb7O
	gFvQSvrDBa9LsH3w6hn1gCvo6KAwh8QfnCUBavWJOaxOi0xlOqjS+7213WZDlOpY40n8
	gcCfWziMfg6LNtXtD0GUVPM983I2MPTrn03/afGFlqCKrXQ07Up5lpgzf+h2le7FLboB
	l2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=MyXovjuHSm/CMp05SP37qH2hsDCGuptCifeVdqpHJ1o=;
	b=hR+vsgrgWIePOjJH5PcR3IvLWU6M+8+XIs/dfYnX2hVOcnJAkeQkIbzJGEkmTqzxc2
	7arZ4ms/bY8UoGV+T+vFeEsR7hs1cbpMKwU0l91/0OSJO3SUheorYdlvbJbBw5onUBo9
	CftPRgSosN8NQNsWdkTXncrcNxscabD5sWL6zYLJtGURmWnC4CcDfTx4/+oQWg0Rzrow
	tZj7bKan6r7ozzVrmUOrMI5cf+KTl0h+QYPI24JmZJUpCx9aEmBHOVaPzRHt67VpaAv3
	mz4v6Gm2bSFVeeI7guwCh5Qn+TmxFiF6k1lR+n0oGQt56M/GVxCgO7ZDwV6eBF+L1pE0
	22GQ==
X-Gm-Message-State: APjAAAXRZHcKFyvg0uzN0aaPEJO8SXBPrnYKNMjls+jtRpzlPXZwsaSB
	8LfSgShEl8hbjrR1Awb/t/NOfYQJXkZ/cihrf8Q=
X-Google-Smtp-Source: APXvYqwqk3w+JKn9ALVHRLcq63mrbnDNIcin6hy4wbOHROiGRJOFSjCmHIoa5dNbHMj9kW60nSYePeKMcOWzDmYfXrc=
X-Received: by 2002:a24:2846:: with SMTP id h67mr25406337ith.138.1555325148749;
	Mon, 15 Apr 2019 03:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
	<29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
	<CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
	<4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
	<5665d408-512e-2ad4-aa4e-481287fc39e7@redhat.com>
In-Reply-To: <5665d408-512e-2ad4-aa4e-481287fc39e7@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 15 Apr 2019 12:45:38 +0200
Message-ID:
 <CACXAS8CDswPp5pss+1VVZxKw8LLS2m0W=jyovBdPDdoJVqNOMg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
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
Cc: "open list:PReP" <qemu-ppc@nongnu.org>,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415104538.bRLKtBBOvaPUfqmx2VUkBn7Q330-Zh-G7n3r1JvuZl4@z>

On Mon, Apr 15, 2019 at 12:36 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 4/14/19 11:24 PM, Herv=C3=A9 Poussineau wrote:
> > Le 14/04/2019 =C3=A0 20:53, Artyom Tarasenko a =C3=A9crit :
> >> On Sun, Apr 14, 2019 at 7:01 PM Herv=C3=A9 Poussineau
> >> <hpoussin@reactos.org> wrote:
> >>>
> >>> Le 12/04/2019 =C3=A0 23:06, Artyom Tarasenko a =C3=A9crit :
> >>>> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
> >>>>
> >>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> >>>> ---
> >>>>    hw/isa/i82378.c | 4 +++-
> >>>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> >>>> index a5d67bc..546c928 100644
> >>>> --- a/hw/isa/i82378.c
> >>>> +++ b/hw/isa/i82378.c
> >>>> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error
> >>>> **errp)
> >>>>        isa =3D isa_create_simple(isabus, "i82374");
> >>>>
> >>>>        /* timer */
> >>>> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
> >>>> +    isa =3D isa_create(isabus, TYPE_MC146818_RTC);
> >>>> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
> >>>> +    qdev_init_nofail(DEVICE(isa));
> >>>
> >>> I am not sure the base_year should be hardcoded in i82378. I can
> >>> assume other machines with a i82378 can have another base_year.
> >>
> >> I doubt it to be honest. How would it work in the hardware? Is there a
> >> pin which would switch a year?
> >> I do believe the different i823xx may have the different base years
> >> though.
>
> There is no RTC on the i82378, this should be moved to the board code
> and set the date there. Do you want me to send this patch?

Please do. I won't have a chance to get to it till the next weekend.

Artyom

--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

