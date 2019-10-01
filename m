Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A66FA373A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAC8215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAC8215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFD3s-0006Rn-EQ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 03:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFD2x-00060a-QC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFD2v-0007vs-BI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:58:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFD2u-0007u0-UK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:58:09 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01136882EA
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 07:58:07 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id j125so1024434wmj.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 00:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=NFHfKjkJSX6wQf+yHZBJe7txvLyBMTyUdazyfjZHkiQ=;
 b=DetVwgGEvT8Ls7nobBibDSDpjjLSK0xtPUn8cgn3uMuDi6uzdEMo+gHiuovqJ7wx1s
 Nzk7ZwgKrbZ5+ITUhtHqsdMlJYBc4ymfFa30cd890BGmDOV+AxY+zXIJ9ML/YJPVOK13
 oYi2QXMOdXgYNzOpJi6e7simumt1uUScxPl7A1q/NkPI+LAmnyXSniVcgObRm7giSgyA
 fp6y7bLMtO3sWZ5GPIF7boZEa/hlYgyrD+/4S2eU9rmRmNoRTmah336D8iQ7SC+zJwbJ
 9OdD2nmTVWHqa+jLGYynBpZqwma3CXTCkGQT/sKY7AH3npd8AtZCyUNgKIxt9DC7ioaE
 pgjg==
X-Gm-Message-State: APjAAAWbmKnKsgUQZs8DNowDY4bzGjfmqFFytAn+IxoqIjuW6LSfsS+5
 XwfGwjJxlE9ZSsdgQSj/iJxiy5K/CF6xk8z1+/LztwTRx5qbewPxMWKw/aKT7zeOIZrTkqmcPK+
 RShc3S4gayobzRlY=
X-Received: by 2002:a05:600c:54a:: with SMTP id
 k10mr2634801wmc.127.1569916685745; 
 Tue, 01 Oct 2019 00:58:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkJyWWTqcgKlfNmvjuzo+buKGNVPrugMo9E2qZMaL87DJSpRw4RNhiCq9ivUX67pGxfHt6CQ==
X-Received: by 2002:a05:600c:54a:: with SMTP id
 k10mr2634786wmc.127.1569916685511; 
 Tue, 01 Oct 2019 00:58:05 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id o9sm38849963wrh.46.2019.10.01.00.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 00:58:04 -0700 (PDT)
References: <87blv2i5ha.fsf@redhat.com> <87lfu6kuyo.fsf@linaro.org>
 <878sq6hyn5.fsf@redhat.com> <20190930210533.GE4084@habkost.net>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Arch info lost in "info cpus"
In-reply-to: <20190930210533.GE4084@habkost.net>
Date: Tue, 01 Oct 2019 09:58:00 +0200
Message-ID: <87h84succ7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: tao3.xu@intel.com, qemu-devel@nongnu.org, mihajlov@linux.vnet.ibm.com,
 imammedo@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Sep 30, 2019 at 12:22:22PM +0200, Sergio Lopez wrote:
>>=20
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>> > Sergio Lopez <slp@redhat.com> writes:
>> >
>> >> Hi,
>> >>
>> >> Commit 137b5cb6ab565cb3781d5337591e155932b4230e (hmp: change
>> >> hmp_info_cpus to use query-cpus-fast) updated the "info cpus" commit =
to
>> >> make it more lightweight, but also removed the ability to get the
>> >> architecture specific status of each vCPU.
>> >>
>> >> This information was really useful to diagnose certain Guest issues,
>> >> without the need of using GDB, which is more intrusive and requires
>> >> enabling it in advance.
>> >
>> > You can always enable the gdbserver from the HMP when you need it.
>> >
>> >> Is there an alternative way of getting something equivalent to what
>> >> "info cpus" provided previously (in 2.10)?
>> >
>> > info registers
>> >
>> > should give you a full dump of the CPU state including the PC.
>> >
>>=20
>> Both methods are less convenient that what we had before. Perhaps it'd
>> be reasonable adding a flag to "info cpus" to give users the options of
>> having the same behavior as before?
>
> Is "info registers -a" less convenient because it prints too much
> information, or because it doesn't print the active CPU indicator
> and thread_id?

A bit of both. Previously, "info cpus" gave you the PC, thread_id, and
whether the CPU is halted or not, which is just enough information to
have an initial idea of the VM's and Guest's status at a quick
glance. You can even call it multiple times to see how the CPUs were
progressing. This came specially useful when debugging boot hangs.

I mean, as for myself, I can definitely work with "info registers
=2Da". But I would find hard explaining users why the original
functionality of "info cpus" was lost.

Cheers,
Sergio.



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2TBwgACgkQ9GknjS8M
AjW6Cg/+NA9iLsFJjrJOu9oUdGzGisgcdI1WKkt0+MJBYhRha4K0VojoJlRHnrTt
l2/gtOaey0t6kiExzozdyCjQ/3GtKDz9QTLTJPbRNxZFm3PO2++zEMjfhaS1/kJ1
wUHCRdpqtNjymQrv3u2QTTbby0gRvmjRT7Qo68N6kQC52OL/B+tfdYbMMzONqtMS
DlzOrvdf2ld+j0oU7KFszR5RqjziLJxuQNbUjXAdnMey44Hk4U+PwFfwqzxpoy4J
wZGGvuDZE1/iE5ZwttW25XkjuDg6Uil9vQ2ftdYBG4AnrgFBY8Si0SFVVB1unjVh
s9fmBjUSQ91j/KuOns1MdRT/gfgGSXXMrWzH6By8DovMyigVc3siVj0hQ2G9ZS9F
XqG7vgpOASECEKW18HiuJVc5tut3j4cRbz1YjZHkwVNG3Y7+YiqjDrTJbXEMYss1
NSHGYwipHe1IvWkeJSIcNasIOPoDrEmNGWgR2M1xh9DzQ3+Na+CyU5Sr/rK37jO2
yx447lmTDtEqXAjCQjXBq3/kk1qBDu8LxGX6FcGIBh3+wakwQKdvzeQN1XuCLzUS
ivjz2AEjgP255T8+CDi9/BiukF3j9d9YJZ49veKIkdRqE+0t4vIje6v3aHsoVA29
1gk91gSTp/fU5pnZjf+WWT+9+OZk/RrrGcAI64NgT9NRbF1GHnY=
=d367
-----END PGP SIGNATURE-----
--=-=-=--

