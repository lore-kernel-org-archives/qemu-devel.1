Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C322C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E676D20898
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbr4A+TT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E676D20898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkuA-0004ld-2Z
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXkt8-00042I-IZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXkt7-0005vs-EB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:44:42 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXkt7-0005sp-73
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:44:41 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so895312wrt.6
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 03:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xjNKjIYn63tDyfIxbk31xrNjdh1AZIV2LOnqyMQNCv8=;
 b=Dbr4A+TTQhyxla7pe5lOSzIVEV4IbJfQoWYH30GA0JhclGkIGZTd7Jh9G58ZbIMpah
 ge9Z845NqJ0yyXaYUp/3HDLhWMc8OdFvZqc6fECx5Y4JzWnRNTuO8GVz3y+VQu5tVEza
 S68oivFAhdCEK4QJtbglcCgI/mlKEWJJNjp2ypUNFb4acYzc8oGipvCYSmQuviXbGLGh
 TSheKs/3kakj04oFCqu989szAZFmzqsJGCfWyffY0/hjlbRTUc6rNT9b1i8LrBTYGeuC
 nOddff73TVg5D+t2aoxNGvaUh94MgAdnm2S9GYBuEiFTymzEnbeAsAceBaVIPGDumWi7
 1VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xjNKjIYn63tDyfIxbk31xrNjdh1AZIV2LOnqyMQNCv8=;
 b=Sixi9THepyih+3o6/CoKmbZP/SAis43z6qq41NjWkZuWwkXTjb+VJmuSbUm7OHYrGn
 P4MWKskOces4yB8O6NMVyPBNaKWmbBP5pqbC1AgZOnH+q7mkzMpCRvZ/CC/mnL5te89G
 arL9HnGyeKOn+ulVp+lcrqm5RQbhhvQc8+f/mIE24Kc+swXh8YAqtARqy9I3j0DwDFVd
 X/YRMJSpc2JxH5EneG57dArUGReBHsOs6yvc42xg/d01Rey/9BTLHOF4YgP5L2n/M2iG
 Vk3QgJM5PJKq8tfriqmLawpKJZuKSov0XIdPtq8OVbcf4RaeT3zCfgtU3OalF291YWMb
 LTAg==
X-Gm-Message-State: APjAAAUw6pLqWwsda5qZ/njDHVaDnlo9d5On2eM5Y7lGwQkMjOykO2dR
 SSyl3OzGgBMuWqIdIct26JY=
X-Google-Smtp-Source: APXvYqzDFIKquF9DbivfkgPkynqZuw18kfXyB+895jIA5s5GZIEWqA4YkeAcuwhOray8rwDljuBpqA==
X-Received: by 2002:adf:f147:: with SMTP id y7mr10018952wro.236.1574336679764; 
 Thu, 21 Nov 2019 03:44:39 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 65sm3135936wrs.9.2019.11.21.03.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 03:44:38 -0800 (PST)
Date: Thu, 21 Nov 2019 11:44:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 17/49] multi-process: Synchronize remote memory
Message-ID: <20191121114437.GL439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <c05fcadf33e13791d28c5fd43241f2c6db30292a.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TdMwOTenGjBWB1uY"
Content-Disposition: inline
In-Reply-To: <c05fcadf33e13791d28c5fd43241f2c6db30292a.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TdMwOTenGjBWB1uY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:08:58AM -0400, Jagannathan Raman wrote:
> +static const TypeInfo remote_mem_sync_type_info = {
> +    .name          = TYPE_MEMORY_LISTENER,
> +    .parent        = TYPE_OBJECT,
> +    .instance_size = sizeof(RemoteMemSync),
> +};
> +
> +static void remote_mem_sync_register_types(void)
> +{
> +    type_register_static(&remote_mem_sync_type_info);
> +}
> +
> +type_init(remote_mem_sync_register_types)

Why is a QEMU Object necessary for the memory listener?  QEMU Objects
are used for the device model and -object.  The memory listener is an
internal concept that doesn't need to be exposed as a QEMU Object.  It's
fine to use plain C structs and functions, not everything needs to be a
QEMU Object.

> +/*
> + * TODO: Memory Sync need not be instantianted once per every proxy device.
> + *       All remote devices are going to get the exact same updates at the
> + *       same time. It therefore makes sense to have a broadcast model.
> + *
> + *       Broadcast model would involve running the MemorySync object in a
> + *       thread. MemorySync would contain a list of mpqemu-link objects
> + *       that need notification. proxy_ml_commit() could send the same
> + *       message to all the links at the same time.

Once mpqemu-link is made event-loop friendly (asynchronous) it won't be
necessary to create more threads.

--TdMwOTenGjBWB1uY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WeKUACgkQnKSrs4Gr
c8gkFwf/YjHlbvQqPFFIiG1BPZLd60VFCLvaJxc7nsWhSrrVriEqqgy7TfWwlwbI
V/T6UHxQNQ329I67rxr0Dz3Qyt+EYJNIFnxIXXPIVznZ0FX8Z4v4lMsl7amm4pqK
JV3qKOD+7us5Fc2KMAw1Nlex9M1z6NrWSGEHfBCXxWic591cwLCrRQ/VQXOFikmR
nUPs7g6pHf5jr1gnQPwRLAa5kj9IN/A5HkiPLmlHor1HCVqWLibn6++GhUQtS60J
eihEI6SNJ0ksu26P1aoEStawSxtB540L2m5dwgenpc6IxyVbwjF3TFS2qEku4//+
HW2Km808Q84tw+uMHGgDFEE1gD1Otg==
=8+xp
-----END PGP SIGNATURE-----

--TdMwOTenGjBWB1uY--

