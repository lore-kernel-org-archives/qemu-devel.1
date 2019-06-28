Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA177C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDFA208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDFA208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgygZ-0001fg-00
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgyfS-0000oD-Bi
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgyfR-0005TT-BQ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:44:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgyfR-0005G9-2v
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:44:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so10403513wmj.5
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 14:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=oZvASivwCjcYeelT+PDxyFfSFHAvDJlRTUAgFfxFlZE=;
 b=qV1dWAI2pup4sKZKe1q+VazcRy1VP+6xn1LsZ5d5lH9QT6WlOoyvvV4wRM1KWNK558
 yxkdnMCFVmECS95tlT5IJSGBhm+7Qsi6gUU8Y8a9yf2ioPvWyOyGoM4r2ESiHRmFxwcM
 pVVQY6grn2IRHvHhYbruMMtnA2XWvygBrLEJrY73+S28ZmaIfEhry1coc4OXcXxl2vZM
 Z8sm5/cMcYc5Fw4CMCN94akEHywSSJOwEa244khD/0BIxsbOvShCpTTb4lAeFuJ3eglI
 pLXT+Nf+Qow8h9pdYDCnFOkJ095wZYxfC1K4snquItu97E3frDo9LqC0v+NjC6VvN3tM
 XV3g==
X-Gm-Message-State: APjAAAUmiVYqxK+FQz6MLjTWL2iRh36A5qXCfgK6PA721aUqef67YI2R
 kOt47T06wJMmp1QimbA7c9wIzCMIOgw=
X-Google-Smtp-Source: APXvYqzrHse8Hf9Cw/8rS3ulsJii0Alv99rf9Sp1rVum6X1xiwmYdv0eWUGgvI4QA50TRizosQuVcQ==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr8800341wma.114.1561758250326; 
 Fri, 28 Jun 2019 14:44:10 -0700 (PDT)
Received: from dritchie.redhat.com (73.red-88-25-212.staticip.rima-tde.net.
 [88.25.212.73])
 by smtp.gmail.com with ESMTPSA id h6sm2634829wre.82.2019.06.28.14.44.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 14:44:09 -0700 (PDT)
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-2-slp@redhat.com> <20190628200328.GI1862@habkost.net>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
In-reply-to: <20190628200328.GI1862@habkost.net>
Date: Fri, 28 Jun 2019 23:44:07 +0200
Message-ID: <87lfxlwfko.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/i386: Factorize CPU routine
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jun 28, 2019 at 01:53:46PM +0200, Sergio Lopez wrote:
> [...]
>>  /* Enables contiguous-apic-ID mode, for compatibility */
>> -static bool compat_apic_id_mode;
>> +bool compat_apic_id_mode;
>
> We can get rid of this global variable, see the patch I have just
> sent:
>
>   [PATCH] pc: Move compat_apic_id_mode variable to PCMachineClass

Nice. I'll adapt the v2 of the patchset to assume this has been
committed.

Thanks!
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0WiicACgkQ9GknjS8M
AjXyEA//Y2HsDlK6YIz7gjViBizUC95U3/x2r27K8VjTiwcj3IPBZ7EwxdAUZXyj
QIU8ASMEqKWqBIxHR17Fqmh7A0ohvTgIsj7xEmZ3/vdjiw477AIcPH6AMzS+xTwQ
OSSRNLqeVg9weEYuTqrKqP2JP+LxNCP0Gn9nkT1f+fixHafZegC4+Q7YWh5vr7zt
8wsJ8PZC91NVN9J3LBYzg/QNCn5K1BCB8hHdDv02vS+XNkxP6aeg6gSfOfUP8ofy
RA/Exs8OFoU/z+SNVb/MIAAsUwLJSKLNwpHBHIUWv1OiFe3PIQlgELuh1cCN/UhA
jGt8K3gLZmAEmvbuTwI9zWWssKsen5PemowZwl6mfENOlXa0NN1pxXpg+9DOMdZT
4+lNKgoQzTl/aDDNHwHkfWGka1pXdUNkKRT2+Kq6nvacHe5jr5ID//mZN9sTbllK
tMroUlWkc1XVkEr4taYbi4w5ZQhllSfPSLseGHQMDPo0OK76U39PcO/0iuhSJWls
rLWKjlKvuJA1zkaYqqAztnpwjAR896PDtVmK9ftYFsbvQw0K/aUlLtZI94v4EguT
vPT2TPfansw6wRBBjrcb4SGrQ0NluoksJjcudfPpTgFnO7waF0CoZ8VJ0DC/3Nsy
+k72i2P58hR8d+MwCO0FvXaK6Z3OeoeD3kxGIBS2RFu6CHQYvEU=
=/YFU
-----END PGP SIGNATURE-----
--=-=-=--

