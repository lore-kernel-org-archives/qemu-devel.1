Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31556C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2AA3208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTf9dB+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2AA3208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uLD-0000aJ-0A
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2uK3-0008Tw-KS
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2uK2-0007Ca-Rm
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:32:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i2uK2-0007CA-JY; Wed, 28 Aug 2019 05:32:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id u16so1782801wrr.0;
 Wed, 28 Aug 2019 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oUGKssuDdu6zwdLwmi9s+m+r+rikrcMUKifusRqzE6s=;
 b=FTf9dB+eQaeXTWyQOfRjoHk7TeoAcosD1HvE5GHHfEX/KJQ9+O9JnxkAkRo+wbI5J4
 xYfBOOBsY7ENDzQ3NN/HWZB/kJMgcJ31Dn8ETpH0JGsOIyhA94c9SfqtdLKcRAeWRYOk
 IlOjGqLxr5YiVDnBOF3sFloqwNgx3LdL1KJm6C/56WdopAFo/07LokfhBwCAM8ffC6x6
 jwXWh9augvD9vMP3ZxHfWfdMQcsglD5CyGfnlz2/IadaviFZUSh09wUm6bEHixTp9HiL
 0YO38DwNUf1Emv0Hztjcx1+9Isal09qeiqLOi0DfNpbg/d5P+d73u8TJfDLOFZkhdtmg
 t+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oUGKssuDdu6zwdLwmi9s+m+r+rikrcMUKifusRqzE6s=;
 b=HqDiZJi045yn+KR1LiGt7Ef1XrYAtaeEoFo4AnAwB5726TxhXvPYZuH517PXj9fDTD
 BJwXwKkx47QTh7kMcDlwuU+tww/fe8p+HiBchgh4tE5xx4HYq/wgEVFPhrNtN4jJqIfG
 oQlHGUSgB19FhS/p17qLJN0muOXdeEdkE9yNezhDzSLxH4q52RDCts7czZepRxPZ+9gq
 ApxB62mR+szaap/4Ll1wIEVfQsN/tyxi1AdnXwnWrTiAQG1wE7/T8OrbLK80anR9I3PM
 xcGyWKOoMAtakvark/i+KME7dqeOQCDmGhIn8FZl7pY340FnC0HxN1aGuKswz34brWMX
 ZzYw==
X-Gm-Message-State: APjAAAWTuy1JEDtNfF08qTpuEWraaZYNFjU05/0AFzV6s4QngBPuELTh
 XvGR/3lk69lCw4JEMG7ncww=
X-Google-Smtp-Source: APXvYqwS3w7h9/3trjZyO98ezhMQZmvUWwAfoWCFHMk+kQ5NWWwuzdXXtgrbmpnHK3EJXq6tyOdwYQ==
X-Received: by 2002:adf:f641:: with SMTP id x1mr2047927wrp.179.1566984777480; 
 Wed, 28 Aug 2019 02:32:57 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t198sm3012792wmt.39.2019.08.28.02.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:32:56 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:32:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190828093255.GD5573@stefanha-x1.localdomain>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
 <20190823194927.23278-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20190823194927.23278-3-dmitry.fomichev@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 2/4] raw: Recognize zoned
 backing devices
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 03:49:25PM -0400, Dmitry Fomichev wrote:
> +static int hdev_get_zoned_model(int fd)

Please use the enum:

  static BdrvZonedModel hdev_get_zoned_model(int fd)

> +{
> +#ifdef CONFIG_LINUX
> +    char buf[32];
> +    int ret;
> +
> +    ret = hdev_read_blk_queue_entry(fd, "zoned", buf, sizeof(buf));
> +    if (ret < 0) {
> +        ret = BLK_ZONED_MODEL_NONE;
> +        goto out;
>      }
> -    g_free(sysfspath);
> +
> +    buf[ret - 1] = 0;

The ret - 1 looks suspicious since sg_get_max_segments() does buf[ret] =
0 instead.  A comment would make it clear why ret - 1 is used here:

  buf[ret - 1] = 0; /* strip newline and NUL-terminate */

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mSkcACgkQnKSrs4Gr
c8jgvQf9EWhkwn+uJrQl6TxBeInIUO8DcKluAe2Q4G5v3a2k7iOov9mTkeLjJp29
pg9+gLo3VuOcjgjUCondb1dQZtGD1bT3Qh3MdRTkglaQoGOP6RtL9wpOMde/hReZ
wy7yAtsXpCXOthnm8os1z5EAim4jLdpA0XZblTxI7GyK0yiaPBWyVbfziUumezDM
PzhSpCGkKlIDygAzwZ0Z5kMIMJumwdmNrcTnNE9tp0gxnE8gGULJzBsenDxYMiHL
dFsGU0qdjOkF+nQjdi4L2LIUXxsaBGmnrFmpHXKwvhvGi0pKsY5n6AbXE2ej6axp
YWxlYgwHm/EyXHK361u2cusvWnEnKQ==
=IhZh
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--

