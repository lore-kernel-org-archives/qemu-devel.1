Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E4EC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 07:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18E42072C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 07:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="cqCFpo3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18E42072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Dvh-0005jJ-4X
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 02:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiri@resnulli.us>) id 1j3DuM-0005Af-9k
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiri@resnulli.us>) id 1j3DuL-0001eJ-91
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:00:02 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:33366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jiri@resnulli.us>) id 1j3DuH-0001Y0-36
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 02:00:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id m10so5011518wmc.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 22:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=G7ripcv92VdCtEiBJMvT7b7G7R0BVTdT9ZFi4WSEm74=;
 b=cqCFpo3s26VVlSUzLUB2gh7vXncn3OgcF3Fwn4DYzuwUU1ATwt+EYnh3cW7PnnCOdd
 afRnmci/dS2aDMvrUvoaoxReEb/OGIRl8K76a8rw94nBkRWtbgI+tQWhAXx/9vagOmIl
 VrTPXtsjegOQeb2PBLGi31R2YDUY9VtwJ4HtiGL6VJV2TTXLPdQZpqoHpTK/7DGzoS2R
 E1cxYe1dNgpPozSuxkoPwlB9nj+/FnNl4VC8yTlzLghwc5eTHJFjY2OROp+zrXUFoM3O
 j9Q1gAY9moS0pRx2pSAbKxyja5tMxdWYt8BkyXPC5cjS2O5tZMmCBdAnsFKIkogz+4bq
 wAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G7ripcv92VdCtEiBJMvT7b7G7R0BVTdT9ZFi4WSEm74=;
 b=OUXSRXSC0tHYr/pn38kJ1t7GpbMu5FBUmObFbTt+UkA12AT2oaLY7zE93xruxZkCIq
 0L60lxQWKTlLAQE7KZL3w4Oq/lmFmNr6pfAtjUnJ7yvYRQzO+TX6Mlh0g1GH0jDE7EF9
 A1PShZGSUsy2akby/1WGD1J9D8lyeVqPkfSxKmASbXkFm/SAO3MQ63HWkO9Fc+zRD2s/
 x+3rKs4ZbLBoTRIRyFlutjLuseuDGB2uib0dncrm+XUKSxnUgn+rbfUy+/DEP/Mh8A6c
 PZLm9rMa1Nb7Ivy/dn9A+K02RQOwzjbT2QZlDuurNdiEyj4dEb3qGmO9kgrqUyiDVRVB
 1Mvg==
X-Gm-Message-State: APjAAAVs+GKoMfTI1a995/mxNCPL03xsYC+XndGCVhZJ9SCjIOs3X9A1
 YcmSTwOeBiDRfruGFU7WTKKnLw==
X-Google-Smtp-Source: APXvYqzjAl4uOFW51xxLn0FzsnUj/QB9IqwhE0lg8AnNt5ilYqtAM/1PjhQzjEAjPZkzqettX20iBg==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr14941329wmi.35.1581836395709; 
 Sat, 15 Feb 2020 22:59:55 -0800 (PST)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
 by smtp.gmail.com with ESMTPSA id d9sm15042958wrx.94.2020.02.15.22.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 22:59:55 -0800 (PST)
Date: Sun, 16 Feb 2020 07:59:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: hw/net/rocker: Dubious code in tx_consume()
Message-ID: <20200216065954.GC2247@nanopsycho.orion>
References: <63e927fd-a462-a871-fcd7-c54dac07173e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e927fd-a462-a871-fcd7-c54dac07173e@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sat, Feb 15, 2020 at 02:15:22PM CET, philmd@redhat.com wrote:
>Hi Jiri,
>
>I am trying to understand this code Scott Feldman added in commit
>dc488f88806:
>
> 157 static int tx_consume(Rocker *r, DescInfo *info)
> 158 {
> ...
> 212     if (tlvs[ROCKER_TLV_TX_TSO_MSS]) {
> 213         tx_tso_mss = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
> 214     }
> ...
> 252     if (iovcnt) {
> 253         /* XXX perform Tx offloads */
> 254         /* XXX   silence compiler for now */
> 255         tx_l3_csum_off += tx_tso_mss = tx_tso_hdr_len = 0;
> 256     }
>
>Nobody complained TSO_MSS is not implemented during almost 5 years.
>Can we remove this code?

Yes, you can.

>
>Thanks,
>
>Phil.
>

