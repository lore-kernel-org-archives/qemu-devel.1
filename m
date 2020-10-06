Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AACC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CF6206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js/zoBk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrFk-0001H8-51
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kPrEX-0000fz-FE; Tue, 06 Oct 2020 13:58:41 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kPrEV-0001ug-Rh; Tue, 06 Oct 2020 13:58:41 -0400
Received: by mail-lf1-x141.google.com with SMTP id b12so16019275lfp.9;
 Tue, 06 Oct 2020 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=x1lG++Wd+nvdikej75KNIk6sAoNrEMIepNHpHtDzkGc=;
 b=Js/zoBk1A8jho/aTJyR7VN4hzBZR31rp+PDbWPTcIzWXk7cMSapWsAyLHKLu2sOd+P
 81jHmJsrPmNI71ESy/Rg/J0H+LyDpHoFi7uTjc2ZkVNTjKvACEHDl+eo4MT2I9M/VsyN
 fPicLpNuTZYTCyaLY47WIRL8nJ2JlcXlvwVnxOD21TZVU7/iJ3WvNksJyaI15hdu+qMR
 VOJdlD1FXb/uFgh9WqRcWA5U6wE76PEB7VD0ZpR1zYmdwYqiuxKhMaq4P2XPmzey9jLJ
 z5VYFqx8Gr0L7Ie9LJmfV+MwBLR6pvuBtb2mbLIjX7siTip0YM23t9nw+i1bVUKIaHK9
 Hb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=x1lG++Wd+nvdikej75KNIk6sAoNrEMIepNHpHtDzkGc=;
 b=gQXJID9DAOYY9JO9jCkkqsqMOU0Jzc3HHKGysyx2XKg+/gpJ923/8JKUYb35G9K/EE
 E0Pl9xu2BAmIsEtW2rC/TERLOclfPHc97zaIPYJ9g1vJiUfZn8i/PD/RUDJ49mPbFASn
 +NE6+dmJLNpANnQEFeM8O3Edok7AQYGqbM0w4IUYjhnRxs8sqxx38eooxd3DmHPTAOOg
 x8ZGbmDn60BrEsgmFoxHmDZzSEIYHSq9wc4pKrcgOLDl81NRNFNiSNLX0ObVdQ5Of1sJ
 wsLTWfZiDDLFqkYtKmO150DWKQMNQRpXdE4diH6K8KdGYwL1IdPqsg85V1eOSmqIu0NP
 dCAQ==
X-Gm-Message-State: AOAM532TPhnmE5kxpPiAKW1/E8zYeWHZn+wmdACdCCEptPDDB/OnD2o7
 4RtzUhUMfeV4PkMd2YtLt0Q=
X-Google-Smtp-Source: ABdhPJw4P75O9Hr8COe7MVcMlmeT31WkcGcjc/OW5KrtKUEXlGGssc6WlZQMijUHGzvh/aADDpW1bw==
X-Received: by 2002:a19:589:: with SMTP id 131mr924288lff.229.1602007113629;
 Tue, 06 Oct 2020 10:58:33 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id l9sm676274lfh.285.2020.10.06.10.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 10:58:32 -0700 (PDT)
Message-ID: <2e6c1f0c07c3ca06f99908fd3b776d791fb54771.camel@gmail.com>
Subject: Re: [PATCH v2] elfload: use g_new/g_malloc and g_autofree
From: Elena Afanasova <eafanasova@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 06 Oct 2020 10:58:19 -0700
In-Reply-To: <CAFEAcA-5FFqr1oUgjeym=NjaSfnZCgHz9UrsnwF6GjMmb+w+wg@mail.gmail.com>
References: <20201001123807.42978-1-eafanasova@gmail.com>
 <87r1qhtdxt.fsf@dusky.pond.sub.org>
 <b4ab229a-0e84-9d0b-1287-846c52a667bb@redhat.com>
 <87eemhm2b9.fsf@dusky.pond.sub.org>
 <17636b91-e111-1b60-4eb2-d526df4a6bb6@redhat.com>
 <d52b5d3655fba86d1b3816115b24997b36952e3b.camel@gmail.com>
 <CAFEAcA-5FFqr1oUgjeym=NjaSfnZCgHz9UrsnwF6GjMmb+w+wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since bsd user space emulation doesn't work for me I can only use
'gmake check'... But some tests don't seem to be supported.

On Mon, 2020-10-05 at 10:55 +0100, Peter Maydell wrote:
> On Sun, 4 Oct 2020 at 13:22, Elena Afanasova <eafanasova@gmail.com>
> wrote:
> > Subject: [PATCH v2] elfload: use g_new/g_malloc and g_autofree
> > 
> > Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> > ---
> >  bsd-user/elfload.c | 79 ++++++++--------------------------------
> > ------
> >  1 file changed, 14 insertions(+), 65 deletions(-)
> 
> Random question -- how are you testing this change? (bsd-user
> isn't covered by 'make check' I think).
> 
> thanks
> -- PMM


