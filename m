Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5417CC4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBFF206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBFF206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGYK-00020I-Ii
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAGWe-0000YV-Hc
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAGWd-0004Cz-Dk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:40:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62269)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAGWd-0004Cl-5L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:40:23 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CB967FDFE
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 16:40:22 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so1083313wmd.9
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4wtvlO/tQ7FyA51BwWL6zzSN1zQdVoJrzNT0mjLO29o=;
 b=hNlScxMZivxbO9hdRwCT3zTMOWimNnCaKB+UR35OvYqD7XrW9IOW5ilBeit9Z8MFIL
 YGGh45CcCzQOIMfufjQYWrDwHaUijRpuoWtXPIxIpByCJL0QDtMeYPRCIEP1aKrYvoxm
 7DlvTtKKVi6ZoRaWRVIvo3oPq4cpbx/imt1TFhqza4xAbVHfgeVCDjamelcNyVaBEmNq
 daHRHBZEkxsOVUBj5W8HJOra/3USIqR0MvniUfEk/KbZEZD27v6HKyCOlk9l0oli3Bpv
 uRm4Qop6XgS7nfEskVXrafaaoXgIEhjP0mESi/egHBJBe7XR5K98OErKygZ3UilnifCt
 M3sQ==
X-Gm-Message-State: APjAAAUUr5Nknsvs3HO2fRBsROYfgZxJ6qCSQNwzwoe5fgzXrn5ZLDIq
 5x2oKwedIB/zCsiD4CjTFr4pQbOjcEfOHZbX/qGA0hwNUp8SHlgg96C5cKGwR6D546y3Wj9Raqu
 5gniB9W1NqFG2h4I=
X-Received: by 2002:a7b:c5ca:: with SMTP id n10mr4335025wmk.138.1568738420567; 
 Tue, 17 Sep 2019 09:40:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKVk2GUS85VsMGEShTLjefvwpfQ46QRuouJvHmco3TdyygX8XTE5r6PMV7s0ZtB77W3EhbvQ==
X-Received: by 2002:a7b:c5ca:: with SMTP id n10mr4335014wmk.138.1568738420407; 
 Tue, 17 Sep 2019 09:40:20 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v11sm4489645wrv.54.2019.09.17.09.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 09:40:19 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>, pbonzini@redhat.com
References: <20190915202011.30459-1-palmer@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <00d5a1a7-5bbe-176b-6272-f5b015a8e13e@redhat.com>
Date: Tue, 17 Sep 2019 18:40:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190915202011.30459-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vl.c: Report unknown machines correctly
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

On 9/15/19 10:20 PM, Palmer Dabbelt wrote:
> I was recently typing in a QEMU command line, and ended up with
> something like
>=20
>     qemu-system-riscv64 -machine virt ... -M 8G
>=20
> which is, in retrospect, obviously incorrect: there is no "8G" machine.
> I should have typed something like
>=20
>     qemu-system-riscv64 -machine virt ... -m 8G
>=20
> but since QEMU was giving me the excessively unhelpful error message
>=20
>     qemu-system-riscv64: -machine virt: unsupported machine type
>     Use -machine help to list supported machines
>=20
> I had to spend a few minutes scratching my head to figure out what was
> going on.  For some reason I felt like I'd done that before, so I
> figured I'd take a whack at fixing the problem this time.  It turns out
> the error reporting for non-existant machines is just wrong: the invali=
d
> machine is detected after we've lost the argument pointer, so it just
> prints out the first instance of "-machine" instead of the one we're
> actually looking for.
>=20
> I've fixed this by just printing out "-machine $NAME" directly, but I
> feel like there's a better way to do this.  Specifically, my issue is
> that it always prints out "-machine" instead of "-M" -- that's actually
> a regression for users just passing a single invalid machine via "-M",
> which I assume is the more common case.
>=20
> I'm not sure how to do this right, though, and my flight is boarding so
> I figured I'd send this out as a way to ask the question.  I didn't hav=
e
> time to run the test suite or figure out how to add a test for this, as
> I'm assuming there's a better way to do it.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/vl.c b/vl.c
> index 630f5c5e9c..821a5d91c8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2487,7 +2487,7 @@ static MachineClass *machine_parse(const char *na=
me, GSList *machines)
> =20
>      mc =3D find_machine(name, machines);
>      if (!mc) {
> -        error_report("unsupported machine type");
> +        error_printf("-machine %s: unsupported machine type\n", name);
>          error_printf("Use -machine help to list supported machines\n")=
;
>          exit(1);
>      }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

