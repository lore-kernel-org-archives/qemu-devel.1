Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEECC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B12206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 07:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ9grNGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B12206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBme-0003XO-Su
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 03:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJBlQ-0002cs-8b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJBlP-0001HR-34
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:56:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJBlP-0001Gx-0L
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 03:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585641406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huI0xeRKRJKC7g0lv/3KqVXE27x7xFR386Jy+Y5JX8A=;
 b=iZ9grNGy5Ff0L59jTtHC8MFolRlvbU+fQbBI/QMKLa0q/QUyjzyACGyxjKgoGVFsZ2ovit
 XJkWifzhLeVA3iGst49aw0PGNZOl3GpBvt96r7CmVBR2A8j2oKxSXoN+XZ7pfa0NYXUi3y
 Ghp2awIxo4StK0Z/mCwtcZTOw6NiCas=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-PhAwW8saMsGr8MqdHizFug-1; Tue, 31 Mar 2020 03:56:45 -0400
X-MC-Unique: PhAwW8saMsGr8MqdHizFug-1
Received: by mail-ed1-f71.google.com with SMTP id b7so18075000edz.9
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 00:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NIbuEqbedWnO4cVViXYTvJqm0qFHOFUcnMgKbAnYcDo=;
 b=t+oKYMREKRPy0FFqQ4lkKFdt40Tr1obk0gyQXNGCl4pUJUC3JuRWp4Ccn7ZKaLrBDw
 NceydH/bfR/AhNW3Bd69ReJtTD5PeVlFr6N0uZK7laspvxACCuOR2/nHO00vzZuoq6Z7
 40T5mOk6Ps5kwl7My41QvRhNfgDf7UUekjjrwk6b+cabTdjGFEXPgMm6NE+rSA/jfce8
 R3sz94h+JwqMEwx0gjzkLLsvjrzEigZyj024WPzXMUhUnm+W6H67hNkUmbINVcEFY5t5
 JRnVklQgVScJHOzd8wGk35w10aX9VUWdL6Yt6+K9qvrbHdH7c8ZbdxnI9h0PEVy12w/z
 aX9w==
X-Gm-Message-State: ANhLgQ3ZLI76pNSnGv9qeW5DqbnK9UJK8U3Xl5Gyt/7y1xfRW1fVgijb
 PogROvPDt09CeUNOWjiMtl0egjOY+MtNKJIYQBDMJXEIGNHhLSnM4P0MUEfW/y5KsD7cZcOjpm7
 jMgFIiUUdu1nWG20=
X-Received: by 2002:a17:906:164f:: with SMTP id
 n15mr9482403ejd.322.1585641403354; 
 Tue, 31 Mar 2020 00:56:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vunb8LRSY8eM4EONNuNgxtf4WDxGSniyZq3LPnJcuvXxjTaVkPTfqYBIeYnTkmTvfkKxs3Brw==
X-Received: by 2002:a17:906:164f:: with SMTP id
 n15mr9482394ejd.322.1585641403147; 
 Tue, 31 Mar 2020 00:56:43 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j31sm708679edb.39.2020.03.31.00.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 00:56:42 -0700 (PDT)
Subject: Re: [PATCH] spapr: Don't allow unplug of NVLink2 devices
To: David Gibson <david@gibson.dropbear.id.au>, aik@ozlabs.ru, groug@kaod.org
References: <20200331032709.112476-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <abfad294-aef3-9750-7bc7-e15006659f79@redhat.com>
Date: Tue, 31 Mar 2020 09:56:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331032709.112476-1-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 5:27 AM, David Gibson wrote:
> Currently, we can't properly handle unplug of NVLink2 devices, because we
> don't have code to tear down their special memory resources.  There's not
> a lot of impetus to implement that: since hardware NVLink2 devices can't
> be hot unplugged, the guest side drivers don't usually support unplug
> anyway.
>=20
> Therefore, simply prevent unplug of NVLink2 devices.

Safe for 5.0, right?

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   hw/ppc/spapr_pci.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 55ca9dee1e..61b84a392d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1665,6 +1665,10 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
>               error_setg(errp, "PCI: Hot unplug of PCI bridges not suppor=
ted");
>               return;
>           }
> +        if (object_property_get_uint(OBJECT(pdev), "nvlink2-tgt", NULL))=
 {
> +            error_setg(errp, "PCI: Cannot unplug NVLink2 devices");
> +            return;
> +        }
>  =20
>           /* ensure any other present functions are pending unplug */
>           if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
>=20


