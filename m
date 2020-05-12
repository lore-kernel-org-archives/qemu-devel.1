Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9288C47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 00:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0410206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 00:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="XiRX/zQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0410206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYJDf-0000Wv-Q4
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 20:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jYJCg-0008UN-MS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 20:55:26 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:46069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jYJCf-0001ty-F4
 for qemu-devel@nongnu.org; Mon, 11 May 2020 20:55:26 -0400
Received: by mail-qv1-xf43.google.com with SMTP id z9so3500610qvi.12
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7UDeX33wDJ5aUCrbtiEMQoLEnh7OgkxLNDFtjXuqdeg=;
 b=XiRX/zQ+4B4md7CF8JfwAOlmGeDAIHMagnJUhkjIvxReQWO24SrUM4hJQr1QXkippj
 CVDsXN5y3yv1KSEZTff7t9sVG/rQyOk1UoKnFsR1Ki1E7SIEHe6+qe+lZzk8slfPm9IM
 +vKaYLeDF+iMgpveJ5UG/VLozEZyHWA0IySCuinOmBMeXT2ujBNJXNHv8mOzEN2kaKqO
 u38a90SpulX6phzLY2A0acMwW68Sl/A19o7AYPd784Avzf/8VMsDJm0TKCjNiXRvbESQ
 R7dndPy92yvmEKhuDCJ9E+XMEHgTpel3GdPiEXjt8WrLZqhRoAGko4xDvc6uM71tPfhr
 sBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7UDeX33wDJ5aUCrbtiEMQoLEnh7OgkxLNDFtjXuqdeg=;
 b=M5v9YWGmFgI/yVbBf6tLCsuK6cbOA/kfHMkJdJqY0aZafDmB9Gx1vDbG5M6zv1iuqR
 3v/8kW2om6fk0Gwj16oSq2tH6YD/5aQXRPxLgQaO9edqHQhoSnJtW/OJODYIqbcjKnhn
 9e3slpUPLYsyIhKe/6Rh1pvAJNwi859YAEnkbqqk525Q7zWBV2nBR4lndl0y8k6Zndqx
 htVrU9dFFxiUSb3EbgfPL8vzvL6tdXH2kTV+0s4Agg6/jSedcEGGEP5wK43jUAONXm3g
 BJvqmZCt1Pjqxj3m9A7PsUqM0Dp9JFP5ddES2iP0jChCxEvA1fETIxQ9veN2qSKGQJIW
 lMuQ==
X-Gm-Message-State: AGi0PuaONEqwFXtnhzyy6gOogOxNwe9LBM+8WtWQ3j7oxSnIFDuYLajF
 Ur87D74f2njKvAjwCE76B+F+uA==
X-Google-Smtp-Source: APiQypK6mbakHlAkLhA+umodw8thLqtqeqMLBwuS9wPLbZpwOlkHne91zpEPCUSt7jj39RZoMbl51w==
X-Received: by 2002:a05:6214:1427:: with SMTP id
 o7mr7146511qvx.104.1589244922478; 
 Mon, 11 May 2020 17:55:22 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id l24sm10458431qtp.8.2020.05.11.17.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 17:55:21 -0700 (PDT)
Date: Mon, 11 May 2020 20:55:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Nikolay Igotti <igotti@gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
Message-ID: <20200512005521.GA198983@sff>
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
 <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
 <20200509230016.GA109593@sff>
 <CAEme+7H82A2RNk5g09rmhThxW4=6sqWP5o65OCsJ8zf1L-nb+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEme+7H82A2RNk5g09rmhThxW4=6sqWP5o65OCsJ8zf1L-nb+w@mail.gmail.com>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::f43;
 envelope-from=cota@braap.org; helo=mail-qv1-xf43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 18:53:19 +0300, Nikolay Igotti wrote:
> Attached to the mail counter.c when running with attached test.c compiled
> to Linux standalone binary shows failing assert, unless the patch is
> applied.

I didn't get the attachment. Can you paste the code at the end of your
reply?

Thanks,
		Emilio

