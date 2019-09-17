Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE2C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B408A21670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B408A21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABCo-00008z-Tt
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAB9c-0005r7-JQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAB9b-0001Mr-4e
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:56:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAB9Y-0001KX-MB
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:56:13 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2431436899
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 10:56:10 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id 4so710146wmj.6
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uvAxstmAnSwepwLQgLbc5Y236mFbSVtOAP2efXMrpHk=;
 b=q7cFKnycKdWi3Tp3wuZ2ufdSmS7PEO5w5azb7BxKsDuVk1va2az+vVTRZTjpn4dY8B
 Qn6z0rWpTfFZS8DJq032PZh20SPQZxZ1A24CL8sakVhrL5s1uiyqpSfD+I5oZ7aOcPdR
 Ugx3Qg+4QUA8UB3ssuYd2XV++ksZNm6H7sHXgzbayIA3290QJVkE3e+32Bn7tMR6A/3o
 F0JOAulwVFyw22qcEHClOVR8yUH2MJGPqEZW8AigJAVVPaHehyzLZCNPecPIVO9KjF3j
 g/U8f/XxS2lxJYLWkIwUckXKK8QUqZDvhmPe0eO9rqU4t7x/hRb2B+a5JRjwSb4K+KQc
 0fxA==
X-Gm-Message-State: APjAAAVdUcMFMX0rWW3F0/QGSqha8h5wCx3nMjktoUCBkMCdQUnCKnXZ
 HzGnvtXUUaCVJB4PVqe61J/PZ6Xd2FW7nVbTo5X1neQYuDStXFR9dlWhce9bEu8GvduEA5h6dCP
 A8JWLtOvExxLl71Q=
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr2323746wrw.314.1568717768908; 
 Tue, 17 Sep 2019 03:56:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxt4Y85pN8WkAAYBNL3UGT90UEZTErSmzFzIMpOnxVAO6ufY6cMORCQjkdDXqQTg5farFxhFA==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr2323722wrw.314.1568717768753; 
 Tue, 17 Sep 2019 03:56:08 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c6sm2636760wrb.60.2019.09.17.03.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:56:08 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871573833.196432.7906362695920387537.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6fe2e5bb-69bf-de52-75ba-cab918e86091@redhat.com>
Date: Tue, 17 Sep 2019 12:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156871573833.196432.7906362695920387537.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 17/17] checkpatch: Warn when errp is passed
 to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 12:22 PM, Greg Kurz wrote:
> Passing errp from the argument list to error_append_hint()
> isn't recommended because it may cause unwanted behaviours
> when errp is equal to &error_fatal or &error_abort.
>=20
> First, error_append_hint() aborts QEMU when passed either of
> those.
>=20
> Second, consider the following:
>=20
>     void foo(Error **errp)
>     {
>          error_setg(errp, "foo");
>          error_append_hint(errp, "Try bar\n");
>     }
>=20
> error_setg() causes QEMU to exit or abort, and hints aren't
> added.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  scripts/checkpatch.pl |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index aa9a354a0e7e..17ce026282a6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2902,6 +2902,10 @@ sub process {
>  		}
>  	}
> =20
> +		if ($line =3D~ /error_append_hint\(errp/) {

Checking for 'errp' variable name seems fragile, but all the codebase
uses exactly this name, so it is sufficient.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +		    WARN("suspicious errp passed to error_append_hint()\n" .
> +			 $herecurr);
> +		}
>  # check for non-portable libc calls that have portable alternatives in=
 QEMU
>  		if ($line =3D~ /\bffs\(/) {
>  			ERROR("use ctz32() instead of ffs()\n" . $herecurr);
>=20
>=20

