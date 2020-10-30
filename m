Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C8AC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C88221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTssWbZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C88221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRyu-0007fX-9p
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYRxy-0007E6-QF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:49:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYRxv-0000mV-K5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:49:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id c9so870970wml.5
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EHXnVhbhlt0T5h7CL8A1q4pqh334NaF7BvKSoYFgnL0=;
 b=kTssWbZ4WBqadlcGj13OwE1MKnrOEYVXhglDlDgxPxbQCaomXsuYBIZ+FRqUuwj+rT
 UMUHXNpR7uZhASM6Msa/wPmbAjKEqeSocTsL1lkn13UWNts/stZW/M/GXMOtUXSTpUGF
 rKx8Da3MGCyzuAR/9CN6PAWBeI6W+PbDZpsZDeI0iXq7FO5hWzpNhMeQ4uQwwbkBxVXK
 7KETZtF0BsXuBZrZf/veeAzAV/zwSMrhZgMyJekDTsUPaJlwbP1r9DxmvzOuZR0eW/Y9
 S+M6t78KQRj43izgof8GRN4NfXhvYphg0g5C6AZLjjNkW7g2EkswSaUsZCQVi2400Xwk
 HMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EHXnVhbhlt0T5h7CL8A1q4pqh334NaF7BvKSoYFgnL0=;
 b=Tj5A0hpVX6QjEAUU9+IwdcXuOMMRG2Vx5qNHKHRXbvrZDTBpPZG9qG/+s9hiICvi9R
 sBiTeIuDv9d8Fyf8bUB1nsEmP/ZSrXVyj5tSUsl2sRr8ZQa90r12D1OCQmCIVW272wFX
 lwRjiO6+pXPXMPKMSYOv0CFsz1IGyujOdxM3P5aZt66JsrlgVcOe5Sih+NKw+TBBh6lV
 iA1AtQ6z3gwQDULBoSXHRvNGjMwsJmMg63Fucy65tXBxo7LXjbj+rwDctozm3UQZTgkr
 Nkr2/8zbpJFjEMNDYAV2aUFPlZ4gV1ZX/BUdeBwXIupbOmmvB579rOtezZchYgnJWix9
 zofQ==
X-Gm-Message-State: AOAM530TrmKHWj3ELQ+T1Ua6+bFTxttgtUVIt8PgZN0fIxs5khT4YPie
 UK4NeiOkS9eDE3VEh3dwjhsbNg==
X-Google-Smtp-Source: ABdhPJykD2k4V0G0x2T+7KV/0yQJObWlJCLPxJG7RmutGRJq+/hDKl3bssnPxHIO2onp1WKdfiIDPQ==
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr1901942wms.130.1604054941365; 
 Fri, 30 Oct 2020 03:49:01 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d142sm4140431wmd.11.2020.10.30.03.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:49:00 -0700 (PDT)
Date: Fri, 30 Oct 2020 11:48:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v10 00/10] virtio-iommu: VFIO integration
Message-ID: <20201030104841.GB294997@myrica>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201030062714-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030062714-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 06:27:35AM -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 08, 2020 at 07:15:48PM +0200, Jean-Philippe Brucker wrote:
> > This series adds support for VFIO endpoints to virtio-iommu.
> > 
> > Versions 1 to 9 were posted by Bharat Bhushan, but I am taking over for
> > now since he doesn't have much time to spend on it. Thanks again Bharat
> > for the work!
> 
> ok so just minor things left, correct? Do you plan to post v11?

Yes, today or early next week

Thanks,
Jean

