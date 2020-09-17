Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F29C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446A020708
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="ehIKjKV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446A020708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvXZ-0004wY-46
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIvOV-0000wG-0H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:00:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIvOS-0000cm-CW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:00:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so2290469wmi.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3SVM8rXotF623Io9IrHQcUlHf3E7vAYuPYcMdJ6OHtw=;
 b=ehIKjKV7pmr32yaIhdGMJIAFOqt3I9hahdx3XadTaNQTqukmy1t7uMyAmIibVW4TQH
 J9rGKGyT8FN/uwjjo3N5moqhJ2DnkhkDv2kGUN9ZoJwoC/eFCw/x2mBPF4VZvKYNhW9P
 1GsYpCaBp1WY581RFfmB7DqRWH4RO+KUufLDveNKSjS+uJHD2HjXJ/6ielxWxoCsNboC
 WuOrd4DUkuIIIma6JdSNTChsTbLIor6eA1cXU2mnxY9L+sph1mST87JoS1TB9RGicWQa
 wC0rBQxpuSvV+EC0qBvdBG2OzQP8KYYAKWPVfrZFY0HW6BWrJpMitKaV8xqfTDh38kxy
 w/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3SVM8rXotF623Io9IrHQcUlHf3E7vAYuPYcMdJ6OHtw=;
 b=mViASPbSl771v+xze5LvycxIyaG6Cgcv8zX+kTTrdj92F5qsAAHSMzduzFgW8A5qO5
 cNCfkVMSNkFPj4AYWNQKCS4JBaFEWi95bP99T8Rh2L1u9tLjwQ1js6xn3Tuv3YE1sBvl
 veNidDjnEcWNXjJse32pIFtKKKPkduq1WXnHEUHELY2zO6TZGYg5XDF1ZWPJga+jlTm8
 DMrjZPo7cFNZKUBw+dpWE8PrYOyR51dLt3eKndVqhSKlPQ4VQwUUpnr66aOkNjmqt8R7
 Kdsnnj+wnz/xXd25YfOfzGSnisN+7ImIAq+mfO/LoiQgS5ZQHt6ko+E0VH1xz8rmazRu
 gP6g==
X-Gm-Message-State: AOAM532XbmuoeM3rTj1jqBm+s5weP1pKXcWFCzkdAY6CAPA9JWlJgCNx
 WSo7sHNdD87yUI5c5pETDH4xbw==
X-Google-Smtp-Source: ABdhPJzNmxfhpX4UOuH3PFmeD4Lo9LMIVBbEvlDXjPnQT6N96OsWsm2ECLa6h7VGI2oUJdvArflQyQ==
X-Received: by 2002:a1c:65c1:: with SMTP id z184mr10023712wmb.61.1600354813954; 
 Thu, 17 Sep 2020 08:00:13 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id h17sm41580596wro.27.2020.09.17.08.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 08:00:13 -0700 (PDT)
Date: Thu, 17 Sep 2020 17:00:12 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] target/i386: always create kvmclock device
Message-ID: <20200917150012.wtub7y7wfrcepnkb@tartarus>
References: <20200917111306.819263-1-vkuznets@redhat.com>
 <20200917122559.e7i5o64k7rw7urdh@tartarus>
 <87ft7gh6gy.fsf@vitty.brq.redhat.com>
 <20200917144237.GK2793@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5je6uqn7y7r526nw"
Content-Disposition: inline
In-Reply-To: <20200917144237.GK2793@work-vm>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5je6uqn7y7r526nw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 03:42:37PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > >
> > > Shouldn't the old check used when machine type <=3D 5.1 in order to a=
void
> > > migration incompatibility ?
> >=20
> > Hm, when the check fails we just don't create the device and no error is
> > reported, so even if we have kvmclock data in the migration stream but
> > fail to create it migration will still succeed, right? (not a migration
> > expert here :-)
>=20
> When the migration stream is parsed, it'll try and find a "kvmclock"
> device to pass the data it's reading to; if one doesn't exist it'll
> fail.
>=20
> The other question is in the incoming direction from an older VM;
> you'll have a kvm clock created here, but you won't load the kvm clock
> state from the migration stream - what is this clock going to do?

I guess that if the migration succeed (and the VMState keeps it's
initial value) the timestamp will be restored to 0 which is the current
behavior.

>=20
> Dave


[...]

--=20
Antoine 'xdbob' Damhet

--5je6uqn7y7r526nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9jefkACgkQ3AmjLzzl
jz69TwgAl8ilg5AhjL20olk8/q9lqrdl7ENnCjz/FPNwzOAovfiQKfuykgIE/95L
x/Kuo/hJJjmyEPTXJpKDPu3oxv8llSqxP1MvcAYJVVuvQfgrGP3VfdjnRIdKUZ/5
HDQnFV+NLfE4Vp3inI2BtQeQbiNTiEnOAaXilHIh42JRUgcPFKQTmZqZBwWXlLSR
d2mKq6Qd9GNE74Emh3K0saIFCaUBDWSGpcuX7KnYKOR1mRYPdbQRwKyKO+mbjFPw
L5EpQX+h5535EpJCz7xfFd+xLz7A/9dGpXC9qplIqftJ0N3szYWaoLiNqkgxTR9M
TPdqUjJmFk0pYzqdiza8YlG14UJXdw==
=lI3M
-----END PGP SIGNATURE-----

--5je6uqn7y7r526nw--

