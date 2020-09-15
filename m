Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30CFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1FD206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFwZ4e/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1FD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kID0p-0002JZ-UM
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kICzz-0001qA-Ig
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:36:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kICzy-0004Dl-44
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:36:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id c18so3799365wrm.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zaFuZxMUy3tHsuYVdAq3S8lyg3yVRpVQDTLse3hXzKE=;
 b=jFwZ4e/zQyBcGq/DXUwPXgOtRYZAKKE65LN4iLrJB6Eo4NSDqDON02l35pInTznQiJ
 /5JGak9LMMyj7qDIPrxUPlNk16RfYyezhB2odZtGLlbW1fRL6xbMRTfAtnN5x35mYOAR
 GMCJzK0tbNFYh4+e1N4jxoCd4rnBbRdaWf899rctvl78bZY3TmKuYaW4ouqJvNTSy2yJ
 iLH111A6ZDcdEO8T+tMnwZh0P1YFRQAupHYvc4V6dQzf+vNaC+b34KEfyO97Q8WHHp/J
 sst517IEMZ88YQxJXBKwL4D15WUEIcgt/38S59z6BGDo+oY+p5lc802jjhuRf3pGYAN9
 KE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zaFuZxMUy3tHsuYVdAq3S8lyg3yVRpVQDTLse3hXzKE=;
 b=BnmcOrP3BrxxZf3tjs0e1iQoG9MtN2IcgcMOz05i7TmaX07E+/w4tlCgYA+TOXIrH3
 OvxTIWam1XKgcLWJlpISqRh3NTr/zcbGnBttNKTKtgsnK1Yg37KqG4XJ0HYfzupzgx3Z
 4BF/lGBmVHDutUWO7oPgDbCPCxfypRnBAe6kXcwKrClcBKYCvtOrQbXyYXN9wq2BN0Da
 nCLNCt6ICthgcTun9FkpJhl/lTUB2QgUVL/y1sef/dAMchWJBqdPORQn61M0KSde37YL
 o3blmJyIwh81UU0C/JWg+/7wmQDvCzSnmyoF85eizJRHcJ/FACYj4VEDY0OSpMRSTjWW
 Bscw==
X-Gm-Message-State: AOAM5318WYbFYob+37Qv5UAK/bIWWnl2JnLRf1EpE2BkEs5lC0rxpoHa
 oF3g5CguhNFyOlj6fE+/h7o=
X-Google-Smtp-Source: ABdhPJzbC/d417LseQVRIIghYeR+Ju8TcXXV1JClhOjVGplXdbbYT78j3rxYBbA1cA3hyx+MIE1LOg==
X-Received: by 2002:adf:cf01:: with SMTP id o1mr22448154wrj.421.1600184159903; 
 Tue, 15 Sep 2020 08:35:59 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v204sm26319754wmg.20.2020.09.15.08.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 08:35:58 -0700 (PDT)
Date: Tue, 15 Sep 2020 16:35:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200915153557.GA713593@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20200614183907.514282-1-coiby.xu@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 02:39:02AM +0800, Coiby Xu wrote:
> v9
>  - move logical block size check function to a utility function
>  - fix issues regarding license, coding style, memory deallocation, etc.

Hi,
Any update on v10?

Please let me know if there's anything I can do to help.

Stefan

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9g310ACgkQnKSrs4Gr
c8gZ7wf/bqJhW2GgoVgYYkgxTEXk61c+JVNs3CcuGfkqCYJF5F1gfDO6UmhOmPf1
RAekelb4zoTKDIGYKg/TZv8mKMMuX7Fib2eee0wgzHFEXSpR/uZWoONoKAdZ4qg9
7owM5M92WfuMjSMVLuVaRTGWZoObP6+j6iONjorALzipvW92HY8qww+mgRT49DkV
QgKojX++Or0jwWmzHbYsdP0HhyF7G0+YznH213iz7/xf+UnMWMQx+IoWWIGa4ArM
9JyyAqdrEcX52+NmAqtUj7AxluAOtSbsEIskpkEAKIRIK+yN8+6DGkHjm/TDg7xW
l1v3u8IZJ+k1QlyEp/uapuUXNOyc8g==
=pgx/
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

