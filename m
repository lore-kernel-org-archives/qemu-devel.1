Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A3CC282DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 01:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7B7217FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 01:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8u7dU+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7B7217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGw7D-0007Wt-RV
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 21:45:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw6M-0007Bp-2x
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGw6L-0002Zu-3R
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 21:44:34 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hGw6K-0002ZM-Q9; Wed, 17 Apr 2019 21:44:33 -0400
Received: by mail-pl1-x644.google.com with SMTP id w23so360106ply.4;
	Wed, 17 Apr 2019 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:subject:to:cc:references:in-reply-to:mime-version
	:user-agent:message-id:content-transfer-encoding;
	bh=75s7REm/voAQ6uYpillsmdDu+oesaXLP8hdOOJ0RwKk=;
	b=B8u7dU+CpM7NlnCtQNP68qKH/29yDhnW20dOfXwGEPisC3qZf9lHxXAWHhO7L/Gnt2
	yOcWN2VhE405orLdMmiQpqmO+DVYM1VUm5AansKvGgHtI0SlooVZSjGWzlswfgUdJAjl
	o3Rvgdhm5RZemr4/uX92eeD1z4ZXcK2J1pi4M0XkEX+iaS7P6Q63TMLV2oVCnu4eq86l
	EenvK1gqOER20Rq+BsZPl0TXeNnF8iPm1rUI5Cz7Y/z4Dwg8QOEjo7Lg+J+Thuzcqtfh
	EpQeukbgSzmzR+gDQ+WpkEmO8qzD8+v3zEtWIHaXyXOe/EgUXbMCIJSrJsJEPNKXvanP
	UDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
	:mime-version:user-agent:message-id:content-transfer-encoding;
	bh=75s7REm/voAQ6uYpillsmdDu+oesaXLP8hdOOJ0RwKk=;
	b=F0pekIQrNuJ8o4Vjsp5EOiC4KjcEfjPKVySBvWwXImp18iu95bH6KfN/V7k37zfW3e
	y1mV4iM2aelRyBXkNOWu0YsZpWMYFWGOe8Wihq3pbIbOeIu6Z4APemzR+8a1JYLQ2hQN
	AhImy57xvObfJBOYyBR4vf/daKAgJy+18a9EWGWLw1P8qSqfuM9Kqp1fHP8BORvNlPN8
	7Za6xWvuHWbUYMze7DCKlk7Jto1NwJOZjbyJiaRT8ZN4zrcD0ypvlbBzULJWxGETtTZq
	Fc0ZJtY9bfzxEO0wf7OeMgmF7ymkrsk9VfTWZfORJ4l9ruufXzXLI/+gS4Ho3Mv98LQ3
	4ZNw==
X-Gm-Message-State: APjAAAWSUJ5GIcppuIPdNUYsTIL8lR8HrDSnX3LMxw6bBRI/21EW4kBh
	eoS0u9jRjRqhFiJs67s8wZ4=
X-Google-Smtp-Source: APXvYqwxkMJQkSPGfDgtbk4Su+p9f0lNbiD5T+LuyvfzMHXN/Eyku4vXt8qKTXFh3adlm7fTCoOW0A==
X-Received: by 2002:a17:902:bf08:: with SMTP id
	bi8mr3264008plb.336.1555551871689; 
	Wed, 17 Apr 2019 18:44:31 -0700 (PDT)
Received: from localhost (14-202-58-58.tpgi.com.au. [14.202.58.58])
	by smtp.gmail.com with ESMTPSA id o67sm337564pga.55.2019.04.17.18.44.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 18:44:30 -0700 (PDT)
Date: Thu, 18 Apr 2019 11:44:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kurz <groug@kaod.org>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
	<20190417140129.18980f0e@bahia.lan>
In-Reply-To: <20190417140129.18980f0e@bahia.lan>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555551562.tc1i2mngsf.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] spapr: add splpar hcalls
 H_PROD, H_CONFER
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	=?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418014424.icrNPjmHfCjEW3FZ18q3QH3CzcoPVCP8EZ5AFf3qoUM@z>

Greg Kurz's on April 17, 2019 10:01 pm:
> On Wed, 17 Apr 2019 21:20:00 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>> [...]
>> >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
>> >>      /* hcall-splpar */
>> >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>> >>      spapr_register_hypercall(H_CEDE, h_cede);
>> >> +    spapr_register_hypercall(H_CONFER, h_confer);
>> >> +    spapr_register_hypercall(H_PROD, h_prod);
>> >> +
>> >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset)=
; =20
>> >=20
>> > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
>> > they enabled by default, or is that an intentional change? =20
>>=20
>=20
> AFAICT they seem to be enabled by default in HV KVM.
>=20
>> Oh, it was not intentional, I must not understand how this works. Why
>> is this no longer enabling the those hcalls?
>>=20
>=20
> Since linux commit 699a0ea0823d ("KVM: PPC: Book3S: Controls for in-kerne=
l=20
> sPAPR hypercall handling"), in-kernel hypercalls are disabled by default
> and must be explicitely enabled by userspace. QEMU does that for some
> hypercalls already (search kvmppc_enable_set_mode_hcall() in QEMU for an
> example).

Thanks for the explanation, that's a nice feature.

> Since H_CONFER and H_PROD are listed in default_hcall_list[] in book3s_hv=
.c,
> no need for QEMU to enable them in KVM.

It looks like we can disable even hcalls that are in the default list
which might help with qemu H_JOIN implementation if we need to send
H_PROD to qemu to do the wake-up.

Thanks,
Nick

=

